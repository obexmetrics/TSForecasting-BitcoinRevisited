FROM r-base:latest as builder

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential automake libtool \
    libcurl4-gnutls-dev libssl-dev libxml2-dev libfontconfig1-dev libfreetype6-dev libpng-dev \
    libtiff5-dev libjpeg-dev libgit2-dev libharfbuzz-dev libfribidi-dev libnlopt-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV CPPFLAGS="-I/usr/local/include" LDFLAGS="-L/usr/local/lib" \
    R_LIBS_USER=/usr/local/lib/R/site-library \
    DEBIAN_FRONTEND=noninteractive \
    ENVIRONMENT=development LOG_LEVEL=debug

# this returns non-zero exit code if any package fails to load
RUN R --save -e "\
packages <- c('devtools', 'tidyverse', 'tsibble', 'forecast', 'tsfeatures', 'smooth', 'Rcatch22', 'glmnet'); \
for (pkg in packages) { \
  install.packages(pkg, dependencies=TRUE, repos='http://cran.rstudio.com/'); \
  if (!require(pkg, character.only = TRUE)) { \
    stop(sprintf('Failed to install %s', pkg), call. = FALSE) \
  } \
}"

# Python environment, incl rpy2
RUN apt-get update && apt-get install -y python3-pip python3-venv python3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
RUN python3 -m venv venv && venv/bin/pip install --upgrade pip
COPY requirements.txt .
RUN venv/bin/pip install --no-cache-dir -r requirements.txt

# our code
COPY TSForecasting/experiments/ TSForecasting/experiments/ 
COPY TSForecasting/models/ TSForecasting/models/
COPY TSForecasting/tsf_data/ TSForecasting/tsf_data/
COPY TSForecasting/utils/ TSForecasting/utils/
COPY *.py ./
COPY *.R ./
COPY *.sh ./

CMD ["bash", "run.sh"]
