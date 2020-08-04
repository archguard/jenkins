pipeline {
    environment {
        registry = 'archguard/jenkins'
        registryCredential = 'DockerHubCredentials'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Build Image') {
            steps{
                script {
                    dockerImage = docker.build(registry)
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential ) {
                        dockerImage.push()
                    }
               }
            }
        }
    }
}
