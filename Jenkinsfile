#!/user/bin/env groovy
@Library('jenkins-shared-library@main') _

pipeline {   
  agent any
  tools {
    maven 'maven-3.9'
  }
  environment {
    IMAGE_NAME = 'alkerix/java-maven-app-2.0'
  }
  stages {
    stage("build app") {
      steps {
        script {
          echo 'building application jar...'
          buildJar()
        }
      }
    }
    stage("build image") {
      steps {
        script {
            buildImage(env.IMAGE_NAME)

            withCredentials([usernamePassword(
                credentialsId: 'dockerhub-credentials',
                usernameVariable: 'DOCKER_USERNAME',
                passwordVariable: 'DOCKER_PASSWORD'
            )]) {
                sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
            }

            sh 'docker push "$IMAGE_NAME"'
          }
        }
      }
    stage("provision server") {
      environment {
        TF_VAR_env_prefix = 'test'
      }

      steps {
        withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'aws-credentials'
        ]]) {
            dir('terraform') {
                sh "terraform init -input=false -migrate-state -force-copy"
                sh "terraform apply --auto-approve"

                script {
                    env.EC2_PUBLIC_IP = sh(
                        script: "terraform output -raw ec2_public_ip",
                        returnStdout: true
                    ).trim()
                }
            }
          }
        }
      }
    stage("deploy") {
      environment {
        DOCKER_CREDS = credentials('dockerhub-credentials')
      }
      steps {
        script {
          echo "waiting for EC2 server to initialize"
          sleep(time: 90, unit: "SECONDS")

          echo 'deploying docker image to EC2...'
          echo "${EC2_PUBLIC_IP}"
          
          def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME} ${DOCKER_CREDS_USR} ${DOCKER_CREDS_PSW}"
          def ec2Instance = "ec2-user@${EC2_PUBLIC_IP}"

          sshagent(['server-ssh-key']) {
            sh "scp -o StrictHostKeyChecking=no server-cmds.sh ${ec2Instance}:/home/ec2-user"
            sh "scp -o StrictHostKeyChecking=no docker-compose.yaml ${ec2Instance}:/home/ec2-user"
            sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
          }
        }
      }
    }               
  }
}
        
