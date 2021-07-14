

## Programação funcional (purrr)


```r
library(dplyr)
library(purrr)
library(ggplot2)
```

**1.** Utilize a função `map()` para calcular a média de cada coluna da base `mtcars`.


```r
map(mtcars, mean)
## $mpg
## [1] 20.09062
## 
## $cyl
## [1] 6.1875
## 
## $disp
## [1] 230.7219
## 
## $hp
## [1] 146.6875
## 
## $drat
## [1] 3.596563
## 
## $wt
## [1] 3.21725
## 
## $qsec
## [1] 17.84875
## 
## $vs
## [1] 0.4375
## 
## $am
## [1] 0.40625
## 
## $gear
## [1] 3.6875
## 
## $carb
## [1] 2.8125
```


---

**2.** Use a função `map()` para testar se cada elemento do vetor `letters` é uma vogal ou não. Dica: você precisará criar uma função para testar se é uma letra é vogal. Faça o resultado ser (a) uma lista de `TRUE/FALSE` e (b) um vetor de `TRUE/FALSE`.


```r
testar_vogal <- function(x) {
  if(x %in% c("a", "e", "i", "o", "u")) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# retornando uma lista
map(letters, testar_vogal)
## [[1]]
## [1] TRUE
## 
## [[2]]
## [1] FALSE
## 
## [[3]]
## [1] FALSE
## 
## [[4]]
## [1] FALSE
## 
## [[5]]
## [1] TRUE
## 
## [[6]]
## [1] FALSE
## 
## [[7]]
## [1] FALSE
## 
## [[8]]
## [1] FALSE
## 
## [[9]]
## [1] TRUE
## 
## [[10]]
## [1] FALSE
## 
## [[11]]
## [1] FALSE
## 
## [[12]]
## [1] FALSE
## 
## [[13]]
## [1] FALSE
## 
## [[14]]
## [1] FALSE
## 
## [[15]]
## [1] TRUE
## 
## [[16]]
## [1] FALSE
## 
## [[17]]
## [1] FALSE
## 
## [[18]]
## [1] FALSE
## 
## [[19]]
## [1] FALSE
## 
## [[20]]
## [1] FALSE
## 
## [[21]]
## [1] TRUE
## 
## [[22]]
## [1] FALSE
## 
## [[23]]
## [1] FALSE
## 
## [[24]]
## [1] FALSE
## 
## [[25]]
## [1] FALSE
## 
## [[26]]
## [1] FALSE

# retornando um vetor (2 soluções equivalentes)
map(letters, testar_vogal) %>% flatten_lgl()
##  [1]  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [13] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [25] FALSE FALSE
map_lgl(letters, testar_vogal)
##  [1]  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [13] FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE
## [25] FALSE FALSE
```


---

**3** Faça uma função que divida um número por 2 se ele for par ou multiplique ele por 2 caso seja ímpar. Utilize uma função `map` para aplicar essa função ao vetor `1:100`. O resultado do código deve ser um vetor numérico.


```r
operacao <- function(x) {
  if (x %% 2 == 0) {
    return(x / 2)
  } else {
    return(x * 2)
  }
}

operacao(2)
## [1] 1
operacao(3)
## [1] 6

map_dbl(1:100, operacao)
##   [1]   2   1   6   2  10   3  14   4  18   5  22   6  26   7  30   8  34   9
##  [19]  38  10  42  11  46  12  50  13  54  14  58  15  62  16  66  17  70  18
##  [37]  74  19  78  20  82  21  86  22  90  23  94  24  98  25 102  26 106  27
##  [55] 110  28 114  29 118  30 122  31 126  32 130  33 134  34 138  35 142  36
##  [73] 146  37 150  38 154  39 158  40 162  41 166  42 170  43 174  44 178  45
##  [91] 182  46 186  47 190  48 194  49 198  50
```

---

**4.** Use a função `map()` para criar gráficos de dispersão da receita vs orçamento para os filmes da base `imdb`. Os filmes de cada ano deverão compor um gráfico diferente. Faça o resultado ser (a) uma lista de gráficos e (b) uma nova coluna na base `imdb` (utilizando a função `tidyr::nest()`).


```r
imdb <- readr::read_rds("imdb.rds")

# gerando uma lista de gráficos

fazer_grafico <- function(tab, ano_) {
  tab %>% 
    filter(ano == ano_) %>% 
    ggplot(aes(x = orcamento, y = receita)) +
    geom_point()
}

anos <- unique(imdb$ano)

graficos <- map(anos, fazer_grafico, tab = imdb)

# gerando uma coluna na tabela imdb
fazer_grafico2 <- function(tab) {
  tab %>% 
    ggplot(aes(x = orcamento, y = receita)) +
    geom_point()
}


imdb_com_graficos <- imdb %>% 
  group_by(ano) %>% 
  tidyr::nest() %>% 
  mutate(
    grafico = map(data, fazer_grafico2)
  )
```


---

**5.** Utilize a função `walk` para salvar cada ano da base `imdb` em um arquivo `.rds` diferente, isto é, o arquivo `imdb_2001.rds`, por exemplo, deve conter apenas filmes do ano de 2001.


```r
imdb <- readr::read_rds("imdb.rds")

salvar_base <- function(tab, ano_) {
  tab %>% 
    filter(ano == ano_) %>% 
    readr::write_rds(file = paste0("teste/imdb_", ano_, ".rds"))
}

anos <- imdb %>% 
  filter(!is.na(ano)) %>% 
  pull(ano)

walk(anos, salvar_base, tab = imdb)
```

