# Используем минимальный образ Alpine для сборки
FROM alpine:3.16

# Указываем информацию об авторе и версии
LABEL maintainer="Neon"
LABEL version="2.0.4"

# Устанавливаем необходимые зависимости
RUN apk add --no-cache bash openssl

# Копируем бинарный файл Sing-box в контейнер
COPY sing-box /usr/local/bin/sing-box

# Устанавливаем права доступа для Sing-box
RUN chmod +x /usr/local/bin/sing-box

# Создаем конфигурационные папки
RUN mkdir -p /etc/keygen_template

# Копируем файл конфигурации по умолчанию (если есть)
COPY empty_config.json /etc/keygen_template/empty_config.json

# Копируем скрипт для генерации ключей
COPY generate_keys.sh /generate_keys.sh

# Устанавливаем права доступа для скрипта
RUN chmod +x /generate_keys.sh

# Команда для запуска контейнера
CMD ["/generate_keys.sh"]
