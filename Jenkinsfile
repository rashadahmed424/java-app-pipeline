pipeline {

    parameters {
        booleanParam(name: 'test', defaultValue: false, description: '')
    }

    agent any

    stages {
        stage('increment version') {
            steps {
                script {
                    sh """
                    mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                    versions:commit 
                    """
                    def temp = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = temp[0][1]
                    env.new_image = "${version}-${BUILD_NUMBER}"
                }
            }
        }

        stage("build jar") {
            steps {
                script {
                    sh "mvn clean package"
                }
            }
        }

        stage('test') {
            when {
                expression {
                    params.test
                }
            }
            steps {
              
                script {
                    sh "mvn test"
                }
            }
        }

        stage('build & push image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-conn', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh "docker build -t rashadahmed424/spring-pet-app:${new_image} ."
                        sh "echo \$PASS | docker login -u \$USER --password-stdin"
                        sh "docker push rashadahmed424/spring-pet-app:${new_image}"
                    }
                }
            }
        }

        stage('deploy to web server'){
            steps{
                script{
                    sshagent(['webServer']){
                        sh '''
                        cd ansible
                        export ANSIBLE_HOST_KEY_CHECKING=False
                        ansible-playbook -i inventory deploy-playbook.yaml --extra-vars "image_name=rashadahmed424/spring-pet-app:${new_image}"
                        '''
                        }
                }
            }
        }

        stage('push pom.xml file') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'github-token', variable: 'GIT_PASSWORD')]) {
                        sh "git config --global user.name 'rashadahmed424'"
                        sh "git config --global user.email 'rashadahmed177@gmail.com'"
                        sh "git remote set-url origin https://${GIT_PASSWORD}@github.com/rashadahmed424/DEPI-DevOps-Grad-Project.git"
                        sh "git add pom.xml"
                        sh 'git commit -m "Added new version in pom.xml"'
                        sh "git push origin HEAD:main"
                        
                    }
                }
            }
        }

    
    }


    post {
        success {
            slackSend (
                channel: '#javaapppipeline', // Customize your Slack channel
                color: 'good', // Green for success
                message: "Build SUCCESSFUL! Job: ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}"
            )
        }
        failure {
            slackSend (
                channel: '#javaapppipeline',
                color: 'danger', // Red for failure
                message: "Build FAILED! Job: ${env.JOB_NAME}, Build Number: ${env.BUILD_NUMBER}"
            )
        }
    }
}
