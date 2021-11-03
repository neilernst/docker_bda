#!/bin/bash
set -e

apt-get update \
&& apt-get install -y --no-install-recommends \
libv8-dev \
&& rm -rf /var/lib/apt/lists/* \
&& install2.r --error --skipinstalled \
    rstanarm \
    brms \
    tidybayes \
    blavaan \
    coda \
    mvtnorm \
    devtools \
    dagitty \
    tidyverse \
    ggthemes \
    patchwork \
    extraDistr \
    ggridges \
    forcats \
    V8 \
    projpred \
    shape \
    bookdown \
    BH \
    kableExtra \
    tufte \
    openxlsx \
    remotes \
    synthpop \
&& installGithub.r rmcelreath/rethinking \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds
