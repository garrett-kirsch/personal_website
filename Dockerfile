# BUILD STAGE
FROM ubuntu:22.04 AS builder

WORKDIR /home/

# Install dependencies
RUN apt update && apt install -y \
    git \
    hugo \
	vim

# Create new Hugo site
RUN hugo new site personal_website --format="yaml"

# Move into Hugo site directory
WORKDIR /home/personal_website

# Add configuration and theme
COPY ./config.yaml .

RUN mkdir -p themes && \
    cd themes && \
    git clone https://github.com/gurusabarish/hugo-profile.git

# Add static content
WORKDIR /home/personal_website/static

COPY ./fav.svg .
RUN mkdir -p images

# Copy images directory from repo to hugo
COPY ./images/* ./images/

# Final build
WORKDIR /home/personal_website
RUN hugo

# SERVE STAGE
FROM nginx:alpine AS server

# Copy generated site from builder
COPY --from=builder /home/personal_website/public /usr/share/nginx/html

# Expose the default HTTP port
EXPOSE 80
