# R avançado {#ravancado}

Neste capítulo, abordaremos alguns assuntos avançados, porém muito úteis no dia-a-dia de quem faz Ciência de Dados no R. 




## NSE

Se o `{tidyverse}` é o conjunto mais incrível de pacotes, faz sentido querermos criar nossos pacotes e fazer nossas análises usando seus princípios. Funções cujo primeiro argumento é um _data frame_ e operações "pipeáveis" são apenas o começo.

Uma das características mais marcantes do `{tidyverse}` é a possibilidade de trabalhar com colunas como se elas fossem objetos comuns, criados fora da função. Basta pensar na `mutate()`: como ela sabe que `mpg` é uma coluna da tabela e não um objeto externo com o mesmo nome?

Existe uma ferramenta especial (e exclusiva ao R!) que nos permite fazer esse tipo de mágica: a _non-standard evaluation_ (NSE) ou, em português, a avaliação não-padrão. Usamos NSE desde a primeira vez que escrevemos o comando `library()`, mas o seu funcionamento ainda é um mistério para a maioria.

Para criar funções flexíveis e enxutas como as do `{tidyverse}`, é necessário entender o básico da NSE e de como trabalhar com alguns operadores desse novo mundo.

### O que é?

_Non-standard evaluation_ é uma propriedade do R que permite capturar o seu código sem avaliá-lo. Isso mesmo: o R deixa de ser uma caixa para a qual nós enviamos comandos a serem executados e passa a ter a capacidade de **interpretar e trabalhar** os próprios comandos. Genericamente isso se chama **metaprogramação**.


```r
# O objeto 'dplyr' simplesmente não existe...
dplyr
```

```
## Error in eval(expr, envir, enclos): object 'dplyr' not found
```

```r
# Por que então esse comando funciona?
library(dplyr)
```

Na chamada `library()` acima, a palavra "dplyr" não se refere a nenhum objeto! O R consegue ler o código que nós escrevemos e agir em cima dessa informação. Apesar de ser comum para nós, outras linguagens são incapazes de fazer isso por causa da forma com que elas tratam seus argumentos.

O R tem o que chamamos de avaliação tardia (_delayed evaluation_), ou seja, uma expressão só é avaliada quando ela é necessária e não logo que ela é criada. No R, `print(1 + 2)` é diferente de `print(3)`, mas nas outras linguagens isso não é o caso!

### Tidy evaluation

A faceta da NSE que nos interessa no momento é a chamada _tidy evaluation_, ou **tidy eval**, a avaliação não-padrão utilizada pelas funções do `{tidyverse}` e outros pacotes feitos para trabalhar com o mesmo paradigma.

- O mundo sem tidy eval é extremamente verborrágico, pois a tabela precisa ser especificada toda vez que nos referirmos a uma coluna:


```r
starwars[starwars$homeworld == "Naboo" & starwars$species == "Human", ]
```

- Para não precisar do `$`, a nossa única saída é criar objetos com as colunas:


```r
homeworld <- starwars$homeworld; species <- starwars$species
starwars[homeworld == "Naboo" & species == "Human", ]
```

- O `{tidyverse}` permite criar um "mini ambiente" em que as colunas da tabela estão disponíveis como se fossem objetos declarados explicitamente:


```r
filter(starwars, homeworld == "Naboo", species == "Human")
```

O problema de capturar o código sem avaliá-lo é que fica difícil avaliar algo antes que ele seja capturado.


```r
# O código 'birth_year' é capturado
starwars %>% filter(is.na(birth_year)) %>% nrow()
```

```
## [1] 44
```

```r
# O objetivo é filtrar uma coluna especificada pelo usuário
filter_na <- function(df, col) {
  filter(df, is.na(col))
}

# A função captura o código 'col'
starwars %>% filter_na(col = birth_year) %>% nrow()
```

```
## Error: Problem with `filter()` input `..1`.
## ℹ Input `..1` is `is.na(col)`.
## x object 'birth_year' not found
```

### Curly-curly

O operador que vai resolver nosso problema é o `{{ }}` (lê-se _curly curly_), que permite interpolar o código, ou seja, avaliá-lo antes da captura.


```r
# O objetivo é filtrar uma coluna especificada pelo usuário
filter_na <- function(df, col) {
  filter(df, is.na( {{col}} ))
}

# Agora a função captura o código 'birth_year'
starwars %>% filter_na(col = birth_year) %>% nrow()
```

```
## [1] 44
```

Essa sintaxe vem da interpolação de strings:


```r
col <- "birth_year"
stringr::str_glue("Interpolando '{col}'!")
```

```
## Interpolando 'birth_year'!
```


Para passar múltiplos argumentos nem é necessário usar o curly-curly já que a reticência já possui as capacidades de tidy eval:


```r
# O objetivo é permitir vários cálculos
summarise_by <- function(df, ..., by) {
  df %>%
    group_by( {{by}} ) %>%
    summarise(...)
}
  
starwars %>%
  summarise_by(
    media = mean(height, na.rm = TRUE),
    maximo = max(height, na.rm = TRUE),
    by = gender
  )
```


Note como não houve necessidade de interpolar `media` e `maximo`: a
`summarise()` não tentou criar uma coluna chamada `...`.

### Strings como argumentos

E se quisermos passar strings para as funções do `{tidyverse}`? Se pedirmos o nome de uma coluna para um usuário, a resposta virá como string.


```r
# O objetivo é dar um nome para a média
summarise_mean <- function(df, nome, col) {
  summarise(df, nome = mean(col, na.rm = TRUE))
}

# É criada uma coluna 'nome' sem valor ('col' não existe)
summarise_mean(starwars, "media", "height")
```

```
## Warning in mean.default(col, na.rm = TRUE): argument is not numeric or logical:
## returning NA
```

```
## # A tibble: 1 × 1
##    nome
##   <dbl>
## 1    NA
```

Quando o "lado esquerdo" (**antes de um igual**) de uma expressão com tidy eval é uma string (ou se tornará uma quando avaliado), precisamos apenas usar o operador `:=` (lê-se _walrus_, "morsa"):


```r
# O objetivo é dar um nome para a média
summarise_mean <- function(df, nome, col) {
  summarise(df, {{nome}} := mean(col, na.rm = TRUE))
}

# É criada uma coluna 'media' sem valor ('col' não existe)
summarise_mean(starwars, "media", "height")
```

```
## Warning in mean.default(col, na.rm = TRUE): argument is not numeric or logical:
## returning NA
```

```
## # A tibble: 1 × 1
##   media
##   <dbl>
## 1    NA
```

Quando uma string (ou algo que se tornará uma quando avaliado) está no "lado direito" (**depois de um igual ou quando não há igual**) de uma expressão com tidy eval, precisamos apenas usar o pronome `.data`:


```r
# O objetivo é dar um nome para a média
summarise_mean <- function(df, nome, col) {
  summarise(df, {{nome}} := mean(.data[[col]], na.rm = TRUE))
}

# É criada uma coluna 'media' com a média de 'height'
summarise_mean(starwars, "media", "height")
```

```
## # A tibble: 1 × 1
##   media
##   <dbl>
## 1  174.
```

É como se estivéssemos chamando `df[["height"]]`, mas, como `df` não faria sentido dentro da expressão, usamos `.data`.

### Exercícios

**1.** Escreva uma função que recebe uma *tibble* e uma coluna qualquer
e devolve uma *tibble* sem as linhas contendo `NA` na coluna especificada.

**2.** Escreva uma função que recebe uma *tibble* e uma coluna e faz um gráfico de barras da frequência dessa coluna.

**3.** Escreva uma função que recebe uma *tibble* e o nome de duas colunas numéricas e faz um gráfico de dispersão dessas colunas.

**4.** Escreva uma função que recebe uma *tibble*, o nome de uma coluna categótica e o nome de uma coluna numérica e devolva uma tabela com a média da coluna numérica para cada categoria da coluna categórica.

