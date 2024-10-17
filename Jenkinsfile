pipeline {
    agent any

    tools {
        maven 'my-maven'
        jdk 'JDK 21'
    }

    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/sharunraj/Eureka-pipeline.git', branch: 'main'
            }
        }
//Test file
//         stage("Pre-Steps"){
//             steps{
//
//                 bat "docker stop springsecurity"
//                 bat "docker rm -f springsecurity"
//                 bat "docker rmi springsecurity"
//             }
//         }
        stage('Pre-Build') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        // Pre-build Docker cleanup steps
                        bat '''
                        docker stop registry-sr || true
                        docker rm registry-sr || true
                        docker rmi -f registry-sr:latest || true
                        '''
                    }
                }
            }
        }
        stage('Build') {
            steps {
                bat "mvn clean install"
            }
        }
        stage('Create Docker Network') {
             steps {
                script {
                    // Create a Docker network, ignore errors if it already exists
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        bat 'docker network create my-network || echo "Network already exists"'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                bat "docker build -t registry-sr ."
                bat "docker run --network my-network -p 8761:8761 -d --name registry-sr registry-sr "
            }
        }
    }
}
