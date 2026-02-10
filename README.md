# Print on Demand (POD) Industrial Deployment

This project demonstrates a fully automated deployment of a **Print on Demand** web application using modern DevOps tools and practices. The infrastructure is provisioned on AWS using Terraform, and the application is containerized with Docker.

## 🚀 Project Overview

The goal of this project is to set up a scalable and robust environment for a 3-tier application consisting of:
- **Frontend:** React-based UI (hosted via Docker)
- **Backend:** Spring Boot API (hosted via Docker)
- **Database:** MySQL 8.0

## 🛠 Tech Stack

- **Cloud Provider:** AWS (EC2, VPC, Security Groups)
- **Infrastructure as Code (IaC):** Terraform
- **Containerization:** Docker & Docker Compose
- **OS:** Ubuntu 24.04 LTS

## 🏗 Infrastructure Architecture (Terraform)

The Terraform configuration provisions the following components:
- A custom **VPC** with public subnets.
- **Security Groups** allowing traffic on ports 22 (SSH), 80 (HTTP), and 5000 (API).
- An **EC2 Instance** (t3.small) with 20GB storage to handle Docker builds and deployments.
- **Key Pair** for secure SSH access.

## 🐳 Docker Deployment

The application is orchestrated using `docker-compose`. 

### Services:
1. **MySQL DB:** Persistent database storage using Docker volumes and health checks.
2. **Backend API:** Connects to the MySQL container within the same bridge network.
3. **Frontend:** Accessible on port 80.

## 🚦 How to Run

1. **Clone the repository:**
   ```bash
   git clone <your-repo-link>
   cd <project-folder>
