# Read build metadata written by CI into .Renviron
# (Defaults keep local runs sane)
COMMIT_SHA      <- substr(Sys.getenv("GIT_SHA", "dev-local"), 1, 7)
DEPLOY_TIME_UTC <- Sys.getenv("DEPLOY_TIME", "")
