# Базовый образ с Node.js
FROM node:18-alpine as builder

# Установка рабочей директории
WORKDIR /app

# Копирование файлов зависимостей
COPY package*.json ./

# Установка зависимостей
RUN npm install

# Копирование исходного кода
COPY . .

# Сборка веб-версии (если используете `react-native-web`)
# Предположим, у вас есть скрипт "build:web" в package.json
RUN expo start --web

# --- Второй этап: запуск через nginx ---
FROM nginx:alpine

# Копирование собранных файлов из предыдущего этапа
COPY --from=builder /app/dist /usr/share/nginx/html

# Копирование конфигурации nginx (опционально)
# COPY nginx.conf /etc/nginx/nginx.conf

# Открытие порта
EXPOSE 80

# Запуск nginx
CMD ["nginx", "-g", "daemon off;"]