#!/usr/bin/env zsh

set -e

ZSHRC="$HOME/.zshrc"
CUSTOM_LINE='export ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"'
PATTERN='source $ZSH/oh-my-zsh.sh'

echo "=== Set ZSH_CUSTOM for Oh My Zsh ==="
echo "Config file: $ZSHRC"
echo

if [[ ! -f "$ZSHRC" ]]; then
  echo "❌ File $ZSHRC not found."
  echo "   Make it or run Oh My Zsh install, then run this script again."
  exit 1
fi

if [[ ! -w "$ZSHRC" ]]; then
  echo "❌ No write access to $ZSHRC."
  echo "   Run this script as a user who can edit this file,"
  echo "   or fix file permissions and try again."
  exit 1
fi

echo "1. Check if line with ZSH_CUSTOM exists..."
if grep -qF "$CUSTOM_LINE" "$ZSHRC"; then
  echo "✅ Line is already in .zshrc:"
  echo "   $CUSTOM_LINE"
  echo
  echo "No change needed."
else
  echo "⏳ No line found, need to add."
  echo

  if grep -qF "$PATTERN" "$ZSHRC"; then
    echo "2. Found line that starts Oh My Zsh:"
    echo "   $PATTERN"
    echo "   Add ZSH_CUSTOM right before this line..."
    echo

    # удаляем старые экспорт-линии, вставляем новую перед точным совпадением
    tmpfile=$(mktemp) || { echo "❌ Не удалось создать временный файл."; exit 1; }
    awk -v line="$CUSTOM_LINE" -v pat="$PATTERN" '
      /^export ZSH_CUSTOM=/ { next }
      $0==pat && !done { print line "\n"; print; done=1; next }
      { print }
      END { if (!done) exit 2 }
    ' "$ZSHRC" >"$tmpfile"

    if [[ $? -eq 2 ]]; then
      echo "❌ Did not find exact Oh My Zsh line, nothing changed."
      rm -f "$tmpfile"
      exit 1
    fi

    chmod --reference="$ZSHRC" "$tmpfile" 2>/dev/null || true
    mv "$tmpfile" "$ZSHRC"

    if grep -q 'ZSH_CUSTOM=' "$ZSHRC"; then
      echo "✅ Done. Added line into $ZSHRC:"
      echo "   $CUSTOM_LINE"
    else
      echo "❌ Could not insert line."
      echo "   Check rights on $ZSHRC and try again."
      exit 1
    fi
  else
    echo "⚠️ Warning:"
    echo "   In $ZSHRC did not find line:"
    echo "   $PATTERN"
    echo
    echo "Script did not change file to keep config safe."
    echo "Add by hand like this:"
    echo
    echo "   $CUSTOM_LINE"
    echo "   source $ZSH/oh-my-zsh.sh"
    echo
    exit 1
  fi
fi

echo
echo "3. Check: lines with ZSH_CUSTOM in $ZSHRC:"
grep -n 'ZSH_CUSTOM' "$ZSHRC" || echo "   (no lines with ZSH_CUSTOM found)"

echo
echo "Done. Now restart terminal or run:"
echo "   source \"$ZSHRC\""
echo "to load new settings."
