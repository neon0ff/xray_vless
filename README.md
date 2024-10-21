# Xray VLESS REALITY
#### Быстрая настройка XRAY на протоколе VLESS с REALITY
##### Нам понадобиться скачать unzip и docker
```bash
sudo apt-get install unzip
```
```bash
curl -fsSL https://test.docker.com | sudo sh
```
##### Скачиваем репозиторий и разархивируем ```xray```
```bash
git clone https://github.com/neon0ff/xray_vless
```
```bash
cd xray_vless
```
```bash
unzip xray.zip
```
```bash
rm xray.zip
```
##### Далее редактируем ```config.json``` под свои параметры и требования
```bash
sudo nano config.json
```
##### Для генерации данных можете воспользоваться этим
```bash
docker run itdoginfo/sing-box:v1.9.3 gen-vless
```
##### После изменений делайте сборку и запускаете контейнер с вашим образом
