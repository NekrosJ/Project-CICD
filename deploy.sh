#!/bin/bash

set -e  # Kết thúc nếu có lỗi xảy ra
set -x  # Hiển thị log khi chạy script

EC2_PUBLIC_IP=3.95.208.126
IMAGE_NAME=nekrosj47/projectcicd
IMAGE_TAG=react-app-1.0

ssh -i ~/.ssh/id_rsa ec2-user@$EC2_PUBLIC_IP <<SHEND
    set -e
    set -x

    # Kiểm tra và cài đặt Docker
    if ! command -v docker &> /dev/null; then
        echo "Docker not found. Installing Docker..."
        sudo yum install -y docker
        sudo service docker start
        sudo usermod -aG docker ec2-user
    else
        echo "Docker is already installed."
    fi

    # Gỡ container và image cũ
    sudo docker rm -f $(sudo docker ps -aq) || true
    sudo docker image prune -f

    # Kéo Docker image và chạy container
    sudo docker pull $IMAGE_NAME:$IMAGE_TAG
    sudo docker run -d -p 80:80 $IMAGE_NAME:$IMAGE_TAG

    # Kiểm tra container đã chạy thành công
    if ! curl -s http://localhost:80; then
        echo "Deployment failed. Exiting..."
        exit 1
    fi
SHEND
