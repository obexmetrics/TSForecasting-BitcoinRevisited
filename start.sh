#!/bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

docker_result_dir=/usr/src/app/TSForecasting/results/

results_dir="${1:-${script_dir}/TSForecasting/results}"
image_name=${2:-ts-forecasting-rpy2}
docker_file=${3:-Dockerfile}

docker build -t ${image_name} -f ${docker_file} .
docker run -v ${results_dir}:${docker_result_dir} ${image_name}
