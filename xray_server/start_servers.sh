#!/bin/bash

# Получение IP-адреса сервера
SERVER_IP=$(curl -s 2ip.ru)

# Чтение содержимого config.json в переменную
config_file="/etc/xray/config.json"
config_content=$(<"$config_file")

# Извлечение значений из конфигурации
uuid=$(jq -r '.inbounds[0].settings.clients[0].id' "$config_file")
private_key=$(jq -r '.inbounds[0].streamSettings.realitySettings.privateKey' "$config_file")
short_id=$(jq -r '.inbounds[0].streamSettings.realitySettings.shortIds[0]' "$config_file")
flow=$(jq -r '.inbounds[0].settings.clients[0].flow' "$config_file")
decryption=$(jq -r '.inbounds[0].settings.decryption' "$config_file")
type=$(jq -r '.inbounds[0].protocol' "$config_file")
security=$(jq -r '.inbounds[0].streamSettings.security' "$config_file")
server_port=$(jq -r '.inbounds[0].port' "$config_file") # Порт указан в конфигурации
sni=$(jq -r '.inbounds[0].streamSettings.realitySettings.serverNames[0]' "$config_file") # SNI указан в конфигурации

# Чтение значения public_key из файла public_key.env
source /etc/keygen/public_key.env

# Генерация конфигурационного файла для Nginx
jq -n \
--arg uuid "$uuid" \
--arg short_id "$short_id" \
--arg pbk "$PUBLIC_KEY" \
--arg server "$SERVER_IP" \
--arg server_port "$server_port" \
--arg flow "$flow" \
--arg decryption "$decryption" \
--arg type "$type" \
--arg security "$security" \
--arg fp "chrome" \
--arg sni "$sni" \
'{uuid: $uuid, sid: $short_id, pbk: $pbk, server: $server, server_port: $server_port, flow: $flow, fp: $fp, sni: $sni}' \
> /usr/share/nginx/html/config_data.json

# Запуск серверов
nginx -g 'daemon off;' &
/usr/local/bin/xray -config /etc/xray/config.json
