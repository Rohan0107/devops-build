# DevOps Build — Production Deployment

## 📌 Project Overview
This project deploys a React application to a production-ready state using Docker, Jenkins CI/CD pipeline, AWS EC2, Docker Hub, and Prometheus/Grafana monitoring.

**GitHub Repository:** https://github.com/Rohan0107/devops-build

**Deployed Application URL:** http://13.232.208.132

**Docker Hub (Dev):** rohan15543/devops-build-dev (Public)

**Docker Hub (Prod):** rohan15543/devops-build-prod (Private)

---

## 🛠️ Tech Stack
- **Frontend:** React (Pre-built)
- **Containerization:** Docker + Nginx
- **Container Registry:** Docker Hub (Dev & Prod repos)
- **CI/CD:** Jenkins (Multibranch Pipeline)
- **Cloud:** AWS EC2 (t3.micro)
- **Monitoring:** Prometheus + Grafana
- **Version Control:** GitHub (dev & master branches)

---

## 📁 Project Structure
```
devops-build/
├── build/                  # Pre-built React app
├── Dockerfile              # Docker configuration
├── docker-compose.yml      # Docker Compose configuration
├── build.sh                # Bash script to build Docker image
├── deploy.sh               # Bash script to deploy container
├── Jenkinsfile             # Jenkins pipeline definition
├── .gitignore              # Git ignore rules
├── .dockerignore           # Docker ignore rules
└── README.md               # Project documentation
```

---

## 🚀 Setup Instructions

### Prerequisites
- Docker installed
- AWS CLI configured
- Jenkins installed on EC2
- Docker Hub account

### Step 1 — Clone the Repository
```bash
git clone https://github.com/Rohan0107/devops-build.git
cd devops-build
```

### Step 2 — Build Docker Image
```bash
bash build.sh
# OR manually:
docker build -t devops-build .
```

### Step 3 — Deploy the App
```bash
bash deploy.sh
# OR manually:
docker run -d --name devops-build-container -p 80:80 devops-build
```
Visit http://localhost to verify.

### Step 4 — Using Docker Compose
```bash
docker-compose up -d
```

---

## 🔄 CI/CD Pipeline Explanation

The Jenkins Multibranch Pipeline automates build and deployment:

```
Push to dev branch
      ↓
Jenkins detects change via GitHub Webhook
      ↓
Build Docker image
      ↓
Push to rohan15543/devops-build-dev (Docker Hub)
      ↓
Deploy to EC2 server

Push to master branch
      ↓
Jenkins detects change
      ↓
Build Docker image
      ↓
Push to rohan15543/devops-build-prod (Docker Hub)
```

### Branch Strategy:
- **dev branch** → builds and pushes to `devops-build-dev` (public repo)
- **master branch** → builds and pushes to `devops-build-prod` (private repo)

---

## 📜 Bash Scripts

### build.sh
Builds the Docker image:
```bash
#!/bin/bash
echo "Building Docker image..."
docker build -t devops-build .
echo "Build complete!"
```

### deploy.sh
Stops existing container and deploys new one:
```bash
#!/bin/bash
docker stop devops-build-container 2>/dev/null || true
docker rm devops-build-container 2>/dev/null || true
docker run -d --name devops-build-container -p 80:80 devops-build
echo "Deployment complete!"
```

---

## ☁️ AWS EC2 Configuration

### Instance Details:
- **Instance Type:** t3.micro (Free Tier)
- **Region:** ap-south-1 (Mumbai)
- **OS:** Ubuntu 22.04
- **Public IP:** 13.232.208.132

### Security Group Rules:
| Type | Port | Source | Purpose |
|---|---|---|---|
| SSH | 22 | My IP only | Secure server access |
| HTTP | 80 | 0.0.0.0/0 | Public app access |
| Custom TCP | 8080 | 0.0.0.0/0 | Jenkins access |
| Custom TCP | 3000 | 0.0.0.0/0 | Grafana access |

---

## 📊 Monitoring

### Tools Used:
- **Prometheus** — Collects server metrics (port 9090)
- **Grafana** — Displays metrics dashboard (port 3000)
- **Node Exporter** — Exports system metrics to Prometheus

### Alert Rule:
- **Name:** App Down Alert
- **Condition:** `up == 0` (triggers when any service goes down)
- **Notification:** Email alert to admin
- **Evaluation:** Every 1 minute

### Access Monitoring:
- Grafana Dashboard: http://13.232.208.132:3000
- Prometheus: http://13.232.208.132:9090

---

## 📸 Screenshots

### 1. Jenkins Dashboard
![Jenkins Dashboard](screenshots/Jenkins_Login_Page.png)

### 2. Jenkins Pipeline Configuration
![Jenkins Pipeline](screenshots/Jenkins_Pipeline_Configuration.png)

### 3. Jenkins Build Success
![Jenkins Build Success](screenshots/enkins_Build_Success.png)

### 4. AWS EC2 Console
![EC2 Console](screenshots/EC2_Console.png)

### 5. Security Group Configuration
![Security Group](screenshots/Security_Group.png)

### 6. Docker Hub Dev Repository
![Docker Hub Dev](screenshots/Docker_Hub_Dev_repo.png)

### 7. Docker Hub Prod Repository
![Docker Hub Prod](screenshots/Docker_Hub_Prod_repo.png)

### 8. Deployed Application
![Deployed Site](screenshots/Deployed_Site.png)

### 9. Grafana Monitoring Dashboard
![Grafana Monitoring](screenshots/Grafana_Monitoring.png)

### 10. Alert Rules
![Alert Rules](screenshots/Alert_Rule.png)
