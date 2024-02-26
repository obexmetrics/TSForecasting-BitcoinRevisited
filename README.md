# TSForecasting-obexmetrics

Extraction of [TSForecasting](https://github.com/rakshitha123/TSForecasting) for reproducing results for bitcoin predictions.

## Getting Started

Run `start.sh` to build and run our Docker container that executes the analysis.  

Output defaults to our local `TSForecasting/results` directories.

## NOTES

- The top-level files in this project are ports of [forecastingdata_bitcoin.ipynb](forecastingdata_bitcoin.ipynb). It needs minor tweaks to make it compatible with this project layout (remove git clone, etc...)

## TODO

- update [forecastingdata_bitcoin.ipynb](forecastingdata_bitcoin.ipynb) to be compatible with this project layout (remove git clone, etc...)
- Use local volume mount for input data files hardcoded at `TSForecasting/tsf_data`

## Source Citation

- `godahewa2021monash`
```bibtex
@InProceedings{godahewa2021monash,
    author = "Godahewa, Rakshitha and Bergmeir, Christoph and Webb, Geoffrey I. and Hyndman, Rob J. and Montero-Manso, Pablo",
    title = "Monash Time Series Forecasting Archive",
    booktitle = "Neural Information Processing Systems Track on Datasets and Benchmarks",
    year = "2021"
}
```
