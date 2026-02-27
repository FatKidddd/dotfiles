# LLM context/prompt generation
# Usage (context): llm [-v] [-c] [-s] [path]
# Usage (prompt):  llm -p "Your request..." [path]
function llm() {
  local MAX_DATA_FILE_LINES=200
  local DATA_EXTENSIONS=("csv" "json" "jsonl" "log" "txt" "xml" "tsv")
  local default_ignore_patterns=(
    ".git/" ".idea/" ".vscode/" ".next/" ".svelte-kit/" ".terragrunt-cache/" ".terraform/"
    "node_modules/" "venv/" ".venv/" "__pycache__/" "dist/" "build/" "target/" "public/build/"
    "coverage/" "cache/" ".cache/" "vendor/" "obj/" "bin/"
    ".DS_Store" "package-lock.json" "yarn.lock" "pnpm-lock.yaml" "composer.lock"
    "*.7z" "*.a" "*.ar" "*.rar" "*.so" "*.tar" "*.tgz" "*.zip" "*.bmp" "*.gif" "*.jpeg" "*.jpg" "*.png"
    "*.svg" "*.webp" "*.heic" "*.avi" "*.flv" "*.mkv" "*.mov" "*.mp3" "*.mp4" "*.mpeg" "*.ogg" "*.wav"
    "*.pdf" "*.doc" "*.docx" "*.odt" "*.xls" "*.xlsx" "*.eot" "*.otf" "*.ttf" "*.woff" "*.woff2"
    "*.bin" "*.class" "*.com" "*.dll" "*.dylib" "*.exe" "*.o" "*.pyc" "*.db" "*.db3-journal"
    "*.lock" "*.sqlite" "*.sqlite3" "*.swp" "*.swo" "*.min.css" "*.min.js"
  )

  function _llm_smart_truncate() {
    local file_path="$1" max_lines="$2"
    local truncate_notice="\n... (truncated) ...\n"
    local extension="${file_path##*.}"
    case "$extension" in
      csv)
        head -n "$max_lines" "$file_path" < /dev/null
        echo -e "$truncate_notice" ;;
      json)
        if command -v jq >/dev/null 2>&1; then
          jq "walk(if type == \"array\" and length > 50 then .[:50] else . end)" "$file_path" < /dev/null 2>/dev/null \
            || { head -n $((max_lines / 2)) "$file_path" < /dev/null; echo -e "$truncate_notice"; tail -n $((max_lines / 2)) "$file_path" < /dev/null; }
        else
          head -n $((max_lines / 2)) "$file_path" < /dev/null
          echo -e "$truncate_notice"
          tail -n $((max_lines / 2)) "$file_path" < /dev/null
        fi ;;
      log)
        echo "[Log truncated — showing last $max_lines lines]"
        tail -n "$max_lines" "$file_path" < /dev/null ;;
      *)
        head -n $((max_lines / 2)) "$file_path" < /dev/null
        echo -e "$truncate_notice"
        tail -n $((max_lines / 2)) "$file_path" < /dev/null ;;
    esac
  }

  local target_path="." verbose=0 output_to_clipboard=1 save_to_file=1 raw_output=0 user_prompt=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -p|--prompt)
        [[ -z "$2" || "$2" == -* ]] && { echo "Error: --prompt requires an argument." >&2; return 1; }
        user_prompt="$2"; shift 2 ;;
      -v|--verbose)        verbose=1; shift ;;
      -c|--clipboard-only) output_to_clipboard=1; save_to_file=0; shift ;;
      -s|--save-only)      output_to_clipboard=0; save_to_file=1; shift ;;
      --raw)               raw_output=1; verbose=1; output_to_clipboard=0; save_to_file=0; shift ;;
      -*)                  echo "Error: Unknown option '$1'" >&2; return 1 ;;
      *)
        [[ -n "$target_path" && "$target_path" != "." ]] && { echo "Error: Only one path argument allowed." >&2; return 1; }
        target_path="$1"; shift ;;
    esac
  done

  # Clipboard detection
  local -a clip_cmd
  if command -v wl-copy >/dev/null 2>&1; then clip_cmd=("wl-copy")
  elif command -v xsel >/dev/null 2>&1; then clip_cmd=("xsel" "--clipboard" "--input")
  fi

  # --- Prompt mode ---
  if [[ -n "$user_prompt" ]]; then
    [[ ${#clip_cmd} -eq 0 ]] && { echo "Error: No clipboard utility found." >&2; return 1; }
    {
      echo "You are an expert programmer and senior software architect."
      echo "Your task is to fulfill the user's request by providing the complete, updated content for any modified files."
      echo ""
      echo "# User Request"
      echo "$user_prompt"
      echo ""
      echo "---"
      echo "# Project Context"
      echo ""
      llm --raw "$target_path"
      echo ""
      echo "---"
      echo "# Instructions"
      echo ""
      echo "1.  Start with a brief summary of changes."
      echo "2.  Provide **complete, updated content** for every modified/created file (no diffs/patches)."
      echo "3.  Format each file in a Markdown code block with info string: \`language:path/to/file.ext\`"
    } | "${clip_cmd[@]}"
    echo "Prompt copied to clipboard. Paste into LLM, save response, then run: llm_apply <file>"
    return 0
  fi

  # --- Context mode ---
  [[ ! -e "$target_path" ]] && { echo "Error: Path '$target_path' does not exist." >&2; return 1; }
  target_path=$(realpath "$target_path" 2>/dev/null || readlink -f "$target_path" 2>/dev/null || echo "$target_path")

  [[ "$output_to_clipboard" -eq 1 && ${#clip_cmd} -eq 0 && "$raw_output" -eq 0 ]] && {
    echo "Warning: No clipboard utility found." >&2; output_to_clipboard=0
  }

  local output_dir="$HOME/.llm_contexts"
  [[ "$save_to_file" -eq 1 ]] && mkdir -p "$output_dir"
  local base_name timestamp output_path
  base_name=$(basename "$target_path" 2>/dev/null || basename "$PWD")
  timestamp=$(date +%Y%m%d-%H%M%S)
  output_path="${output_dir}/${base_name}-${timestamp}.txt"

  {
    if [[ -f "$target_path" ]]; then
      echo "--- FILE: $(basename "$target_path") ---"
      cat "$target_path"
      echo
    else
      # Build ignore list
      local -a all_ignore_patterns
      all_ignore_patterns=("${default_ignore_patterns[@]}")

      function _llm_read_ignore_file() {
        local line pattern
        while IFS= read -r line || [[ -n "$line" ]]; do
          pattern="${line#"${line%%[! ]*}"}"  # ltrim
          pattern="${pattern%"${pattern##*[! ]}"}"  # rtrim
          [[ -z "$pattern" || "$pattern" == \#* || "$pattern" == \!* ]] && continue
          all_ignore_patterns+=("$pattern")
        done < "$1"
      }

      # Find project root
      local search_root="" current_path="$target_path"
      while [[ "$current_path" != "/" && -n "$current_path" ]]; do
        if [[ -d "${current_path}/.git" ]]; then search_root="$current_path"; break; fi
        current_path=$(dirname "$current_path")
      done
      [[ -z "$search_root" ]] && search_root="$target_path"

      [[ -f "${search_root}/.gitignore" ]] && _llm_read_ignore_file "${search_root}/.gitignore"
      [[ -f "${search_root}/.llmignore" ]] && _llm_read_ignore_file "${search_root}/.llmignore"

      # Build find args
      local -a prune_paths exclude_conditions find_args
      local pattern
      for pattern in "${all_ignore_patterns[@]}"; do
        if [[ "$pattern" == */ ]]; then
          prune_paths+=("-o" "-path" "./${pattern}*")
        elif [[ "$pattern" == *"/"* ]]; then
          exclude_conditions+=("-not" "-path" "./$pattern")
        else
          exclude_conditions+=("-not" "-name" "$pattern")
        fi
      done

      [[ ${#prune_paths[@]} -gt 0 ]] && find_args+=(\( "${prune_paths[@]:1}" \) -prune -o)
      find_args+=(-type f "${exclude_conditions[@]}" -print0)

      # Run find and process files
      local rel
      [[ "$target_path" == "$search_root" ]] && rel="." || rel="${target_path#$search_root/}"

      (cd "$search_root" && find "$rel" "${find_args[@]}") \
        | while IFS= read -r -d '' file; do
          local clean_file="${file#./}"
          local abs_file="${search_root}/${clean_file}"
          local mime_type="$(file -b --mime-type "$abs_file" 2>/dev/null)"

          [[ "$mime_type" != text/* && "$mime_type" != application/json && "$mime_type" != application/xml ]] && continue

          [[ "$verbose" -eq 1 ]] && echo "  -> $clean_file" >&2
          echo "--- FILE: $clean_file ---"

          local ext="${clean_file##*.}"
          if [[ " ${DATA_EXTENSIONS[@]} " =~ " ${ext} " ]]; then
            local lc="$(wc -l < "$abs_file" | tr -d ' ')"
            if (( lc > MAX_DATA_FILE_LINES )); then
              _llm_smart_truncate "$abs_file" "$MAX_DATA_FILE_LINES"
            else
              cat "$abs_file"
            fi
          else
            cat "$abs_file"
          fi
          echo
          echo
        done
    fi
  } | {
    if   [[ "$raw_output"        -eq 1 ]]; then cat
    elif [[ "$save_to_file" -eq 1 && "$output_to_clipboard" -eq 1 ]]; then tee "$output_path" | "${clip_cmd[@]}"
    elif [[ "$save_to_file"      -eq 1 ]]; then cat > "$output_path"
    elif [[ "$output_to_clipboard" -eq 1 ]]; then "${clip_cmd[@]}"
    fi
  }

  if [[ "$raw_output" -eq 0 ]]; then
    local char_count=0
    [[ "$save_to_file" -eq 1 && -f "$output_path" ]] && char_count=$(wc -m < "$output_path" | tr -d ' ')
    local token_estimate=$(( (char_count + 3) / 4 ))
    [[ "$output_to_clipboard" -eq 1 ]] && echo "Content from '$(basename "$target_path")' copied to clipboard."
    if [[ "$save_to_file" -eq 1 ]]; then echo "   ~${token_estimate} tokens saved to: $output_path"
    else echo "   (Not saved. Use default or --save-only to save.)"; fi
  fi
}

# Apply LLM-generated file changes from a response file
# Usage: llm_apply [-d|--dry-run] [-i|--interactive] [-b|--backup] <llm_response.md>
function llm_apply() {
  command -v diff >/dev/null 2>&1 || { echo "Error: 'diff' not found." >&2; return 1; }
  command -v gawk >/dev/null 2>&1 || { echo "Error: 'gawk' not found." >&2; return 1; }

  zmodload zsh/zutil
  zparseopts -D -E -- \
    d=dry_run    -dry-run=dry_run \
    i=interactive -interactive=interactive \
    b=backup     -backup=backup

  [[ $# -ne 1 ]] && { echo "Usage: llm_apply [-d | -i] [-b] <llm_response.md>" >&2; return 1; }
  [[ ! -f "$1" ]] && { echo "Error: File not found: $1" >&2; return 1; }

  gawk '
    BEGIN { start_regex = "^`{3,}[a-zA-Z0-9._-]+:([^`[:space:]]+)" }
    match($0, start_regex, parts) {
      if (in_block) { printf "%s\0%s\0", current_path, current_content }
      in_block = 1; current_path = parts[1]; current_content = ""; next
    }
    in_block && /^`{3,}[[:space:]]*$/ {
      printf "%s\0%s\0", current_path, current_content
      in_block = 0; next
    }
    in_block { gsub(/\r/, "", $0); current_content = current_content $0 "\n" }
    END      { if (in_block) { printf "%s\0%s\0", current_path, current_content } }
  ' "$1" | while IFS= read -r -d '' file_path && IFS= read -r -d '' new_content; do
    file_path=$(echo -n "$file_path" | xargs)
    [[ -z "$file_path" ]] && continue

    echo "\n─────────────────────────────────────────────────────"
    echo "File: $file_path"
    echo "─────────────────────────────────────────────────────"

    local apply=0
    if [[ -n "$dry_run" || -n "$interactive" ]]; then
      if [[ -f "$file_path" ]]; then
        echo "Diff vs existing:"
        diff -u --color=always "$file_path" <(printf "%s" "$new_content") || true
      else
        echo "New file. Preview:"
        printf "%s" "$new_content" | sed 's/^/+ /'
      fi
      if [[ -n "$interactive" ]]; then
        local reply
        vared -p 'Apply? [y/N/q] ' -c reply
        case "$reply" in
          [yY]) apply=1 ;;
          [qQ]) echo "Quit."; return 0 ;;
          *)    echo "Skipped." ;;
        esac
      fi
    else
      apply=1
    fi

    if [[ $apply -eq 1 ]]; then
      [[ ! -d "$(dirname "$file_path")" ]] && mkdir -p "$(dirname "$file_path")"
      [[ -n "$backup" && -f "$file_path" ]] && cp "$file_path" "${file_path}.bak"
      printf "%s" "$new_content" > "$file_path"
      echo "Applied."
    elif [[ -z "$dry_run" ]]; then
      echo "Skipped."
    fi
  done

  echo "\n─────────────────────────────────────────────────────"
  echo "Done."
  [[ -n "$dry_run" ]] && echo "(Dry run — no files changed.)"
}
