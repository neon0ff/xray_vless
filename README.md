#### Сборка образов
##### Собираем образ keygen-singbox
```bash
dokcer build -t keygen-singbox -f Dockerfile_keygen .
```
##### Собираем образ xRay
```bash
docker build -t xray-vless .
```
##### Запускаем keygen
```bash
docker run --rm -v $(pwd)/data:/etc/keygen keygen-singbox
```
##### Запускаем xRay
```bash
docker run -d --name vless -v ./data/config.json:/etc/xray/config.json -v ./data/public_key.env:/etc/keygen/public_key.env -p 80:80 -p 443:443 xray-vless
```
