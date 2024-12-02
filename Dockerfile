# Build stage
FROM node:16-slim AS build
WORKDIR /app

# Chỉ copy các file cần thiết trước khi cài đặt
COPY package.json package-lock.json ./
RUN npm install && npm cache clean --force

# Copy source code và build
COPY . .
RUN npm run build && rm -rf node_modules && ls -l /app/dist

# Serve stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
