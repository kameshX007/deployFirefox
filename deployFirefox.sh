#!/bin/sh
#Checking whether VNC password is passed to script
vncPassword=$2;
[ -z "$vncPassword" ] && echo "###Please pass VNC password...!!!" && exit 0 || echo "Successfully got VNC password...";

#Checking & Removing existing container
echo "Checking if Firefox already deployed...";
container=$(docker ps -q --filter ancestor=kasmweb/firefox:1.11.0 );
[ -z "$container" ] && echo "No running container found" || docker rm -f $container;

#Deploying container
echo "Deploying Firefox...";
docker run -d -p 6901:6901 -e VNC_PW=$vncPassword --network tunnel --restart=always -v /home/$dockerUser/docker/CoadingWS/kasm-user:/home/kasm-user --name firefoxcontainer kasmweb/firefox:1.11.0;
echo "Firefox deployment successfull...";
exit 0