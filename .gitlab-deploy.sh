#!/bin/bash
set -e # Dừng script nếu có lỗi xảy ra

echo "Đang SSH vào EC2 instance..."
ssh -i ~/.ssh/id_rsa $SSH_USER@$EC2_PUBLIC_IP "
    docker login -u $REGISTRY_USER -p $REGISTRY_PASS $REGISTRY_URL &&
    docker pull $IMAGE_NAME:$IMAGE_TAG &&
    docker stop react-app || true &&
    docker rm react-app || true &&
    docker run -d --name react-app -p 80:80 $IMAGE_NAME:$IMAGE_TAG
"

echo "Triển khai thành công!"
