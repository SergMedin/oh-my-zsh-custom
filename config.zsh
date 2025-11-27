# Run one time on each shell start (OMZ reads this file two times)
if [[ -z ${OMZ_CUSTOM_PRE_LOADED:-} ]]; then
  typeset -g OMZ_CUSTOM_PRE_LOADED=1

  # Turn on async git prompt from omz/lib/git.zsh
  zstyle ':omz:alpha:lib:git' async-prompt true

  # Plugins and auto venv
  typeset -gaU plugins
  plugins+=(git python virtualenv)
  export PYTHON_AUTO_VRUN=true
  export PYTHON_VENV_NAMES=(.venv venv)
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  unset VIRTUAL_ENV_PROMPT

  # Small guard: if shell starts inside old venv, drop it
  if [[ -n $VIRTUAL_ENV && -z ${functions[deactivate]} && $PWD != ${VIRTUAL_ENV:h}* ]]; then
    path=(${path:#${VIRTUAL_ENV}/bin})
    unset VIRTUAL_ENV
  fi

  # omz = Oh My Zsh helper. Load python and virtualenv plugins if they are still off.
  # Do it only when auto_vrun is not set yet.
  if (( ! $+functions[auto_vrun] )) && (( $+functions[omz] )); then
    omz plugin load python virtualenv
  fi

fi

# Theme (set again before OMZ loads theme)
ZSH_THEME="gnzh-sergo"
