#!/bin/bash

docker compose up -d --build

docker exec -it personal_website bash
