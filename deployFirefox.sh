#!/bin/sh
#Checking whether VNC password is passed to script
vncPassword=$2;
[ -z "$vncPassword" ] && echo "###Please pass VNC password...!!!">deployFirefox.log && exit 0 || echo "Successfully got VNC password...">deployFirefox.log;

#Checking & Removing existing container
echo "Checking if Firefox already deployed...">>deployFirefox.log;
container=$(docker ps -q --filter ancestor=firefoxkasm )>>deployFirefox.log;
[ -z "$container" ] && echo "No running container found">>deployFirefox.log || docker rm -f $container;

#Building image
echo "Building firefox image...">>deployFirefox.log;
docker build . --file Dockerfile --tag firefoxkasm;
echo "Image build successfully...">>deployFirefox.log;

#Deploying container
echo "Deploying Firefox...">>deployFirefox.log;
docker run -d -p 49151:6901 -e VNC_PW=$vncPassword --restart=always --name firefoxcontainer firefoxkasm;
echo "Firefox deployment successfull...">>deployFirefox.log;
exit 0
