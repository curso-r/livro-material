

## NSE


```r
library(dplyr)
library(ggplot2)
```

**1.** Escreva uma função que recebe uma *tibble* e uma coluna qualquer e devolve uma *tibble* sem as linhas contendo `NA` na coluna especificada.


```r
tabela_qualquer <- tibble::tibble(
  x = c(1, 2, 3, NA, 6),
  y = c("a", "b", NA, "d", "e")
)

filtrar_na <- function(tab, coluna) {
  tab %>%
    filter(!is.na({{coluna}}))
}

filtrar_na(tabela_qualquer, x)
## # A tibble: 4 x 2
##       x y    
##   <dbl> <chr>
## 1     1 a    
## 2     2 b    
## 3     3 <NA> 
## 4     6 e
filtrar_na(tabela_qualquer, y)
## # A tibble: 4 x 2
##       x y    
##   <dbl> <chr>
## 1     1 a    
## 2     2 b    
## 3    NA d    
## 4     6 e


# string como argumento
filtrar_na <- function(tab, coluna) {
  tab %>%
    filter(!is.na(.data[[coluna]]))
}

filtrar_na(tabela_qualquer, "x")
## # A tibble: 4 x 2
##       x y    
##   <dbl> <chr>
## 1     1 a    
## 2     2 b    
## 3     3 <NA> 
## 4     6 e
filtrar_na(tabela_qualquer, "y")
## # A tibble: 4 x 2
##       x y    
##   <dbl> <chr>
## 1     1 a    
## 2     2 b    
## 3    NA d    
## 4     6 e
```


---

**2.** Escreva uma função que recebe uma *tibble* e uma coluna e faz um gráfico de barras da frequência dessa coluna.


```r
criar_grafico <- function(tab, coluna) {
  tab %>%
    count({{coluna}}) %>%
    ggplot(aes(x = {{coluna}}, y = n)) +
    geom_col()
}

criar_grafico(mtcars, cyl)
```

<img src="9881-respostas-nse_files/figure-epub3/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

```r

# string como argumento
criar_grafico <- function(tab, coluna) {
  tab %>%
    count(.data[[coluna]]) %>%
    ggplot(aes(x = .data[[coluna]], y = n)) +
    geom_col()
}

criar_grafico(mtcars, "cyl")
```

<img src="9881-respostas-nse_files/figure-epub3/unnamed-chunk-4-2.png" style="display: block; margin: auto;" />


---

**3.** Escreva uma função que recebe uma *tibble* e o nome de duas colunas numéricas e faz um gráfico de dispersão dessas colunas.


```r
fazer_grafico_disp <- function(tab, col1, col2) {
  tab %>% 
    ggplot(aes(x = {{col1}}, y = {{col2}})) +
    geom_point()
}

fazer_grafico_disp(mtcars, mpg, wt)
```

<img src="9881-respostas-nse_files/figure-epub3/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

```r


# string como argumento

fazer_grafico_disp <- function(tab, col1, col2) {
  tab %>% 
    ggplot(aes(x = .data[[col1]], y = .data[[col2]])) +
    geom_point()
}

fazer_grafico_disp(mtcars, "mpg", "wt")
```

<img src="9881-respostas-nse_files/figure-epub3/unnamed-chunk-5-2.png" style="display: block; margin: auto;" />


---

**4.** Escreva uma função que recebe uma *tibble*, o nome de uma coluna categótica e o nome de uma coluna numérica e devolva uma tabela com a média da coluna numérica para cada categoria da coluna categórica.


```r
calcular_media <- function(tab, col_grupo, col_num) {
  tab %>% 
    group_by({{col_grupo}}) %>% 
    summarise(media = mean({{col_num}}, na.rm = TRUE))
}

calcular_media(mtcars, cyl, mpg)
## # A tibble: 3 x 2
##     cyl media
##   <dbl> <dbl>
## 1     4  26.7
## 2     6  19.7
## 3     8  15.1


# string como argumento
calcular_media <- function(tab, col_grupo, col_num) {
  tab %>% 
    group_by(.data[[col_grupo]]) %>% 
    summarise(media = mean(.data[[col_num]], na.rm = TRUE))
}

calcular_media(mtcars, "cyl", "mpg")
## # A tibble: 3 x 2
##     cyl media
##   <dbl> <dbl>
## 1     4  26.7
## 2     6  19.7
## 3     8  15.1
```

