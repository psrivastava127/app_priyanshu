pipeline {
    agent any
    environment {
        git = 'Default'
		maven = 'Maven3'
    }
    options {
        timeout(time: 1, unit: 'HOURS') 
    }
    stages {
        stage("Build") {
            steps {
				git url: 'https://github.com/psrivastava127/app_priyanshu.git'
                sh 'mvn clean install'
				echo 'In build step'
            }
        }
        stage("Test case execution") {
			when {
                branch 'master'
            }
            steps {
                sh 'mvn test'
				echo 'In test case execute'
            }
        }
		stage("Sonar Qube Analysis") {
			when {
                branch 'develop'
            }
            steps {
                script {
					def scannerHome = tool 'SonarQubeScanner';
					withSonarQubeEnv('Test_Sonar') {
						sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=sonar-priyanshu'
					}
				}
			}
        }
        stage("Kubernetes Deployment") {
            steps {
				script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub2') {
                        def dockerImage = docker.build("ps127/nagp-k8s-app:latest")
                        dockerImage.push("latest")
                    }
					withCredentials([file(credentialsId: 'GCP_CRED', variable: 'FILE')]) {
                        bat returnStdout: true, script: "gcloud auth activate-service-account --key-file ${FILE}"
                        bat returnStdout: true, script: "kubectl apply -f nagp-k8s-app.deployment.yaml"
                    }
                }
                
            }
        }
     }
 }