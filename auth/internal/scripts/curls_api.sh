# Регистрация нового пользователя
curl -X POST "http://localhost:8101/auth/register" \
     -H "Content-Type: application/json" \
     -d '{
           "username": "testuser",
           "email": "test@example.com",
           "password": "password123"
         }' \
     -w "\nStatus: %{http_code}\n"

# Логин пользователя
curl -X POST "http://localhost:8101/auth/login" \
     -H "Content-Type: application/json" \
     -d '{
          "username": "testuser",
           "password": "password123"
         }' \
     -w "\nStatus: %{http_code}\n"

# Получение данных о пользователе
curl -X GET "http://localhost:8101/auth/user" \
     -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTE2MTU0ODksImlhdCI6MTc1MTUyOTA4OSwiaWQiOjUsInR5cGUiOiJhY2Nlc3NUb2tlbiJ9.AFSkh751rxI_Op_fCeLFsrPSJGz7U4cujlIV_kILEBQ" \
     -H "Content-Type: application/json" \
     -w "\nStatus: %{http_code}\n"

# Обновление данных пользователя
curl -X PUT "http://localhost:8101/auth/user" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTE2MTU0ODksImlhdCI6MTc1MTUyOTA4OSwiaWQiOjUsInR5cGUiOiJhY2Nlc3NUb2tlbiJ9.AFSkh751rxI_Op_fCeLFsrPSJGz7U4cujlIV_kILEBQ" \
     -d '{
           "username": "updated_username",
           "email": "updated@example.com"
         }' \
     -w "\nStatus: %{http_code}\n"

# Удаление пользователя
curl -X DELETE "http://localhost:8101/auth/user" \
     -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTE2MTU0ODksImlhdCI6MTc1MTUyOTA4OSwiaWQiOjUsInR5cGUiOiJhY2Nlc3NUb2tlbiJ9.AFSkh751rxI_Op_fCeLFsrPSJGz7U4cujlIV_kILEBQ" \
     -H "Content-Type: application/json" \
     -w "\nStatus: %{http_code}\n"

# Обновление токена
curl -X POST "http://localhost:8101/auth/refresh" \
     -H "Content-Type: application/json" \
     -d '{
           "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTE2MTU0ODksImlhdCI6MTc1MTUyOTA4OSwiaWQiOjUsInR5cGUiOiJyZWZyZXNoVG9rZW4ifQ.AFSkh751rxI_Op_fCeLFsrPSJGz7U4cujlIV_kILEBQ"
         }' \
     -w "\nStatus: %{http_code}\n" 
