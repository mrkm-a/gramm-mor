# version 2.0
FROM rocker/tidyverse:4.0.0
LABEL "maintainer"="Akira Murakami (a.murakami@bham.ac.uk)"

# install clang that is used to compile rstan
RUN apt-get update && apt-get install -y --no-install-recommends clang

# https://github.com/stan-dev/rstan/wiki/Installing-RStan-on-Linux
RUN Rscript -e 'dotR <- file.path(Sys.getenv("HOME"), ".R"); \
if (!file.exists(dotR)) dir.create(dotR); \
M <- file.path(dotR, "Makevars"); \
if (!file.exists(M)) file.create(M); \
cat("\nCXX14FLAGS=-O3 -march=native -mtune=native -fPIC","CXX14=clang++",file = M, sep = "\n", append = TRUE)'

RUN Rscript -e 'options(repos = list(CRAN = "http://mran.revolutionanalytics.com/snapshot/2020-08-01")); \
  install.packages(c("brms", "data.table", "devtools", "parallel", "SnowballC", "tidyverse"))'

CMD [ “/bin/bash” ]
