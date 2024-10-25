# Используем минимальный образ Alpine для сборки
FROM alpine:3.16

# Указываем информацию об авторе и версии
LABEL maintainer="Neon"
LABEL version="0.5.0"

# Устанавливаем необходимые зависимости
RUN apk add --no-cache nginx jq curl

# Копируем бинарный файл Xray в контейнер
COPY xray /usr/local/bin/xray

# Устанавливаем права доступа для Xray
RUN chmod +x /usr/local/bin/xray

# Создаем конфигурационные папки
RUN mkdir -p /etc/xray /usr/local/share/xray /usr/share/nginx/html

# Копируем конфигурационный файл VLESS
COPY config.json /etc/xray/config.json

# Копируем файл конфигурации Nginx
COPY default.conf /etc/nginx/http.d/default.conf

# Указываем SNI и Server Port
ENV SNI="yahoo.com"
ENV SERVER_PORT="443"

# Команда для запуска контейнера
CMD SERVER_IP=$(curl -s 2ip.ru) && \
    jq -n \
        --arg uuid "$(jq -r '.inbounds[0].settings.clients[0].id' /etc/xray/config.json)" \
        --arg short_id "$(jq -r '.inbounds[0].streamSettings.realitySettings.shortIds[0]' /etc/xray/config.json)" \
        --arg pbk "xwMcjQ-YZOOWy0fHaR1SQsjKMGbDlnXqts7DwcLEulY" \
        --arg server "$SERVER_IP" \
        --arg server_port "$SERVER_PORT" \
        --arg flow "$(jq -r '.inbounds[0].settings.clients[0].flow' /etc/xray/config.json)" \
        --arg decryption "$(jq -r '.inbounds[0].settings.decryption' /etc/xray/config.json)" \
        --arg type "$(jq -r '.inbounds[0].protocol' /etc/xray/config.json)" \
        --arg security "$(jq -r '.inbounds[0].streamSettings.security' /etc/xray/config.json)" \
        --arg fp "chrome" \
        --arg sni "$SNI" \
        '{uuid: $uuid, sid: $short_id, pbk: $public_key, server: $server, server_port: $server_port, flow: $flow, fp: $fp, sni: $sni}' \
        > /usr/share/nginx/html/config_data.json && \
    nginx -g 'daemon off;' & /usr/local/bin/xray -config /etc/xray/config.json
