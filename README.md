# Oh My Zsh Custom

Simple personal setup for Oh My Zsh. Theme `gnzh-sergo`, file `config.zsh`, and auto Python venv.

## Quick install
1) Clone to the custom folder of Oh My Zsh:
```bash
mkdir -p ~/.oh-my-zsh-custom
cd ~/.oh-my-zsh-custom
git clone https://github.com/SergMedin/oh-my-zsh-custom.git .
```
2) Add config and theme in `~/.zshrc` (put lines near `source $ZSH/oh-my-zsh.sh`):
```bash
export ZSH_CUSTOM=~/.oh-my-zsh-custom
source $ZSH/custom/config.zsh
```
3) Restart shell: `exec zsh` or `source ~/.zshrc`.

## What is inside
- `config.zsh` — plugins, small helpers, auto start venv.
- `themes/gnzh-sergo.zsh-theme` — time, path, venv name, git info, return code.
