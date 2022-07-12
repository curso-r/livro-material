r_chap_pattern = '^<!--chapter:end:(.+)-->$'
split_chapters2 = function(
    output, build = build_chapter, global_numbering, split_by, split_bib, ...
) {

  use_rmd_names = split_by == 'rmd'
  split_level = switch(
    split_by, none = 0, chapter = 1, `chapter+number` = 1,
    section = 2, `section+number` = 2, rmd = 1
  )

  if (!(split_level %in% 0:2)) stop('split_level must be 0, 1, or 2')

  x = rmarkdown:::read_utf8(output)
  x = bookdown:::clean_html_tags(x)

  i1 = bookdown:::find_token(x, '<!--bookdown:title:start-->')
  i2 = bookdown:::find_token(x, '<!--bookdown:title:end-->')
  i3 = bookdown:::find_token(x, '<!--bookdown:toc:start-->')
  i4 = bookdown:::find_token(x, '<!--bookdown:toc:end-->')
  i5 = bookdown:::find_token(x, '<!--bookdown:body:start-->')
  i6 = bookdown:::find_token(x, '<!--bookdown:body:end-->')

  n = length(grep(r_chap_pattern, x))

  # Need to take care of the div tags here before restore_part_html and
  # restore_appendix_html erase the section ids of the hidden PART or APPENDIX
  # sections.
  if (split_level > 1) {
    body = x[(i5 + 1):(i6 - 1)]
    h1 = grep('^<div (id="[^"]+" )?class="section level1("| )', body) + i5
    h2 = grep('^<div (id="[^"]+" )?class="section level2("| )', body) + i5
    h12 = setNames(c(h1, h2), rep(c('h1', 'h2'), c(length(h1), length(h2))))
    if (length(h12) > 0 && h12[1] != i5 + 1) stop(
      'The document must start with a first (#) or second level (##) heading'
    )
    h12 = sort(h12)
    if (length(h12) > 1) {
      n12 = names(h12)
      # h2 that immediately follows h1
      i = h12[n12 == 'h2' & c('h2', head(n12, -1)) == 'h1'] - 1
      # close the h1 section early with </div>
      # reg_chap and sec_num must take this into account so that cross reference
      # works when split by section. (#849)
      if (length(i)) x[i] = paste0(x[i], '\n</div>')
      # h1 that immediately follows h2 but not the first h1
      i = n12 == 'h1' & c('h1', head(n12, -1)) == 'h2'
      if (any(i) && n12[1] == 'h2') i[which(n12 == 'h1')[1]] = FALSE
      i = h12[i] - 1
      # need to comment out the </div> corresponding to the last <h1> in the body
      if (tail(n12, 1) == 'h2' && any(n12 == 'h1')) {
        for (j in (i6 - 1):(tail(h12, 1))) {
          # the line j should close h1, and j - 1 should close h2
          if (all(x[j - 0:1] == '</div>')) break
        }
        i = c(i, j)
      }
      for (j in i) {
        # the i-th lines should be the closing </div> for h1
        if (x[j] != '</div>') stop(
          'Something wrong with the HTML output. The line ', x[j],
          ' is supposed to be </div>'
        )
      }
      x[i] = paste('<!--', x[i], '-->')  # remove the extra </div> of h1
    }
  }

  x = bookdown:::add_section_ids(x)
  x = bookdown:::restore_part_html(x)
  x = bookdown:::restore_appendix_html(x)

  # no (or not enough) tokens found in the template
  if (any(c(i1, i2, i3, i4, i5, i6) == 0)) {
    x = bookdown:::resolve_refs_html(x, global_numbering)
    x = bookdown:::add_chapter_prefix(x)
    rmarkdown:::write_utf8(x, output)
    return(output)
  }

  html_head  = x[1:(i1 - 1)]  # HTML header + includes
  html_title = x[(i1 + 1):(i2 - 1)]  # title/author/date
  html_toc   = x[(i3 + 1):(i4 - 1)]  # TOC
  html_body  = x[(i5 + 1):(i6 - 1)]  # body
  html_foot  = x[(i6 + 1):length(x)]  # HTML footer

  html_toc = bookdown:::add_toc_ids(html_toc)

  idx = grep(r_chap_pattern, html_body)
  nms = gsub(r_chap_pattern, '\\1', html_body[idx])  # to be used in HTML filenames
  h1 = grep('^<div (id="[^"]+" )?class="section level1("| )', x)
  if (length(h1) < length(nms)) warning(
    'You have ', length(nms), ' Rmd input file(s) but only ', length(h1),
    ' first-level heading(s). Did you forget first-level headings in certain Rmd files?'
  )

  html_body = bookdown:::resolve_refs_html(html_body, global_numbering)

  # do not split the HTML file
  if (split_level == 0) {
    html_body[idx] = ''  # remove chapter tokens
    html_body = bookdown:::add_chapter_prefix(html_body)
    rmarkdown:::write_utf8(build(
      html_head, html_toc, c(html_title, html_body), NULL, NULL, NULL, output, html_foot, ...
    ), output)
    return(bookdown:::move_to_output_dir(output))
  }

  if (split_bib) {
    # parse and remove the references chapter
    res = bookdown:::parse_references(html_body)
    refs = res$refs; html_body = res$html
    ref_title = res$title; refs_div = res$div
  }
  # parse and remove footnotes (will reassign them to relevant pages later)
  res = bookdown:::parse_footnotes(html_body)
  fnts = res$items
  if (length(fnts)) html_body[res$range] = ''

  if (use_rmd_names) {
    html_body[idx] = ''
    nms_chaps = nms  # Rmd filenames
    if (n >= 1) {
      idx = bookdown:::next_nearest(idx, grep('^<div', html_body))
      idx = c(1, idx[-n])
    }
  } else {
    h1 = grep('^<div (id="[^"]+" )?class="section level1("| )', html_body)
    h2 = grep('^<div (id="[^"]+" )?class="section level2("| )', html_body)
    idx2 = if (split_level == 1) h1 else if (split_level == 2) sort(c(h1, h2))
    n = length(idx2)
    nms_chaps = if (length(idx)) {
      vapply(idx2, character(1), FUN = function(i) head(nms[idx > i], 1))
    }
    reg_id = '^<div id="([^"]+)".*$'
    reg_num = '^(<h[12]><span class="header-section-number">)([.A-Z0-9]+)(</span>.+</h[12]>).*$'
    nms = vapply(idx2, character(1), FUN = function(i) {
      x1 = html_body[i]; x2 = html_body[i + 1]
      id = if (grepl(reg_id, x1)) gsub(reg_id, '\\1', x1)
      num = if (grepl(reg_num, x2)) gsub(reg_num, '\\2', x2)
      if (is.null(id) && is.null(num)) stop(
        'The heading ', x2, ' must have at least an id or a number'
      )
      nm = if (grepl('[+]number$', split_by)) {
        paste(c(stringr::str_replace_all(num, "\\.", "-"), id), collapse = '-')
      } else id
      if (is.null(nm)) stop('The heading ', x2, ' must have an id')
      nm
    })
    if (anyDuplicated(nms)) (if (isTRUE(bookdown:::opts$get('preview'))) warning else stop)(
      'Automatically generated filenames contain duplicated ones: ',
      paste(nms[duplicated(nms)], collapse = ', ')
    )
    # generate index.html if the first Rmd filename is index.Rmd
    if (identical(xfun::with_ext(head(nms_chaps, 1), ''), 'index')) nms[1] = 'index'
    html_body[idx] = ''
    idx = idx2
  }
  if (n == 0) {
    idx = 1; nms = output; n = 1
  }

  nms = basename(xfun::with_ext(nms, '.html'))  # the HTML filenames to be generated
  input = bookdown:::opts$get('input_rmd')
  html_body = bookdown:::add_chapter_prefix(html_body)
  html_toc = bookdown:::restore_links(html_toc, html_body, idx, nms)
  for (i in seq_len(n)) {
    # skip writing the chapter.html if the current Rmd name is not in the vector
    # of Rmd names passed to render_book() (only this vector of Rmd's should be
    # rendered for preview purposes)
    if (isTRUE(bookdown:::opts$get('preview')) && !(nms_chaps[i] %in% input)) {
      if (!file.exists(output_path(nms[i]))) file.create(nms[i])
      next
    }
    i1 = idx[i]
    i2 = if (i == n) length(html_body) else idx[i + 1] - 1
    html = c(if (i == 1) html_title, html_body[i1:i2])
    a_targets = bookdown:::parse_a_targets(html)
    if (split_bib) {
      # in order to find references in footnotes, we add footnotes to chapter body
      a_targets = bookdown:::parse_a_targets(bookdown:::relocate_footnotes(html, fnts, a_targets))
      html = bookdown:::relocate_references(html, refs, ref_title, a_targets, refs_div)
    }
    html = bookdown:::relocate_footnotes(html, fnts, a_targets)
    html = bookdown:::restore_links(html, html_body, idx, nms)
    html = build(
      bookdown:::prepend_chapter_title(html_head, html), html_toc, html,
      if (i > 1) nms[i - 1],
      if (i < n) nms[i + 1],
      if (length(nms_chaps)) nms_chaps[i],
      nms[i], html_foot, ...
    )
    rmarkdown:::write_utf8(html, nms[i])
  }

  # add a 404 page
  r404 = bookdown:::build_404()
  p404 = r404$path; h404 = r404$html
  if (!is.null(h404)) {
    h404 = build(
      bookdown:::prepend_chapter_title(html_head, h404), html_toc, h404, NULL, NULL,
      r404$rmd_cur, p404, html_foot, ...
    )
    rmarkdown:::write_utf8(h404, p404)
  }

  nms = bookdown:::move_to_output_dir(c(nms, p404))

  # find the HTML output file corresponding to the Rmd file passed to render_book()
  if (is.null(input) || length(nms_chaps) == 0) j = 1 else {
    if (is.na(j <- match(input[1], nms_chaps))) j = 1
  }
  nms[j]
}

utils::assignInNamespace("split_chapters", split_chapters2, ns = "bookdown")

