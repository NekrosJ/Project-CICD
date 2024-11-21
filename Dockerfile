# # Build stage
# FROM node:16 AS build
# WORKDIR /app
# COPY package.json package-lock.json ./
# RUN npm install
# COPY . .
# RUN npm run build
# RUN ls -l /app/dist

# # Serve stage
# FROM nginx:alpine
# COPY --from=build /app/dist /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

# Sử dụng Node.js để build ứng dụng
FROM node:16 AS build

# Set thư mục làm việc trong container
WORKDIR /app

# Sao chép package.json và cài đặt dependencies
COPY package.json package-lock.json ./
RUN npm install

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Build ứng dụng React
RUN npm run build

# Kiểm tra nếu thư mục build tồn tại
RUN if [ ! -d "/app/build" ]; then echo "Build folder not found!"; exit 1; fi

# Sử dụng nginx để phục vụ ứng dụng React đã build
FROM nginx:alpine

# Sao chép build output từ image build vào nginx
COPY --from=build /app/build /usr/share/nginx/html

# Mở port 80 để phục vụ ứng dụng
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
