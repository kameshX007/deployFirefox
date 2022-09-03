#!/bin/sh
echo "Checking if Firefox already deployed...">deployFirefox.log;
container=$(docker ps -q --filter ancestor=firefoxkasm )>>deployFirefox.log;
[ -z "$container" ] && echo "No running container found">>deployFirefox.log || docker rm -f $container;

echo "Building firefox image...">>deployFirefox.log;
docker build . --file Dockerfile --tag firefoxkasm;
echo "Image build successfully...">>deployFirefox.log;

echo "Deploying Firefox...">>deployFirefox.log;
docker run -d -p 49154:6901 -e VNC_PW=2022 --restart=always --name firefoxcontainer firefoxkasm;
echo "Firefox deployment successfull...">>deployFirefox.log;
exit 0