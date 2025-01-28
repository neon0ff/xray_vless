#!/bin/bash

# Проверяем, существует ли файл конфигурации в монтируемой директории
if [ ! -f "/etc/keygen/config.json" ]; then
    # Если нет, копируем шаблон из /etc/keygen_template в /etc/keygen
    cp /etc/keygen_template/empty_config.json /etc/keygen/config.json
fi

# Генерация ключей
key_pair=$(sing-box generate reality-keypair)
private_key=$(echo "$key_pair" | awk '/PrivateKey/ {print $2}')
public_key=$(echo "$key_pair" | awk '/PublicKey/ {print $2}')

# Генерация Short ID
short_id=$(openssl rand -hex 8)

# Генерация UUID
uuid=$(sing-box generate uuid)

# Вывод в нужном формате
echo "Private Key: $private_key"
echo "Public Key: $public_key"
echo "Short ID: $short_id"
echo "UUID: $uuid"

# Чтение содержимого config.json в переменную
config_file="/etc/keygen/config.json"
config_content=$(<"$config_file")

# Замена значений в конфигурации
config_content=$(echo "$config_content" | sed "s/\"id\": \"YOUR_ID\"/\"id\": \"$uuid\"/")
config_content=$(echo "$config_content" | sed "s/\"privateKey\": \"YOUR_PRIVAT_KEY\"/\"privateKey\": \"$private_key\"/")
config_content=$(echo "$config_content" | sed "s/\"shortIds\": \[\"YOUR_SHORT_ID\"\]/\"shortIds\": [\"$short_id\"]/")

# Запись обновленного содержимого обратно в config.json
echo "$config_content" > "$config_file"
echo "Конфигурация успешно записана"

# Сохраняем publicKey в отдельный файл или выводим его как переменную окружения
echo "PUBLIC_KEY=$public_key" >> /etc/keygen/public_key.env
