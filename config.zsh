# run once per shell startup (config is sourced twice by OMZ)
if [[ -z ${OMZ_CUSTOM_PRE_LOADED:-} ]]; then
  typeset -g OMZ_CUSTOM_PRE_LOADED=1

  # включаем async-обработчик git-подсказки из omz/lib/git.zsh
  zstyle ':omz:alpha:lib:git' async-prompt true

  # плагины и авто-venv
  typeset -gaU plugins
  plugins+=(git python virtualenv)
  export PYTHON_AUTO_VRUN=true
  export PYTHON_VENV_NAMES=(.venv venv)
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  unset VIRTUAL_ENV_PROMPT

  # лёгкий страж от унаследованного venv (если shell стартует внутри активного venv)
  if [[ -n $VIRTUAL_ENV && -z ${functions[deactivate]} && $PWD != ${VIRTUAL_ENV:h}* ]]; then
    path=(${path:#${VIRTUAL_ENV}/bin})
    unset VIRTUAL_ENV
  fi

  # Если config.zsh загрузился ПОСЛЕ oh-my-zsh.sh и python/virtualenv не подхватились,
  # догружаем их вручную через omz, но только если auto_vrun ещё не определён
  if (( ! $+functions[auto_vrun] )) && (( $+functions[omz] )); then
    omz plugin load python virtualenv
  fi

fi

# тема (нужно и при втором проходе, перед загрузкой темы OMZ)
ZSH_THEME="gnzh-sergo"
