pipeline {
    // run on jenkins nodes tha has java 8 label
    agent { label 'java8' }
    // global env variables
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerHub')
        TAG = sh(returnStdout: true, script: "git rev-parse --short=10 HEAD").trim()
        APP_NAME = "simple_db_app"

    }
    stages {

        stage('Compile') {
            steps {
                echo "-=- compiling and package project -=-"
                  sh "./mvnw clean package"
            }
        }

        stage("Create container"){
            steps {
                sh "docker build -t olbinski/${APP_NAME}:latest -t olbinski/${APP_NAME}:${TAG} ." 
            }
        }

        stage('Auth dockerHub') {
             when {
                branch "master"
            }
            
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push docker image') {
            when {
                branch "master"
            }

            steps {
                sh "docker push olbinski/${APP_NAME}:${TAG} --all-tags"
            }
        }
    }

    post {
        // Always runs. And it runs before any of the other post conditions.
        always {
            // Let's wipe out the workspace before we finish!
            deleteDir()
            sh 'docker logout'
        }
    }

// The options directive is for configuration that applies to the whole job.
    options {
        // And we'd really like to be sure that this build doesn't hang forever, so
        // let's time it out after an hour.
        timeout(time: 25, unit: 'MINUTES')
    }

}