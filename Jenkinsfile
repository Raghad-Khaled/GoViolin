pipeline {
    // Lets Jenkins use Docker for us later.
    agent any    

    // If anything fails, the whole Pipeline stops.
    stages {
        stage('Build') {   
            // Use golang.
            agent { docker { image 'golang' } }

            steps {                                           
                // Create our project directory.
                sh 'cd ${GOPATH}/src'
                sh 'mkdir -p ${GOPATH}/src/MY_PROJECT_DIRECTORY'

                // Copy all files in our Jenkins workspace to our project directory.                
                sh "cp -r ${WORKSPACE}/* ${GOPATH}/src/MY_PROJECT_DIRECTORY"

                // Copy all files in our "vendor" folder to our "src" folder.
                sh "cp -r ${WORKSPACE}/vendor/* ${GOPATH}/src"

                // Build the app.
                sh 'go build'               
            }
            post {
                success {
                    echo "Build is Succeeded.."
                     
                }
                failure {
                    echo "Build is Failed.." 
                }
            }            
        }

        stage('Test') {
            // Use golang.
            agent { docker { image 'golang' } }

            steps {                 
                // Create our project directory.
                sh 'cd ${GOPATH}/src'
                sh 'mkdir -p ${GOPATH}/src/MY_PROJECT_DIRECTORY'

                // Copy all files in our Jenkins workspace to our project directory.                
                sh "cp -r ${WORKSPACE}/* ${GOPATH}/src/MY_PROJECT_DIRECTORY"

                // Copy all files in our "vendor" folder to our "src" folder.
                sh "p -r ${WORKSPACE}/vendor/* ${GOPATH}/src"

                // Remove cached test results.
                sh "go clean -cache"

                // Run Unit Tests.
                sh "go test ./... -v -short"            
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

    }

    post {
        always {
            // Clean up our workspace.
            deleteDir()
        }
    }
} 