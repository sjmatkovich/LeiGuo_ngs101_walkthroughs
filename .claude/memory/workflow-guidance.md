---
name: workflow-guidance
description: Contributor guidance for extraction/notebook tasks: plan first, verify statically, no installs or commits without asking
metadata:
  type: feedback
---

Propose a plan and settle design questions (notebook layout, choices that change results) before writing files.

**How to apply:**
- Verify statically (`yaml_front_matter`, `knitr::purl` + `parse`, article-vs-Rmd line comparison). Do not install packages or run chunks unless the data and packages exist, and say so when notebooks were not run.
- Report packages missing from `renv.lock` (monocle3, slingshot, speckle, DESeq2, msigdbr, ...) instead of installing them.
- Do not commit without being asked; keep `tmp/` and `scRNAseq_tutorials_html_source/` out of commits.
- Flag suspicious article logic with a comment rather than silently changing results; change it only where a decision has been agreed.
- Treat later hand edits to generated files as deliberate.

Related: [[ngs101-rmd-conventions]]
