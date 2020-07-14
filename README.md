[![DOI](https://zenodo.org/badge/277138015.svg)](https://zenodo.org/badge/latestdoi/277138015)

# Dockerfile for Stan

This Docker file can be used to build a Docker image containing Stan <http://mc-stan.org> with some accompanying packages. In order to use this please first install [Docker](https://docs.docker.com/get-docker/).

## Run via <http://hub.docker.com>

You can choose to run the latest version as-is from <http://hub.docker.com> in your terminal directly,

```{bash}
docker run -d -p 8787:8787 -e PASSWORD=foo -e ROOT=TRUE torkar/docker_bda
```

The password above is set to `foo` (change if needed). Next, point your browser to <http://localhost:8787> and use `rstudio` as your username and the password you just set.

## To use this for your own projects/papers

If you want to adapt this repository for publishing a replication package through <http://hub.docker.com> then,

1. [Fork this repository](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo#fork-an-example-repository) on GitHub.
2. Go to <http://hub.docker.com> and [add the repository](https://docs.docker.com/docker-hub/repos/).
3. Clone the repository to your computer and create a new branch with an appropriate name, e.g., `git checkout -b affective_states`. (Do this for every paper/project you want to have a replication package for.)
4. Make changes in that branch's `scripts/install_repl.sh`, commit the changes, and push the branch, e.g., `git push -u origin affective_states`.
6. Set up automated builds for the repository (please see [[Set up automated builds]](https://docs.docker.com/docker-hub/builds/)). Make sure to point to your branch, and not `master`, and tag the build with a sane keyword. Also, make sure to turn off `Build caching` since we're pulling things from GitHub.

With the last step <http://hub.docker.com> will find the `Docker` file and `scripts/` directory in the branch and, thus, should be able to push it through its automated builds system. If you change things in this repository it will automatically build a new image for you. However, any changes in your repository, containing the replication package, will go unnoticed, i.e., if you want the image to pull from GitHub and rebuild you need to simply trigger a new build.

## Background

The image makes use of the excellent `rocker/rstudio` image (see [Rocker](https://hub.docker.com/r/rocker/rstudio/)). Then we use `install_stan.sh` to install some packages in Ubuntu, e.g., `libnode-dev` and `libxml2-dev`, and we install `rstan` and other packages.

We then use `install_env.sh` to set up the environment for the `rstudio` user. We make sure to create the file `/home/rstudio/.R/Makevars` containing the following lines,

```{bash}
CXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function -Wno-macro-redefined
CXXFLAGS+=-flto -Wno-unused-local-typedefs
CXXFLAGS+=-Wno-ignored-attributes -Wno-deprecated-declarations
```

and the file `/home/rstudio/.Rprofile`containing the following lines,

```{bash}
rstan::rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
```

Finally, `scripts/install_repl.sh` allows you to add a command that will clone a GitHub repository (which should contain your replication package).
