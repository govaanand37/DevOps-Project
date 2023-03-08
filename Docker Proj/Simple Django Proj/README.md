Hey all,

The purpose of this blog is to demonstrate how a Docker file can be used to containerize a Django application. By exposing the port, we can access the application in the network

![Screenshot 2023-03-07 211434](https://user-images.githubusercontent.com/86225331/223611249-77238372-a25e-4603-9c10-248835d67ccb.png)


## Pre-requisite

* Have the repo in your host machine

* Docker should be installed in your host machine

* Add inbound rule 8000 for exposing the application

## Steps to set up the Environment

* Firstly we should have an ec2 instance so, Create an ec2 instance\[Linux-AMI\] in your AWS account and add the inbound rule under security like below

![0a247e77-8e86-4835-8eaa-bfda813ccf76](https://user-images.githubusercontent.com/86225331/223611421-26dc172a-2b54-4c49-b6c3-af923ecbf54b.png)

* After creating the ec2 instance, log in to the ec2 instance and install the following dependencies

```bash
sudo apt update
sudo apt upgrade
sudo apt-get install git
sudo apt install docker.io
```

Once the above dependencies are installed then now we can clone the repo using the command below

```bash
git clone https://github.com/govaanand37/DevOps-Project.git
```

now move the directory pointer inside the application like below

```bash
ubuntu@ip-172-31-16-93:~$ ls
DevOps-Project
ubuntu@ip-172-31-16-93:~$ cd DevOps-Project/
ubuntu@ip-172-31-16-93:~/DevOps-Project$ cd Docker\ Proj/
ubuntu@ip-172-31-16-93:~/DevOps-Project/Docker Proj$ ls
'Simple Django Proj'
ubuntu@ip-172-31-16-93:~/DevOps-Project/Docker Proj$ cd Simple\ Django\ Proj/
ubuntu@ip-172-31-16-93:~/DevOps-Project/Docker Proj/Simple Django Proj$ ls
Dockerfile  README.md  devops  requirements.txt
ubuntu@ip-172-31-16-93:~/DevOps-Project/Docker Proj/Simple Django Proj$
```

If you could see the files we have under the Simple Django project

here we have 2 important files

* Docker File

* Requirement.txt

## Dockerfile Explanation

here is the docker file I used for this application to containerize

```apache
FROM ubuntu

WORKDIR /app

COPY requirements.txt /app
COPY devops /app

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip install -r requirements.txt && \
    cd devops

ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]
```

requirement.txt consists of dependencies to be installed while containerizing

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678195504197/e4f023ed-468f-4979-b78a-5d0edd75008f.png align="center")

Here is a step-by-step explanation of the Dockerfile:

* `FROM ubuntu`: specifies the base image to be used for this Docker image. In this case, it is Ubuntu.

* `WORKDIR /app`: sets the working directory inside the container to `/app`.

* `COPY requirements.txt /app`: copies the `requirements.txt` file from the local machine to the `/app` directory inside the container.

* `COPY DevOps/app`: copies the `devops` directory from the local machine to the `/app` directory inside the container.

* `RUN apt-get update && \`: update the package list inside the container and installs Python 3 and pip.

* `pip install -r requirements.txt && \`: install the Python packages specified in the `requirements.txt` file inside the container.

* `cd DevOps`: changes the working directory inside the container to the `DevOps` directory.

* `ENTRYPOINT ["python3"]`: sets the default command to run when the container starts as `python3`.

* `CMD ["`[`manage.py`](http://manage.py)`", "runserver", "0.0.0.0:8000"]`: sets the default arguments for the command. In this case, it runs the Django web server using the [`manage.py`](http://manage.py) file and listens on all available network interfaces (`0.0.0.0`) on port `8000`.

## Build and run docker container

we can build the container using the below command

```yaml
sudo docker build . -t django-app
```

This command builds a Docker image from the Dockerfile in the current directory, and tags it as `Django-app`, and stores it in the local Docker registry.

once this command started, it will take some time to create content because it will download Ubuntu and install all the mentioned dependencies

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678195886546/28fa136b-77ed-4d65-895d-b4a3fe7d749a.png align="center")

After creating the Image, we can see the created image with all dependencies by running the below command

```yaml
sudo docker images
```

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678196062237/0f842d99-e5ef-4666-9142-9a567a8f731b.png align="center")

here we can see the created image now let's run that in a container using the command below

```yaml
sudo docker run -p 8000:8000 -it django-app
```

This command runs a Docker container using the `Django-app` image that was previously built. The container will run a Django web application and map the container's port 8000 to the host machine's port 8000. The `-it` option attaches an interactive terminal to the container, allowing you to interact with it.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678196672106/a7520aeb-3c8b-4fa5-b059-53610b59ce69.png align="center")

After executing this command, Docker will start the container using the `Django-app` image and map its port 8000 to the host machine's port 8000. The container will run the Django web application with the specified settings, and the interactive terminal will be attached to it, allowing you to interact with the container's command line. You can use this container to host and test your Django application.

Now we can hit the public IP of our ec2 instance to see the app interface as below.

```
<publicipofec2>:8000/demo
```

This is the output of the Django app that runs in our container.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1678196336826/deb63d89-ac25-45e8-8ba6-638132b2b4d9.png align="center")
