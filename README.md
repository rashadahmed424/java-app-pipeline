# java maven app pipeline

this project is to build spring-pet-clinic app with jenkins pipeline and push final image to docker hub repo.
with increment version stage to edit pom.xml file with new version number and assign it to docker image tag.
setting up infrastructure with Terraform and Configuration with Ansible.


## docker compose file to specify services and its replicas and its configurations:

* pet-app service to run five replicas of the app.
* mysqldb service to run mysql database to store pet-app data. 
* balancer service to run nginx container with its default.conf file to work as a load balancer for the five replicas.


## requirements:
* git
* Docker
* Ansible
* Terraform
* Jenkins



## Tools
- git
- Docker & Docker compose 
- nginx as load Balancer  
- Jenkins CICD 
- Terraform
- Ansible
- Prometheus


## Jenkinsfile
* "increment version" stage to change old version in pom.xml file to the new version:
    ![image](https://github.com/user-attachments/assets/bdc51ca6-c149-44dd-a2a9-c48871425933)

* "build jar" stage to build jar file for the app with clean option to clean the target directory from old version of app:
    ![image](https://github.com/user-attachments/assets/151d3cdc-1ce9-4dc9-a53e-d5f4cf81db4e)

* "test" stage to test app using maven build tool with when condition to specify make the test or skip:
    ![image](https://github.com/user-attachments/assets/e6a6b1b7-a205-45aa-b8a6-d26a958dca9c)

* "build & push image" stage to build docker image, login dockerhub using and push the image with the new version:
    ![image](https://github.com/user-attachments/assets/12ff0a55-304e-4644-bdbe-b2660469897e)

* "deploy to web server" stage to dploy the new version of aap on the web server using ansible and dockercompose:
    ![image](https://github.com/user-attachments/assets/2fe96922-76c4-4ad8-b9d7-df28f6eabd94)

* "push pom.xml file" stage to push pom.xml file that contains the new version to github repo to make it valid for next build:
    ![image](https://github.com/user-attachments/assets/807e1e66-bf0f-41d6-b338-8cc92f3c16fc)

## dockerhub repo after successful builds
  ![image](https://github.com/user-attachments/assets/222d214f-2b1c-42b6-b1b9-60522e8905fd)


## nginx configuration to work as a load balancer and store logs for app:
 ![Screenshot 2024-08-20 061026](https://github.com/user-attachments/assets/bcaaaca4-882f-4ecc-a0f0-bec837b106c7)
 
  ### part of logs file that show IPs of app container that traffic is balanced with upstream method:  
 ![Screenshot 2024-08-20 071830](https://github.com/user-attachments/assets/b5884ab7-03c0-4561-8ff5-16261ab077d9)




## to clone this repo :
'''bash
git clone https://github.com/rashadahmed424/java-app-pipeline.git
'''



## Run Locally

Clone the project

```bash
  git clone https://github.com/rashadahmed424/java-app-pipeline.git
```

Go to the project directory

```bash
  cd java-app-pipeline
```


Start services 

```bash
   docker compose -f dockercompose.yaml  up --build -d 
```

## Prometheus dashboard
  ![image](https://github.com/user-attachments/assets/9e182199-0216-4f9e-b7d7-18167582bb35)


![Screenshot 2024-08-20 070847](https://github.com/user-attachments/assets/35f5d092-3da4-413a-8cff-20d6675a9232)


