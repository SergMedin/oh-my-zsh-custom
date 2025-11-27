#!/usr/bin/env zsh

set -e

ZSHRC="$HOME/.zshrc"
CUSTOM_LINE='export ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"'
PATTERN='source $ZSH/oh-my-zsh.sh'

echo "=== Настройка ZSH_CUSTOM для Oh My Zsh ==="
echo "Файл конфигурации: $ZSHRC"
echo

if [[ ! -f "$ZSHRC" ]]; then
  echo "❌ Файл $ZSHRC не найден."
  echo "   Создай его или запусти Oh My Zsh установщик, а потом повтори скрипт."
  exit 1
fi

if [[ ! -w "$ZSHRC" ]]; then
  echo "❌ Нет прав на запись в $ZSHRC."
  echo "   Запусти скрипт из-под пользователя, который может менять этот файл,"
  echo "   или поправь права/владельца и попробуй снова."
  exit 1
fi

echo "1. Проверяю, есть ли уже строка с ZSH_CUSTOM..."
if grep -qF "$CUSTOM_LINE" "$ZSHRC"; then
  echo "✅ Строка уже есть в .zshrc:"
  echo "   $CUSTOM_LINE"
  echo
  echo "Ничего менять не нужно."
else
  echo "⏳ Строки нет, нужно добавить."
  echo

  if grep -qF "$PATTERN" "$ZSHRC"; then
    echo "2. Нашёл строку запуска Oh My Zsh:"
    echo "   $PATTERN"
    echo "   Вставляю ZSH_CUSTOM прямо перед этой строкой..."
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
      echo "❌ Не нашёл точную строку запуска Oh My Zsh, ничего не менял."
      rm -f "$tmpfile"
      exit 1
    fi

    chmod --reference="$ZSHRC" "$tmpfile" 2>/dev/null || true
    mv "$tmpfile" "$ZSHRC"

    if grep -q 'ZSH_CUSTOM=' "$ZSHRC"; then
      echo "✅ Готово. В $ZSHRC добавлена строка:"
      echo "   $CUSTOM_LINE"
    else
      echo "❌ Не получилось вставить строку."
      echo "   Проверь права на файл $ZSHRC и попробуй ещё раз."
      exit 1
    fi
  else
    echo "⚠️ Внимание:"
    echo "   В $ZSHRC не нашёл строку:"
    echo "   $PATTERN"
    echo
    echo "Скрипт не стал ничего менять, чтобы не сломать конфиг."
    echo "Добавь вручную примерно так:"
    echo
    echo "   $CUSTOM_LINE"
    echo "   source $ZSH/oh-my-zsh.sh"
    echo
    exit 1
  fi
fi

echo
echo "3. Проверка: строки с ZSH_CUSTOM в $ZSHRC:"
grep -n 'ZSH_CUSTOM' "$ZSHRC" || echo "   (ни одной строки с ZSH_CUSTOM не найдено)"

echo
echo "Все. Теперь перезапусти терминал или выполни:"
echo "   source \"$ZSHRC\""
echo "чтобы новые настройки подхватились."
