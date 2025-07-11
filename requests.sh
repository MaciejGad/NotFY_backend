#!/bin/bash

DEVICE_TOKEN=152658de3b5b116b8111957fc9ea5d8b32adc5ffff1c1522a44bf4e133e11423

DEVICE_ID=`curl -X POST http://127.0.0.1:8080/device/register -H "Content-Type: application/json" -d "{\"token\":\"${DEVICE_TOKEN}\"}" | jq -r '.id' | tr -d '"'`

if [ $? -ne 0 ]; then
    echo "Failed to register device with token ${DEVICE_TOKEN}"
    exit 1
fi
echo "Device ${DEVICE_ID} registered successfully with token ${DEVICE_TOKEN}"

curl http://127.0.0.1:8080/channels/94D55A51-6FE3-4965-977C-07EE33F12F64/add/${DEVICE_ID}

curl -X POST http://127.0.0.1:8080/send/94D55A51-6FE3-4965-977C-07EE33F12F64 -d '{"title": "Custom title", "body": "And body"}' -H "Content-Type: application/json"