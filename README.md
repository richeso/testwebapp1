# Testwebapp1

This project is an example Java J2EE web application deployable to Jboss Community Edition (Wildfly) and using Postgres database as the back end. It is a Single Page App (index.jsp) using Jquery's JqGrid with a REST web services api to invoke back end CRUD functions. Database Persistence uses Hibernate and JPA. The Web Services framework uses Jboss Rest Easy. Build Tooling uses Gradle to build the war file for the application.

## Features

1. JBoss Wildfly App Server, PostGres Database 
2. Jboss Rest Easy Web Services
3. Hibernate, JPA, connection to Postgres using JNDI defined in Jboss standalone.xml configuration file. WEB-INF/classes/META-INF/persistence.xml connects to the JNDI database conneciton
4. Jquery, JQGrid

*Note: This is a self contained application which also includes the required runtimes to launch and run the web application using two docker containers - a jboss/wildfly application server container and a postgres database container.

## Prerequisites
1. Download and install a Docker Engine for your brand of O/S: [https://docs.docker.com/engine/getstarted/step_one/#step-1-get-docker](https://docs.docker.com/engine/getstarted/step_one/#step-1-get-docker "Docker Getting Started")
2. Install Docker Compose Tool: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/ "Docker Compose")
3. Download and install a Git Version Control System if you don't already have one - For windows this can be found here: [https://git-scm.com/download/win](https://git-scm.com/download/win "Git For Windows")
4. Download and install JDK 1.7 [http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html#jdk-7u80-oth-JPR](http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html#jdk-7u80-oth-JPR "JDK1.7")
5. Download and install Gradle build tool. Instructions can be found here: [https://gradle.org/install](https://gradle.org/install "Gradle Install")


## Running the application  (steps 1-2-3-4-5)

After installing the above prerequisite software, do the following: 

1. Clone this repository into a directory on your local pc using: git clone  git@github.com:richeso/testwebapp1.git. **Note:** ***For VirtualBox/Windows 7 *** Users, the repository may have to be under your **C:\Users directory** otherwise docker host mapping to container may not work. For windows 7/virtualbox host sharing sets up directories under C:\Users.
2. Customize any ports and or directories and files in docker-compose.yml for your OS. The current implementation uses windows style naming conventions under Git Bash.
3. Start your docker engine. If you are using Virtual Box as a provider for docker, remember to port forward whatever ports are defined in docker-compose.yml to your localhost machine.
4. Change the location of the Java JDK specified in startup.sh and then execute startup.sh  (use the git bash shell if you're on windows). This will do a gradle build, configure and startup the two containers (web, db) and then initialize the application database as well as deploy the war file.
5. Wait a few seconds and then launch your browser and point it to the url: [http://localhost:8080/testwebapp](http://localhost:8080/testwebapp "testwebapp")

## What the above steps 1-2-3-4-5 do


1. Runs a Gradle Build of the application to generate testwebapp.war file and copies the generated file to the ./wildfly/webapps directory
2. Runs docker-compose up -d which uses the docker-compose.yml for the following tasks:
	- Creates mywildfly container using a customized Dockerfile in wildfly/Dockerfile running wildfly 10 from the official docker image
		- maps container port 8080 to 8082 on the host so the web app can be accessed via localhost:8080
		- maps host directories wildfly/scripts to a container directory
		- maps the newly built war file to be deployed: widfly/webapps/testwebapp.war into the widfly container deployment directory .
	- Creates mypostgres container running latest postgres. (This also uses a custom docker build file under /postgres/Dockerfile)
		- creates and initializes the persondb using the postgres/scripts/createperson.sql file by adding to the postgres container initialization directory. 
	- Links the mywildfly container network to the mypostgres container using links:db directive so that the wildfly container can connect to postgres
	- Runs both container services after creating the two docker containers.
