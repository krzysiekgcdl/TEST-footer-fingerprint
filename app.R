# minimal shiny app with a footer showing GIT_SHA and DEPLOY_TIME from env
library(shiny)

if (file.exists("global.R")) source("global.R")
# if (!exists("COMMIT_SHA", inherits = TRUE)) COMMIT_SHA <- substr(Sys.getenv("GIT_SHA", "dev-local"), 1, 7)
# if (!exists("DEPLOY_TIME_UTC", inherits = TRUE)) DEPLOY_TIME_UTC <- Sys.getenv("DEPLOY_TIME", "")


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
