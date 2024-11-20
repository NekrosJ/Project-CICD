#!/bin/bash
set -e # Dừng script nếu có lỗi xảy ra

echo "Đang SSH vào EC2 instance..."
ssh -i ~/.ssh/id_rsa $SSH_USER@$EC2_PUBLIC_IP "
    set -e &&
    echo 'Đăng nhập Docker Registry...' &&
    docker login -u $REGISTRY_USER -p $REGISTRY_PASS $REGISTRY_URL &&
    echo 'Kéo Docker image mới...' &&
    docker pull $IMAGE_NAME:$IMAGE_TAG &&
    echo 'Dừng và xóa container cũ nếu có...' &&
    docker stop react-app || true &&
    docker rm react-app || true &&
    echo 'Chạy container mới...' &&
    docker run -d --name react-app -p 80:80 $IMAGE_NAME:$IMAGE_TAG
"

echo "Triển khai thành công!"
