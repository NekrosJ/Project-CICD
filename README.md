# 🚀 CI/CD Pipeline for React + Vite Deployment

## 📝 Overview  
This project demonstrates a **CI/CD pipeline** for deploying a React application built with **Vite** using **GitLab CI/CD and GitHub Actions**. The application is containerized with **Docker** and deployed to **AWS EC2** via SSH.

## 🎯 Key Features  
✅ **Automated CI/CD Pipeline** – GitLab CI/CD & GitHub Actions for build, test, and deployment.  
✅ **Containerization** – Dockerized application, stored on DockerHub.  
✅ **Cloud Deployment** – Automated deployment to AWS EC2.  
✅ **Secure Deployment** – SSH keys for secure access.  

## 🛠️ Tech Stack  
- **CI/CD Tools**: GitLab CI/CD, GitHub Actions  
- **Containerization**: Docker, DockerHub  
- **Cloud Provider**: AWS EC2  
- **Scripting**: Bash  
- **Web Server**: Nginx  

## ⚙️ CI/CD Pipeline Workflow  

1️⃣ **Code Push** – Push code to GitLab/GitHub → CI/CD pipeline triggers.  
2️⃣ **Build & Test** – Install dependencies, run tests, and build the project.  
3️⃣ **Dockerization** – Build Docker image and push to DockerHub.  
4️⃣ **Deployment** – Connect to AWS EC2 via SSH and deploy the containerized application.  

## 🚀 Deployment Process  

### 🔹 CI/CD Automation  
CI/CD pipelines are defined in `.gitlab-ci.yml` (GitLab) and `.github/workflows/deploy.yml` (GitHub Actions).  

### 🔹 Manual Deployment  
```bash
docker build -t your-image-name .
docker run -d -p 80:80 your-image-name
