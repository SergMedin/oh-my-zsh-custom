# Based on bira theme

setopt prompt_subst

# Return code indicator
local return_code="%(?..%F{red}%? ↵%f)"

# Helper to show git branch and status
function safe_git_prompt() {
  if command -v git >/dev/null && git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
      local dirty=""
      if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
        dirty="*"
      fi
      echo "%F{yellow}‹${branch}${dirty}› %f"
    fi
  fi
}

# Helper to show venv
function safe_venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "%F{red}(${VIRTUAL_ENV:t})%f "
  fi
}

# Prompt elements
local clock='%F{cyan}[%D{%H:%M:%S}]%f'
local current_dir='%B%F{blue}%~%f%b'
local venv_prompt='$(safe_venv_prompt)'
local git_branch='$(safe_git_prompt)'

# User/Host (only for SSH or root, to keep it clean as per user preference)
local user_host=''
if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" || $UID -eq 0 ]]; then
  user_host='%F{red}%n@%m%f '
fi

# Build PROMPT
PROMPT="╭─${clock} ${user_host}${current_dir} ${venv_prompt}${git_branch}
╰─%(!.%F{red}.%f)➤%f "
RPROMPT="${return_code}"
