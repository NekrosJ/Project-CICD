#!/bin/bash

# Thông tin cần thiết
EC2_PUBLIC_IP=52.201.131.187
IMAGE_NAME=nekrosj47/projectcicd
IMAGE_TAG=react-app-1.0

# Cài đặt Docker và chạy ứng dụng
ssh -i ~/.ssh/id_rsa ec2-user@$EC2_PUBLIC_IP <<SHEND
    # Kiểm tra Docker có sẵn chưa, nếu chưa cài đặt Docker
    if ! command -v docker &> /dev/null
    then
        echo "Docker not found. Installing Docker..."
        sudo yum install -y docker
        sudo service docker start
        sudo usermod -aG docker ec2-user
    else
        echo "Docker is already installed."
    fi

    # Kéo Docker image và chạy container
    sudo docker pull $IMAGE_NAME:$IMAGE_TAG
    sudo docker ps -q | xargs -r sudo docker stop
    sudo docker ps -aq | xargs -r sudo docker rm
    sudo docker run -d -p 80:80 $IMAGE_NAME:$IMAGE_TAG
SHEND
