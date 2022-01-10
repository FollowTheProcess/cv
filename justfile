DEFAULT_THEME := "kendall"
PDF := "./exports/Tom_Fleet_CV.pdf"
HTML := "./public/index.html"
RESUME := "./node_modules/resume-cli/build/main.js"

_default:
    @just --list

# Show all declared justfile variables
show:
    @just --evaluate

# Format the justfile
fmt:
    @just --unstable --fmt

# Build and serve the resume
serve *theme: validate
    {{ RESUME }} serve --theme {{ if theme != "" { theme } else { DEFAULT_THEME } }}

# Validate the schema
validate:
    {{ RESUME }} validate

# Build a pdf
pdf: validate
    mkdir -p exports
    {{ RESUME }} export {{ PDF }} --format pdf --theme {{ DEFAULT_THEME }}

# Build a html page
html: validate
    {{ RESUME }} export {{ HTML }} --format html --theme {{ DEFAULT_THEME }}

# Spell check the CV
check:
    pre-commit run --all-files

# Clean up built exports and public
clean:
    rm -rf exports/* public
