# Manipulação 


> "(...) The fact that data science exists as a field is a colossal failure of statistics. To me, what I do is what statistics is all about. It is gaining insight from data using modelling and visualization. Data munging and manipulation is hard and statistics has just said that’s not our domain." - Hadley Wickham

Esta seção trata do tema *manipulação de dados*. Trata-se de uma tarefa dolorosa e demorada, tomando muitas vezes a maior parte do tempo de uma análise estatística. Essa etapa é essencial em qualquer análise de dados e, apesar de negligenciada pela academia, é decisiva para o sucesso de estudos aplicados.

Usualmente, o cientista de dados parte de uma base "crua" e a transforma até obter uma base de dados analítica, que, a menos de transformações simples, está preparada para passar por análises estatísticas.

A figura abaixo mostra a fase de "disputa" com os dados (*data wrangling*) para deixá-los no formato analítico.

<img src="img/manipulacao/ciclo-ciencia-de-dados.png" style="display: block; margin: auto;" />

Um conceito importante para obtenção de uma base analítica é o *data tidying*, ou arrumação de dados. Uma base é considerada *tidy* se

1. Cada linha da base representa uma observação.
2. Cada coluna da base representa uma variável.

A base de dados analítica é estruturada de tal forma que pode ser colocada diretamente em ambientes de modelagem estatística ou de visualização. Nem sempre uma base de dados analítica está no formato *tidy*, mas usualmente são necessários poucos passos para migrar de uma para outra. A filosofia *tidy* é a base do [tidyverse](https://www.tidyverse.org/).

Os principais pacotes encarregados da tarefa de estruturar os dados são o `dplyr` e o `tidyr`. Eles serão o tema desse tópico. Instale e carregue os pacotes utilizando:


```r
install.packages("dplyr")
install.packages("tidyr")

library(dplyr)
library(tidyr)
```

Mas antes de apresentar as principais funções do `dplyr` e do `tidyr`, precisamos falar sobre o conceito de `tibbles`.

## Trabalhando com tibbles

Uma `tibble` nada mais é do que um `data.frame`, mas com um método de impressão mais adequado. 

As `tibbles` são parte do pacote `tibble`. Assim, para começar a usá-las, instale e carregue o pacote.


```r
install.packages("tibble")
library(tibble)
```

Mais informações sobre `tibbles` podem ser encontradas [neste link](http://r4ds.had.co.nz/tibbles.html).

Nessa seção, vamos trabalhar com uma base de filmes do IMDB. Essa base pode ser baixada [clicando aqui](https://github.com/curso-r/site-v2/raw/master/content/material/importacao/data/imdb.rds).


```r
imdb <- readr::read_rds("data/imdb.rds")
```

Assim, utilizaremos o objeto `imdb` para acessar os dados.


```r
imdb
```

```
## # A tibble: 3,807 x 15
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
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

Veja que, por padrão, apenas as dez primeiras linhas da `tibble` são impressas na tela. Além disso, as colunas que não couberem na largura do console serão omitidas. Também são apresentadas a dimensão da tabela e as classes de cada coluna.
