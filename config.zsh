# run once per shell startup (config is sourced twice by OMZ)
if [[ -z ${OMZ_CUSTOM_PRE_LOADED:-} ]]; then
  typeset -g OMZ_CUSTOM_PRE_LOADED=1

  # плагины и авто-venv
  plugins=(git python virtualenv)
  export PYTHON_AUTO_VRUN=true
  export PYTHON_VENV_NAMES=(.venv venv)
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  unset VIRTUAL_ENV_PROMPT

  # лёгкий страж от унаследованного venv (если shell стартует внутри активного venv)
  if [[ -n $VIRTUAL_ENV && -z ${functions[deactivate]} && $PWD != ${VIRTUAL_ENV:h}* ]]; then
    path=(${path:#${VIRTUAL_ENV}/bin})
    unset VIRTUAL_ENV
  fi

  # подгружаем нужные плагины вручную (plugins=(git) в ~/.zshrc их не загрузит)
  autoload -Uz add-zsh-hook
  (( $+functions[auto_vrun] )) && add-zsh-hook -d chpwd auto_vrun 2>/dev/null
  
  source "$ZSH/plugins/python/python.plugin.zsh"
  source "$ZSH/plugins/virtualenv/virtualenv.plugin.zsh"
fi

# тема (нужно и при втором проходе, перед загрузкой темы OMZ)
ZSH_THEME="gnzh-sergo"
