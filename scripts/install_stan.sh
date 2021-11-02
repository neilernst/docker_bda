#!/bin/bash
set -e

apt update \
&& apt install nodejs\
&& install2.r --error --skipinstalled \
    rstanarm \
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
