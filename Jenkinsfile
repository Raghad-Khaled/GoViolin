pipeline {
    // Lets Jenkins use Docker for us later.
    agent any    
    environment{
        //Ensure the desired Go version is installed
        root = tool type: 'go', name: 'Go-18' //Use GO-18 as it is the same used in building docker image and the name for the blugine
    }

    // If anything fails, the whole Pipeline stops.
    stages {
        

        // stage('Test') {
        //     // Use golang.

        //     steps {     
        //         withEnv(["GOROOT=${root}", "PATH+GO=${root}/bin"]) {            
        //         // Create our project directory.
        //         // sh 'cd ${GOPATH}/src'
        //         // sh 'mkdir -p ${GOPATH}/src/MY_PROJECT_DIRECTORY'

        //         // // Copy all files in our Jenkins workspace to our project directory.                
        //         // sh "cp -r ${WORKSPACE}/* ${GOPATH}/src/MY_PROJECT_DIRECTORY"

        //         // // Copy all files in our "vendor" folder to our "src" folder.
        //         // sh "p -r ${WORKSPACE}/vendor/* ${GOPATH}/src"

        //         // Remove cached test results.
        //         sh "go clean -cache"

        //         sh "go mod vendor"

        //         sh "go mod download"
                
        //         sh "go mod verify"
        //         // Run Unit Tests.
        //         sh "go test ./..."  
        //         }          
        //     }
        //     post {
        //         success {
        //             echo "Test is Succeeded.."
                     
        //         }
        //         failure {
        //             echo "Test is Failed.." 
        //         }
        //     }
        // }
        stage('Docker Build') {
            steps {
                sh 'docker build -t raghad123/go-app:latest .'
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
                withCredentials([usernamePassword(credentialsId: 'dockerhub-id', passwordVariable: 'Password', usernameVariable: 'User')]) {
                sh "docker login -u ${User} -p ${Password}"
                sh 'docker push raghad123/go-app:latest'
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
        always {
            // Clean up our workspace.
            deleteDir()
        }
    }
} 