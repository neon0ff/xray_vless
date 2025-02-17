# Используем минимальный образ Alpine для сборки
FROM alpine:3.16

# Указываем информацию об авторе и версии
LABEL maintainer="Neon"
LABEL version="2.0.4"

# Устанавливаем необходимые зависимости
RUN apk add --no-cache nginx jq curl openssl bash

# Копируем бинарный файл Xray в контейнер
COPY xray /usr/local/bin/xray

# Устанавливаем права доступа для Xray
RUN chmod +x /usr/local/bin/xray

# Создаем конфигурационные папки
RUN mkdir -p /etc/xray /usr/local/share/xray /usr/share/nginx/html

# Копируем файл конфигурации Nginx
COPY default.conf /etc/nginx/http.d/default.conf

# Скрипт для запуска серверов
COPY start_servers.sh /start_servers.sh

# Устанавливаем права доступа для скрипта
RUN chmod +x /start_servers.sh

# Команда для запуска контейнера
CMD ["/start_servers.sh"]
