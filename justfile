# Root of the RuneScape beta client cache (the folder containing the *.jcache files).
# Override by setting the RS_BETA_DIR environment variable.
RS_BETA_DIR := env_var_or_default("RS_BETA_DIR", if os() == "macos" {
  env_var("HOME") / "Jagex/RuneScape-BETA"
} else {
  "/mnt/c/ProgramData/Jagex/RuneScape-BETA"
})

DEV_PLUGINS := RS_BETA_DIR / "dev_plugins"

install environment="test": check-beta-dir (package_into DEV_PLUGINS / "cluetrainer" environment)
    #!/usr/bin/env bash
    set -euo pipefail

    just install_devtool

    install_plugin() {
      local plugin_name="$1"
      local target_dir="{{DEV_PLUGINS}}/$(basename "$plugin_name")"

      if [ -d "$target_dir" ]; then
        rm -rf "$target_dir"
      fi

      cp -r "$plugin_name" "$target_dir"
    }

    for plugin in dependencies/dynamic/*; do
      if [ -d "$plugin" ]; then
        install_plugin "$plugin"
      fi
    done

# Replaces everything in the installed plugin except the resources folder.
install-light environment="test": check-beta-dir (check-environment environment)
    #!/usr/bin/env bash
    set -euo pipefail

    TARGET="{{DEV_PLUGINS}}/cluetrainer"

    mkdir -p "$TARGET"
    find "$TARGET" -mindepth 1 -maxdepth 1 ! -name resources -exec rm -rf {} +

    copy_without_resources() {
      local src="$1"
      (
        cd "$src"
        find . -path ./resources/prettymap -prune -o -type f -print0 | while IFS= read -r -d '' f; do
          mkdir -p "$TARGET/$(dirname "$f")"
          cp -f "$f" "$TARGET/$f"
        done
      )
    }

    copy_without_resources cluetrainer
    copy_without_resources dependencies/zyklib/src
    rm "$TARGET/plugin.production.json" "$TARGET/plugin.test.json"
    cp "cluetrainer/plugin.{{environment}}.json" "$TARGET/plugin.json"

    just install_devtool

# The devtool is a plugin of its own and only gets the data files of Clue Trainer, no code.
[private]
install_devtool:
    #!/usr/bin/env bash
    set -euo pipefail

    TARGET="{{DEV_PLUGINS}}/cluetrainer_devtool"

    rm -rf "$TARGET"
    mkdir -p "$TARGET/cluetrainer/data"
    cp -R cluetrainer_devtool/. "$TARGET/"
    cp -R cluetrainer/cluetrainer/data/. "$TARGET/cluetrainer/data/"

package: (package_into "dist/cluetrainer")

package-zip environment="production": (package_into "dist/cluetrainer" environment)
    #!/usr/bin/env bash
    set -euo pipefail

    rm -f dist/cluetrainer.zip
    (
      cd dist/cluetrainer
      shopt -s dotglob nullglob
      zip -r ../cluetrainer.zip *
    )

[private]
package_into target environment="production": (check-environment environment)
    rm -rf "{{target}}"
    mkdir -p "{{target}}"
    cp -R cluetrainer/. "{{target}}/"
    cp -R dependencies/zyklib/src/. "{{target}}/"
    rm "{{target}}/plugin.production.json" "{{target}}/plugin.test.json"
    cp "cluetrainer/plugin.{{environment}}.json" "{{target}}/plugin.json"
    @if grep -rnE '(ids|source_loc) = ([^-]*[{,])? *[0-9]' "{{target}}/cluetrainer/data"; then echo "Entity ids must be names: run lua tools/entity_names/name_ids.lua" >&2; exit 1; fi

[private]
check-environment environment:
    #!/usr/bin/env bash
    case "{{environment}}" in
      production|test) ;;
      *)
        echo "Invalid environment '{{environment}}'; choose 'production' or 'test'." >&2
        exit 2
        ;;
    esac

[private]
check-beta-dir:
    #!/usr/bin/env bash
    if ! ls "{{RS_BETA_DIR}}"/*.jcache > /dev/null 2>&1; then
      echo "No RuneScape beta cache found at {{RS_BETA_DIR}}." >&2
      echo "Launch the beta client once, or set RS_BETA_DIR to the folder containing the *.jcache files." >&2
      exit 1
    fi

# Paths relative to the project root
CLOC_BLACKLIST := "^(./)?(cluetrainer/cluetrainer/data|cluetrainer/prettymap/data|cluetrainer/prettyui)(/|$)"

cloc:
    cloc cluetrainer --fullpath --not-match-d '{{CLOC_BLACKLIST}}' --by-file
