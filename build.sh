#!/bin/bash

JMETER_VERSION="5.3"

# Example build line
# --build-arg IMAGE_TIMEZONE="Europe/Amsterdam"
docker build  --build-arg IMAGE_TIMEZONE="Europe/Istanbul" JMETER_VERSION=${JMETER_VERSION} -t "netas/jmeter:${JMETER_VERSION}" .
