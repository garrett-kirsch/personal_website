FROM ubuntu:22.04

WORKDIR /home/

# Install dependencies
RUN apt update && apt install -y \
	git \
	snapd

# Install hugo
RUN snap install hugo

# Make new website
RUN hugo new site personal_website --format="yaml" 


