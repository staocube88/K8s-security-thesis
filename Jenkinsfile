pipeline {

    agent any

    stages {

        stage('Checkout Project') {
            steps {
                git 'https://github.com/staocube88/K8s-security-thesis.git'
            }
        }

        stage('Verify Kubernetes Access') {
            steps {
                sh 'kubectl get nodes'
            }
        }

        stage('Run Security Evaluation') {
            steps {
                sh 'chmod +x *.sh'
                sh './run-k8s-security-evaluation.sh'
            }
        }

        stage('Archive Results') {
            steps {
                archiveArtifacts artifacts: 'results/*'
            }
        }

    }
}
