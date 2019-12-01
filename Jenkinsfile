#!/usr/bin/env groovy

REPOSITORY_ADDRESS = "${AWS_ACCOUNT_ID}.dkr.ecr.eu-central-1.amazonaws.com"
PROJECT_NAME = "nginx-with-s3"

pipeline {
    agent any
    stages {
        stage('Initialise') {
            steps {
		      sh "rm -rf ${PROJECT_NAME} "
              	      sh "git clone https://github.com/dswilkinson73/${PROJECT_NAME}.git"
		      echo "Initialising job - cloning ${PROJECT_NAME} repository"
                      dir("${PROJECT_NAME}") {
                      sh 'pwd'
                  }
            }
        }
        stage('Build') {
            steps {
                      dir("${PROJECT_NAME}") {
                      echo "Building the ${PROJECT_NAME} Container"
                      sh "docker build --tag ${PROJECT_NAME} ."
                  }
		      
            }
        }
        stage('Deploy') {
            steps {
                     dir("${PROJECT_NAME}") {
                     echo "Uploading ${PROJECT_NAME} to AWS"

                     sh "aws ecr describe-repositories --repository-names ${PROJECT_NAME} || aws ecr create-repository --repository-name ${PROJECT_NAME}"

                     sh "aws ecr get-login --no-include-email --region ${AWS_DEFAULT_REGION} | sh"
                     sh "docker tag jenkins-with-tools:latest ${REPOSITORY_ADDRESS}/${PROJECT_NAME}:latest"
                     sh "docker push $REPOSITORY_ADDRESS/${PROJECT_NAME}"
                }
            }
        }
    }
}

