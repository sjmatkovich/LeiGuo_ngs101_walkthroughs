---
name: ngs101-rmd-conventions
description: "Conventions for the tutorial Rmd notebooks (YAML params, header chunks, FIX/ADDED markers, hand-off files, naming)"
metadata:
  node_type: memory
  type: project
  originSessionId: a6d8fb34-25c2-4d18-b145-b8926b765c48
  modified: 2026-10-17T19:03:00.128Z
---

Notebooks in `scRNAseq_tutorial_N_*/` follow the tut2/tut3 template: YAML with `title`, `subtitle`, `author: "Scot J Matkovich; Lei Guo"`, date, `params:` (inline `#` comments), html_document toc/code_folding hide, `markdown: wrap: 80`; `setup` chunk; `## Description` with "Primary source" link; `step1_libs_data` chunk that sources `helper_functions/params_read.R` (via `here::here()`) and calls `params_ingest()` before directory definitions; `# STEP n:` banners kept from the article; closing sessionInfo chunk.

**Rules learned:**
- Hard-coded values (paths, column names, thresholds, cell types, colors, seed) go into `params`; `setwd()` becomes `file.path(base.dir, <x>.subdir, ...)`.
- `rmarkdown` params reject nested maps ("no value field specified"): use parallel lists (`condition.levels` / `condition.palette`) and `"collection:name"` strings; use `""` as the "auto" sentinel instead of YAML null.
- Mark every deviation from the article in comments: `FIX:` (article bug) or `ADDED:` (new code, e.g. hand-offs). State in the Description that code is from the article's blocks.
- Long tutorials are split into 3 notebooks; parts hand off via `saveRDS`/`save` under `results/` or `annotations/`. The tut4 final object `annotations/integrated_annotated_seurat.rds` (columns `final_annotation`, `sample_id`, `condition`, `patient_id`) is the input for tutorials 5, 7, 7-2.
- Folder naming follows the article part number: `scRNAseq_tutorial_7-2_trajectory_slingshot`, files `tut7-2_*`. Each folder gets a `tutN_R_requirements.R` from the article's install block.
- Known article bugs fixed so far: truncated `create_confusion_matrix()` (tut4), `mean`/`sd` column mismatch and propeller `row.names = FALSE` (tut5), sequential `order_cells()` calls and duplicated `graph_test()` (tut7).

Related: [[ngs101-html-code-extraction]], [[workflow-guidance]]
