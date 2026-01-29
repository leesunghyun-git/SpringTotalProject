pipeline {
	agent any
	
	environment {
			SERVER_IP = "43.200.172.84"
			SERVER_USER = "ubuntu"
			APP_DIR = "~/app"
			JAR_NAME = "SpringTotalProject-0.0.01-SNAPSHOT.war"
	}
	
	stages{
	
		/*
		stage('Check Git Info'){
			steps {
				sh '''
				echo "===Git Info==="
				git branch 
				git log -1 
			   '''
			}
		}*/
		
		stage('Check Out'){
			steps {
				/*git branch: '/main'
				url 'https://github.com/leesunghyun-git/SpringFinalProject.git'*/
				checkout scm
			}
		}
		
		stage('Gradle Permission'){
			steps{
				
				sh '''
					chmod +x gradlew
				   '''
			}
		}
		
		// build 시작
		stage('Gradle Build'){
			steps {
				sh '''
				    ./gradlew clean build
				   '''
			}
		}
		stage('Deploy = rsync') {
			steps{
				sshagent(credentials:['SERVER_SSH_KEY']){
					sh """
						rsync -avz -e 'ssh -o StrictHostKeyChecking=no' build/libs/*.war ${SERVER_USER}@${SERVER_IP}:${APP_DIR}
					   """
				}
				
			}
			
		}
		stage('Run Application') {
			steps{
				sshagent(credentials:['SERVER_SSH_KEY']){
					sh """
ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} << EOF
pkill -f 'java -jar' || true
nohup java -jar ${APP_DIR}/${JAR_NAME} > log.txt 2>&1 & 
EOF
					   """
				}
				
			}
			
		}
	}
}