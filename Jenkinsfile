pipeline{
    agent any
    tools {
	jdk 'JAVA_HOME'
        maven 'M2_HOME'
    }


    stages {


        stage('Getting project from Git') {
            steps {
                echo 'Pulling code from Git'
                git branch: 'main', 
                url: 'https://github.com/chyheb/GestionTrain.git'
				}
        }

stage('Building JAR') {
            steps {
                echo 'Building with Maven'
                sh 'mvn clean install -DskipTests'
				}
			}

        stage('Cleaning the project') {
            steps{
		    echo 'Cleaning . . .'
                	sh "mvn -B -DskipTests clean  "
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

      stage('JUnit/Mockito') {
            steps{
		    echo 'Testing Facture Services'
               		 sh "mvn test "
            }
        }
	    
	    
        stage('Publish to Nexus') {
            steps {
 echo 'Nexus ...'

  sh 'mvn clean package deploy:deploy-file -DgroupId=tn.esprit -DartifactId=ExamThourayaS2 -Dversion=1.0 -DgeneratePom=true -Dpackaging=jar -DrepositoryId=deploymentRepo -Durl=http://localhost:8081/repository/devops/ -Dfile=target/ExamThourayaS2-1.0.jar'


            }
        }



stage('Build Docker Image') {
                      steps {
			      echo 'Building Docker Image'
                          script {
                            sh 'docker build -t chihebnj/examthourayas2 .'
                          }
                      }
                  }

                  stage('login dockerhub') {
                                        steps {
					echo 'Login toDocker '
						script{
							withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
								sh 'docker login -u chihebnj -p ${dockerhubpwd}'
							}
                                    
						} }
		  }
	    
	                      stage('Push Docker Image') {
                                        steps {
					echo 'Pushing Docker Image'
                                   sh 'docker push chihebnj/examthourayas2'
                                            }
		  }


		   stage('Run Spring & MySQL Containers') {
                                steps {
					echo 'Docker compose'
                                    script {
                                      sh 'docker-compose up -d'
                                    }
                                }
                            }
		  
	    
    }
     
}

	    
      
       
