# DevOps-CI-CD-Pipeline-Implementation-for-Abode-Software

**Automated CI/CD pipeline with branch-based deployment - Deploy to production from master, test-only from develop branch.**


**📋 Table of Contents**
---

✅ Project Overview 

✅ Problem Statement

✅ Solution Architecture

✅ Pipeline Workflow

✅ Quick Start Guide

✅ Repository Structure

✅ Technologies Used

✅ Key Features

✅ Results & Impact




**🎯Project Overview**
---

As a Senior DevOps Engineer at Abode Software, I implemented a complete CI/CD pipeline that automates the entire software delivery process. This project demonstrates:

✅ Automated deployment pipeline using Jenkins

✅ Branch-based deployment logic (master → prod, develop → test only)

✅ Docker containerization for consistent deployments

✅ Infrastructure automation with Ansible

✅ Zero-downtime deployments


Application Repository: [hshar/website](https://github.com/hshar/website.git)

Container Base Image: hshar/webapp


**🚨 Problem Statement**
---

Abode Software needed to:

 - Reduce manual deployment time and errors

 - Implement automated testing before production

 - Separate development testing from production deployments

 - Containerize the application for environment consistency

 - Automate infrastructure setup






**🏗️ Solution Architecture**
---

```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│   GitHub    │────────▶│   Jenkins    │────────▶│   Docker    │
│  Repository │ Webhook │   Pipeline   │  Build  │     Hub     │
└─────────────┘         └──────────────┘         └─────────────┘
                               │
                    ┌──────────┴──────────┐
                    ▼                     ▼
            ┌──────────────┐      ┌──────────────┐
            │ Develop Push │      │ Master Push  │
            │  (Test Only) │      │ (Test + Prod)│
            └──────────────┘      └──────────────┘

```


**🔄 Pipeline Workflow**
---

- When Code is Pushed to DEVELOP Branch:

```
1. GitHub Webhook Triggers Jenkins
2. Job 1: Build → Checkout code + Build Docker image
3. Job 2: Test → Run automated tests
4. ❌ Job 3: SKIP Production deployment
5. ✅ Pipeline Complete (No prod deployment)
```
- When Code is Pushed to MASTER Branch:

```
1. GitHub Webhook Triggers Jenkins
2. Job 1: Build → Checkout code + Build Docker image
3. Job 2: Test → Run automated tests
4. ✅ Job 3: Deploy to Production
5. 🎉 Live on Production Server
```
