# Guidance for working in this repo

Follow-along R Markdown notebooks for the [ngs101](https://ngs101.com/tutorials/) single-cell tutorials, with configurable values pulled into YAML `params`. Each tutorial lives in a `scRNAseq_tutorial_N_*` folder. The same guidance is mirrored as separate notes in `.claude/memory/`.

## Extracting code from a new tutorial

- Do not rely on a web fetch for the article's code: it summarizes and will not return code verbatim. Save the page as HTML (the repo's convention is `scRNAseq_tutorials_html_source/tutN.htm`) and parse that.
- The code is SyntaxHighlighter markup (no `<pre>`): each line is a `<div class="line ...">` with `<code class="r ...">` spans, inside `div.container` of a `div.syntaxhighlighter`. The line-number gutter also uses `div.line`, so only take lines inside `container`. The nearest preceding h1-h4 heading names each block. Printed-output blocks are mixed in with real code; tell them apart by content.
- Some blocks are double-escaped (`&lt;-` instead of `<-`): unescape twice and grep the finished Rmds for leftover `&lt;`, `&gt;`, `&amp;`.
- Use the page's `<link rel="canonical">` for the "Primary source" link.
- Verify by a normalized line comparison of article blocks against the Rmds; every non-matching line must be an intended substitution (params, paths) or a marked fix.

## Notebook conventions

- Template: tut2/tut3 notebooks. YAML with `title`, `subtitle`, `author: "Scot J Matkovich; Lei Guo"`, date, `params:` (inline `#` comments), html_document with toc and `code_folding: hide`, `markdown: wrap: 80`. Then a `setup` chunk, `## Description` with a "Primary source" link, a `step1_libs_data` chunk that sources `helper_functions/params_read.R` via `here::here()` and calls `params <- params_ingest()` before any directory definition that uses `params` (the helper re-reads the Rmd's own YAML when run interactively and returns the knit `params` when knitting), `# STEP n:` banners kept from the article, and a closing sessionInfo chunk.
- Hard-coded values (paths, column names, thresholds, cell types, colors, seed) go into `params`. `setwd()` becomes `file.path(base.dir, <x>.subdir, ...)`.
- `rmarkdown` params reject nested maps ("no value field specified"). Use parallel lists (`condition.levels` / `condition.palette`), `"collection:name"` strings, and `""` as an "auto" sentinel instead of YAML null.
- Mark every deviation from the article in a comment: `FIX:` for an article bug, `ADDED:` for new code such as hand-off steps. The Description states that code is taken from the article's blocks.
- Long tutorials are split into three notebooks; parts hand off through `saveRDS`/`save` under `results/` or `annotations/`. The tutorial 4 final object `annotations/integrated_annotated_seurat.rds` (columns `final_annotation`, `sample_id`, `condition`, `patient_id`) is the input for tutorials 5, 7 and 7-2.
- Folder names follow the article part number (`scRNAseq_tutorial_7-2_trajectory_slingshot`, files `tut7-2_*`). Each folder has a `tutN_R_requirements.R` taken from the article's install block.
- Article bugs fixed so far: truncated `create_confusion_matrix()` (tut4); `mean`/`sd` column mismatch and propeller `row.names = FALSE` (tut5); sequential `order_cells()` calls and duplicated `graph_test()` (tut7).

## Working practices

- Verify statically: `rmarkdown::yaml_front_matter()`, `knitr::purl()` followed by `parse()`, and the article-vs-Rmd line comparison. Say plainly when notebooks were not run.
- Do not install packages without asking; several are not in `renv.lock` (for example monocle3, slingshot, speckle, DESeq2, msigdbr). Report what is missing instead.
- Flag questionable article logic with a comment (for example an auto-detected Slingshot start cluster that is CD8+, or pseudotime scales that are not comparable between lineages) rather than silently changing results.
- Treat edits made to generated files after the fact as deliberate.
- Do not commit `tmp/` or the downloaded HTML unless asked.
