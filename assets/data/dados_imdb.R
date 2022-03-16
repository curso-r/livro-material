# install.packages("devtools")
# devtools::install_github("curso-r/basesCursoR")

# Quais são as bases disponíveis no basesCursoR?
basesCursoR::bases_disponiveis()

# Salvar a base imdb em um objeto
imdb <- basesCursoR::pegar_base("imdb")
# imdb_avaliacoes <- basesCursoR::pegar_base("imdb_avaliacoes")

imdb <- imdb  |>
  dplyr::select(-titulo)  |>
  dplyr::rename(titulo = titulo_original)  |>
  dplyr::filter(pais == "USA") |>
  dplyr::filter(num_avaliacoes > 1000)

# Salvar o imdb localmente
readr::write_csv2(imdb, "assets/data/imdb2.csv")
readr::write_csv(imdb, "assets/data/imdb.csv")
readr::write_rds(imdb, "assets/data/imdb.rds")
readr::write_tsv(imdb, "assets/data/imdb.txt")
readr::write_tsv(imdb, "assets/data/imdb.tsv")
writexl::write_xlsx(imdb, "assets/data/imdb.xlsx")
writexl::write_xlsx(imdb, "assets/data/imdb.xls")
haven::write_sas(imdb, "assets/data/imdb.sas7bdat")
haven::write_sav(imdb, "assets/data/imdb.sav")
haven::write_dta(imdb, "assets/data/imdb.dta")
jsonlite::write_json(imdb, "assets/data/imdb.json")

# salvar o sqlite
con <- DBI::dbConnect(RSQLite::SQLite(), dbname = "assets/data/imdb.sqlite")
RSQLite::dbWriteTable(con, "imdb", imdb,  overwrite = TRUE)
DBI::dbListTables(con)

# testando se o sqlite dá pra ser aberto
# con <- RSQLite::dbConnect(RSQLite::SQLite(), "assets/data/imdb.sqlite")
# imdb_tbl <- dplyr::tbl(con, "imdb")
# imdb <- dplyr::collect(imdb_tbl)
# DBI::dbListTables(con)

#.zip - arquivo com os vários imdb
arquivos_para_zipar <- list.files(path = "assets/data",
           pattern = "imdb", full.names = TRUE) |>
  tibble::enframe() |>
  dplyr::filter(!stringr::str_detect(value, ".R$|.zip$"))

utils::zip("assets/data/imdb.zip", files = arquivos_para_zipar$value)

# readr::write_rds(imdb_avaliacoes, "assets/data/imdb_avaliacoes.rds")

