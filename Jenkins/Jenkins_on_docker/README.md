
![jenkins-docker](https://user-images.githubusercontent.com/86225331/224634859-55fa3f16-aa7b-45fb-a301-7d550ad17122.png)

# Jenkins on docker

This docker compose file has all the required services to create a new Jenkins [kinda sandbox] using docker in our local machine. 
we can use this Jenkins for practice purpose

## Pre-requisite
- Docker should be installed in local machine

## Explanation of docker compose file

`version: '3.7'`: This specifies the version of the Docker Compose file format being used.

`services`: This section defines the services to be created.

`jenkins`: This is the name of the service being defined.

`image`: jenkins/jenkins:lts: This specifies the Docker image to be used for this service. The jenkins/jenkins:lts image is the Long-Term Support (LTS) release of Jenkins.

`privileged: true`: This flag gives the container full access to the host system.

`user`: root: This sets the user of the container to root.

`ports`: This section maps the ports of the container to the ports of the host machine.

`8083:8080`: Maps the Jenkins web interface to port 8083 on the host machine.

`50003:50000`: Maps the Jenkins agent communication port to port 50003 on the host machine.

`container_name`: my-jenkins-3: This specifies the name of the container.

`volumes`: This section defines the volumes to be mounted in the container.

- `D:\jenkins\gova\Session\jenkins_data:/var/jenkins_home`: Maps the jenkins_data directory on the host machine to the /var/jenkins_home directory in the container. This directory will store the Jenkins configuration and data.

- `/var/run/docker.sock:/var/run/docker.sock`: Mounts the Docker socket on the host machine to the Docker socket in the container. This allows Jenkins to interact with the Docker daemon running on the host machine.

` When you run docker-compose up with the above Docker Compose file, it will create a Docker container based on the jenkins/jenkins:lts image`

`The container will run in the foreground and display Jenkins logs in the console. Once the container is up and running, you can access the Jenkins web interface at http://localhost:8083 to start configuring your Jenkins instance. `

## Steps to use this docker file:

- clone this repository
- then open the repository in your local machine inside that repository open terminal or command prompt then
- run the below command to start
``` 
docker-compose up
 ```
 - it will pull the image from public registry and create a container in our local machine in the name of `my-jenkins-3` at the end of the process we will get the initial admin password

 once you received the password in terminal/cmd then hit `localhost8083` in your browser to access this jenkins 

 after restarting your machine sometimes container will be stopped so run the below command to start the container 
 whenever you are going to work on jenkins its a good practice to cross-check whether container running in background or not 

 to start the container use the below command

 ```
 docker start my-jenkins-3
 ```

to stop the container use the below command
```
docker stop my-jenkins-3
```