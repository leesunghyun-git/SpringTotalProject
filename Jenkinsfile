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
					export IMAGE_NAME=${IMAGE}:latest
					export CONTAINER_NAME=spring-app-${targetColor}
					export HOST_PORT=${targetPort}
					
					docker-compose -p spring-app-${targetColor} down || true
					# -p 옵션으로 프로젝트 이름을 다르게 주어 별개로 관리합니다.
					docker-compose -p spring-app-${targetColor} up -d --force-recreate
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
		            sh "sed -i 's/localhost:[0-9]*/localhost:${targetPort}/' /home/sist/nginx/conf.d/default.conf"
		            sh "docker exec nginx-proxy nginx -s reload"
		
		            echo "▶ 이전 컨테이너(${oldColor}) 제거"
					sh "docker-compose -p spring-app-${oldColor} down || true"
		        }
		    }
		}
	}
	post {
	        failure {
	            echo "♻️ 배포 실패 - 현재 상태 유지 (이전 컨테이너가 살아있으므로 자동 롤백 효과)"
	            // 새로 띄우려다 실패한 컨테이너만 제거
	            script {
	                // targetColor 변수를 위 stage에서 정의했으므로 
	                // 실패한 색상의 컨테이너만 정리해주는 것이 좋습니다.
	                sh "docker-compose -p spring-app-blue down || true"
	                sh "docker-compose -p spring-app-green down || true"
	            }
	        }
	        always {
	            // 용량 관리를 위해 사용하지 않는 이미지 정리 (가상머신 용량 문제 해결)
	            sh 'docker image prune -f'
	            cleanWs()
	        }
	    }
	
}