pipeline{
    agent any
    tools {
        maven 'M2_HOME'
    }


    stages {


        stage('Getting project from Git') {
            steps{
      			checkout([$class: 'GitSCM', branches: [[name: '*/main']],
			extensions: [],
			userRemoteConfigs: [[url: 'https://github.com/ZrigHiba/hibaDevops.git']]])
            }
        }



        stage('Cleaning the project') {
            steps{
                	sh "mvn -B -DskipTests clean  "
            }
        }



        stage('Artifact Construction') {
            steps{
                	sh "mvn -B -DskipTests package "
            }
        }



         stage('Unit Tests') {
            steps{
               		 sh "mvn test "
            }
        }



        stage('Code Quality Check via SonarQube') {
            steps{

             		sh " mvn sonar:sonar -Dsonar.projectKey=devops -Dsonar.host.url=http://192.168.33.10:9000 -Dsonar.login=14ff9d41f05ffa8cabe2c7487513bbc606b1c70a"

            }
        }


        stage('Publish to Nexus') {
            steps {


  sh 'mvn clean package deploy:deploy-file -DgroupId=tn.esprit -DartifactId=ExamThourayaS2 -Dversion=1.0 -DgeneratePom=true -Dpackaging=jar -DrepositoryId=deploymentRepo -Durl=http://localhost:8081/repository/maven-releases/ -Dfile=target/ExamThourayaS2-1.0.jar'


            }
        }

stage('Build Docker Image') {
                      steps {
                          script {
                            sh 'docker build -t hibazrig/spring-app:latest .'
                          }
                      }
                  }

                  stage('login dockerhub') {
                                        steps {
                                      sh 'docker login -u hibazrig -p habhouba1234'
                                            }
		  }
	    
	                      stage('Push Docker Image') {
                                        steps {
                                   sh 'docker push hibazrig/spring-app:latest'
                                            }
		  }


		   stage('Run Spring && MySQL Containers') {
                                steps {
                                    script {
                                      sh 'docker-compose up -d'
                                    }
                                }
                            }

	    



     
}

	    
        post {

        always {
            cleanWs()
        }
    }

    
	
}
       
