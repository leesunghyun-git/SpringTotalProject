pipeline {
	agent any
	
	stages{
		stage('Git Check Test'){
			steps{
				git branch: 'main'
				url: https://github.com/leesunghyun-git/SpringTotalProject.git
			}
		}
		
		stage('Check Git Info'){
			sh '''
				echo "===Git Info==="
				git branch
				git log -1
			   '''
		}
	}
}