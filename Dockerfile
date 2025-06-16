FROM ubuntu:22.04

WORKDIR /home/

# Install dependencies
RUN apt update && apt install -y \
	git \
	hugo\
	vim 

# Make new website
RUN hugo new site personal_website --format="yaml" 

WORKDIR /home/personal_website

# Insert config.yaml file
COPY ./config.yaml .

# Install theme
RUN cd themes ; git clone https://github.com/gurusabarish/hugo-profile.git

WORKDIR /home/personal_website/static

COPY ./fav.svg .

RUN mkdir images

COPY "Profile_Picture.jpg" ./images/.

WORKDIR /home/personal_website
