#!/usr/bin/env python3

import os
import sys
import re
import shutil
from pathlib import Path
from typing import Dict, List, Set, Tuple, Any, Optional


class PreprocessorError(Exception):
    pass


class ExpressionEvaluator:
    """Evaluates simple boolean expressions with operator precedence."""

    def __init__(self, symbols: Dict[str, Any]):
        self.symbols = symbols
        self.tokens: List[Any] = []
        self.pos = 0

    def tokenize(self, expr: str) -> Optional[List[Any]]:
        """Tokenize an expression string."""
        self.tokens = []
        i = 0
        while i < len(expr):
            c = expr[i]

            # Skip whitespace
            if c.isspace():
                i += 1
                continue

            # Parentheses
            if c in "()":
                self.tokens.append(c)
                i += 1
            # Strings
            elif c == '"':
                j = i + 1
                while j < len(expr) and expr[j] != '"':
                    if expr[j] == "\\":
                        j += 1
                    j += 1
                if j >= len(expr):
                    return None
                self.tokens.append(expr[i : j + 1])
                i = j + 1
            # Numbers
            elif c.isdigit() or (c == "-" and i + 1 < len(expr) and expr[i + 1].isdigit()):
                j = i
                if c == "-":
                    j += 1
                while j < len(expr) and expr[j].isdigit():
                    j += 1
                self.tokens.append(expr[i:j])
                i = j
            # Comparison operators
            elif i + 1 < len(expr) and expr[i : i + 2] in ("==", "~=", "<=", ">="):
                self.tokens.append(expr[i : i + 2])
                i += 2
            # Single character operators
            elif c in "<>=":
                self.tokens.append(c)
                i += 1
            # Keywords and identifiers
            elif c.isalpha() or c == "_":
                j = i
                while j < len(expr) and (expr[j].isalnum() or expr[j] == "_"):
                    j += 1
                word = expr[i:j]
                if word == "and":
                    self.tokens.append("and")
                elif word == "or":
                    self.tokens.append("or")
                elif word == "not":
                    self.tokens.append("not")
                elif word == "true":
                    self.tokens.append(True)
                elif word == "false":
                    self.tokens.append(False)
                elif word == "nil":
                    self.tokens.append(None)
                else:
                    self.tokens.append(word)
                i = j
            else:
                return None

        return self.tokens

    def evaluate(self, expr: str) -> Tuple[Optional[Any], Optional[str]]:
        """Evaluate an expression and return (result, error_message)."""
        self.tokens = self.tokenize(expr)
        if self.tokens is None:
            return None, f"Tokenization failed for: {expr}"

        if len(self.tokens) == 0:
            return None, "Empty expression"

        self.pos = 0
        try:
            result = self._parse_or()
            if self.pos < len(self.tokens):
                return None, f"Unexpected tokens in expression: {expr}"
            return result, None
        except Exception as e:
            return None, str(e)

    def _peek(self) -> Optional[Any]:
        if self.pos < len(self.tokens):
            return self.tokens[self.pos]
        return None

    def _consume(self) -> Optional[Any]:
        token = self._peek()
        self.pos += 1
        return token

    def _parse_or(self) -> Any:
        left = self._parse_and()
        while self._peek() == "or":
            self._consume()
            right = self._parse_and()
            left = left or right
        return left

    def _parse_and(self) -> Any:
        left = self._parse_not()
        while self._peek() == "and":
            self._consume()
            right = self._parse_not()
            left = left and right
        return left

    def _parse_not(self) -> Any:
        if self._peek() == "not":
            self._consume()
            val = self._parse_not()
            return not val
        return self._parse_comparison()

    def _parse_comparison(self) -> Any:
        left = self._parse_primary()
        op = self._peek()
        if op in ("==", "~=", "<", "<=", ">", ">="):
            self._consume()
            right = self._parse_primary()
            if op == "==":
                return left == right
            elif op == "~=":
                return left != right
            elif op == "<":
                return left < right
            elif op == "<=":
                return left <= right
            elif op == ">":
                return left > right
            elif op == ">=":
                return left >= right
        return left

    def _parse_primary(self) -> Any:
        token = self._peek()

        if token == "(":
            self._consume()
            val = self._parse_or()
            if self._peek() != ")":
                raise Exception("Expected ')'")
            self._consume()
            return val
        elif isinstance(token, bool) or token is None:
            self._consume()
            return token
        elif isinstance(token, str) and token[0] == '"':
            self._consume()
            # Remove quotes and unescape
            s = token[1:-1]
            s = s.replace('\\"', '"').replace("\\\\", "\\")
            return s
        elif isinstance(token, str) and token.lstrip("-").isdigit():
            self._consume()
            return int(token)
        elif isinstance(token, str):
            # Identifier
            self._consume()
            return self.symbols.get(token)
        else:
            raise Exception(f"Unexpected token: {token}")


class Preprocessor:
    """Single-pass preprocessor for Lua files with conditional compilation, exclusions, and copying."""

    def __init__(self, root_dir: str, cli_symbols: Dict[str, Any], output_dir: Optional[str] = None, 
                 preserve_patterns: Optional[List[str]] = None):
        self.root_dir = Path(root_dir).resolve()
        self.output_dir = Path(output_dir).resolve() if output_dir else None
        self.cli_symbols = cli_symbols
        self.preserve_patterns = preserve_patterns or []  # Glob patterns to preserve in target
        self.excluded_paths: Set[Path] = set()
        self.processing_queue: List[Tuple[Path, Path, bool]] = []  # (source, target, discovered directory)
        self.processed_targets: Set[Path] = set()  # Track what we've already processed
        self.errors: List[str] = []
        self.processed_files = 0
        self._active_entry = False

    def _progress(self, final: bool = False) -> None:
        remaining = len(self.processing_queue) + int(self._active_entry)
        total = self.processed_files + remaining
        filled = 20 * self.processed_files // total if total else 20
        message = (f"[{'#' * filled}{'-' * (20 - filled)}] "
                   f"Processed files: {self.processed_files} | Queue entries left: {remaining}")
        if sys.stdout.isatty():
            print(f"\r\033[K{message}", end="\n" if final else "", flush=True)
        elif final:
            print(message)

    def _log(self, message: str) -> None:
        if sys.stdout.isatty():
            print("\r\033[K", end="")
        print(message)
        if sys.stdout.isatty():
            self._progress()

    def run(self) -> Tuple[bool, List[str]]:
        """Run the preprocessor with queue-based workflow. Returns (success, errors)."""
        try:
            self._log(f"Initial variables: {self.cli_symbols}")
            if self.output_dir:
                self.output_dir.mkdir(parents=True, exist_ok=True)
                
                # Always clean target directory before processing
                # Preserves files matching preserve patterns (if any)
                self._clean_target_directory()
            
            # Start by processing the input directory
            self.processing_queue.append((self.root_dir, self.output_dir or self.root_dir, True))
            self._progress()

            # Process queue until empty
            while self.processing_queue:
                source_path, target_path, discovered_directory = self.processing_queue.pop(0)
                self._active_entry = True
                try:
                    if self._matches_preserve_pattern(target_path):
                        self._log(f"Skipping {target_path} (preserved)")
                        continue

                    if self._is_in_exclude_set(target_path):
                        self._log(f"Skipping {target_path} (excluded)")
                        continue

                    if not discovered_directory and target_path in self.processed_targets:
                        self._log(f"Skipping {target_path} (already processed)")
                        continue

                    if not discovered_directory:
                        self.processed_targets.add(target_path)

                    if source_path.is_file():
                        if source_path.suffix == ".lua":
                            self._log(f"Processing {source_path} -> {target_path}")
                            if not self._process_file(source_path, target_path):
                                return False, self.errors
                            self.processed_files += 1
                        elif source_path != target_path:
                            self._copy_file(source_path, target_path)
                        else:
                            self._log(f"Skipping {source_path} (unchanged in place)")
                    elif source_path.is_dir():
                        self._log(f"Processing directory {source_path} -> {target_path}")
                        if self.output_dir and source_path != target_path and self._is_non_lua_leaf(source_path):
                            self._copy_directory(source_path, target_path)
                        else:
                            self._discover_and_queue_files(source_path, target_path)
                    else:
                        self._log(f"Skipping {source_path} (does not exist)")
                finally:
                    self._active_entry = False
                    self._progress()
            
            # Delete excluded paths (deepest first to avoid cascading errors)
            for excluded_path in sorted(self.excluded_paths, key=lambda p: -len(p.parts)):
                self._delete_path(excluded_path)

            self._log("Preprocessing complete")
            return True, self.errors
        except Exception as e:
            self.errors.append(str(e))
            return False, self.errors
        finally:
            self._progress(final=True)

    def _discover_and_queue_files(self, source_root: Path, target_root: Path) -> None:
        """Queue the directory's immediate files and subdirectories."""
        children = []
        for source_item in sorted(source_root.iterdir()):
            target_item = target_root / source_item.name
            if source_item.is_file():
                children.append((source_item, target_item, False))
            elif source_item.is_dir() and not source_item.is_symlink():
                children.append((source_item, target_item, True))
        self.processing_queue[0:0] = children

    def _is_non_lua_leaf(self, directory: Path) -> bool:
        return all(item.is_file() and item.suffix != ".lua" for item in directory.iterdir())

    def _copy_file(self, source: Path, target: Path) -> None:
        self._log(f"Processing {source} -> {target}")
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, target)
        self.processed_files += 1
        self._progress()

    def _copy_directory(self, source: Path, target: Path) -> None:
        def ignore(directory: str, names: List[str]) -> List[str]:
            ignored = []
            for name in names:
                target_file = target / name
                if self._matches_preserve_pattern(target_file):
                    self._log(f"Skipping {target_file} (preserved)")
                    ignored.append(name)
                elif target_file in self.processed_targets:
                    self._log(f"Skipping {target_file} (already processed)")
                    ignored.append(name)
            return ignored

        def copy_file(source_file: str, target_file: str) -> str:
            source_path = Path(source_file)
            target_path = Path(target_file)
            self._copy_file(source_path, target_path)
            self.processed_targets.add(target_path)
            return target_file

        shutil.copytree(source, target, dirs_exist_ok=True, ignore=ignore, copy_function=copy_file)

    def _matches_preserve_pattern(self, target_path: Path) -> bool:
        """Check the target and its ancestor directories against preserve patterns."""
        if not self.preserve_patterns or not self.output_dir:
            return False

        try:
            rel_path = target_path.relative_to(self.output_dir)
        except ValueError:
            return False

        for path in (rel_path, *rel_path.parents):
            if path == Path("."):
                continue
            path_str = path.as_posix()
            for pattern in self.preserve_patterns:
                if self._path_matches_pattern(path_str, pattern.rstrip("/")):
                    return True
        return False
    
    def _path_matches_pattern(self, path_str: str, pattern: str) -> bool:
        """Check if path matches a glob pattern, handling ** wildcards."""
        from pathlib import PurePath
        import fnmatch
        
        # Handle ** patterns (recursive matching)
        if "**" in pattern:
            # Replace ** with a placeholder, convert *, then handle **
            parts = pattern.split("/")
            path_parts = path_str.split("/")
            
            # Simple approach: ** matches zero or more path components
            return self._glob_matches(path_parts, parts)
        else:
            # Standard fnmatch for single-level patterns
            return fnmatch.fnmatch(path_str, pattern)
    
    def _glob_matches(self, path_parts: List[str], pattern_parts: List[str]) -> bool:
        """Recursively match path components against glob pattern."""
        import fnmatch
        
        if not pattern_parts:
            return not path_parts
        
        pattern = pattern_parts[0]
        
        if pattern == "**":
            # ** can match zero or more path components
            # Try matching with zero components consumed
            if self._glob_matches(path_parts, pattern_parts[1:]):
                return True
            # Try matching with one component consumed
            if path_parts and self._glob_matches(path_parts[1:], pattern_parts):
                return True
            return False
        elif fnmatch.fnmatch(path_parts[0] if path_parts else "", pattern):
            # Current component matches, advance both
            return self._glob_matches(path_parts[1:], pattern_parts[1:])
        else:
            return False

    def _clean_target_directory(self) -> None:
        """Delete all files from target directory except those matching preserve patterns."""
        if not self.output_dir or not self.output_dir.exists():
            return

        if not self.preserve_patterns:
            protected = (self.root_dir, Path(__file__).resolve(), Path.cwd().resolve(), Path.home().resolve())
            if (any(self.output_dir == path or self.output_dir in path.parents for path in protected)
                    or self.root_dir in self.output_dir.parents):
                raise PreprocessorError(f"Refusing to clean unsafe output directory: {self.output_dir}")

            for item in self.output_dir.iterdir():
                try:
                    if item.is_symlink() or not item.is_dir():
                        item.unlink()
                        self._log(f"Deleted {item}")
                    else:
                        shutil.rmtree(item)
                        self._log(f"Deleted directory {item}")
                except OSError as e:
                    raise PreprocessorError(f"Failed to clean {item}: {e}") from e
            return
        
        for item in self.output_dir.iterdir():
            try:
                self._delete_unpreserved_path(item)
            except OSError as e:
                raise PreprocessorError(f"Failed to clean {item}: {e}") from e

    def _delete_unpreserved_path(self, path: Path) -> bool:
        if self._matches_preserve_pattern(path):
            self._log(f"Skipping {path} (preserved)")
            return False
        if path.is_symlink() or not path.is_dir():
            path.unlink()
            self._log(f"Deleted {path}")
            return True

        all_deleted = True
        for item in path.iterdir():
            if not self._delete_unpreserved_path(item):
                all_deleted = False
        if all_deleted:
            path.rmdir()
            self._log(f"Deleted directory {path}")
        else:
            self._log(f"Skipping directory {path} (not empty)")
        return all_deleted

    def _is_in_exclude_set(self, path: Path) -> bool:
        """Check if a path is in the exclude set."""
        try:
            path = path.resolve()
            for excluded in self.excluded_paths:
                if path == excluded or self._is_child_of(path, excluded):
                    return True
        except Exception:
            pass
        return False

    def _is_child_of(self, child: Path, parent: Path) -> bool:
        """Check if child is under parent directory."""
        try:
            child.relative_to(parent)
            return True
        except ValueError:
            return False

    def _delete_path(self, path: Path) -> None:
        """Delete a file or directory."""
        try:
            if not path.exists() and not path.is_symlink():
                self._log(f"Skipping {path} (does not exist)")
            elif self.preserve_patterns and self.output_dir:
                self._delete_unpreserved_path(path)
            elif path.is_symlink():
                path.unlink()
                self._log(f"Deleted {path}")
            elif path.is_dir():
                shutil.rmtree(path)
                self._log(f"Deleted directory {path}")
            else:
                path.unlink()
                self._log(f"Deleted {path}")
        except OSError as e:
            raise PreprocessorError(f"Failed to delete {path}: {e}") from e

    def _resolve_relative_path(self, base_file: Path, rel_path: str) -> Path:
        """Resolve a path relative to a file's directory."""
        base_dir = base_file.parent
        target = base_dir / rel_path
        try:
            return target.resolve()
        except Exception:
            return target

    def _process_file(self, source_file: Path, target_file: Path) -> bool:
        """Process file: track conditionals and collect exclusions/copies based on state.
        
        source_file: original file to read
        target_file: where file will be written (used for exclude path resolution)
        """
        try:
            with open(source_file, "r", encoding="utf-8") as f:
                lines = f.readlines()
        except Exception as e:
            self.errors.append(f"{source_file}: {e}")
            return False

        if not any(line.startswith("--#") for line in lines):
            try:
                if source_file.resolve() != target_file.resolve():
                    target_file.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copyfile(source_file, target_file)
            except OSError as e:
                self.errors.append(f"Failed to copy {source_file} to {target_file}: {e}")
                return False
            return True

        # File-local symbols start with CLI symbols
        file_symbols = self.cli_symbols.copy()
        evaluator = ExpressionEvaluator(file_symbols)

        output = []
        condition_stack: List[Dict[str, Any]] = []
        i = 0

        while i < len(lines):
            line = lines[i].rstrip("\n")

            # --#define NAME VALUE
            match = re.match(r"^--#define\s+([a-zA-Z_]\w*)\s+(.+)$", line)
            if match:
                name = match.group(1)
                value_str = match.group(2).strip()
                if value_str == "true":
                    file_symbols[name] = True
                elif value_str == "false":
                    file_symbols[name] = False
                elif value_str == "nil":
                    file_symbols[name] = None
                elif value_str.lstrip("-").isdigit():
                    file_symbols[name] = int(value_str)
                elif value_str.startswith('"') and value_str.endswith('"'):
                    s = value_str[1:-1]
                    s = s.replace('\\"', '"').replace("\\\\", "\\")
                    file_symbols[name] = s
                else:
                    file_symbols[name] = value_str
                evaluator.symbols = file_symbols
                i += 1
                continue

            # --#if EXPR
            match = re.match(r"^--#if\s+(.+)$", line)
            if match:
                expr_str = match.group(1)
                result, err = evaluator.evaluate(expr_str)
                if err:
                    self.errors.append(f"{file_path}:{i + 1}: {err}")
                    return False
                if result is None:
                    result = False
                condition_stack.append({"active": result, "found_true": result})
                i += 1
                continue

            # --#elseif EXPR
            match = re.match(r"^--#elseif\s+(.+)$", line)
            if match:
                if not condition_stack:
                    self.errors.append(f"{file_path}:{i + 1}: elseif without if")
                    return False
                expr_str = match.group(1)
                current = condition_stack[-1]
                if current["found_true"]:
                    current["active"] = False
                else:
                    result, err = evaluator.evaluate(expr_str)
                    if err:
                        self.errors.append(f"{file_path}:{i + 1}: {err}")
                        return False
                    if result is None:
                        result = False
                    current["active"] = result
                    if result:
                        current["found_true"] = True
                i += 1
                continue

            # --#else
            if re.match(r"^--#else\s*$", line):
                if not condition_stack:
                    self.errors.append(f"{file_path}:{i + 1}: else without if")
                    return False
                current = condition_stack[-1]
                current["active"] = not current["found_true"]
                current["found_true"] = True
                i += 1
                continue

            # --#endif
            if re.match(r"^--#endif\s*$", line):
                if not condition_stack:
                    self.errors.append(f"{file_path}:{i + 1}: endif without if")
                    return False
                condition_stack.pop()
                i += 1
                continue

            # Check if we're currently inside an active condition
            should_include = all(cond["active"] for cond in condition_stack)

            # --#exclude if EXPR (exclude target file itself, respects conditions)
            match = re.match(r"^--#exclude\s+if\s+(.+)$", line)
            if match and should_include:
                expr_str = match.group(1)
                result, err = evaluator.evaluate(expr_str)
                if err:
                    self.errors.append(f"{source_file}:{i + 1}: {err}")
                    return False
                if result:
                    self.excluded_paths.add(target_file)
                i += 1
                continue

            # --#exclude "PATH" (respects conditions, resolved relative to source file)
            match = re.match(r'^--#exclude\s+"([^"]*)"$', line)
            if match and should_include:
                path_str = match.group(1)
                source_excluded = self._resolve_relative_path(source_file, path_str)
                # Map to target location
                try:
                    rel_path = source_excluded.relative_to(self.root_dir)
                    target_excluded = (self.output_dir if self.output_dir else self.root_dir) / rel_path
                    self.excluded_paths.add(target_excluded)
                except ValueError:
                    self.errors.append(f"{source_file}:{i + 1}: Cannot resolve excluded path: {source_excluded}")
                    return False
                i += 1
                continue

            # --#exclude "PATH" if EXPR (respects conditions)
            match = re.match(r'^--#exclude\s+"([^"]*)"\s+if\s+(.+)$', line)
            if match and should_include:
                path_str = match.group(1)
                expr_str = match.group(2)
                result, err = evaluator.evaluate(expr_str)
                if err:
                    self.errors.append(f"{source_file}:{i + 1}: {err}")
                    return False
                if result:
                    source_excluded = self._resolve_relative_path(source_file, path_str)
                    try:
                        rel_path = source_excluded.relative_to(self.root_dir)
                        target_excluded = (self.output_dir if self.output_dir else self.root_dir) / rel_path
                        self.excluded_paths.add(target_excluded)
                    except ValueError:
                        self.errors.append(f"{source_file}:{i + 1}: Cannot resolve excluded path: {source_excluded}")
                        return False
                i += 1
                continue

            # --#copy "SOURCE" to "TARGET" (respects conditions, queues for processing)
            match = re.match(r'^--#copy\s+"([^"]*)"\s+to\s+"([^"]*)"$', line)
            if match and should_include:
                source_str = match.group(1)
                target_str = match.group(2)
                source_copy = self._resolve_relative_path(source_file, source_str)
                if not source_copy.exists():
                    self.errors.append(f"{source_file}:{i + 1}: Copy source does not exist: {source_copy}")
                    return False
                # Target path is relative to output root
                target_copy = (self.output_dir if self.output_dir else self.root_dir) / target_str
                self.processing_queue.append((source_copy, target_copy, False))
                i += 1
                continue

            # --#copy "SOURCE" to "TARGET" if EXPR
            match = re.match(r'^--#copy\s+"([^"]*)"\s+to\s+"([^"]*)"\s+if\s+(.+)$', line)
            if match and should_include:
                source_str = match.group(1)
                target_str = match.group(2)
                expr_str = match.group(3)
                result, err = evaluator.evaluate(expr_str)
                if err:
                    self.errors.append(f"{source_file}:{i + 1}: {err}")
                    return False
                if result:
                    source_copy = self._resolve_relative_path(source_file, source_str)
                    if not source_copy.exists():
                        self.errors.append(f"{source_file}:{i + 1}: Copy source does not exist: {source_copy}")
                        return False
                    target_copy = (self.output_dir if self.output_dir else self.root_dir) / target_str
                    self.processing_queue.append((source_copy, target_copy, False))
                i += 1
                continue

            # --#copy "PATH" (respects conditions, queues for processing)
            # When source is inside root_dir, auto-map to equivalent location in target
            # When source is outside root_dir, copy to root with same name
            match = re.match(r'^--#copy\s+"([^"]*)"$', line)
            if match and should_include:
                path_str = match.group(1)
                source_copy = self._resolve_relative_path(source_file, path_str)
                if not source_copy.exists():
                    self.errors.append(f"{source_file}:{i + 1}: Copy source does not exist: {source_copy}")
                    return False
                # Queue for processing (maps source to target location)
                try:
                    rel_path = source_copy.relative_to(self.root_dir)
                    target_copy = (self.output_dir if self.output_dir else self.root_dir) / rel_path
                except ValueError:
                    # Source is outside root_dir, copy to output root with source's name
                    if source_copy.is_dir():
                        target_copy = (self.output_dir if self.output_dir else self.root_dir) / source_copy.name
                    else:
                        target_copy = (self.output_dir if self.output_dir else self.root_dir) / source_copy.name
                self.processing_queue.append((source_copy, target_copy, False))
                i += 1
                continue

            # --#copy "PATH" if EXPR (respects conditions)
            match = re.match(r'^--#copy\s+"([^"]*)"\s+if\s+(.+)$', line)
            if match and should_include:
                path_str = match.group(1)
                expr_str = match.group(2)
                result, err = evaluator.evaluate(expr_str)
                if err:
                    self.errors.append(f"{source_file}:{i + 1}: {err}")
                    return False
                if result:
                    source_copy = self._resolve_relative_path(source_file, path_str)
                    if not source_copy.exists():
                        self.errors.append(f"{source_file}:{i + 1}: Copy source does not exist: {source_copy}")
                        return False
                    try:
                        rel_path = source_copy.relative_to(self.root_dir)
                        target_copy = (self.output_dir if self.output_dir else self.root_dir) / rel_path
                    except ValueError:
                        # Source is outside root_dir, copy to output root with source's name
                        if source_copy.is_dir():
                            target_copy = (self.output_dir if self.output_dir else self.root_dir) / source_copy.name
                        else:
                            target_copy = (self.output_dir if self.output_dir else self.root_dir) / source_copy.name
                    self.processing_queue.append((source_copy, target_copy, False))
                i += 1
                continue

            # Regular line: include if all active conditions are true
            if should_include and not re.match(r"^--#(exclude|copy)", line):
                output.append(line)

            i += 1

        if condition_stack:
            self.errors.append(f"{source_file}: Unclosed conditional block")
            return False

        # Write output to target location
        try:
            target_file.parent.mkdir(parents=True, exist_ok=True)
            with open(target_file, "w", encoding="utf-8") as f:
                for line in output:
                    f.write(line + "\n")
        except Exception as e:
            self.errors.append(f"{target_file}: {e}")
            return False

        return True


def parse_cli_args(args: List[str]) -> Tuple[Optional[str], Optional[str], Dict[str, Any], List[str]]:
    """Parse CLI arguments.
    
    Modes:
      - In-place: python preprocess.py <directory> [SYMBOL=value ...] [--preserve PATTERN]...
      - Out-of-place: python preprocess.py --input <input> --output <output> [SYMBOL=value ...] [--preserve PATTERN]...
    """
    if len(args) < 1:
        raise PreprocessorError(
            "Usage: python preprocess.py <directory> [SYMBOL=value ...] [--preserve PATTERN]...\n"
            "   or: python preprocess.py --input <input> --output <output> [SYMBOL=value ...] [--preserve PATTERN]..."
        )

    input_dir = None
    output_dir = None
    symbols = {}
    preserve_patterns = []
    i = 0

    # Check for --input/--output mode
    if args[0] == "--input":
        if len(args) < 2:
            raise PreprocessorError("--input requires an argument")
        input_dir = args[1]
        i = 2

        if i >= len(args) or args[i] != "--output":
            raise PreprocessorError("--input requires --output")
        if i + 1 >= len(args):
            raise PreprocessorError("--output requires an argument")
        output_dir = args[i + 1]
        i += 2
    else:
        # In-place mode: first arg is directory
        input_dir = args[0]
        i = 1

    # Parse remaining SYMBOL=value and --preserve arguments
    while i < len(args):
        arg = args[i]
        
        if arg == "--preserve":
            if i + 1 >= len(args) or args[i + 1].startswith("-"):
                raise PreprocessorError("--preserve requires a pattern")
            preserve_patterns.append(args[i + 1])
            i += 2
            continue
        
        if "=" not in arg:
            raise PreprocessorError(f"Invalid argument: {arg}")
        
        name, value_str = arg.split("=", 1)
        if not re.match(r"^[a-zA-Z_]\w*$", name):
            raise PreprocessorError(f"Invalid symbol name: {name}")

        if value_str == "true":
            symbols[name] = True
        elif value_str == "false":
            symbols[name] = False
        elif value_str == "nil":
            symbols[name] = None
        elif value_str.lstrip("-").isdigit():
            symbols[name] = int(value_str)
        else:
            symbols[name] = value_str
        
        i += 1

    return input_dir, output_dir, symbols, preserve_patterns


if __name__ == "__main__":
    try:
        input_dir, output_dir, symbols, preserve_patterns = parse_cli_args(sys.argv[1:])
        preprocessor = Preprocessor(input_dir, symbols, output_dir, preserve_patterns)
        success, errors = preprocessor.run()

        for error in errors:
            print(f"Error: {error}", file=sys.stderr)

        if success:
            sys.exit(0)
        else:
            sys.exit(1)
    except PreprocessorError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Unexpected error: {e}", file=sys.stderr)
        sys.exit(1)

