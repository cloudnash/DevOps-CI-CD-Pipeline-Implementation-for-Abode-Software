# DevOps-CI-CD-Pipeline-Implementation-for-Abode-Software

**Automated CI/CD pipeline with branch-based deployment - Deploy to production from master, test-only from develop branch.**


**📋 Table of Contents**
---

- Project Overview 
- Problem Statement
- Solution Architecture
- Pipeline Workflow
- Quick Start Guide
- Repository Structure
- Technologies Used
- Key Features
- Results & Impact




**🎯Project Overview**
---

As a Senior DevOps Engineer at Abode Software, I implemented a complete CI/CD pipeline that automates the entire software delivery process. This project demonstrates:

- Automated deployment pipeline using Jenkins
- Branch-based deployment logic (master → prod, develop → test only)
- Docker containerization for consistent deployments
- Infrastructure automation with Ansible
- Zero-downtime deployments


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


**⚡ Quick Start Guide**
---

- Step 1: Setup Infrastructure with Ansible
```
bash# Install Ansible
sudo apt update && sudo apt install ansible -y

# Run infrastructure setup
cd ansible
ansible-playbook -i inventory/hosts.ini playbooks/setup.yml
```
- Step 2: Configure Jenkins
```
bash# Access Jenkins
http://your-jenkins-server:8080

# Install Required Plugins:
- Git Plugin
- Docker Pipeline Plugin
- GitHub Integration Plugin

# Add Credentials:
- GitHub Personal Access Token
- Docker Hub Credentials
```
- Step 3: Create Jenkins Pipeline
  
  - New Item → Pipeline
  - Configure GitHub webhook: http://jenkins-server:8080/github-webhook/
  - Pipeline script from SCM → Select this repository
  - Save and test with a push

- Step 4: Test the Pipeline
```
bash# Clone the application
git clone https://github.com/hshar/website.git
cd website

# Make a change and push to develop (test only)
git checkout develop
echo "Test change" >> README.md
git commit -am "test: trigger pipeline"
git push origin develop

# Push to master (full deployment)
git checkout master
git merge develop
git push origin master
```


**📁 Repository Structure**
---
```
abode-software-devops-pipeline/
│
├── README.md                          # This file
├── Jenkinsfile                        # CI/CD pipeline definition
├── Dockerfile                         # Container configuration
│
├── ansible/                           # Infrastructure automation
│   ├── inventory/
│   │   └── hosts.ini                 # Server inventory
│   ├── playbooks/
│   │   ├── setup.yml                 # Main setup playbook
│   │   ├── jenkins.yml               # Jenkins installation
│   │   └── docker.yml                # Docker installation
│   └── roles/                        # Reusable roles
│
├── scripts/                          # Helper scripts
│   ├── deploy.sh                    # Deployment script
│   ├── test.sh                      # Test execution script
│   └── cleanup.sh                   # Cleanup script
│
├── tests/                           # Test files
│   └── run-tests.sh                # Test runner
│
└── docs/                            # Documentation
    ├── installation.md              # Setup guide
    ├── pipeline-explained.md        # Pipeline details
    └── images/                      # Diagrams and screenshots
```

**🛠️ Technologies Used*
---

```
| Technology | Purpose           | Version |
| ---------- | ----------------- | ------- |
| Jenkins    | CI/CD Automation  | 2.400+  |
| Docker     | Containerization  | 24.0+   |
| Ansible    | Config Management | 2.9+    |
| Git/GitHub | Version Control   | —       |
| Bash       | Scripting         | —       |
| Groovy     | Jenkins Pipelines | —       |
```
