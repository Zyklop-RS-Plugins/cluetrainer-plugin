--#if ENVIRONMENT == "test"
ExecuteConsoleCommand("ppr cluetrainer")
ExecuteConsoleCommand("ppe cluetrainer httpAccess")
--#endif

-- Copy zyklib library (from dependencies, map to zyklib/)
--#copy "../dependencies/zyklib/src/" to "./"

-- Select the correct plugin.json based on environment using preprocessor
--#if ENVIRONMENT == "production"
--#copy "plugin.production.json" to "plugin.json"
--#elseif ENVIRONMENT == "test"
--#copy "plugin.test.json" to "plugin.json"
--#endif
--#exclude "plugin.production.json"
--#exclude "plugin.test.json"

local main = require "cluetrainer/main"

main.main()

-- Exclude unused files for packaging using the preprocessor
--#exclude "prettyui/achievement_popup.lua"
--#exclude "prettyui/anchored_tooltip.lua"
--#exclude "prettyui/buff_bar.lua"
--#exclude "prettyui/confirm.lua"
--#exclude "prettyui/core/category_groups.lua"
--#exclude "prettyui/minimenu.lua"
--#exclude "prettyui/overhead_bar.lua"

--#if ENVIRONMENT == "test"
local devtool_main = require "cluetrainer_devtool/main"
devtool_main.init()
--#else
--#exclude "cluetrainer_devtool/"
--#endif
