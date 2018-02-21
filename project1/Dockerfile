# version 0.1
FROM ubuntu:14.04
MAINTAINER Jonas KS "jonas-ks at hot mail dåt com"
RUN apt-get update
RUN apt-get -y install apache2 && apt-get install -y git
RUN mkdir /root/.ssh/
ADD id_rsa /root/.ssh/id_rsa
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan git.cs.hioa.no >> /root/.ssh/known_hosts
RUN rm /var/www/html/index.html
RUN git clone privategit@url.com /var/www/html/
