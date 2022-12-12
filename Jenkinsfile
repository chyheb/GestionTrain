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
			userRemoteConfigs: [[url: 'https://github.com/chyheb/GestionTrain.git']]])
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

 stage("SonarQube") {
                       steps {
						echo 'SonarQube'
                         withSonarQubeEnv('sonar') {
                           sh 'mvn clean -DskipTests package sonar:sonar'
                         }
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
                            sh 'docker build -t chihebnj/spring-app:latest .'
                          }
                      }
                  }

                  stage('login dockerhub') {
                                        steps {
                                      sh 'docker login -u chihebnj -p @123aze45'
                                            }
		  }
	    
	                      stage('Push Docker Image') {
                                        steps {
                                   sh 'docker push chihebnj/spring-app:latest'
                                            }
		  }


		   stage('Run Spring & MySQL Containers') {
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
       
