# Jenkins CI/CD with Terraform

This project demonstrates a CI/CD pipeline using Jenkins, Docker, Maven, and Terraform.

## Technologies

- Jenkins
- Terraform
- Docker
- Docker Compose
- Maven
- Java

## Project Structure

- `Jenkinsfile` - Jenkins CI/CD pipeline
- `terraform/` - Terraform infrastructure configuration
- `Dockerfile` - Application container image
- `docker-compose.yaml` - Docker Compose configuration
- `server-cmds.sh` - Server setup commands
- `src/` - Java application source code
- `pom.xml` - Maven project configuration

## Terraform

The Terraform configuration is located in the `terraform/` directory and is used to provision the infrastructure required for the application deployment.

## CI/CD

The Jenkins pipeline builds the Maven application, creates the Docker image, and uses the Terraform configuration as part of the deployment workflow.

## Project Purpose

This project demonstrates infrastructure as code and CI/CD automation by combining Jenkins, Terraform, Docker, and Maven.
