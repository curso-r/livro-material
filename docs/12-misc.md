# Miscelânea {#misc}


## Arrumando banco de dados: o pacote janitor

O pacote [`janitor`](https://garthtarr.github.io/meatR/janitor.html) disponibiliza algumas funções para limpar bases de dados.

Primeiramente, instale e carregue o pacote:


```r
install.packages("janitor") # Instale a versão do CRAN, OU:

devtools::install_github("sfirke/janitor") # Versão de desenvolvimento
```


```r
library(tidyverse)
library(janitor)
```

### Arrumando o nome das variáveis

Utilizaremos a base com informações de pacientes com arritmia cardíaca. O código para obter essa base de exemplo está descrito abaixo:






```r
# URL da base para baixar
url <- "https://github.com/curso-r/livro-material/raw/master/assets/data/dados_nomes_variaveis_livro.xlsx"

# Arquivo de destino onde a base deverá ser salva
destfile <- "dados_nomes_variaveis_livro.xlsx"

# Fazer o download da base
curl::curl_download(url, destfile)

# Importar a base 
dados_brutos <- readxl::read_excel(destfile)
```

As variáveis presentes na base são:

```r
dados_brutos %>% names() # Ver o nome das variáveis
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

Os nomes das variáveis contém letras maiúsculas, acentos, parênteses, pontos e barras, o que atrapalha na hora da programação. Para resolver esse problema, usamos a função `clean_names()`.


```r
dados_brutos %>% 
  janitor::clean_names() %>% # Limpar os nomes das variáveis
  names() # Ver o nome das variáveis
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

Veja que a função removeu os parênteses, pontos e barras e substituiu os espaços por `_`. 


E para substituir na base, precisamos atribuir o resultado em um novo objeto:


```r
dados <- dados_brutos %>% 
  janitor::clean_names() # Limpar os nomes das variáveis
```

### Removendo linhas e colunas vazias


Esse banco de dados também contém outro problema: linhas vazias. Na verdade, elas não eram completamente vazias, pois havia algumas informações de identificação de pacientes, mas nenhuma outra variável tinha sido computada.


```r
dados %>% 
  dplyr::slice(3) %>% # Apresentar apenas a linha 3
  knitr::kable()
```



| id|sexo |nascimento | idade|inclusao |cor | peso| altura|cintura | imc|superficie_corporal |tabagismo | cg_tabag_cig_dia| alcool_dose_semana|drogas_ilicitas | cafeina_dia| refrig_dia|sedentario |ativ_fisica |
|--:|:----|:----------|-----:|:--------|:---|----:|------:|:-------|---:|:-------------------|:---------|----------------:|------------------:|:---------------|-----------:|----------:|:----------|:-----------|
|  3|NA   |NA         |    NA|NA       |NA  |   NA|     NA|NA      |  NA|NA                  |NA        |               NA|                 NA|NA              |          NA|         NA|NA         |NA          |

Para resolver o problema, é possível utilizar a função `remove_empty()`.


```r
dados_sem_linhas_vazias <- dados %>% 
  as.data.frame() %>% 
  dplyr::select(-id) %>% 
  janitor::remove_empty() %>% 
  tibble::rowid_to_column("id") %>% 
  dplyr::select(id, everything()) %>%
  tibble::as_tibble()

dados_sem_linhas_vazias %>% knitr::kable()
```



| id|sexo |nascimento | idade|inclusao   |cor    | peso| altura|cintura |      imc|superficie_corporal |tabagismo | cg_tabag_cig_dia| alcool_dose_semana|drogas_ilicitas | cafeina_dia| refrig_dia|sedentario |ativ_fisica  |
|--:|:----|:----------|-----:|:----------|:------|----:|------:|:-------|--------:|:-------------------|:---------|----------------:|------------------:|:---------------|-----------:|----------:|:----------|:------------|
|  1|F    |1964-01-31 |    41|2006-02-17 |branca |   75|   1.63|98      | 28.22839|1.81                |N         |                0|                  0|N               |         100|          0|S          |N            |
|  2|M    |1959-01-28 |    45|2005-11-29 |negra  |   71|   1.70|NT      | 24.57000|1.83                |N         |                0|                 35|N               |          50|        300|N          |insuficiente |
|  3|M    |1957-09-13 |    50|2008-02-13 |NT     |   80|   1.64|NT      | 29.74420|1.87                |N         |                0|                  0|N               |         500|          0|S          |N            |
|  4|F    |1938-02-06 |    71|2009-06-25 |parda  |   56|   1.51|96      | 24.56033|1,51                |N         |                0|                  0|N               |          50|          0|S          |N            |

Foi necessário converter para `data.frame` primeiro porque não é possível definir os nomes das linhas de uma `tibble`. Se a linha estivesse completamente vazia, bastaria usar diretamente a função `remove_empty_rows()`.

Equivalentemente para colunas, existe a função `remove_empty_cols()`.

Outra forma de realizar este mesmo procedimento é utilizando a função `drop_na()` do pacote `tidyr`:


```r
dados_sem_linhas_vazias <- dados %>% 
  tidyr::drop_na(-id) %>%
  dplyr::select(-id) %>% 
  tibble::rowid_to_column("id") %>% 
  dplyr::relocate(id, .before = sexo)

dados_sem_linhas_vazias %>% knitr::kable()
```



| id|sexo |nascimento | idade|inclusao   |cor    | peso| altura|cintura |      imc|superficie_corporal |tabagismo | cg_tabag_cig_dia| alcool_dose_semana|drogas_ilicitas | cafeina_dia| refrig_dia|sedentario |ativ_fisica  |
|--:|:----|:----------|-----:|:----------|:------|----:|------:|:-------|--------:|:-------------------|:---------|----------------:|------------------:|:---------------|-----------:|----------:|:----------|:------------|
|  1|F    |1964-01-31 |    41|2006-02-17 |branca |   75|   1.63|98      | 28.22839|1.81                |N         |                0|                  0|N               |         100|          0|S          |N            |
|  2|M    |1959-01-28 |    45|2005-11-29 |negra  |   71|   1.70|NT      | 24.57000|1.83                |N         |                0|                 35|N               |          50|        300|N          |insuficiente |
|  3|M    |1957-09-13 |    50|2008-02-13 |NT     |   80|   1.64|NT      | 29.74420|1.87                |N         |                0|                  0|N               |         500|          0|S          |N            |
|  4|F    |1938-02-06 |    71|2009-06-25 |parda  |   56|   1.51|96      | 24.56033|1,51                |N         |                0|                  0|N               |          50|          0|S          |N            |



### Identificando linhas duplicadas

O pacote `janitor` possui uma função para identificar entradas duplicadas numa base de dados: `get_dupes()`. Vamos criar uma base genérica para testá-la.


```r
# Criar a base de exemplo
p_nome <- c("Athos", "Daniel", "Fernando", "Julio", "William")
sobrenome <- c("Damiani", "Falbel", "Corrêa", "Trecenti", "Amorim")

base_exemplo <- tibble::tibble(
  nome = sample(p_nome, 25, replace = TRUE),
  sobrenome = sample(sobrenome, 25, replace = TRUE),
  variavel_importante = rnorm(25)
)
# Dar uma espiada na base de exemplo
dplyr::glimpse(base_exemplo)
```

```
## Rows: 25
## Columns: 3
## $ nome                <chr> "Athos", "Athos", "Athos", "Athos", "Daniel", "Dan…
## $ sobrenome           <chr> "Falbel", "Damiani", "Amorim", "Damiani", "Trecent…
## $ variavel_importante <dbl> -0.07942386, 0.12279630, 0.31136766, -1.92171731, …
```

```r
# Ver as duplicatas com a função get_dupes()
janitor::get_dupes(base_exemplo, nome, sobrenome)
```

```
## # A tibble: 16 × 4
##    nome     sobrenome dupe_count variavel_importante
##    <chr>    <chr>          <int>               <dbl>
##  1 Athos    Damiani            3              0.123 
##  2 Athos    Damiani            3             -1.92  
##  3 Athos    Damiani            3             -1.15  
##  4 Daniel   Corrêa             2              0.449 
##  5 Daniel   Corrêa             2              1.00  
##  6 Daniel   Trecenti           2              0.513 
##  7 Daniel   Trecenti           2             -0.848 
##  8 Fernando Amorim             3              0.387 
##  9 Fernando Amorim             3              0.0357
## 10 Fernando Amorim             3              0.147 
## 11 Julio    Falbel             2             -1.60  
## 12 Julio    Falbel             2              1.14  
## 13 William  Amorim             2              1.63  
## 14 William  Amorim             2             -0.0369
## 15 William  Falbel             2              0.193 
## 16 William  Falbel             2             -2.55
```

Todas as linhas na `tibble` resultante representam uma combinação de nome-sobrenome repetida.

### Outras funções

Por fim, o `janitor` também tem funções equivalentes à `table()` para produzir tabelas de frequência:

- `tabyl()` - similar a `table()`, mas *pipeável* e com mais recursos.
- `adorn_totals()` - acrescenta o total das linhas ou colunas.



```r
# Fazer uma tabela de frequência
mtcars %>% janitor::tabyl(cyl)
```

```
##  cyl  n percent
##    4 11 0.34375
##    6  7 0.21875
##    8 14 0.43750
```

```r
# Fazer uma tabela de frequência com valores totais,
# e porcentagem
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
# Fazer uma tabela de frequência com duas variáveis,
# e valores totais
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

Esperamos que essas dicas e o pacote `janitor` ajudem a agilizar as suas análises!


<!-- Criar outro exemplo para usar o abjutils::rm_accent() -->
