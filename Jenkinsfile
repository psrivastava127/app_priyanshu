pipeline {
    agent any
    environment {
        scannerHome = tool name: 'SonarQubeScanner'
        git = 'Default'
		maven = 'Maven3'
		docker = tool name: 'Test_Docker'
		dockerHubId="ps127"
		username="priyanshusrivastava01"
		sourcePort="${env.BRANCH_NAME == "master" ? 8081 : 8082}"
    }
    options {
        timeout(time: 1, unit: 'HOURS') 
    }
    stages {
        stage("Build") {
            steps {
				git credentialsId: 'Github', url: 'https://github.com/psrivastava127/app_priyanshu.git'
                //bat 'mvn clean install'
				echo 'In build step'
            }
        }
        stage("Test case execution") {
 			when {
                 branch 'master'
            }
            steps {
                bat 'mvn test'
				echo 'In test case execute'
            }
        }
		stage("Sonar Qube Analysis") {
 			when {
                 branch 'develop'
            }
            steps {
                script {
					withSonarQubeEnv('Test_Sonar') {
						bat "mvn clean verify sonar:sonar -Dsonar.projectKey=sonar-${username}"
					}
				}
			}
        }
        stage("Kubernetes Deployment") {
            steps {
				//script {
				    //bat 'docker build -t ${dockerHubId}/i-${username}-${env.BRANCH_NAME}:latest --no-cache .'
				    //bat 'docker tag ${dockerHubId}/i-${username}-${env.BRANCH_NAME}:v1 ${dockerHubId}/i-${username}-${env.BRANCH_NAME}:latest'
                    //withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                        //bat "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                        //bat 'docker push ${dockerHubId}/i-${username}-${env.BRANCH_NAME}:latest'
                    //}
                    //bat 'docker run -d --name c-${username}-${env.BRANCH_NAME} -p ${sourcePort}:8080 ${dockerHubId}/i-${username}-${env.BRANCH_NAME}:latest'
					//bat 'gcloud auth login'
			        //bat 'gcloud container clusters get-credentials k8s-nagp-demo --zone us-central1-c --project kubernetes-cluster-priyanshu'
			        //bat 'kubectl apply -f KubernetesYaml/namespace.yaml'
					//bat 'kubectl apply -f KubernetesYaml/deployment.yaml'
                 //}
				echo 'kubernetes step end'
                
            }
        }
     }
 }