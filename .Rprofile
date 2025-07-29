# Set repository to p3m.dev
options(repos = c(CRAN = "https://p3m.dev/cran/__linux__/manylinux_2_28/latest"))

# Enable pak with renv
options(renv.config.pak.enabled = TRUE)

source("renv/activate.R")

# prepend homebrew gifski binary to PATH so camcorder finds it
current_path <- Sys.getenv("PATH")
gifski_path <- "/opt/homebrew/bin"
if (!grepl(gifski_path, current_path, fixed = TRUE)) {
  Sys.setenv(PATH = paste(gifski_path, current_path, sep = ":"))
}
