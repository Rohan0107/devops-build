pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        IMAGE_NAME_DEV = 'rohan15543/devops-build-dev'
        IMAGE_NAME_PROD = 'rohan15543/devops-build-prod'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t devops-build .'
            }
        }
        stage('Push to Dev') {
            when {
                branch 'dev'
            }
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker tag devops-build $IMAGE_NAME_DEV:latest'
                sh 'docker push $IMAGE_NAME_DEV:latest'
            }
        }
        stage('Push to Prod') {
            when {
                branch 'master'
            }
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker tag devops-build $IMAGE_NAME_PROD:latest'
                sh 'docker push $IMAGE_NAME_PROD:latest'
            }
        }
        stage('Deploy') {
            steps {
                sh 'bash deploy.sh'
            }
        }
    }
}