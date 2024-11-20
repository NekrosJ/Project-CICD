#!/bin/bash
set -e # Dừng script nếu có lỗi xảy ra

echo "Đang SSH vào EC2 instance..."
ssh -i ~/.ssh/id_rsa $SSH_USER@$EC2_PUBLIC_IP "
    set -e &&
    # Debug: Kiểm tra Docker phiên bản và kết nối SSH
    docker --version &&
    echo 'Kết nối SSH thành công' &&
    echo 'Kéo Docker image mới...' &&
    docker pull $IMAGE_NAME:$IMAGE_TAG &&
    echo 'Dừng và xóa container cũ nếu có...' &&
    docker stop react-app || true &&
    docker rm react-app || true &&
    echo 'Chạy container mới...' &&
    docker run -d --name react-app -p 80:80 $IMAGE_NAME:$IMAGE_TAG &&
    echo 'Container đã được khởi động. Giữ container chạy liên tục...' &&
    # Giữ container chạy vĩnh viễn
    while true; do
        sleep 60 # Duy trì hoạt động để container không bị dừng
    done
"

echo "Triển khai thành công!"
