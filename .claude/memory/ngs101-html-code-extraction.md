---
name: ngs101-html-code-extraction
description: "How to extract article code for new ngs101 tutorials: WebFetch refuses verbatim code, so parse the user-saved HTML"
metadata:
  node_type: memory
  type: feedback
  originSessionId: a6d8fb34-25c2-4d18-b145-b8926b765c48
  modified: 2026-10-17T19:02:54.364Z
---

For a new ngs101 tutorial, do not rely on WebFetch for code: it summarizes and refuses to reproduce code verbatim (first attempt at tutorial 4 produced my own re-implementation that later had to be redone). Ask the user to save the page as HTML; they put it in `scRNAseq_tutorials_html_source/tutN.htm` (earlier `tmp/`). Copy it to a new scratchpad dir and parse with `python3 -I` + `html.parser`.

**Why:** code on the site is SyntaxHighlighter markup (no `<pre>`): lines are `<div class="line ...">` with `<code class="r ...">` spans inside `div.container` of each `div.syntaxhighlighter`. The gutter has `div.line` too, so only take lines inside `container`. Nearest preceding h1-h4 gives the block's heading. Printed-output blocks are mixed in with real code; recognize them by content.

**How to apply:** some blocks are double-escaped (`&lt;-`), so run a second `html.unescape()` pass and grep the finished Rmds for leftover `&lt;|&gt;|&amp;`. Verify by normalized line comparison of article blocks vs the Rmds; every non-matching line must be an intended substitution or a marked fix. The canonical URL is in `<link rel="canonical">`; use it for the "Primary source" link.

Related: [[ngs101-rmd-conventions]]
