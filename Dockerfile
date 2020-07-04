FROM rocker/rstudio

LABEL maintainer="Richard Torkar <richard.torkar@gmail.com>"

COPY scripts /rocker_scripts

# install rstan etc.
RUN /rocker_scripts/install_stan.sh

# configure and d/l any repos needed
RUN /rocker_scripts/install_env.sh

EXPOSE 8787

CMD ["/init"]
