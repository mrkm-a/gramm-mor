FROM rocker/r-ver:4.0.2
LABEL "maintainer"="Akira Murakami (a.murakami@bham.ac.uk)"

# install other packages that are necessary to install tidyverse and other R packages.
# https://hub.docker.com/r/rocker/rstudio/dockerfile
# https://hub.docker.com/r/rocker/tidyverse/dockerfile
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  file \
  git \
  libapparmor1 \
  libclang-dev \
  libcurl4-openssl-dev \
  libedit2 \
  libssl-dev \
  lsb-release \
  multiarch-support \
  psmisc \
  procps \
  python-setuptools \
  sudo \
  wget \
  libxml2-dev \
  libcairo2-dev \
  libsqlite-dev \
  libmariadbd-dev \
  libmariadbclient-dev \
  libpq-dev \
  libssh2-1-dev \
  unixodbc-dev \
  libsasl2-dev \
  clang
  
# install clang that is used to compile rstan
# RUN apt-get update && apt-get install -y --no-install-recommends clang
  
# https://github.com/stan-dev/rstan/wiki/Installing-RStan-on-Linux
RUN Rscript -e 'dotR <- file.path(Sys.getenv("HOME"), ".R"); \
  if (!file.exists(dotR)) dir.create(dotR); \
  M <- file.path(dotR, "Makevars"); \
  if (!file.exists(M)) file.create(M); \
  cat("\nCXX14FLAGS=-O3 -march=native -mtune=native -fPIC","CXX14=clang++",file = M, sep = "\n", append = TRUE)'


RUN Rscript -e 'options(repos = list(CRAN = "http://mran.revolutionanalytics.com/snapshot/2020-08-01")); \
  install.packages(c("brms", "data.table", "devtools", "SnowballC", "tidyverse", "dplyr"))'


