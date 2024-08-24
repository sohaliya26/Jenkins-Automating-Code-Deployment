pipeline {
    agent any
    tools {
        maven 'Maven3' // Use the name you configured in Jenkins
    }
    environment {
        TOMCAT_URL = 'http://18.216.29.123:8080/manager/text/'
        TOMCAT_USER = 'tomcat'
        TOMCAT_PASSWORD = 'password'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/sohaliya26/Jenkins-Automating-Code-Deployment.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                deploy adapters: [tomcat8(
                credentialsId: 'tomcatCred',
                contextPath: 'myapp', // Context path for the application
                url: "${TOMCAT_URL}"
                )], war: '**/*.war'

            }
        }
    }
}
