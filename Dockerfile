# Используем минимальный образ Alpine для сборки
FROM alpine:3.16 AS builder

# Указываем информацию об авторе и версии
LABEL maintainer="Neon"
LABEL version="0.1.0"

# Устанавливаем необходимые зависимости
RUN apk add --no-cache unzip

# Копируем бинарный файл Xray в контейнер
COPY xray /usr/local/bin/xray

# Создаем конфигурационные папки
RUN mkdir -p /etc/xray /usr/local/share/xray

# Копируем конфигурационный файл VLESS
COPY config.json /etc/xray/config.json

# Устанавливаем права доступа
RUN chmod +x /usr/local/bin/xray

# Указываем точку входа для контейнера
ENTRYPOINT ["/usr/local/bin/xray", "-config", "/etc/xray/config.json"]
