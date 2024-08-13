#!/bin/bash

# Обновление списка пакетов
echo "Обновление списка пакетов..."
sudo apt update

# Установка необходимых пакетов для установки Docker
echo "Установка необходимых пакетов..."
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Добавление официального GPG ключа Docker
echo "Добавление официального GPG ключа Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Добавление Docker репозитория в список источников APT
echo "Добавление Docker репозитория в список источников APT..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновление списка пакетов снова для загрузки пакетов из нового репозитория Docker
echo "Обновление списка пакетов снова..."
sudo apt update

# Установка Docker
echo "Установка Docker..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Проверка статуса Docker
echo "Проверка статуса Docker..."
sudo systemctl status docker --no-pager

# Добавление пользователя в группу docker, чтобы можно было использовать Docker без sudo
echo "Добавление пользователя в группу docker..."
sudo usermod -aG docker $USER

# Перезагрузка shell для применения изменений группы пользователя
echo "Перезагрузка shell..."
newgrp docker

# Загрузка Docker Compose
echo "Загрузка Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Делаем Docker Compose исполняемым
echo "Делаем Docker Compose исполняемым..."
sudo chmod +x /usr/local/bin/docker-compose

# Проверка установки Docker Compose
echo "Проверка установки Docker Compose..."
docker-compose --version

echo "Установка Docker и Docker Compose завершена."
