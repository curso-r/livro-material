## O pacote tidyr

O pacote `tidyr` dispõe de funções úteis para deixar os seus dados no formato que você precisa para a análise. Na maioria das vezes, utilizamos para deixá-los _tidy_. Outras, precisamos "bagunçá-los" um pouco para poder aplicar alguma função específica.

As principais funções deste pacote são a `gather()` e a `spread()`

-----------------------------------------------------

### `gather()`

A função `gather()` "empilha" o banco de dados. Ela é utilizada principalmente quando as colunas da base não representam nomes de variáveis, mas sim seus valores.




```r
library(tidyr)

imdb <- readr::read_rds("data/imdb.rds")

imdb_gather <- imdb %>%
  mutate(id = 1:n()) %>%
  gather(
    key = "importancia_ator",
    value = "nome_ator",
    ator_1, ator_2, ator_3
  ) %>%
  select(nome_ator, importancia_ator, everything())

imdb_gather
```

```
## # A tibble: 11,421 x 15
##    nome_ator importancia_ator titulo   ano diretor duracao cor   generos pais 
##    <chr>     <chr>            <chr>  <int> <chr>     <int> <chr> <chr>   <chr>
##  1 CCH Poun… ator_1           Avata…  2009 James …     178 Color Action… USA  
##  2 Johnny D… ator_1           Pirat…  2007 Gore V…     169 Color Action… USA  
##  3 Tom Hardy ator_1           The D…  2012 Christ…     164 Color Action… USA  
##  4 Daryl Sa… ator_1           John …  2012 Andrew…     132 Color Action… USA  
##  5 J.K. Sim… ator_1           Spide…  2007 Sam Ra…     156 Color Action… USA  
##  6 Brad Gar… ator_1           Tangl…  2010 Nathan…     100 Color Advent… USA  
##  7 Chris He… ator_1           Aveng…  2015 Joss W…     141 Color Action… USA  
##  8 Henry Ca… ator_1           Batma…  2016 Zack S…     183 Color Action… USA  
##  9 Kevin Sp… ator_1           Super…  2006 Bryan …     169 Color Action… USA  
## 10 Johnny D… ator_1           Pirat…  2006 Gore V…     151 Color Action… USA  
## # … with 11,411 more rows, and 6 more variables: classificacao <chr>,
## #   orcamento <int>, receita <int>, nota_imdb <dbl>, likes_facebook <int>,
## #   id <int>
```

-----------------------------------------------------

### `spread()`

A função `spread()` é essencialmente o inverso da `gather()`. Ela espalha uma variável nas colunas.


```r
imdb_spread <- imdb_gather %>%
  spread(
    key = importancia_ator,
    value = nome_ator
  )

imdb_spread
```

```
## # A tibble: 3,807 x 16
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
##  1 Avata…  2009 James …     178 Color Action… USA   A partir de … 237000000
##  2 Pirat…  2007 Gore V…     169 Color Action… USA   A partir de … 300000000
##  3 The D…  2012 Christ…     164 Color Action… USA   A partir de … 250000000
##  4 John …  2012 Andrew…     132 Color Action… USA   A partir de … 263700000
##  5 Spide…  2007 Sam Ra…     156 Color Action… USA   A partir de … 258000000
##  6 Tangl…  2010 Nathan…     100 Color Advent… USA   Livre         260000000
##  7 Aveng…  2015 Joss W…     141 Color Action… USA   A partir de … 250000000
##  8 Batma…  2016 Zack S…     183 Color Action… USA   A partir de … 250000000
##  9 Super…  2006 Bryan …     169 Color Action… USA   A partir de … 209000000
## 10 Pirat…  2006 Gore V…     151 Color Action… USA   A partir de … 225000000
## # … with 3,797 more rows, and 7 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, id <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

-----------------------------------------------------

### Outras funções do `tidyr`

- A função `unite()` junta duas ou mais colunas usando algum separador (`_`, por exemplo).

- A função `separate()` faz o inverso de `unite()`: transforma uma coluna em várias usando um separador.


```r
imdb %>%
  unite(
    col = "titulo_diretor",
    titulo, diretor,
    sep = " - "
  )
```

```
## # A tibble: 3,807 x 14
##    titulo_diretor   ano duracao cor   generos pais  classificacao orcamento
##    <chr>          <int>   <int> <chr> <chr>   <chr> <chr>             <int>
##  1 Avatar  - Jam…  2009     178 Color Action… USA   A partir de … 237000000
##  2 Pirates of th…  2007     169 Color Action… USA   A partir de … 300000000
##  3 The Dark Knig…  2012     164 Color Action… USA   A partir de … 250000000
##  4 John Carter  …  2012     132 Color Action… USA   A partir de … 263700000
##  5 Spider-Man 3 …  2007     156 Color Action… USA   A partir de … 258000000
##  6 Tangled  - Na…  2010     100 Color Advent… USA   Livre         260000000
##  7 Avengers: Age…  2015     141 Color Action… USA   A partir de … 250000000
##  8 Batman v Supe…  2016     183 Color Action… USA   A partir de … 250000000
##  9 Superman Retu…  2006     169 Color Action… USA   A partir de … 209000000
## 10 Pirates of th…  2006     151 Color Action… USA   A partir de … 225000000
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


```r
imdb %>%
  separate(
    col = generos,
    into = c("genero_1", "genero_2", "genero_3"),
    sep = "\\|",
    extra = "drop"
  )
```

```
## # A tibble: 3,807 x 17
##    titulo   ano diretor duracao cor   genero_1 genero_2 genero_3 pais 
##    <chr>  <int> <chr>     <int> <chr> <chr>    <chr>    <chr>    <chr>
##  1 Avata…  2009 James …     178 Color Action   Adventu… Fantasy  USA  
##  2 Pirat…  2007 Gore V…     169 Color Action   Adventu… Fantasy  USA  
##  3 The D…  2012 Christ…     164 Color Action   Thriller <NA>     USA  
##  4 John …  2012 Andrew…     132 Color Action   Adventu… Sci-Fi   USA  
##  5 Spide…  2007 Sam Ra…     156 Color Action   Adventu… Romance  USA  
##  6 Tangl…  2010 Nathan…     100 Color Adventu… Animati… Comedy   USA  
##  7 Aveng…  2015 Joss W…     141 Color Action   Adventu… Sci-Fi   USA  
##  8 Batma…  2016 Zack S…     183 Color Action   Adventu… Sci-Fi   USA  
##  9 Super…  2006 Bryan …     169 Color Action   Adventu… Sci-Fi   USA  
## 10 Pirat…  2006 Gore V…     151 Color Action   Adventu… Fantasy  USA  
## # … with 3,797 more rows, and 8 more variables: classificacao <chr>,
## #   orcamento <int>, receita <int>, nota_imdb <dbl>, likes_facebook <int>,
## #   ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

