# Microservices Demo on AWS using ECS Fargate, Terraform, and GitHub Actions

This project is a complete end-to-end deployment of a microservices-based application on AWS.  
It covers containerization, CI, infrastructure provisioning, and automated deployments using real production tooling.

The goal of this project is to demonstrate **practical DevOps skills**

---

## Architecture Overview

The application is composed of multiple independent microservices deployed as Docker containers on **AWS ECS Fargate**.  
A public **Application Load Balancer (ALB)** exposes the frontend, while internal services communicate using **AWS Cloud Map Service Discovery**.  
Container images are stored in **Amazon ECR**, and the entire infrastructure is provisioned using **Terraform**.  
CI and image builds are automated using **GitHub Actions**.

---

## High-Level Architecture

- AWS VPC with public and private subnets
- Application Load Balancer (public)
- ECS Cluster (Fargate launch type)
- ECS Services for each microservice
- AWS Cloud Map for service discovery
- Amazon ECR for container images
- Terraform for Infrastructure as Code
- GitHub Actions for CI and deployment

---

## Microservices List

| Service Name | Exposure | Description |
|-------------|---------|-------------|
| frontend | Public (ALB) | Web UI |
| cart-service | Internal | Shopping cart |
| checkout-service | Internal | Checkout processing |
| payment | Internal | Payment handling |
| shipping | Internal | Shipping logic |
| product | Internal | Product catalog |
| recommendation-service | Internal | Product recommendations |
| assistant-service | Internal | Shopping assistant |
| currency-service | Internal | Currency conversion |
| email-service | Internal | Email notifications |
| redis-service | Internal | Cache |
| loadgenerator-service | Internal | Load testing |

---

## Container Image Strategy

- Each service has its own Docker image
- Images are built and pushed to **Amazon ECR**
- Image tags use **short Git SHA** for immutability
- ECS task definitions are updated automatically with new tags

Example image format:
