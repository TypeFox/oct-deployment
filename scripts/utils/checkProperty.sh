#!/bin/bash

key=${1}
value=${2}

if [[ -n "${value// /}" ]]; then  
    echo "${key} is set to: ${value}"    
    exit 0
else
    echo "Error: ${key} is not set."
    exit 1
fi
