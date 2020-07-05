
# Dockerfile for Stan

This Docker file can be used to build a Docker image containing Stan <http://mc-stan.org> with some accompanying packages.

## Run locally

If you want to create the Docker image locally then clone this directory and run `bash docker build --tag bda` from the this directory. Then you've created an image namned `bda`, which you now can run locally in your terminal as-is. 

## Run via <http://hub.docker.com>

You can also choose to not build the image and instead run the image at <http://hub.docker.com> from your terminal directly (curtesy of <http://hub.docker.com>),

```{bash}
docker run -d -p 8787:8787 -e PASSWORD=foo -e ROOT=TRUE torkar/docker_bda
```

The password above is set to `foo` (change if needed). Next, point your browser to <http://localhost:8787> and use `rstudio` as your username and the password you just set.

## Use this for your own projects/papers

If you want to adapt this repository for publishing a replication package through <http://hub.docker.com> then,

1. [Fork this repository](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo#fork-an-example-repository) on GitHub.
2. Go to <http://hub.docker.com> and [add the repository](https://docs.docker.com/docker-hub/repos/) to <http://hub.docker.com>.
3. Clone the pository to your computer and create a new branch with an appropriate name, e.g., `git checkout -b affective_states`.
4. Make changes in that branch's `scripts/install_repl.sh`, commit the changes, and push the branch, e.g., `git push -u origin affective_states`.
6. Add `Automated Builds` for the repository (please see [[Set up automated builds]](https://docs.docker.com/docker-hub/builds/)).

With the last step <http://hub.docker.com> will find the `Docker` file and `scripts/` directory in the root directory of the branch and, thus, should be able to push it through its automated builds system (make sure that you add the name of the *branch*).

## Background

The image makes use of the excellent `rocker/rstudio` image as a base (see [Rocker](https://hub.docker.com/r/rocker/rstudio/)). Then we use `install_stan.sh` to install some packages in Ubuntu, i.e., `apt-utils` and `libnode-dev`, and we install `rstan` and other packages.

We then use `install_env.sh` to set up the environment for the `rstudio` user. We make sure to create the file `/home/rstudio/.R/Makevars` containing the following lines,

```{bash}
CXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function -Wno-macro-redefined
CXXFLAGS+=-flto -Wno-unused-local-typedefs
CXXFLAGS += -Wno-ignored-attributes -Wno-deprecated-declarations
```

and the file `/home/rstudio/.Rprofile`containing the following lines,

```{bash}
rstan::rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
```

Finally, `scripts/install_repl.sh` allows you to add a command that will clone a GitHub repository (which should contain your replication package).
