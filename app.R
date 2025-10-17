# minimal shiny app with a footer showing GIT_SHA and DEPLOY_TIME from env
library(shiny)

ui <- fluidPage(
  tags$head(tags$style(HTML("\n    .footer { margin-top: 30px; font-size: 12px; opacity: .75; }\n+  "))),
  h2("ClinViewer Mini Test"),
  p("If you can see commit + deploy time below, the CI → .Renviron → footer path works."),
  div(class = "footer",
      textOutput("build_meta", container = tags$small))
)

server <- function(input, output, session) {
  # COMMIT_SHA and DEPLOY_TIME_UTC are sourced from global.R (env-backed)
  output$build_meta <- renderText({
    paste0("Commit: ", COMMIT_SHA,
           if (nzchar(DEPLOY_TIME_UTC)) paste0(" | Deployed (UTC): ", DEPLOY_TIME_UTC) else "")
  })
}

shinyApp(ui, server)
