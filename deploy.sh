#!/bin/bash

# Nhận thông tin từ tham số
EC2_PUBLIC_IP=$1
IMAGE_NAME=$2
IMAGE_TAG=$3

# Kiểm tra Docker và triển khai ứng dụng
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa ec2-user@$EC2_PUBLIC_IP <<EOF
    # Kiểm tra và cài đặt Docker nếu chưa có
    if ! command -v docker &> /dev/null
    then
        echo "Docker không được tìm thấy. Đang cài đặt Docker..."
        sudo yum update -y
        sudo yum install -y docker
        sudo service docker start
        sudo usermod -aG docker ec2-user
    else
        echo "Docker đã được cài đặt."
    fi

    # Kéo image từ Docker Hub và chạy container
    echo "Đang kéo image từ Docker Hub..."
    sudo docker pull $IMAGE_NAME:$IMAGE_TAG
    echo "Dừng và gỡ bỏ container cũ (nếu có)..."
    sudo docker ps -q | xargs -r sudo docker stop
    sudo docker ps -aq | xargs -r sudo docker rm
    echo "Chạy container mới..."
    sudo docker run -d -p 80:80 $IMAGE_NAME:$IMAGE_TAG
EOF
