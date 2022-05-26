pipeline {
    // Lets Jenkins use Docker for us later.
    agent any    
    environment{
        //Ensure the desired Go version is installed
        root = tool type: 'go', name: 'Go-18' //Use GO-18 as it is the same used in building docker image and the name for the blugine
        registry = "raghad123/goviolin:latest"
        registryCredential = 'dockerhub-id'
        dockerImage = ''
    }

    // If anything fails, the whole Pipeline stops.
    stages {
        

        stage('Test') {
            // Use golang.

            steps {     
                withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {            
                
                // Remove cached test results.
                sh "go clean -cache"

                sh "go mod vendor"

                sh "go mod download"
                
                sh "go mod verify"  
                // Run Unit Tests.
                sh "go test ./..."  
                }          
            }
            post {
                success {
                    echo "Test is Succeeded.."
                     
                }
                failure {
                    echo "Test is Failed.." 
                }
            }
        }
        stage('Docker Build') {
            steps {
                script {
                dockerImage = docker.build registry
                }
            }
            post {
                success {
                    echo "Docker Build is Succeeded.."
                     
                }
                failure {
                    echo "Docker Build is Failed.." 
                }
            }
        }
        stage('Docker Push') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
            post {
                success {
                    echo "Docker Push is Succeeded.."
                     
                }
                failure {
                    echo "Docker Push is Failed.." 
                }
            }
      }      

    }
    post {
        success {
             //send mail
            mail to: "raghad200059@gmail.com",
            subject: "GoViolin Project",
            body: "goviolin:latest image pushed successfully to dockerhub"
        }
    }

} 