# caso nao tenha instalado os pacotes, use o arquivo packages.R
bookdown::render_book("index.Rmd", "bookdown::gitbook")
bookdown::render_book("index.Rmd", "bookdown::pdf_book")
bookdown::render_book("index.Rmd", "bookdown::epub_book")
system("cd docs/; ebook-convert livro-curso-r.epub livro-curso-r.mobi")
