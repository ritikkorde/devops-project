pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        EKS_CLUSTER = 'devops-cluster'
        DOCKER_IMAGE = 'dockerrk11/devops-project'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', credentialsId: 'github-access-token', url: 'https://github.com/ritikkorde/devops-project.git'
            }
        }

        stage('Verify Workspace') {
            steps {
                sh 'pwd'
                sh 'ls -lah'
                sh 'ls -lah src || echo "src directory not found!"'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh '''
                    aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER
                    kubectl apply -f deployment.yaml
                    '''
                }
            }
        }
    }  // ✅ Closing "stages"
}  // ✅ Closing "pipeline"
