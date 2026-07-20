# Demo based on posit bslib dashboard demos: https://rstudio.github.io/bslib/articles/dashboards/index.html
# By: Will Hore-Lacy
# Date: 2026-07-20

# Packages data ----------------------------------------------------------------
library(shiny)
library(bslib)
library(ggplot2)

data(penguins, package = "palmerpenguins")

# UI ---------------------------------------------------------------------------
ui <- page_navbar(
  title = "Penguins dashboard",
  
  # Theme and options
  theme = bs_theme(preset="cosmo"),
  navbar_options = navbar_options(class = "bg-dark", theme = "dark"),
  
  # Tab 1 - Histogram
  nav_panel("Histogram",
            
            layout_sidebar(
              sidebar = sidebar(
                title = "Histogram controls",
                varSelectInput(
                  "var", "Select variable",
                  dplyr::select_if(penguins, is.numeric)
                ),
                numericInput("bins", "Number of bins", 30)
              ),
              card(
                card_header("Histogram"),
                plotOutput("histogram")
              )
            )
  ),
  
  # Tab 2 - Density
  nav_panel("Density",
            layout_sidebar(
              sidebar = sidebar(
                varSelectInput(
                  "color_by", "Color by",
                  penguins[c("species", "island", "sex")],
                  selected = "species"
                )
              ),
              layout_columns(
                card(
                  full_screen = TRUE,
                  card_header("Bill Length"),
                  plotOutput("bill_length")
                ), 
                card(
                  full_screen = TRUE,
                  card_header("Bill depth"),
                  plotOutput("bill_depth")
                )
              ),
              card(
                full_screen = TRUE,
                card_header("Body Mass"),
                plotOutput("body_mass")
              )
            )
  )
  
)


# SERVER -----------------------------------------------------------------------
server <- function(input, output) {
  
  # Tab 1 - Histogram
  output$histogram <- renderPlot({
    ggplot(penguins) +
      geom_histogram(aes(!!input$var), bins = input$bins) +
      theme_bw(base_size = 20)
  })
  
  # Tab 2 - Density plots
  # Graph function
  gg_plot <- reactive({
    ggplot(penguins) +
      geom_density(aes(fill = !!input$color_by), alpha = 0.2) +
      theme_bw(base_size = 16) +
      theme(axis.title = element_blank())
  })
  
  # Graph outputs
  output$bill_length <- renderPlot(gg_plot() + aes(bill_length_mm))
  output$bill_depth <- renderPlot(gg_plot() + aes(bill_depth_mm))
  output$body_mass <- renderPlot(gg_plot() + aes(body_mass_g))
  
  
}

# RUN APP ----------------------------------------------------------------------
shinyApp(ui, server)