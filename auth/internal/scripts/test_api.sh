#!/bin/bash

# Простой скрипт для тестирования всех API endpoints
# Автоматически извлекает JWT токен и тестирует все маршруты

# Базовый URL для API
BASE_URL="http://localhost:8101/auth"

echo "🚀 Полное тестирование Auth API"
echo "==============================="


# Тест 1: Регистрация нового пользователя
echo ""
echo "🔍 Регистрация нового пользователя"
echo "Запрос: POST $BASE_URL/register"
curl -X POST "$BASE_URL/register" \
     -H "Content-Type: application/json" \
     -d '{
           "username": "testuser",
           "password": "password123"
         }' \
     -w "\n📊 HTTP Статус: %{http_code}\n" \
     -s
echo "-------------------------------------------"

# Небольшая пауза между запросами
sleep 1

# Тест 2: Вход в систему и получение токена
echo ""
echo "🔍 Вход в систему (получение JWT токена)"
echo "Запрос: POST $BASE_URL/login"
echo "Ответ:"
# Сохраняем ответ логина для извлечения токена
LOGIN_RESPONSE=$(curl -X "POST" "$BASE_URL/login" \
     -H "Content-Type: application/json" \
     -d '{"username": "testuser","password":"password123"}' \
     -w "\n📊 HTTP Статус: %{http_code}\n" \
     -s)

echo "$LOGIN_RESPONSE"

# Извлекаем токен из JSON ответа (поле "access_token")
TOKEN=$(echo "$LOGIN_RESPONSE" | grep -o '"access_token":"[^"]*"' | cut -d'"' -f4)

echo "Извлеченный токен: $TOKEN"
echo "-------------------------------------------"

# Небольшая пауза между запросами
sleep 1

# Тест 3: Получение информации о пользователе
echo ""
echo "🔍 Получение информации о пользователе"
echo "Запрос: GET $BASE_URL/user"
echo "Ответ:"
curl -X "GET" "$BASE_URL/user" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $TOKEN" \
     -w "\n📊 HTTP Статус: %{http_code}\n" \
     -s
echo "-------------------------------------------"

# Небольшая пауза между запросами
sleep 1

# Тест 4: Обновление информации о пользователе
echo ""
echo "🔍 Обновление информации о пользователе"
echo "Запрос: PUT $BASE_URL/user"
echo "Ответ:"
curl -X "PUT" "$BASE_URL/user" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $TOKEN" \
     -d '{"username":"updated_testuser","email":"updated@example.com"}' \
     -w "\n📊 HTTP Статус: %{http_code}\n" \
     -s
echo "-------------------------------------------"

# Небольшая пауза между запросами
sleep 1

# Тест 5: Проверка обновленной информации
echo ""
echo "🔍 Проверка обновленной информации о пользователе"
echo "Запрос: GET $BASE_URL/user"
echo "Ответ:"
curl -X "GET" "$BASE_URL/user" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $TOKEN" \
     -w "\n📊 HTTP Статус: %{http_code}\n" \
     -s
echo "-------------------------------------------"

# Небольшая пауза между запросами
sleep 1

# Тест 6: Удаление пользователя
echo ""
echo "🔍 Удаление пользователя"
echo "Запрос: DELETE $BASE_URL/user"
echo "Ответ:"
curl -X "DELETE" "$BASE_URL/user" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $TOKEN" \
     -w "\n📊 HTTP Статус: %{http_code}\n" \
     -s
echo "-------------------------------------------"


echo ""
echo "✅ Тестирование всех endpoints завершено!"