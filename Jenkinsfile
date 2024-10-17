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
        stage('Build') {
            steps {
                bat "mvn clean install -DskipTests"
            }
        }

        stage('Test') {
            steps {
                bat "mvn test"
            }
        }

        stage('Deploy') {
            steps {
                bat "docker build -t registry-sr ."
                bat "docker run -p 8761:8761 -d --name registry-sr registry-sr "
            }
        }
    }
}
