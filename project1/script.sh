#!/bin/bash
echo "Jenkins received a PUSH. This script wil now execute."
echo "Checking if a previous non-production container is running.."
if docker ps | grep nonprod; then
    echo "Nonprod is running."
    docker kill nonprod
    docker rm nonprod -f
    echo "Nonprod killed and removed."
else
    echo "Nonprod is not running. Moving on."
fi

if docker images | grep ^"nonprod"; then
    echo "Docker nonprod image exists."
    docker rmi nonprod -f
    echo "Docker nonprod image removed."
else
    echo "Docker nonprod image does not exist. Moving on."
fi

echo "Building a new image with the new git files."
docker build --no-cache=true -t "nonprod" /var/lib/jenkins/docker
echo "Running new image as nonprod, port 9091."
docker run --name nonprod -P -p 9091:80 -d nonprod /usr/sbin/apache2ctl -D FOREGROUND
echo "Checking if content is correct."
sleep 3
if curl --silent http://128.39.121.129:9091/ | grep ^"Hello world"$; then
	echo "Everything ok. We will now push this to production."
    echo "Killing production container."
	docker kill production
    echo "Deleting production container."
	docker rm production -f
    echo "Deleting old production image."
	docker rmi production -f
    echo "Building new production image."
	docker build --no-cache=true -t "production" \
	/var/lib/jenkins/docker
    echo "Spawning new production on port 80."
	docker run --name production -P -p 80:80 -d production \
	/usr/sbin/apache2ctl -D FOREGROUND
    exit 0
else
	echo "Content check were not correct. We will " \
	"not put this container into production."
    exit 1
fi
