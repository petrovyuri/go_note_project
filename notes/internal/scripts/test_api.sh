#!/bin/bash

# Простой скрипт для тестирования всех API endpoints
# Автоматически извлекает JWT токен и тестирует все маршруты

# Базовый URL для API
BASE_URL="http://localhost:8103/notes"
AUTH_BASE_URL="http://localhost:8101/auth"

echo "🚀 Полное тестирование Notes API"
echo "==============================="


# Получаем токен из auth API
echo ""
echo "🔍 Вход в систему (получение JWT токена)"
echo "Запрос: POST $AUTH_BASE_URL/login"
echo "Ответ:"
# Сохраняем ответ логина для извлечения токена - отдельно тело и статус
LOGIN_RESPONSE=$(curl -X "POST" "$AUTH_BASE_URL/login" \
     -H "Content-Type: application/json" \
     -d '{"username": "testuser","password":"password123"}' \
     -s)

echo "$LOGIN_RESPONSE"

# Получаем статус отдельно
LOGIN_STATUS=$(curl -X "POST" "$AUTH_BASE_URL/login" \
     -H "Content-Type: application/json" \
     -d '{"username": "testuser","password":"password123"}' \
     -w "%{http_code}" \
     -s -o /dev/null)

echo "📊 HTTP Статус: $LOGIN_STATUS"

# Извлекаем токен из JSON ответа (поле "access_token")
TOKEN=$(echo "$LOGIN_RESPONSE" | grep -o '"access_token":"[^"]*"' | cut -d'"' -f4)
# Удаляем возможные переносы строк и пробелы
TOKEN=$(echo "$TOKEN" | tr -d '\n\r ' | xargs)
echo "Извлеченный токен: $TOKEN"
echo "-------------------------------------------"

# Небольшая пауза между запросами
sleep 3

# Тест 1: Создание новой заметки
echo ""
echo "🔍 Создание новой заметки"
echo "Запрос: POST $BASE_URL/note"
echo "Ответ:"
CREATE_RESPONSE=$(curl -X "POST" "$BASE_URL/note" \
     -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"name":"Test Note","content":"Test Content"}' \
     -w "\n📊 HTTP Статус: %{http_code}\n")
     
# Извлекаем ID созданной заметки из ответа
ID_NOTE=$(echo "$CREATE_RESPONSE" | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
echo "ID созданной заметки: $ID_NOTE"
echo "-------------------------------------------"

# Небольшая пауза между запросами
sleep 2
# Тест 2: Получение списка всех заметок
echo ""
echo "🔍 Получение списка всех заметок"
echo "Запрос: GET $BASE_URL/notes"
echo "Ответ:"
curl -X "GET" "$BASE_URL/notes" \
     -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -w "\n📊 HTTP Статус: %{http_code}\n"
echo "-------------------------------------------"

# Небольшая пауза между запросами
sleep 2
# Тест 3: Получение заметки по ID
echo ""
echo "🔍 Получение заметки по ID"
echo "Запрос: GET $BASE_URL/note/$ID_NOTE"
echo "Ответ:"
curl -X "GET" "$BASE_URL/note/$ID_NOTE" \
     -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -w "\n📊 HTTP Статус: %{http_code}\n"
echo "-------------------------------------------"

# Небольшая пауза между запросами
sleep 2
# Тест 4: Редактирование заметки по ID
echo ""
echo "🔍 Редактирование заметки по ID"
echo "Запрос: PUT $BASE_URL/note/$ID_NOTE"
echo "Ответ:"
curl -X "PUT" "$BASE_URL/note/$ID_NOTE" \
     -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"name":"Updated Note","content":"Updated Content"}' \
     -w "\n📊 HTTP Статус: %{http_code}\n"
echo "-------------------------------------------"

# Небольшая пауза между запросами
sleep 2
# Тест 5: Удаление заметки по ID
echo ""
echo "🔍 Удаление заметки по ID"
echo "Запрос: DELETE $BASE_URL/note/$ID_NOTE"
echo "Ответ:"
curl -X "DELETE" "$BASE_URL/note/$ID_NOTE" \
     -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -w "\n📊 HTTP Статус: %{http_code}\n"
echo "-------------------------------------------"

echo "✅ Все тесты завершены!"
echo "==============================="