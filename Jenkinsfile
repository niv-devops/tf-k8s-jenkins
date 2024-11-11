pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "docker.io/devopsgoofy"
        DOCKER_IMAGE = "tf-k8s-jenkins"
        K8S_NAMESPACE = "tf-k8s-jenkins"
        K8S_DEPLOYMENT_NAME = "app-deployment"
        K8S_INGRESS_NAME = "app-ingress"
        dockerHubCredentials = 'dockerhub'
    }

    stages {
        stage('Build the Docker image from the GitLab repository') {
            steps {
                script {
                    sh "sudo docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${env.BUILD_ID} ."
                }
            }
        }

        stage("Pushing app to Docker Hub") {
            steps {
                script {
                    docker.withRegistry('', dockerHubCredentials) {
                        sh "sudo docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${env.BUILD_ID}"
                        sh "sudo docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest"
                    }
                }
            }
        }

        stage('Update Kubernetes Deployment') {
            steps {
                script {
                    def deploymentFile = readFile('deployment.yml')
                    def updatedDeployment = deploymentFile.replaceAll("image: .*", "image: ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${BUILD_NUMBER}")
                    writeFile file: 'deployment.yml', text: updatedDeployment
                }
            }
        }

        stage("Deploy using deployment.yaml") {
            steps {
                script {
                    sh 'sudo kubectl apply -f deployment.yml'
                }
            }
        }

        stage("Expose app using ingress") {
            steps {
                script {
                    // Replace with actual command to expose app, e.g., using kubectl to create an ingress resource
                    sh '''
                    kubectl expose deployment tf-k8s-jenkins --type=LoadBalancer --name=jenkins-ingress
                    '''
                }
            }
        }
    }
}
