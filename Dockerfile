FROM rocker/rstudio

LABEL maintainer="Richard Torkar <richard.torkar@gmail.com>"

COPY scripts /rocker_scripts

# install rstan etc.
RUN /rocker_scripts/install_stan.sh

# configure 
RUN /rocker_scripts/install_env.sh

# make sure we're not root
USER rstudio

RUN R -e "remotes::install_github('stan-dev/rstantools')"
RUN R -e "remotes::install_github('paul-buerkner/brms')"
RUN R -e "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos')))"
RUN R -e "cmdstanr::install_cmdstan()"

# d/l any repos needed
RUN /rocker_scripts/install_repl.sh

USER root

EXPOSE 8787

CMD ["/init"]
