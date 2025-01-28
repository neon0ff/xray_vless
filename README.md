### Сборка образов
##### Собираем образ keygen-singbox
```bash
docker build -t keygen-singbox -f Dockerfile_keygen .
```
##### Собираем образ xRay
```bash
docker build -t xray-vless .
```
---
### Сборка контейнеров
##### Запуск контейнеров ччерез docker compose
```bash
docker-compose up -d
```
---
##### Запуск контейнеров в ручном режиме
##### 1) Запускаем keygen
```bash
docker run --rm -v $(pwd)/data:/etc/keygen keygen-singbox
```
##### 2) Запускаем xRay
```bash
docker run -d --name vless -v ./data/config.json:/etc/xray/config.json -v ./data/public_key.env:/etc/keygen/public_key.env -p 80:80 -p 443:443 xray-vless
```
