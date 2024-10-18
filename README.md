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


## Jenkinsfile
* "increment version" stage to change old version in pom.xml file to the new version:
  ![Screenshot 2024-08-20 051540](https://github.com/user-attachments/assets/2250ffb5-d73c-48a6-ac44-def6d5a9e123)

* "build jar" stage to build jar file for the app with clean option to clean the target directory from old version of app:
  ![Screenshot 2024-08-20 051847](https://github.com/user-attachments/assets/20b2f2e1-3942-4003-ac54-fb4d44bf8f22)

* "test" stage to test app using maven build tool with when condition to specify make the test or skip:
  ![Screenshot 2024-08-20 070502](https://github.com/user-attachments/assets/72bd197a-cc7d-436b-a274-5cd91bc5c134)

* "build&push image" stage to build docker image, login dockerhub using and push the image with the new version:
  ![Screenshot 2024-08-20 052555](https://github.com/user-attachments/assets/612f9650-c8fb-4b19-aa81-63ff188a4285)

* "push pom.xml file" stage to push pom.xml file that contains the new version to github repo to make it valid for next build:
  ![Screenshot 2024-08-20 052753](https://github.com/user-attachments/assets/36f6d952-cc46-4d1a-bda0-db39a3faa035)

## dockerhub repo after successful builds
![Screenshot 2024-08-20 185425](https://github.com/user-attachments/assets/fb95d087-4dc9-4992-979d-fc1dbc6f0a46)


## nginx configuration to work as a load balancer and store logs for app:
 ![Screenshot 2024-08-20 061026](https://github.com/user-attachments/assets/bcaaaca4-882f-4ecc-a0f0-bec837b106c7)
 
  ### part of logs file that show IPs of app container that traffic is balanced with upstream method:  
 ![Screenshot 2024-08-20 071830](https://github.com/user-attachments/assets/b5884ab7-03c0-4561-8ff5-16261ab077d9)

deployscript.sh file :
it is bash script to install docker and git then run docker compose file to deploy services.




## to clone this repo :
'''bash
git clone https://github.com/rashadahmed424/java-pet-clinic-app-pipeline.git
'''



## Run Locally

Clone the project

```bash
  git clone https://github.com/rashadahmed424/java-pet-clinic-app-pipeline.git
```

Go to the project directory

```bash
  cd java-pet-clinic-app-pipeline
```


Start services 

```bash
   docker compose -f dockercompose.yaml  up --build -d 
```

![Screenshot 2024-08-20 070847](https://github.com/user-attachments/assets/35f5d092-3da4-413a-8cff-20d6675a9232)


