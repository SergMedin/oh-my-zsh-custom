# Oh My Zsh Custom

Личные настройки Oh My Zsh: тема `gnzh-sergo`, конфиг `config.zsh`, плагины и автоподхват Python venv.

## Быстрая установка
1) Клонируй в кастомную папку Oh My Zsh:
```bash
ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"
mkdir -p "$ZSH_CUSTOM"
cd "$ZSH_CUSTOM"
git clone <URL_ВАШЕГО_РЕПО> .
```
2) Подключи конфиг и тему в `~/.zshrc` (строки рядом с `source $ZSH/oh-my-zsh.sh`):
```bash
export ZSH_CUSTOM="$ZSH_CUSTOM"
source $ZSH/custom/config.zsh
```
3) Перезапусти оболочку: `exec zsh` или `source ~/.zshrc`.

## Что внутри
- `config.zsh` — плагины, алиасы, автозапуск venv.
- `themes/gnzh-sergo.zsh-theme` — время, путь, venv, git-статус, код возврата.
- `plugins/` — доп. плагины (пример в репо).

## Минимальные требования
- Установлен Oh My Zsh (`~/.oh-my-zsh`).
- Git для клонирования.
