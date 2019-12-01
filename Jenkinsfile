#!/usr/bin/env groovy

REPOSITORY_ADDRESS = "${AWS_ACCOUNT_ID}.dkr.ecr.eu-central-1.amazonaws.com"
PROJECT_NAME = "Nginx-WithS3"

pipeline {
    agent any
    stages {
        stage('Initialise') {
            steps {
		      sh "rm -rf ${PROJECT_NAME}"
              	      sh "git clone https://github.com/dswilkinson73/${PROJECT_NAME}.git"
		      echo "Initialising job - cloning repo"
                      dir("${PROJECT_NAME}") {
                      sh 'pwd'
                  }
            }
        }
        stage('Build') {
            steps {
                      dir("Jenkins-WithTools-Docker") {
                      echo "Building Container"
                      sh 'docker build --tag jenkins-with-tools .'
                  }
		      
            }
        }
        stage('Deploy') {
            steps {
                     dir("Jenkins-WithTools-Docker") {
                     echo "Upload to Docker Hub"
                     sh "aws ecr get-login --no-include-email --region ${AWS_DEFAULT_REGION} | sh"
                     sh "docker tag jenkins-with-tools:latest ${REPOSITORY_ADDRESS}/jenkins-with-tools:latest"
                     sh "docker push $REPOSITORY_ADDRESS/jenkins-with-tools"
                }
            }
        }
    }
}

