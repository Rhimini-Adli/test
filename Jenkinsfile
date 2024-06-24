pipeline {
    agent any

    environment {
        imageName = 'docker-image-name:latest'
        containerName = 'container-name'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from SCM (e.g., Git)
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from Dockerfile
                    docker.build(imageName, '-f Dockerfile .')
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run Docker container based on the built image
                    docker.image(imageName).run('--name ${containerName} -d')
                }
            }
        }
    }

    // Optionally, you can add post actions for cleanup, notifications, etc.
    post {
        always {
            echo 'Cleaning up...'
            // Stop and remove Docker container (optional)
            // docker.container(containerName).stop()
            // docker.container(containerName).remove()
            // Remove Docker image (optional)
            // docker.image(imageName).remove()
        }
    }
}
