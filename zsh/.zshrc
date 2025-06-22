# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(history)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

export LS_COLORS="rs=0:no=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32:"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

plugins=(
    command-not-found
    extract
    # deno
    # docker
    git
    # github
    # gitignore
    fzf
    # node
    # npm
    # nvm
    poetry
    # yarn
    volta
    vscode
    # sudo
    # web-search
    zoxide
    zsh-autosuggestions
    zsh-syntax-highlighting
    # zsh-history-substring-search
    # ohmyzsh-full-autoupdate
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
if command -v nvim > /dev/null 2>&1; then
  alias vim='nvim'
else
  alias vim='vim'
fi

alias conf="nvim ~/dotfiles/zsh/.zshrc"
alias nvimrc="nvim ~/dotfiles/nvim/.config/nvim/init.lua"

alias poet="source \$(poetry env info --path)/bin/activate"

alias upev="sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y"

alias ls="eza -ah --color=auto --group-directories-first --icons"
alias lh="eza -ah --color=auto --group-directories-first --icons"
alias l="eza -ah --color=auto --group-directories-first --icons"
alias :q="exit"

alias lg="lazygit"
alias c="clear"

alias cdde="cd /mnt/c/Users/justi/Desktop/";
alias cddo="cd /mnt/c/Users/justi/Downloads/";

alias gitzip="git archive HEAD -o ${PWD##*/}.zip"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:$HOME/.nvim/bin"

VOLTA_FEATURE_PNPM=1
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

alias npm=pnpm

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

. "$HOME/.cargo/env"
export PATH="$PATH:$HOME/.local/bin" # for protoc rust

# for clangd lsp to know where header files are
export CPLUS_INCLUDE_PATH="/usr/include/c++/13:/usr/include/x86_64-linux-gnu/c++/13"
export CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH:$HOME/CP/ac-library"

export PATH="$PATH:$HOME/.foundry/bin"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"

# Searches for and activates a Python .venv at the root of the current git repository.
function vup() {
  # 1. Find the root of the git repository.
  # The '2>/dev/null' silences errors if you're not in a git repo.
  local repo_root
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null)

  # 2. Check if we are actually in a git repository.
  if [[ -z "$repo_root" ]]; then
    echo "vup: Not inside a git repository." >&2
    return 1
  fi

  # 3. Define the potential path to the activate script.
  local venv_path="$repo_root/.venv/bin/activate"

  # 4. Check if the activate script exists and source it.
  if [[ -f "$venv_path" ]]; then
    source "$venv_path"
    echo "vup: Activated virtual environment at: $repo_root/.venv"
  else
    echo "vup: No '.venv/bin/activate' found at the root of this git repository." >&2
    return 1
  fi
}

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# -----------------------------------------------------------------------------
# llm - A multi-purpose LLM context and prompt generation tool.
#
# By default, concatenates project files for LLM context.
# With the --prompt flag, it wraps that context in a structured
# prompt for code generation tasks.
#
# Now extends .gitignore with .llmignore for a comprehensive ignore list.
#
# -- CONTEXT MODE --
# Usage: llm [-v] [-c] [-s] [path]
#
# -- PROMPT MODE --
# Usage: llm -p "Your request..." [path]
# -----------------------------------------------------------------------------
function llm() {
  # --- Configuration ---
  local MAX_DATA_FILE_LINES=200
  local DATA_EXTENSIONS=(
    "csv" "json" "jsonl" "log" "txt" "xml" "tsv"
  )
  local default_ignore_patterns=(
    # Directories (must end with /)
    ".git/" ".idea/" ".vscode/" ".next/" ".svelte-kit/" ".terragrunt-cache/" ".terraform/"
    "node_modules/" "venv/" ".venv/" "__pycache__/" "dist/" "build/" "target/" "public/build/"
    "coverage/" "cache/" ".cache/" "vendor/" "obj/" "bin/"
    # Files by exact name
    ".DS_Store" "package-lock.json" "yarn.lock" "pnpm-lock.yaml" "composer.lock"
    # Files by wildcard pattern (binary/unhelpful)
    "*.7z" "*.a" "*.ar" "*.rar" "*.so" "*.tar" "*.tgz" "*.zip" "*.bmp" "*.gif" "*.jpeg" "*.jpg" "*.png"
    "*.svg" "*.webp" "*.heic" "*.avi" "*.flv" "*.mkv" "*.mov" "*.mp3" "*.mp4" "*.mpeg" "*.ogg" "*.wav"
    "*.pdf" "*.doc" "*.docx" "*.odt" "*.xls" "*.xlsx" "*.eot" "*.otf" "*.ttf" "*.woff" "*.woff2"
    "*.bin" "*.class" "*.com" "*.dll" "*.dylib" "*.exe" "*.o" "*.pyc" "*.db" "*.db3-journal"
    "*.lock" "*.sqlite" "*.sqlite3" "*.swp" "*.swo" "*.min.css" "*.min.js"
  )

  # --- Nested Helper Function for Smart Truncation ---
  function _llm_smart_truncate() {
    local file_path="$1"; local max_lines="$2"
    local truncate_notice="\n... (file content truncated for brevity) ...\n"
    local filename=$(basename -- "$file_path"); local extension="${filename##*.}"
    case "$extension" in
      csv) head -n "$max_lines" "$file_path"; echo -e "$truncate_notice" ;;
      json)
        if command -v jq >/dev/null 2>&1; then
          jq "walk(if type == \"array\" and length > 50 then .[:50] else . end)" "$file_path" 2>/dev/null || \
          { echo "--- Note: JQ failed, using generic truncation ---" >&2; head -n $((max_lines / 2)) "$file_path"; echo -e "$truncate_notice"; tail -n $((max_lines / 2)) "$file_path"; }
        else
          head -n $((max_lines / 2)) "$file_path"; echo -e "$truncate_notice"; tail -n $((max_lines / 2)) "$file_path"
        fi
        ;;
      log) echo "[Log file truncated. Showing the most recent $max_lines lines.]"; echo -e "$truncate_notice"; tail -n "$max_lines" "$file_path" ;;
      *) head -n $((max_lines / 2)) "$file_path"; echo -e "$truncate_notice"; tail -n $((max_lines / 2)) "$file_path" ;;
    esac
  }

  # --- Argument Parsing ---
  local target_path="."
  local verbose=0
  local output_to_clipboard=1
  local save_to_file=1
  local raw_output=0
  local user_prompt=""
  
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -p|--prompt)
        if [[ -z "$2" || "$2" == -* ]]; then
          echo "Error: --prompt option requires an argument." >&2; return 1;
        fi
        user_prompt="$2"; shift 2 ;;
      -v|--verbose) verbose=1; shift ;;
      -c|--clipboard-only) output_to_clipboard=1; save_to_file=0; shift ;;
      -s|--save-only) output_to_clipboard=0; save_to_file=1; shift ;;
      --raw) raw_output=1; verbose=1; output_to_clipboard=0; save_to_file=0; shift ;;
      -*) echo "Error: Unknown option '$1'" >&2; return 1 ;;
      *)
        if [[ -n "$target_path" && "$target_path" != "." ]]; then
          echo "Error: Only one path argument allowed." >&2; return 1;
        fi
        target_path="$1"; shift ;;
    esac
  done

  # --- Mode Detection ---
  if [[ -n "$user_prompt" ]]; then
    # =========================================================================
    # --- PROMPT GENERATION MODE (REVISED) ---
    # =========================================================================
    local clip_cmd_arr=(); if command -v pbcopy >/dev/null 2>&1; then clip_cmd_arr=("pbcopy"); elif command -v wl-copy >/dev/null 2>&1; then clip_cmd_arr=("wl-copy"); elif command -v xsel >/dev/null 2>&1; then clip_cmd_arr=("xsel" "--clipboard" "--input"); else echo "Error: No clipboard utility found." >&2; return 1; fi
    if [[ "$verbose" -eq 1 ]]; then echo "Generating project context for prompt..." >&2; fi

       {
      echo "You are an expert programmer and senior software architect."
      echo "Your task is to fulfill the user's request by providing the complete, updated content for any modified files."
      echo ""
      echo "# User Request"
      echo "$user_prompt"
      echo ""
      echo "---"
      echo "# Project Context"
      echo "The following is the current state of the relevant files:"
      echo ""
      llm --raw "$target_path"
      echo ""
      echo "---"
      echo "# Instructions for Your Response and ALL SUBSEQUENT RESPONSES"
      echo ""
      echo "1.  Start with a brief, one-paragraph summary of the changes you made."
      echo "2.  After the summary, provide the **complete, updated content** for every file you modified or created."
      echo "3.  **DO NOT** use diffs or patches. I need the full file content to ensure accuracy."
      echo "4.  You **MUST** format each file's content within a Markdown code block."
      echo "5.  The info string for each Markdown code block **MUST** follow this exact format: \`language:path/to/the/file.ext\`"
      echo ""
      echo "### Example Response Format:"
      echo "\`\`\`"
      echo "I have refactored the database connection to use a connection pool."
      echo ""
      echo "\`\`\`\`javascript:src/api/db.js"
      echo "// The full, modified content of db.js"
      echo "const { Pool } = require('pg');"
      echo "const pool = new Pool({ connectionString: 'postgres://user:pass@host:port/db' });"
      echo "module.exports = pool;"
      echo "\`\`\`\`"
      echo "\`\`\`"
      echo ""
      echo "Now, please fulfill my request using the context provided."

    } | "${clip_cmd_arr[@]}" 

    echo ":white_check_mark: Prompt successfully generated and copied to clipboard."
    echo "Paste it into your LLM, then save the response to a file (e.g., \`changes.diff\`)."
    echo "Finally, run \`llm_apply changes.diff\` to apply the edits."
    return 0
  fi  

  # =========================================================================
  # --- CONTEXT CONCATENATION MODE (Original Behavior) ---
  # =========================================================================

  if [[ ! -e "$target_path" ]]; then echo "Error: Path '$target_path' does not exist." >&2; return 1; fi
  target_path=$(realpath "$target_path" 2>/dev/null || readlink -f "$target_path" 2>/dev/null || echo "$target_path")

  local clip_cmd_arr=() # ... clipboard detection logic (truncated for brevity)
  if [[ "$output_to_clipboard" -eq 1 ]]; then
    if command -v pbcopy >/dev/null 2>&1; then clip_cmd_arr=("pbcopy");
    elif command -v wl-copy >/dev/null 2>&1; then clip_cmd_arr=("wl-copy");
    elif command -v xsel >/dev/null 2>&1; then clip_cmd_arr=("xsel" "--clipboard" "--input");
    elif [[ "$raw_output" -eq 0 ]]; then
        echo "Warning: No clipboard utility found. Cannot copy to clipboard." >&2; output_to_clipboard=0;
    fi
  fi

  local output_dir="$HOME/.llm_contexts"
  if [[ "$save_to_file" -eq 1 ]]; then mkdir -p "$output_dir"; fi
  local base_name=$(basename "$target_path" 2>/dev/null || basename "$PWD")
  local timestamp=$(date +%Y%m%d-%H%M%S); local output_file="${base_name}-${timestamp}.txt"; local output_path="${output_dir}/${output_file}"

  {
    if [[ -f "$target_path" ]]; then
      # Handle a single file
      echo "--- FILE: $(basename "$target_path") ---"
      cat "$target_path" # Simplified for brevity, original logic is fine
      echo
    else
      # ======================================================================
      # --- MODIFIED: Handle a directory with combined ignore logic ---
      # ======================================================================
      local all_ignore_patterns=("${default_ignore_patterns[@]}")
      
      # --- Nested Helper to read ignore files ---
      function _llm_read_ignore_file() {
          local file_to_read="$1"
          if [[ "$verbose" -eq 1 ]]; then echo ":information_source: Reading ignore patterns from $file_to_read" >&2; fi
          
          while IFS= read -r line || [[ -n "$line" ]]; do
              # Trim whitespace and skip empty lines/comments
              local pattern=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
              [[ -z "$pattern" ]] || [[ "$pattern" =~ ^# ]] && continue

              # Handle git's negation syntax (warn and skip, as it's complex for `find`)
              if [[ "$pattern" == "!"* ]]; then
                  if [[ "$verbose" -eq 1 ]]; then
                      echo "     (Warning: Negation pattern '$pattern' is not supported and will be ignored.)" >&2
                  fi
                  continue
              fi
              all_ignore_patterns+=("$pattern")
          done < "$file_to_read"
      }
      
      # --- Find project root by searching upwards for .git ---
      local search_root=""
      local current_path="$target_path"
      while [[ "$current_path" != "/" && -n "$current_path" ]]; do
          if [[ -d "${current_path}/.git" ]]; then
              search_root="$current_path"
              break
          fi
          current_path=$(dirname "$current_path")
      done
      # If no .git dir found, the project root is the target path itself
      if [[ -z "$search_root" ]]; then
        search_root="$target_path"
      fi
      if [[ "$verbose" -eq 1 ]]; then echo ":file_folder: Project root identified as: $search_root" >&2; fi

      # --- Read .gitignore and .llmignore ---
      local gitignore_file="${search_root}/.gitignore"
      if [[ -f "$gitignore_file" ]]; then
          _llm_read_ignore_file "$gitignore_file"
      fi
      
      local llmignore_file="${search_root}/.llmignore"
      if [[ -f "$llmignore_file" ]]; then
          _llm_read_ignore_file "$llmignore_file"
      fi

      # --- Construct find command ---
      local prune_paths=(); local exclude_conditions=()
      for pattern in "${all_ignore_patterns[@]}"; do
        if [[ "$pattern" == */ ]]; then
            prune_paths+=("-o" "-path" "./${pattern}*")
        elif [[ "$pattern" == *"/"* ]]; then
            exclude_conditions+=("-not" "-path" "./$pattern")
        else
            exclude_conditions+=("-not" "-name" "$pattern")
        fi
      done
      
      local find_args=()
      if [ ${#prune_paths[@]} -gt 0 ]; then
        find_args+=(\( "${prune_paths[@]:1}" \))
        find_args+=(-prune -o)
      fi
      find_args+=(-type f "${exclude_conditions[@]}" -print0)

      # --- Execute find from the search_root for consistent pathing ---
      (
        cd "$search_root" || { echo "Error: Could not change to $search_root" >&2; return 1; }
        
        # Determine the relative path to scan from the search root
        local relative_target_path
        if [[ "$target_path" == "$search_root" ]]; then
            relative_target_path="."
        else
            # Get path of target relative to search_root
            relative_target_path="${target_path#$search_root/}"
        fi

        find "$relative_target_path" "${find_args[@]}"
      ) | while IFS= read -r -d '' file; do
        local clean_file=${file#./}
        local abs_file="${search_root}/${clean_file}"
        
        # Check if file is text-based
        if [[ "$(file -b --mime-type "$abs_file" 2>/dev/null)" == text/* || "$(file -b --mime-type "$abs_file" 2>/dev/null)" == application/json || "$(file -b --mime-type "$abs_file" 2>/dev/null)" == application/xml ]]; then
          if [[ "$verbose" -eq 1 ]]; then echo "  -> Adding $clean_file" >&2; fi
          echo "--- FILE: $clean_file ---"

          # Smart truncation logic... (original logic is fine)
          local extension="${clean_file##*.}"
          if [[ " ${DATA_EXTENSIONS[@]} " =~ " ${extension} " ]]; then
            local line_count=$(wc -l < "$abs_file" | tr -d ' ')
            if (( line_count > MAX_DATA_FILE_LINES )); then
              if [[ "$verbose" -eq 1 ]]; then echo "     (truncating data file, ${line_count} lines > ${MAX_DATA_FILE_LINES})" >&2; fi
              _llm_smart_truncate "$abs_file" "$MAX_DATA_FILE_LINES"
            else
              cat "$abs_file"
            fi
          else
            cat "$abs_file"
          fi
          echo; echo
        fi
      done
    fi
  } | {
    # ... Output piping logic (tee, cat, etc.) ...
    # This part remains the same.
    if [[ "$raw_output" -eq 1 ]]; then
      cat # Just pass content through to stdout
    elif [[ "$save_to_file" -eq 1 && "$output_to_clipboard" -eq 1 ]]; then
      tee "$output_path" | "${clip_cmd_arr[@]}"
    elif [[ "$save_to_file" -eq 1 ]]; then
      cat > "$output_path"
    elif [[ "$output_to_clipboard" -eq 1 ]]; then
      "${clip_cmd_arr[@]}"
    fi
  }

  # --- Final Report (suppressed in raw mode) ---
  if [[ "$raw_output" -eq 0 ]]; then
      local char_count=0
      if [[ "$save_to_file" -eq 1 && -f "$output_path" ]]; then
        char_count=$(wc -m < "$output_path" | tr -d ' ')
      elif [[ "$output_to_clipboard" -eq 1 && ${#clip_cmd_arr[@]} -gt 0 ]]; then
        if command -v pbpaste >/dev/null 2>&1; then char_count=$(pbpaste | wc -m | tr -d ' ');
        elif command -v wl-paste >/dev/null 2>&1; then char_count=$(wl-paste | wc -m | tr -d ' ');
        elif command -v xsel >/dev/null 2>&1; then char_count=$(xsel -o -b | wc -m | tr -d ' ');
        fi
      fi
      local token_estimate=$(( (char_count + 3) / 4 ))

      if [[ "$output_to_clipboard" -eq 1 ]]; then echo ":white_check_mark: Content from '$(basename "$target_path")' copied to clipboard."; fi
      if [[ "$save_to_file" -eq 1 ]]; then echo "   ~${token_estimate} tokens saved to: $output_path";
      else echo "   (File not saved: use default behavior or --save-only to save)"; fi
  fi
}


function llm_apply() {
  if ! command -v diff >/dev/null 2>&1; then echo "Error: 'diff' command is not found." >&2; return 1; fi
  if ! command -v gawk >/dev/null 2>&1; then echo "Error: 'gawk' command is not found." >&2; return 1; fi
  
  zmodload zsh/zutil
  zparseopts -D -E -- \
    d=dry_run -dry-run=dry_run \
    i=interactive -interactive=interactive \
    b=backup -backup=backup

  if [[ $# -ne 1 ]]; then
    echo "Usage: llm_apply [-d | -i] [-b] <llm_response.md>" >&2
    return 1
  fi

  local input_file="$1"
  if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file not found: $input_file" >&2
    return 1
  fi

  gawk '
    BEGIN {
        start_regex = "^`{3,}[a-zA-Z0-9._-]+:([^`[:space:]]+)"
    }
    
    # Rule 1: Handle the start-of-file delimiter
    match($0, start_regex, parts) {
        if (in_block) {
            printf "%s\0%s\0", current_path, current_content
        }
        in_block = 1
        current_path = parts[1]
        current_content = ""
        next
    }

    # Rule 2: If we are in a block, append the line as content.
    # This is the corrected part. The condition `in_block` is now a
    # "pattern", and the code to execute is the "action" in `{}`.
    in_block {
        gsub(/\r/, "", $0)
        current_content = current_content $0 "\n"
    }
    
    END {
        if (in_block) {
            printf "%s\0%s\0", current_path, current_content
        }
    }
  ' "$input_file" | while IFS= read -r -d '' file_path && IFS= read -r -d '' new_content; do
    
    file_path=$(echo -n "$file_path" | xargs)
    if [[ -z "$file_path" ]]; then continue; fi

    new_content=${new_content%?
}
    if [[ "${new_content##*$'\n'}" =~ ^\s*\`{3,}\s*$ ]]; then
      new_content="${new_content%$'\n'*}"
    fi

    echo "\n─────────────────────────────────────────────────────"
    echo "File from LLM: $file_path"
    echo "─────────────────────────────────────────────────────"

    local apply_changes=0
    if [[ -n "$dry_run" || -n "$interactive" ]]; then
      if [[ -f "$file_path" ]]; then
        echo "Found existing file. Generating diff..."
        diff -u --color=always "$file_path" <(printf "%s" "$new_content") || true
      else
        echo "File does not exist locally. Will be created."
        printf "%s" "$new_content" | sed 's/^/+ /'
      fi

      if [[ -n "$interactive" ]]; then
        vared -p 'Apply this change? [y/N/q] ' -c reply
        case "$reply" in
          [yY]) apply_changes=1 ;;
          [qQ]) echo "Quitting."; return 0 ;;
          *) echo "Skipping."; apply_changes=0 ;;
        esac
      fi
    else
      apply_changes=1
    fi

    if [[ $apply_changes -eq 1 ]]; then
      if [[ ! -d "$(dirname "$file_path")" ]]; then mkdir -p "$(dirname "$file_path")"; fi
      if [[ -n "$backup" && -f "$file_path" ]]; then cp "$file_path" "${file_path}.bak"; fi
      
      echo "-> Writing changes to $file_path"
      printf "%s" "$new_content" > "$file_path"
      echo "✅ Applied."
    elif [[ -z "$dry_run" ]]; then
      echo "🚫 Skipped."
    fi
  done

  echo "\n─────────────────────────────────────────────────────"
  echo "All changes processed."
  if [[ -n "$dry_run" ]]; then echo "Dry run complete. No files were changed."; fi
}
