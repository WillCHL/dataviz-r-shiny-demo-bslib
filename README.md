# Demo app for R Shiny using `bslib`

App is a `bslib::navbar_page` app that is heavily based on two of the examples from the [Posit bslib dashboard demo page](https://rstudio.github.io/bslib/articles/dashboards/index.html)

Data is sourced from the [`plamerpenguins`](https://allisonhorst.github.io/palmerpenguins/) package.

This repo contains an renv.lock files to enable `renv` package management.

Install packages using:

```{r}
renv::init()
renv::restore()
```