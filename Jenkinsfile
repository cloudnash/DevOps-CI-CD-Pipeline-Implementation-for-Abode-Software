pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "nashit836/abode-webapp"
        DOCKER_TAG = "${BUILD_NUMBER}"
        APP_DIR = "/var/www/html"
    }
    
    stages {
        stage('1️⃣ Build') {
            steps {
                echo '🚀 Starting Build Stage'
                checkout scm
                
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                    docker.build("${DOCKER_IMAGE}:latest")
                }
                
                echo '✅ Build completed!'
            }
        }
        
        stage('2️⃣ Test') {
            steps {
                echo '🧪 Running Tests'
                
                script {
                    sh '''
                        docker run --rm ${DOCKER_IMAGE}:${DOCKER_TAG} \
                        /bin/bash -c "bash /tests/run-tests.sh"
                    '''
                }
                
                echo '✅ Tests passed!'
            }
        }
        
        stage('3️⃣ Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                echo '🚀 Deploying to Production'
                
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                    
                    sh '''
                        docker stop abode-webapp || true
                        docker rm abode-webapp || true
                        
                        docker run -d \
                            --name abode-webapp \
                            -p 80:80 \
                            ${DOCKER_IMAGE}:${DOCKER_TAG}
                        
                        sleep 10
                        curl -f http://localhost:80 || exit 1
                    '''
                }
                
                echo '✅ Production deployment successful!'
            }
        }
    }
    
    post {
        success {
            script {
                if (env.BRANCH_NAME == 'main') {
                    echo '🎉 Deployed to PRODUCTION'
                } else {
                    echo '✅ Tests passed (no deployment)'
                }
            }
        }
        
        failure {
            echo '❌ Pipeline Failed!'
        }
    }
}
