#!/bin/bash

source /usr/src/app/venv/bin/activate
python3 run.py

echo "head of the tsfeatures features"
ls -r TSForecasting/results/tsfeatures
head -5 TSForecasting/results/tsfeatures/bitcoin_without_missing_features.csv
echo "head of the catch22 features"
ls -r TSForecasting/results/catch22_features
head -5 TSForecasting/results/catch22_features/bitcoin_without_missing_features.csv
