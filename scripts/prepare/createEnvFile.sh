#!/bin/bash

path_cef=$(realpath $(dirname "${BASH_SOURCE[0]}"))

if [ -e ${path_cef}/../../.env ]; then
    echo "Environment file already exists: ${path_cef}/../../.env"
    exit 1
else
    cp ${path_cef}/../../config/templates/env.template ${path_cef}/../../.env

    echo "Created Environment file: ${path_cef}/../../.env"
fi
