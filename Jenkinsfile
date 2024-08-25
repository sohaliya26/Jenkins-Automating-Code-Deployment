pipeline {
    agent any
    tools {
        maven 'Maven3' // Ensure this is configured in Jenkins
    }
    environment {
        AWS_CREDENTIALS = credentials('aws-creds')
        TOMCAT_URL = 'http://18.188.4.77:8080/manager/text/'
        SNS_TOPIC_ARN = 'arn:aws:sns:us-east-2:173646783052:Jenkins-CICD-SNS'
        AWS_REGION = 'us-east-2'
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

        stage('Run Test Case') {
            steps {
                script {
                    try {
                        sh 'mvn test'
                    } catch (Exception e) {
                        // Notify failure
                        def buildNumber = env.BUILD_NUMBER
                        def jobName = env.JOB_NAME
                        def message = "Build #${buildNumber} for ${jobName} failed: Test cases failed."
                        sh "aws sns publish --topic-arn ${env.SNS_TOPIC_ARN} --message '${message}' --region ${env.AWS_REGION}"
                        throw e
                    }
                }
            }
        }

        stage('Deploy to Tomcat') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                deploy adapters: [tomcat8(
                    credentialsId: 'tomcatCred',
                    url: "${TOMCAT_URL}"
                )], war: '**/*.war'
            }
        }
    }

    post {
        success {
            script {
                def buildNumber = env.BUILD_NUMBER
                def jobName = env.JOB_NAME
                def message = "Build #${buildNumber} for ${jobName} succeeded."
                sh "aws sns publish --topic-arn ${env.SNS_TOPIC_ARN} --message '${message}' --region ${env.AWS_REGION}"
            }
        }
        failure {
            script {
                def buildNumber = env.BUILD_NUMBER
                def jobName = env.JOB_NAME
                def message = "Build #${buildNumber} for ${jobName} failed. Please check the logs for details."
                sh "aws sns publish --topic-arn ${env.SNS_TOPIC_ARN} --message '${message}' --region ${env.AWS_REGION}"
            }
        }
    }
}
