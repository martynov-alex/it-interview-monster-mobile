#!/bin/bash

# Скрипт для генерации API кода из OpenAPI спецификации используя swagger_parser

set -e

echo "🚀 Генерация API кода из OpenAPI спецификации..."
echo ""

# Определяем корневую директорию проекта
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
API_DIR="$PROJECT_ROOT/core/api"

# Проверяем существование директории api
if [ ! -d "$API_DIR" ]; then
    echo "❌ Директория $API_DIR не найдена!"
    exit 1
fi

# Переходим в директорию пакета api
cd "$API_DIR"

echo "📂 Директория: $API_DIR"
echo ""

# Шаг 1: Генерация с помощью swagger_parser
echo "📝 Шаг 1: Генерация кода с помощью swagger_parser..."
dart run swagger_parser

# Шаг 2: Генерация с помощью build_runner (retrofit, freezed, json_serializable)
echo ""
echo "🔨 Шаг 2: Генерация кода с помощью build_runner..."
dart run build_runner build --delete-conflicting-outputs

echo ""
echo "✅ Генерация завершена успешно!"
echo ""
echo "📦 Структура сгенерированных файлов:"
tree -L 3 lib/src/generated 2>/dev/null || ls -lR lib/src/generated

echo ""
echo "📊 Статистика:"
echo "   Файлов: $(find lib/src/generated -type f -name "*.dart" | wc -l | tr -d ' ')"
echo "   Размер: $(du -sh lib/src/generated | cut -f1)"

