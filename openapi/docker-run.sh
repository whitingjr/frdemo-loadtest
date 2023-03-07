#!/bin/bash
docker run -p 80:8080 \
        -e BASE_URL=/swagger \
        -e SWAGGER_JSON=/mnt/frdemo-api.json \
        -v $(pwd)/apidoc:/mnt \
        swaggerapi/swagger-ui