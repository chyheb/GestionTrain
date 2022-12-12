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



     
        stage('Publish to Nexus') {
            steps {


  sh 'mvn clean package deploy:deploy-file -DgroupId=tn.esprit -DartifactId=ExamThourayaS2 -Dversion=1.0 -DgeneratePom=true -Dpackaging=jar -DrepositoryId=deploymentRepo -Durl=http://192.168.33.10:8081/repository/maven-releases/ -Dfile=target/ExamThourayaS2-1.0.jar'


            }
        }




		  
	    

     
}

	    
        post {

        always {
            cleanWs()
        }
    }

    
	
}
       
