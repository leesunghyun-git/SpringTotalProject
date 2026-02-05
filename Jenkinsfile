pipeline {
	agent any
	
	environment {
		APP = "spring-app"
		IMAGE = "spring-app"
		PORT = "9090"
	}
	
	stages {
		stage('Git Checkout') {
	            steps {
	                echo "=== Git Checkout ==="
	                checkout scm
	            }
	    }
	
	    stage('Gradle Permission') {
	            steps {
	                sh 'chmod +x gradlew'
	            }
	    }
	
	    stage('Gradle Build') {
	            steps {
	                sh './gradlew build -x test --build-cache'
	            }
	    }
	    
	
	    stage('Docker Build') {
	            steps {
	                sh "docker build -t ${IMAGE}:latest ."
	            }
	    }
	    stage('Deploy') {
		    steps {
		        script {
		            // 1. 현재 실행 중인 색상 확인
		            def isBlue = sh(script: "docker ps --format '{{.Names}}' | grep spring-app-blue", returnStatus: true) == 0
		            def targetColor = isBlue ? "green" : "blue"
		            def targetPort = isBlue ? "9092" : "9091"
		            def oldColor = isBlue ? "blue" : "green"
		
		            echo "▶ ${targetColor} 배포 시작 (Port: ${targetPort})"
		
		            // 2. 새 컨테이너 실행
		            sh """
		            IMAGE_NAME=${IMAGE}:latest \
		            CONTAINER_NAME=spring-app-${targetColor} \
		            HOST_PORT=${targetPort} \
		            docker-compose up -d
		            """
		
		            // 3. Health Check (새 컨테이너가 뜰 때까지 대기)
		            echo "▶ Health Check 중..."
		            timeout(time: 5, unit: 'MINUTES') {
		                waitUntil {
		                    def r = sh script: "curl -s http://localhost:${targetPort}/actuator/health | grep UP", returnStatus: true
		                    return (r == 0)
		                }
		            }
		
		            // 4. Nginx 설정 변경 (이 부분이 핵심!)
		            // 로컬의 nginx.conf를 수정하거나 docker exec로 nginx 설정을 교체합니다.
		            sh "sed -i 's/localhost:[0-9]*/localhost:${targetPort}/' /home/ubuntu/sist/conf.d/default.conf"
		            sh "docker exec nginx-proxy nginx -s reload"
		
		            // 5. 이전 컨테이너 종료
		            sh "docker rm -f spring-app-${oldColor} || true"
		        }
		    }
		}
	}
    post {
        failure {
            echo "♻️ 자동 롤백 시작"

            sh '''
            echo "▶ 실패 컨테이너 제거"
            docker rm -f spring-app || true

            if docker image inspect spring-app:previous > /dev/null 2>&1; then
              echo "▶ 이전 이미지로 롤백"
              docker run -d \
                --name spring-app \
                -p 9090:9090 \
                spring-app:previous
            else
              echo "❌ 롤백할 이미지 없음 (최초 배포)"
            fi
            '''
        }

        always {
            cleanWs()
        }
    }
	
}