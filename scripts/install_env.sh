#!/bin/bash
set -e

mkdir -p /home/rstudio/.R/ \
    && echo "CXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function -Wno-macro-redefined" >> /home/rstudio/.R/Makevars \
    && echo "CXXFLAGS+=-flto -Wno-unused-local-typedefs" >> /home/rstudio/.R/Makevars \
    && echo "CXXFLAGS += -Wno-ignored-attributes -Wno-deprecated-declarations" >> /home/rstudio/.R/Makevars \
    && echo "rstan::rstan_options(auto_write = TRUE)" >> /home/rstudio/.Rprofile \
    && echo "options(mc.cores = parallel::detectCores())" >> /home/rstudio/.Rprofile

# If you want to make sure that the Docker image downloads a certain repository
# mkdir -p /home/rstudio/development \
#    && git clone https://github.com/torkar/affective_states.git
