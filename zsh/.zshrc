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

#!/bin/bash
# -----------------------------------------------------------------------------
# llm - A multi-purpose LLM context and prompt generation tool.
#
# By default, concatenates project files for LLM context.
# With the --prompt flag, it wraps that context in a structured, cost-effective
# "semantic patch" prompt for code generation tasks.
#
# Now extends .gitignore with .llmignore for a comprehensive ignore list.
#
# -- CONTEXT MODE --
# Usage: llm [-v] [-c] [-s] [path]
#
# -- PROMPT MODE (SEMANTIC PATCH) --
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
      --raw) raw_output=1; verbose=0; output_to_clipboard=0; save_to_file=0; shift ;;
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
    # --- PROMPT GENERATION MODE (SEMANTIC PATCH v2) ---
    # =========================================================================
    local clip_cmd_arr=()
    if command -v wl-copy >/dev/null 2>&1; then clip_cmd_arr=("wl-copy");
    elif command -v xsel >/dev/null 2>&1; then clip_cmd_arr=("xsel" "--clipboard" "--input");
    else echo "Error: No clipboard utility (pbcopy, wl-copy, xsel) found." >&2; return 1; fi

    if [[ "$verbose" -eq 1 ]]; then echo "Generating project context for prompt..." >&2; fi

    {
      echo "You are an expert programmer. Your task is to fulfill the user's request by providing code changes in a special 'semantic patch' format."
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
      echo "# Instructions for Your Response"
      echo ""
      echo "1.  Start with a brief summary of your changes."
      echo "2.  For each file you modify, you **MUST** provide one or more change blocks in the exact format below."
      echo "3.  **DO NOT** provide the full file. Only provide the new code to be inserted."
      echo ""
      echo "### Semantic Patch Format:"
      echo "\`\`\`"
      echo "[BEGIN CHANGE]"
      echo "file: path/to/the/file.ext"
      echo "start_after:"
      echo "---"
      echo "A multi-line block of 3-5 lines that comes"
      echo "IMMEDIATELY BEFORE the code you are replacing or inserting."
      echo "This is a context block, not a single line."
      echo "---"
      echo "end_before:"
      echo "---"
      echo "A multi-line block of 3-5 lines that comes"
      echo "IMMEDIATELY AFTER the code you are replacing or inserting."
      echo "This is also a context block."
      echo "---"
      echo "content:"
      echo "---"
      echo "The new code block to be inserted goes here."
      echo "This replaces everything between start_after and end_before."
      echo "---"
      echo "[END CHANGE]"
      echo "\`\`\`"
      echo ""
      echo "### IMPORTANT RULES for the context blocks:"
      echo "-   **CRITICAL**: The \`start_after\` and \`end_before\` blocks must be **unique and stable**. Choose context that is unlikely to change, like function signatures or stable surrounding code."
      echo "-   Include indentation **exactly** as it appears in the original file. Whitespace matters."
      echo "-   To **insert** code, the \`start_after\` and \`end_before\` blocks should be adjacent in the original file."
      echo "-   To **replace** code, the \`start_after\` and \`end_before\` blocks should have the code-to-be-replaced between them."
      echo "-   To create a **new file**, use \`file: path/to/new/file.ext\` and leave the other sections (start_after, end_before, content) blank, except for the new file content inside the \`content\` section."
      echo ""
      echo "Now, please fulfill my request using the context and format provided."
    } | "${clip_cmd_arr[@]}"
    
    echo "✅ Prompt for 'semantic patch' generated and copied."
    echo "Paste it into your LLM, save the response to a file (e.g., \`changes.md\`),"
    echo "and run \`llm_apply changes.md\` to apply the edits."
    return 0
  fi  

  # =========================================================================
  # --- CONTEXT CONCATENATION MODE (Original Behavior) ---
  # =========================================================================

  if [[ ! -e "$target_path" ]]; then echo "Error: Path '$target_path' does not exist." >&2; return 1; fi
  target_path=$(realpath "$target_path" 2>/dev/null || readlink -f "$target_path" 2>/dev/null || echo "$target_path")

  local clip_cmd_arr=()
  if [[ "$output_to_clipboard" -eq 1 ]]; then
    if command -v wl-copy >/dev/null 2>&1; then clip_cmd_arr=("wl-copy");
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
      local extension="${target_path##*.}"
      if [[ " ${DATA_EXTENSIONS[@]} " =~ " ${extension} " ]]; then
        local line_count=$(wc -l < "$target_path" | tr -d ' ')
        if (( line_count > MAX_DATA_FILE_LINES )); then
          if [[ "$verbose" -eq 1 ]]; then echo "     (truncating data file, ${line_count} lines > ${MAX_DATA_FILE_LINES})" >&2; fi
          _llm_smart_truncate "$target_path" "$MAX_DATA_FILE_LINES"
        else
          cat "$target_path"
        fi
      else
        cat "$target_path"
      fi
      echo
    else
      # Handle a directory with combined ignore logic
      local all_ignore_patterns=("${default_ignore_patterns[@]}")
      
      function _llm_read_ignore_file() {
          local file_to_read="$1"
          if [[ "$verbose" -eq 1 ]]; then echo ":information_source: Reading ignore patterns from $file_to_read" >&2; fi
          
          while IFS= read -r line || [[ -n "$line" ]]; do
              local pattern=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
              [[ -z "$pattern" ]] || [[ "$pattern" =~ ^# ]] && continue
              if [[ "$pattern" == "!"* ]]; then
                  if [[ "$verbose" -eq 1 ]]; then
                      echo "     (Warning: Negation pattern '$pattern' is not supported and will be ignored.)" >&2
                  fi
                  continue
              fi
              all_ignore_patterns+=("$pattern")
          done < "$file_to_read"
      }
      
      local search_root=""
      local current_path="$target_path"
      while [[ "$current_path" != "/" && -n "$current_path" ]]; do
          if [[ -d "${current_path}/.git" ]]; then
              search_root="$current_path"
              break
          fi
          current_path=$(dirname "$current_path")
      done
      if [[ -z "$search_root" ]]; then
        search_root="$target_path"
      fi
      if [[ "$verbose" -eq 1 && -d "${search_root}/.git" ]]; then echo ":file_folder: Project root identified as: $search_root" >&2; fi

      local gitignore_file="${search_root}/.gitignore"
      if [[ -f "$gitignore_file" ]]; then
          _llm_read_ignore_file "$gitignore_file"
      fi
      
      local llmignore_file="${search_root}/.llmignore"
      if [[ -f "$llmignore_file" ]]; then
          _llm_read_ignore_file "$llmignore_file"
      fi

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

      (
        cd "$search_root" || { echo "Error: Could not change to $search_root" >&2; return 1; }
        local relative_target_path
        if [[ "$target_path" == "$search_root" ]]; then
            relative_target_path="."
        else
            relative_target_path="${target_path#$search_root/}"
        fi
        find "$relative_target_path" "${find_args[@]}"
      ) | while IFS= read -r -d '' file; do
        local clean_file=${file#./}
        local abs_file="${search_root}/${clean_file}"
        
        if [[ "$(file -b --mime-type "$abs_file" 2>/dev/null)" == text/* || "$(file -b --mime-type "$abs_file" 2>/dev/null)" == application/json || "$(file -b --mime-type "$abs_file" 2>/dev/null)" == application/xml ]]; then
          if [[ "$verbose" -eq 1 ]]; then echo "  -> Adding $clean_file" >&2; fi
          echo "--- FILE: $clean_file ---"
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
    if [[ "$raw_output" -eq 1 ]]; then
      cat
    elif [[ "$save_to_file" -eq 1 && "$output_to_clipboard" -eq 1 ]]; then
      tee "$output_path" | "${clip_cmd_arr[@]}"
    elif [[ "$save_to_file" -eq 1 ]]; then
      cat > "$output_path"
    elif [[ "$output_to_clipboard" -eq 1 ]]; then
      "${clip_cmd_arr[@]}"
    fi
  }

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

# -----------------------------------------------------------------------------
# llm_apply - Applies a "semantic patch" v2 generated by an LLM.
#
# This version uses a robust multi-line matching algorithm to find the
# precise location for a code change, preventing errors caused by
# non-unique single-line markers.
# -----------------------------------------------------------------------------
function llm_apply() {
  # --- Dependencies ---
  if ! command -v gawk >/dev/null 2>&1; then echo "Error: 'gawk' not found." >&2; return 1; fi
  if ! command -v diff >/dev/null 2>&1; then echo "Error: 'diff' not found." >&2; return 1; fi

  # --- Zsh-specific options ---
  zmodload zsh/zutil
  zparseopts -D -E -- \
    i=interactive -interactive=interactive \
    b=backup -backup=backup

  if [[ $# -ne 1 ]]; then
    echo "Usage: llm_apply [-i] [-b] <llm_response.md>" >&2; return 1
  fi
  local input_file="$1"
  if [[ ! -f "$input_file" ]]; then echo "Error: Input file not found: $input_file" >&2; return 1; fi

  # --- Helper function to find the line number of a multi-line pattern ---
  # Returns the line number where the *last* line of the pattern was found.
  _llm_find_multiline_pattern() {
    local file_to_search="$1"
    local pattern_to_find="$2"

    # If pattern is empty, it's not findable.
    if [[ -z "$pattern_to_find" ]]; then echo ""; return; fi

    # Awk script to find a multi-line needle in a haystack file.
    gawk -v pattern="$pattern_to_find" '
      BEGIN {
        n = split(pattern, pattern_arr, "\n")
        # Handle trailing newline in pattern from shell command substitution
        if (pattern_arr[n] == "") {
          n--
        }
        if (n == 0) exit 1;
      }
      {
        # Store current line in a circular buffer (our sliding window)
        window[NR % n] = $0
        
        # Once the window is full, start comparing
        if (NR >= n) {
          match = 1
          for (i = 1; i <= n; i++) {
            # Modulo arithmetic to get the correct index in the circular buffer
            idx = (NR - n + i - 1) % n
            if (window[idx] != pattern_arr[i]) {
              match = 0
              break
            }
          }
          if (match) {
            print NR # Print the line number of the *last* line of the match
            exit 0  # Exit after first match
          }
        }
      }
    ' "$file_to_search"
  }
  
  # --- Main processing loop ---
  # Use awk to split the input file into change blocks based on "[END CHANGE]"
  gawk 'BEGIN { RS = "\\[END CHANGE\\]" } { if ($0 ~ /\[BEGIN CHANGE\]/) print $0 }' "$input_file" | \
  while IFS= read -r block; do
    block=$(printf "%s" "$block" | tr -d '\r')

    local file_path=$(echo "$block" | awk -F': *' '/^file:/ {print $2; exit}')
    # Use sed to extract multi-line blocks between delimiters
    local start_after=$(echo "$block" | sed -n '/^start_after:/,/^---$/p' | sed '1d;$d')
    local end_before=$(echo "$block" | sed -n '/^end_before:/,/^---$/p' | sed '1d;$d')
    local new_content=$(echo "$block" | sed -n '/^content:/,/^---$/p' | sed '1d;$d')

    if [[ -z "$file_path" ]]; then continue; fi

    echo "\n─────────────────────────────────────────────────────"
    echo "Applying change to: $file_path"
    echo "─────────────────────────────────────────────────────"

    # --- Case 1: NEW FILE ---
    if [[ ! -f "$file_path" ]]; then
        echo "File does not exist. This change will create a new file."
        printf "%s\n" "$new_content" | sed 's/^/+ /'
        
        vared -p 'Create this file? [y/N/q] ' -c reply
        case "$reply" in
          [yY])
            echo "-> Creating file: $file_path"
            mkdir -p "$(dirname "$file_path")"
            # No backup needed for a new file
            printf "%s" "$new_content" > "$file_path"
            echo "✅ Applied."
            ;;
          [qQ]) echo "Quitting."; return 0 ;;
          *) echo "🚫 Skipped." ;;
        esac
        continue
    fi
    
    # --- Case 2: MODIFY EXISTING FILE ---
    local start_line_num_end_of_block=$(_llm_find_multiline_pattern "$file_path" "$start_after")
    local end_line_num_end_of_block=$(_llm_find_multiline_pattern "$file_path" "$end_before")

    if [[ -z "$start_line_num_end_of_block" || -z "$end_line_num_end_of_block" ]]; then
      echo "🚫 Error: Could not find unique start_after or end_before context in '$file_path'." >&2
      echo "   Please check the markers provided by the LLM." >&2
      continue
    fi
    
    # Calculate the start of the 'end_before' block
    local num_lines_in_end_before_block=$(echo "$end_before" | wc -l)
    local end_line_num=$((end_line_num_end_of_block - num_lines_in_end_before_block + 1))
    local start_line_num=$start_line_num_end_of_block

    if (( start_line_num >= end_line_num )); then
      echo "🚫 Error: 'start_after' context appears on or after 'end_before' context." >&2
      echo "   This usually means the markers are incorrect or overlapping." >&2
      continue
    fi
    
    # Extract the old content for diffing (from line AFTER start_after to line BEFORE end_before)
    local old_content=$(sed -n "$((start_line_num + 1)),$((end_line_num - 1))p" "$file_path")

    echo "Found markers. Code to be replaced is between line $start_line_num and $end_line_num. Generating diff..."
    diff -u --color=always <(printf "%s\n" "$old_content") <(printf "%s\n" "$new_content") || true

    vared -p 'Apply this change? [y/N/q] ' -c reply
    case "$reply" in
      [yY])
        if [[ -n "$backup" ]]; then
            echo "-> Backing up original file to ${file_path}.bak"
            cp "$file_path" "${file_path}.bak"
        fi
        
        # Create the new file content in memory by combining the parts
        {
          # 1. Head of file, up to and including the start_after block
          sed -n "1,${start_line_num}p" "$file_path"
          # 2. The new content from the LLM
          printf "%s\n" "$new_content"
          # 3. Tail of file, starting from the end_before block
          sed -n "${end_line_num},\$p" "$file_path"
        } > "${file_path}.tmp" && mv "${file_path}.tmp" "$file_path"

        echo "✅ Applied."
        ;;
      [qQ]) echo "Quitting."; return 0 ;;
      *) echo "🚫 Skipped." ;;
    esac
  done

  echo "\n─────────────────────────────────────────────────────"
  echo "All changes processed."
}
