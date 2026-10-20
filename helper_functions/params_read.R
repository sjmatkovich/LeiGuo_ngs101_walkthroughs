#' Ingest the YAML `params` for the current R Markdown notebook
#'
#' Returns the `params` list for a notebook whether it is being knit or run
#' chunk-by-chunk in an editor (for example Positron's "Run Cell"). Chunk-by-chunk
#' runs never create `params`, because `rmarkdown::render()` is what normally
#' does that.
#'
#' When knitting (`knitr.in.progress` is `TRUE`), the `params` object that
#' `rmarkdown::render()` created is returned unchanged and the YAML is not read.
#'
#' Otherwise the notebook's own YAML front matter is read on every call, so
#' edits to the YAML take effect when the chunk is re-run without `rm(params)`.
#' Values are the raw YAML values from [rmarkdown::yaml_front_matter()]:
#' `!r` expressions and `label`/`input`/`value` specifications are not evaluated.
#'
#' @param rmd_path Path to the `.Rmd` file to read. If `NULL` (the default),
#'   the file in the active editor tab is used, via
#'   `rstudioapi::getSourceEditorContext()`. That is only correct while the
#'   notebook is the focused tab.
#' @param envir Environment in which to look for the `params` object when
#'   knitting. Defaults to the calling environment.
#'
#' @return A named list of parameter values.
#' @seealso [rmarkdown::yaml_front_matter()]
#' @examples
#' \dontrun{
#' source(here::here("helper_functions", "params_read.R"))
#' params <- params_ingest()
#' params <- params_ingest(rmd_path = "scRNAseq_tutorial_4_cell_type_annotation/tut4_cell_type_annotation_part1.Rmd")
#' }
params_ingest <- function(rmd_path = NULL, envir = parent.frame()) {
  if (isTRUE(getOption("knitr.in.progress"))) {
    if (!exists("params", envir = envir)) {
      stop("Knitting is in progress but no `params` object was found.", call. = FALSE)
    }
    return(get("params", envir = envir))
  }

  if (is.null(rmd_path)) {
    rmd_path <- tryCatch(
      rstudioapi::getSourceEditorContext()$path,
      error = function(e) NA_character_
    )
  }
  if (is.null(rmd_path) || is.na(rmd_path) || !nzchar(rmd_path) || !file.exists(rmd_path)) {
    stop(
      "Can't locate the .Rmd to read its YAML params. ",
      "Focus the notebook's editor tab or pass `rmd_path`.",
      call. = FALSE
    )
  }

  yaml_params <- rmarkdown::yaml_front_matter(rmd_path)$params
  if (is.null(yaml_params)) {
    stop("No `params:` block found in the YAML header of ", rmd_path, call. = FALSE)
  }
  yaml_params
}
