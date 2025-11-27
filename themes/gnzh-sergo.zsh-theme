# Based on bira theme

setopt prompt_subst

# Return code indicator
local return_code="%(?..%F{red}%? ↵%f)"

# Git prompt look — uses OMZ git.zsh (async and respects DISABLE_UNTRACKED_FILES_DIRTY)
ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%f "
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{red}?%f"
ZSH_THEME_GIT_PROMPT_ADDED="%F{green}+%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{blue}~%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{magenta}»%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{red}✖%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{red}!%f"
ZSH_THEME_GIT_PROMPT_AHEAD="%F{cyan}⇡%f"
ZSH_THEME_GIT_PROMPT_BEHIND="%F{cyan}⇣%f"
ZSH_THEME_GIT_PROMPT_DIVERGED="%F{cyan}⇕%f"
ZSH_THEME_GIT_PROMPT_STASHED="%F{yellow}S%f"

# Show Python venv name
function safe_venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "%F{red}(${VIRTUAL_ENV:t})%f "
  fi
}

# Prompt parts
local clock='%F{cyan}[%D{%H:%M:%S}]%f'
local current_dir='%B%F{blue}%~%f%b'
local venv_prompt='$(safe_venv_prompt)'
local git_prompt='$(git_prompt_info)'

# Show user and host only on SSH or root to keep prompt clean
local user_host=''
if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" || $UID -eq 0 ]]; then
  user_host='%F{red}%n@%m%f '
fi

# Build prompt (add empty line before each prompt)
PROMPT="
╭─${clock} ${user_host}${current_dir} ${venv_prompt}${git_prompt}
╰─%(!.%F{red}.%f)➤%f "
RPROMPT="${return_code}"
