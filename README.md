# Demo app for R Shiny using `bslib`

App is a `bslib::navbar_page` app that is heavily based on two of the examples from the [Posit bslib dashboard demo page](https://rstudio.github.io/bslib/articles/dashboards/index.html)

Data is sourced from the [`plamerpenguins`](https://allisonhorst.github.io/palmerpenguins/) package.

This repo contains an `renv.lock` file to enable `renv` package management.

Install packages using:

```{r}
renv::init()
```

Then select "1: Restore the project from the lockfile." or run `renv::restore()` separately.