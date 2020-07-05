# Dockerfile for Stan

If you want to create the Docker image locally then clone this directory and run `bash docker build --tag bda:1.0 .` Then you've created an image `bda` tagged as `1.0`. You can also choose to run it as-is from your terminal directly (curtesy of <http://hub.docker.com>),

```{bash}
docker run -d -p 8787:8787 -e PASSWORD=foo torkar/docker_bda
```

Password above is set to `foo`, and then point your browser to <http://localhost:8787> and use `rstudio` as your username.

Note to self: If you want to adapt this repository for publishing a replication package:

1. Clone the repository.
2. Create a new branch with an appropriate name, `git checkout -b affective_states`.
3. Make changes in that branch's `scripts/install_repl.sh`, and commit the changes.
4. In the original repo, e.g., `torkar/affective_states`,
    1. `git submodule add -b affective_states https://github.com/torkar/docker_bda.git`, to add a submodule.
    2. `git submodule update --init`, to initialize the submodule and fetch the code.
    3. `ln -s docker_bda/Docker Docker`, to create a link `Docker` in `/` pointing to the `Docker` file in `docker_bda`.
    4. `ln -s docker_bda/scripts scripts`, to create a link `scripts`, which points to the directory `docker_bda/scripts`. 

With the last two steps <http://hub.docker.com> will find the `Docker` file and `scripts/` directory in the root directory and, thus, should be able to push it through its autoamted builds system.

***

This Docker file can be used to build a Docker image containing Stan <http://mc-stan.org> with some accompanying packages.

The image makes use of the excellent `rocker/rstudio` image as a base. Then we use `install_stan.sh` to install some packages in Ubuntu, i.e., `apt-utils` and `libnode-dev`. Then we install `rstan` and other packages.

Finally, we use `install_env.sh` to set up the environment for the `rstudio` user. We make sure to create the file `/home/rstudio/.R/Makevars` containing the following lines,

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

The following `R` packages are currently (2020-07-04) installed,

```{R}
> ip <- as.data.frame(installed.packages()[,c(1,3:4)])
> rownames(ip) <- NULL
> ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]
> print(ip, row.names=FALSE)
        Package     Version
          abind       1.4-5
   arrayhelpers       1.1-0
        askpass         1.1
     assertthat       0.2.1
      backports       1.1.8
      base64enc       0.1-3
      bayesplot       1.7.2
             BH    1.72.0-3
        blavaan       0.3-9
           blob       1.2.1
           brew       1.0-6
 bridgesampling       1.0-0
           brms      2.13.0
    Brobdingnag       1.2-6
          broom       0.5.6
          callr       3.4.3
     cellranger       1.1.0
      checkmate       2.0.0
            cli       2.0.2
          clipr       0.7.0
           coda      0.19-3
     colorspace       1.4-1
   colourpicker         1.0
     commonmark         1.7
   CompQuadForm       1.4.3
           covr       3.5.0
         crayon       1.3.4
      crosstalk     1.1.0.1
           curl         4.3
        dagitty       0.2-2
            DBI       1.1.0
         dbplyr       1.4.4
           desc       1.2.0
       devtools       2.3.0
         digest      0.6.25
         docopt       0.7.1
          dplyr       1.0.0
             DT        0.14
       dygraphs     1.1.1.6
       ellipsis       0.3.1
       evaluate        0.14
     extraDistr      1.8.11
          fansi       0.4.1
         farver       2.0.3
        fastmap       1.0.1
        forcats       0.5.0
             fs       1.4.2
         future      1.17.0
   future.apply       1.6.0
       generics       0.0.2
         ggdist       2.1.1
        ggplot2       3.3.2
       ggridges       0.5.2
       ggthemes       4.2.0
             gh       1.1.0
          git2r      0.27.1
        globals      0.12.5
           glue       1.4.1
      gridExtra         2.3
         gtable       0.3.0
         gtools       3.8.2
          haven       2.3.1
     HDInterval       0.2.2
          highr         0.8
            hms       0.5.3
      htmltools       0.5.0
    htmlwidgets       1.5.1
         httpuv       1.5.4
           httr       1.4.1
         igraph       1.2.5
            ini       0.3.1
         inline      0.3.15
        isoband       0.2.2
       jsonlite       1.7.0
          knitr        1.29
       labeling         0.3
          later     1.1.0.1
         lavaan       0.6-6
       lazyeval       0.2.2
      lifecycle       0.2.0
        listenv       0.8.0
        littler      0.3.11
           lme4      1.1-23
            loo       2.2.0
      lubridate       1.7.9
       magrittr         1.5
       markdown         1.1
   MatrixModels       0.4-1
    matrixStats      0.56.0
           mcmc       0.9-7
       MCMCpack       1.4-8
        memoise       1.1.0
           mime         0.9
         miniUI     0.1.1.1
          minqa       1.2.4
         mnormt       2.0.1
         modelr       0.1.8
        munsell       0.5.0
        mvtnorm       1.1-1
        nleqslv       3.3.2
         nloptr     1.2.2.1
       nonnest2       0.5-4
       numDeriv  2016.8-1.1
        openssl       1.4.2
        packrat       0.5.0
      patchwork       1.0.1
       pbivnorm       0.6.0
         pillar       1.4.4
       pkgbuild       1.0.8
      pkgconfig       2.0.3
        pkgload       1.1.0
           plyr       1.8.6
         praise       1.0.0
    prettyunits       1.1.1
       processx       3.4.2
       progress       1.2.2
       projpred       1.1.6
       promises       1.1.1
             ps       1.3.3
          purrr       0.3.4
       quantreg        5.55
             R6       2.4.1
      rcmdcheck       1.3.3
   RColorBrewer       1.1-2
           Rcpp     1.0.4.6
  RcppArmadillo 0.9.900.1.0
      RcppEigen   0.3.3.7.0
   RcppParallel       5.0.2
          readr       1.3.1
         readxl       1.3.1
        rematch       1.0.1
       rematch2       2.1.2
        remotes       2.1.1
         reprex       0.3.0
       reshape2       1.4.4
     rethinking        2.01
            rex       1.2.0
          rlang       0.4.6
      rmarkdown         2.3
       roxygen2       7.1.1
      rprojroot       1.3-2
      rsconnect      0.8.16
          rstan      2.19.3
       rstanarm      2.19.3
     rstantools       2.1.0
     rstudioapi        0.11
      rversions       2.0.2
          rvest       0.3.5
       sandwich       2.5-1
         scales       1.1.1
        selectr       0.4-2
    sessioninfo       1.1.1
          shape       1.4.4
          shiny       1.5.0
        shinyjs         1.1
      shinystan       2.5.0
    shinythemes       1.1.2
    sourcetools       0.1.7
        SparseM        1.78
    StanHeaders    2.21.0-5
        statmod      1.4.34
        stringi       1.4.6
        stringr       1.4.0
         svUnit       1.0.3
            sys         3.3
       testthat       2.3.2
        threejs       0.3.3
         tibble       3.0.1
      tidybayes       2.1.1
          tidyr       1.1.0
     tidyselect       1.1.0
      tidyverse       1.3.0
        tinytex        0.24
        tmvnsim       1.0-2
        usethis       1.6.1
           utf8       1.1.4
             V8       3.2.0
          vctrs       0.3.1
    viridisLite       0.3.0
        whisker         0.4
          withr       2.2.0
           xfun        0.15
           xml2       1.3.2
          xopen       1.0.0
         xtable       1.8-4
            xts      0.12-0
           yaml       2.2.1
            zoo       1.8-8
```
