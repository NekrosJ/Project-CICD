#!/bin/bash

# Thông tin cần thiết
EC2_PUBLIC_IP=52.201.131.187
IMAGE_NAME=nekrosj47/projectcicd
IMAGE_TAG=react-app-1.0

# Cấu hình SSH
SSH_USER="ec2-user" # hoặc tên người dùng tương ứng với hệ điều hành EC2 của bạn
PRIVATE_KEY_PATH="~/.ssh/id_rsa"

# Kết nối SSH và triển khai Docker container
ssh -i $PRIVATE_KEY_PATH $SSH_USER@$EC2_PUBLIC_IP << EOF
    sudo docker pull $IMAGE_NAME:$IMAGE_TAG && \
    sudo docker ps -q | xargs -r sudo docker stop && \
    sudo docker ps -aq | xargs -r sudo docker rm && \
    sudo docker run -d -p 80:80 $IMAGE_NAME:$IMAGE_TAG
EOF
