# Miscelânea {#misc}


## Arrumando banco de dados: o pacote janitor

Vamos falar do pacote `janitor`, que traz algumas funções para dar aquele trato nas BDs.

Antes de mais nada, instale e carregue o pacote:


```r
install.packages("janitor")
devtools::install_github("sfirke/janitor") # Versão de desenvolvimento
```


```r
library(tidyverse)
```

```
## Warning: package 'tidyverse' was built under R version 4.0.2
```

```r
library(janitor)
```

```
## Warning: package 'janitor' was built under R version 4.0.2
```

### Arrumando o nome das variáveis

Assim como no post passado, utilizaremos a base com informações de pacientes com arritmia cardíaca, cujas variáveis selecionadas foram:





```r
dados %>% names()
```

```
##  [1] "ID"                   "Sexo"                 "Nascimento"          
##  [4] "Idade"                "Inclusão"             "Cor"                 
##  [7] "Peso"                 "Altura"               "cintura"             
## [10] "IMC"                  "Superfície corporal"  "Tabagismo"           
## [13] "cg.tabag (cig/dia)"   "Alcool (dose/semana)" "Drogas ilícitas"     
## [16] "Cafeína/dia"          "Refrig/dia"           "Sedentario"          
## [19] "ativ. Fisica"
```

Os nomes têm letras maiúsculas, acentos, parênteses, pontos e barras, o que atrapalha na hora da programação. Para resolver esse problema, usamos a função `clean_names()`.


```r
dados %>% 
  janitor::clean_names() %>% 
  names()
```

```
##  [1] "id"                  "sexo"                "nascimento"         
##  [4] "idade"               "inclusao"            "cor"                
##  [7] "peso"                "altura"              "cintura"            
## [10] "imc"                 "superficie_corporal" "tabagismo"          
## [13] "cg_tabag_cig_dia"    "alcool_dose_semana"  "drogas_ilicitas"    
## [16] "cafeina_dia"         "refrig_dia"          "sedentario"         
## [19] "ativ_fisica"
```

Veja que a função removeu os parênteses, pontos e barras e substituiu os espaços por `_`. No entanto, ela não remove os acentos. Assim, podemos adicionar mais uma linha ao pipeline para chegar onde queremos.


```r
dados %>%
  janitor::clean_names() %>% 
  names() %>% 
  abjutils::rm_accent()
```

```
##  [1] "id"                  "sexo"                "nascimento"         
##  [4] "idade"               "inclusao"            "cor"                
##  [7] "peso"                "altura"              "cintura"            
## [10] "imc"                 "superficie_corporal" "tabagismo"          
## [13] "cg_tabag_cig_dia"    "alcool_dose_semana"  "drogas_ilicitas"    
## [16] "cafeina_dia"         "refrig_dia"          "sedentario"         
## [19] "ativ_fisica"
```

E para substituir na base.


```r
nomes <- dados %>%
  janitor::clean_names() %>% 
  names() %>% 
  abjutils::rm_accent()

names(dados) <- nomes
```

### Removendo linhas e colunas vazias



Esse banco de dados também tinha outro problema: linhas vazias. Na verdade, elas não eram completamente vazias, pois havia algumas informações de identificação do paciente, mas nenhuma outra variável tinha sido computada.


```r
dados[3,]
```

```
## # A tibble: 1 x 19
##      id sexo  nascimento          idade inclusao            cor    peso altura
##   <int> <chr> <dttm>              <dbl> <dttm>              <chr> <dbl>  <dbl>
## 1     3 <NA>  NA                     NA NA                  <NA>     NA     NA
## # … with 11 more variables: cintura <chr>, imc <dbl>,
## #   superficie_corporal <chr>, tabagismo <chr>, cg_tabag_cig_dia <dbl>,
## #   alcool_dose_semana <dbl>, drogas_ilicitas <chr>, cafeina_dia <dbl>,
## #   refrig_dia <dbl>, sedentario <chr>, ativ_fisica <chr>
```

Essa foi a solução que eu pensei para resolver o problema utilizando a função `remove_empty()`.


```r
dados <- dados %>% 
  as.data.frame %>% 
  dplyr::select(-id) %>% 
  janitor::remove_empty() %>% 
  tibble::rownames_to_column("id") %>% 
  dplyr::select(id, everything())
```

```
## value for "which" not specified, defaulting to c("rows", "cols")
```

```r
dados %>% tibble::as_tibble()
```

```
## # A tibble: 4 x 19
##   id    sexo  nascimento          idade inclusao            cor    peso altura
##   <chr> <chr> <dttm>              <dbl> <dttm>              <chr> <dbl>  <dbl>
## 1 1     F     1964-01-31 00:00:00    41 2006-02-17 00:00:00 bran…    75   1.63
## 2 2     M     1959-01-28 00:00:00    45 2005-11-29 00:00:00 negra    71   1.7 
## 3 4     M     1957-09-13 00:00:00    50 2008-02-13 00:00:00 NT       80   1.64
## 4 5     F     1938-02-06 00:00:00    71 2009-06-25 00:00:00 parda    56   1.51
## # … with 11 more variables: cintura <chr>, imc <dbl>,
## #   superficie_corporal <chr>, tabagismo <chr>, cg_tabag_cig_dia <dbl>,
## #   alcool_dose_semana <dbl>, drogas_ilicitas <chr>, cafeina_dia <dbl>,
## #   refrig_dia <dbl>, sedentario <chr>, ativ_fisica <chr>
```

Eu precisei converter para `data.frame` primeiro porque não é possível definir os nomes das linhas de uma `tibble`. Se a linha estivesse completamente vazia, bastaria usar diretamente a função `remove_empty_rows()`.

Equivalentemente para colunas, existe a função `remove_empty_cols()`.

### Identificando linhas duplicadas

O pacote `janitor` possui uma função para identificar entradas duplicadas numa base de dados: `get_dupes()`. Vamos criar uma base genérica para testá-la.


```r
p_nome <- c("Athos", "Daniel", "Fernando", "Julio", "William")
sobrenome <- c("Damiani", "Falbel", "Corrêa", "Trecenti", "Amorim")

base_qualquer <- tibble::tibble(
  nome = sample(p_nome, 25, replace = TRUE),
  sobrenome = sample(sobrenome, 25, replace = TRUE),
  variavel_importante = rnorm(25)
)

janitor::get_dupes(base_qualquer, nome, sobrenome)
```

```
## # A tibble: 12 x 4
##    nome     sobrenome dupe_count variavel_importante
##    <chr>    <chr>          <int>               <dbl>
##  1 Athos    Amorim             2             -0.946 
##  2 Athos    Amorim             2              0.105 
##  3 Daniel   Damiani            2              2.31  
##  4 Daniel   Damiani            2             -0.103 
##  5 Fernando Trecenti           2              0.824 
##  6 Fernando Trecenti           2              1.50  
##  7 Julio    Damiani            2             -0.336 
##  8 Julio    Damiani            2             -0.176 
##  9 Julio    Falbel             2             -0.0209
## 10 Julio    Falbel             2             -1.30  
## 11 William  Trecenti           2              0.656 
## 12 William  Trecenti           2              2.72
```

Todas as linhas na `tibble` resultante representam uma combinação de nome-sobrenome repetida.

### Outras funções

Por fim, o `janitor` também tem funções equivalentes à `table()` para produzir tabelas de frequência:

- `tabyl()` - similar a `table()`, mas pipe-ável e com mais recursos.
- `adorn_totals()` - acrescenta o total das linhas ou colunas.



```r
mtcars %>% janitor::tabyl(cyl)
```

```
##  cyl  n percent
##    4 11 0.34375
##    6  7 0.21875
##    8 14 0.43750
```

```r
mtcars %>% 
  janitor::tabyl(cyl) %>% 
  janitor::adorn_totals()
```

```
##    cyl  n percent
##      4 11 0.34375
##      6  7 0.21875
##      8 14 0.43750
##  Total 32 1.00000
```

```r
mtcars %>% 
  janitor::tabyl(cyl, am) %>% 
  janitor::adorn_totals(where = "col")
```

```
##  cyl  0 1 Total
##    4  3 8    11
##    6  4 3     7
##    8 12 2    14
```

É isso! Espero que essas dicas e o pacote `janitor` ajudem a agilizar as suas análises :)
