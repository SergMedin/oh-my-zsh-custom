# Oh My Zsh Custom

Simple personal setup for Oh My Zsh. Theme `gnzh-sergo`, file `config.zsh`, and auto Python venv.

## Quick install
1) Clone to the custom folder of Oh My Zsh:
```bash
ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"
mkdir -p "$ZSH_CUSTOM"
cd "$ZSH_CUSTOM"
git clone <YOUR_REPO_URL> .
```
2) Add config and theme in `~/.zshrc` (put lines near `source $ZSH/oh-my-zsh.sh`):
```bash
export ZSH_CUSTOM="$ZSH_CUSTOM"
source $ZSH/custom/config.zsh
```
3) Restart shell: `exec zsh` or `source ~/.zshrc`.

## What is inside
- `config.zsh` — plugins, small helpers, auto start venv.
- `themes/gnzh-sergo.zsh-theme` — time, path, venv name, git info, return code.
- `plugins/` — extra plugins (example only).

## Need to have
- Oh My Zsh in `~/.oh-my-zsh`.
- Git to clone.
