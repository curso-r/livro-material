## O pacote dplyr {#dplyr}

O `dplyr` é o pacote mais útil para realizar transformação de dados, aliando simplicidade e eficiência de uma forma elegante. Os scripts em R que fazem uso inteligente dos verbos `dplyr` e as facilidades do operador _pipe_ tendem a ficar mais legíveis e organizados sem perder velocidade de execução.

As principais funções do `dplyr` são:

- `select()` - seleciona colunas
- `arrange()` - ordena a base
- `filter()` - filtra linhas
- `mutate()` - cria/modifica colunas
- `group_by()` - agrupa a base
- `summarise()` - sumariza a base

Todas essas funções seguem as mesmas características:

- O _input_  é sempre uma `tibble` e o _output_  é sempre um `tibble`.
- Colocamos a `tibble` no primeiro argumento e o que queremos fazer nos outros argumentos.
- A utilização é facilitada com o emprego do operador `%>%`.

As principais vantagens de se usar o `dplyr` em detrimento das funções do R base são:

- Manipular dados se torna uma tarefa muito mais simples.
- O código fica mais intuitivo de ser escrito e mais simples de ser lido.
- O pacote `dplyr` utiliza `C` e `C++` por trás da maioria das funções, o que geralmente torna o código mais rápido.
- É possível trabalhar com diferentes fontes de dados, como bases relacionais (SQL) e `data.table`.

Se você ainda não tiver o `dplyr` instalado, rode o código abaixo.


```r
install.packages("dplyr")
library(dplyr)
```

Neste capítulo, vamos trabalhar com uma base de filmes do IMDB. Essa base pode ser baixada [clicando aqui](https://github.com/curso-r/site-v2/raw/master/content/material/importacao/data/imdb.rds).

Assim, utilizaremos o objeto `imdb` para acessar os dados.





```r
imdb <- readr::read_rds("imdb.rds")
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


Agora, vamos avaliar com mais detalhes as principais funções do pacote `dplyr`.

### Selecionando colunas

Para selecionar colunas, utilizamos a função `select()`.

O primeiro argumento da função é a base de dados e os demais argumentos são os nomes das colunas que você gostaria de selecionar. Repare que você não precisa colocar o nome da coluna entre aspas.


```r
select(imdb, titulo)
```

```
## # A tibble: 3,807 x 1
##    titulo                                     
##    <chr>                                      
##  1 Avatar                                     
##  2 Pirates of the Caribbean: At World's End   
##  3 The Dark Knight Rises                      
##  4 John Carter                                
##  5 Spider-Man 3                               
##  6 Tangled                                    
##  7 Avengers: Age of Ultron                    
##  8 Batman v Superman: Dawn of Justice         
##  9 Superman Returns                           
## 10 Pirates of the Caribbean: Dead Man's Chest 
## # … with 3,797 more rows
```


Você também pode selecionar várias colunas.


```r
select(imdb, titulo, ano, orcamento)
```

```
## # A tibble: 3,807 x 3
##    titulo                                        ano orcamento
##    <chr>                                       <int>     <int>
##  1 Avatar                                       2009 237000000
##  2 Pirates of the Caribbean: At World's End     2007 300000000
##  3 The Dark Knight Rises                        2012 250000000
##  4 John Carter                                  2012 263700000
##  5 Spider-Man 3                                 2007 258000000
##  6 Tangled                                      2010 260000000
##  7 Avengers: Age of Ultron                      2015 250000000
##  8 Batman v Superman: Dawn of Justice           2016 250000000
##  9 Superman Returns                             2006 209000000
## 10 Pirates of the Caribbean: Dead Man's Chest   2006 225000000
## # … with 3,797 more rows
```

O operador `:` é muito útil para selecionar colunas consecutivas.


```r
select(imdb, titulo:cor)
```

```
## # A tibble: 3,807 x 5
##    titulo                                     ano diretor          duracao cor  
##    <chr>                                    <int> <chr>              <int> <chr>
##  1 Avatar                                    2009 James Cameron        178 Color
##  2 Pirates of the Caribbean: At World's En…  2007 Gore Verbinski       169 Color
##  3 The Dark Knight Rises                     2012 Christopher Nol…     164 Color
##  4 John Carter                               2012 Andrew Stanton       132 Color
##  5 Spider-Man 3                              2007 Sam Raimi            156 Color
##  6 Tangled                                   2010 Nathan Greno         100 Color
##  7 Avengers: Age of Ultron                   2015 Joss Whedon          141 Color
##  8 Batman v Superman: Dawn of Justice        2016 Zack Snyder          183 Color
##  9 Superman Returns                          2006 Bryan Singer         169 Color
## 10 Pirates of the Caribbean: Dead Man's Ch…  2006 Gore Verbinski       151 Color
## # … with 3,797 more rows
```


O `dplyr` possui o conjunto de funções auxiliares muito úteis para seleção de colunas. As principais são:

- `starts_with()`: para colunas que começam com um texto padrão
- `ends_with()`: para colunas que terminam com um texto padrão
- `contains()`: para colunas que contêm um texto padrão

Selecionamos a seguir todas as colunas que começam com o texto "ator".


```r
select(imdb, starts_with("ator"))
```

```
## # A tibble: 3,807 x 3
##    ator_1          ator_2            ator_3              
##    <chr>           <chr>             <chr>               
##  1 CCH Pounder     Joel David Moore  Wes Studi           
##  2 Johnny Depp     Orlando Bloom     Jack Davenport      
##  3 Tom Hardy       Christian Bale    Joseph Gordon-Levitt
##  4 Daryl Sabara    Samantha Morton   Polly Walker        
##  5 J.K. Simmons    James Franco      Kirsten Dunst       
##  6 Brad Garrett    Donna Murphy      M.C. Gainey         
##  7 Chris Hemsworth Robert Downey Jr. Scarlett Johansson  
##  8 Henry Cavill    Lauren Cohan      Alan D. Purwin      
##  9 Kevin Spacey    Marlon Brando     Frank Langella      
## 10 Johnny Depp     Orlando Bloom     Jack Davenport      
## # … with 3,797 more rows
```

Para retirar colunas da base, base acrescentar um `-` antes da seleção.


```r
imdb %>%
  select(-ano, - diretor)
```

```
## # A tibble: 3,807 x 13
##    titulo duracao cor   generos pais  classificacao orcamento receita nota_imdb
##    <chr>    <int> <chr> <chr>   <chr> <chr>             <int>   <int>     <dbl>
##  1 Avata…     178 Color Action… USA   A partir de … 237000000  7.61e8       7.9
##  2 Pirat…     169 Color Action… USA   A partir de … 300000000  3.09e8       7.1
##  3 The D…     164 Color Action… USA   A partir de … 250000000  4.48e8       8.5
##  4 John …     132 Color Action… USA   A partir de … 263700000  7.31e7       6.6
##  5 Spide…     156 Color Action… USA   A partir de … 258000000  3.37e8       6.2
##  6 Tangl…     100 Color Advent… USA   Livre         260000000  2.01e8       7.8
##  7 Aveng…     141 Color Action… USA   A partir de … 250000000  4.59e8       7.5
##  8 Batma…     183 Color Action… USA   A partir de … 250000000  3.30e8       6.9
##  9 Super…     169 Color Action… USA   A partir de … 209000000  2.00e8       6.1
## 10 Pirat…     151 Color Action… USA   A partir de … 225000000  4.23e8       7.3
## # … with 3,797 more rows, and 4 more variables: likes_facebook <int>,
## #   ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

```r
imdb %>%
  select(-starts_with("ator"))
```

```
## # A tibble: 3,807 x 12
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
## # … with 3,797 more rows, and 3 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>
```

#### Exercícios {-}

Utilize a base `imdb` nos exercícios a seguir.

**1.** Teste aplicar a função `glimpse()` do pacote `{dplyr}` à base `imdb`. O que ela faz?

**2.** Crie uma tabela com apenas as colunas `titulo`, `diretor`, e `orcamento.` Salve em um objeto chamado `imdb_simples`.

**3.** Selecione apenas as colunas `ator_1`, `ator_2` e `ator_3` usando o ajudante `contains()`.

**4.** Usando a função `select()` (e seus ajudantes), escreva códigos que retornem a base IMDB sem as colunas `ator_1`, `ator_2` e `ator_3.` Escreva todas as soluções diferentes que você conseguir pensar. 

### Ordenando a base

Para ordenar linhas, utilizamos a função `arrange()`. O primeiro argumento é a base de dados. Os demais argumentos são as colunas pelas quais queremos ordenar as linhas. No exemplo a seguir, ordenamos as linhas da base por ordem crescente de orçamento.


```r
arrange(imdb, orcamento)
```

```
## # A tibble: 3,807 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
##  1 Tarna…  2003 Jonath…      88 Color Biogra… USA   Outros              218
##  2 My Da…  2004 Jon Gu…      90 Color Docume… USA   Livre              1100
##  3 A Pla…  2013 Benjam…      76 Color Drama|… USA   Outros             1400
##  4 The M…  2005 Anthon…      84 Color Crime|… USA   A partir de …      3250
##  5 Prime…  2004 Shane …      77 Color Drama|… USA   A partir de …      7000
##  6 El Ma…  1992 Robert…      81 Color Action… USA   A partir de …      7000
##  7 Newly…  2011 Edward…      95 Color Comedy… USA   Outros             9000
##  8 Pink …  1972 John W…     108 Color Comedy… USA   A partir de …     10000
##  9 The T…  2007 Jane C…       7 Color Romanc… USA   Outros            13000
## 10 Paran…  2007 Oren P…      84 Color Horror  USA   A partir de …     15000
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

Também podemos ordenar de forma decrescente usando a função `desc()`.


```r
arrange(imdb, desc(orcamento))
```

```
## # A tibble: 3,807 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
##  1 Pirat…  2007 Gore V…     169 Color Action… USA   A partir de … 300000000
##  2 John …  2012 Andrew…     132 Color Action… USA   A partir de … 263700000
##  3 Tangl…  2010 Nathan…     100 Color Advent… USA   Livre         260000000
##  4 Spide…  2007 Sam Ra…     156 Color Action… USA   A partir de … 258000000
##  5 Spide…  2007 Sam Ra…     156 Color Action… USA   A partir de … 258000000
##  6 The D…  2012 Christ…     164 Color Action… USA   A partir de … 250000000
##  7 Aveng…  2015 Joss W…     141 Color Action… USA   A partir de … 250000000
##  8 Batma…  2016 Zack S…     183 Color Action… USA   A partir de … 250000000
##  9 Pirat…  2011 Rob Ma…     136 Color Action… USA   A partir de … 250000000
## 10 Capta…  2016 Anthon…     147 Color Action… USA   A partir de … 250000000
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


E claro, ordenar segundo duas ou mais colunas.


```r
arrange(imdb, desc(ano), desc(orcamento))
```

```
## # A tibble: 3,807 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
##  1 Batma…  2016 Zack S…     183 Color Action… USA   A partir de … 250000000
##  2 Capta…  2016 Anthon…     147 Color Action… USA   A partir de … 250000000
##  3 Star …  2016 Justin…     122 Color Action… USA   A partir de … 185000000
##  4 The L…  2016 David …     110 Color Action… USA   A partir de … 180000000
##  5 The L…  2016 David …     110 Color Action… USA   A partir de … 180000000
##  6 X-Men…  2016 Bryan …     144 Color Action… USA   A partir de … 178000000
##  7 Suici…  2016 David …     123 Color Action… USA   A partir de … 175000000
##  8 Alice…  2016 James …     113 Color Advent… USA   Livre         170000000
##  9 Indep…  2016 Roland…     120 Color Action… USA   A partir de … 165000000
## 10 Warcr…  2016 Duncan…     123 Color Action… USA   A partir de … 160000000
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

#### Exercícios {-}

Utilize a base `imdb` nos exercícios a seguir.

**1.** Ordene os filmes em ordem crescente de `ano` e decrescente de `receita` e salve em um objeto chamado `filmes_ordenados`.

**2.** Selecione apenas as colunas `titulo` e `orcamento` e então ordene de forma decrescente pelo `orcamento.`

### O pipe em ação

Na grande maioria dos casos, vamos aplicar mais de uma função de manipulação em uma base para obtermos a tabela que desejamos. Poderíamos, por exemplo, querer uma tabela apenas com o título e ano dos filmes, ordenada de forma crescente de lançamento. Para fazer isso, poderíamos aninhar as funções


```r
arrange(select(imdb, titulo, ano), ano)
```

```
## # A tibble: 3,807 x 2
##    titulo                                              ano
##    <chr>                                             <int>
##  1 Intolerance: Love's Struggle Throughout the Ages   1916
##  2 Over the Hill to the Poorhouse                     1920
##  3 The Big Parade                                     1925
##  4 The Broadway Melody                                1929
##  5 Hell's Angels                                      1930
##  6 A Farewell to Arms                                 1932
##  7 42nd Street                                        1933
##  8 She Done Him Wrong                                 1933
##  9 It Happened One Night                              1934
## 10 Top Hat                                            1935
## # … with 3,797 more rows
```

ou criar um objeto intermediário 


```r
tab_titulo_ano <- select(imdb, titulo, ano)

arrange(tab_titulo_ano, ano)
```

```
## # A tibble: 3,807 x 2
##    titulo                                              ano
##    <chr>                                             <int>
##  1 Intolerance: Love's Struggle Throughout the Ages   1916
##  2 Over the Hill to the Poorhouse                     1920
##  3 The Big Parade                                     1925
##  4 The Broadway Melody                                1929
##  5 Hell's Angels                                      1930
##  6 A Farewell to Arms                                 1932
##  7 42nd Street                                        1933
##  8 She Done Him Wrong                                 1933
##  9 It Happened One Night                              1934
## 10 Top Hat                                            1935
## # … with 3,797 more rows
```

Os dois códigos funcionam e levam ao mesmo resultado, mas não são muito boas.

A primeira alternativa é ruim de escrever, já que precisamos escrever primeiro a função que roda por último, e de ler, pois é difícil identificar qual argumento pertence a qual função.

A segunda alternativa é ruim pois exige a criação de objetos auxiliares. Se quiséssimos aplicar 10 operações na base, precisaríamos criar 9 objetos intermediários.

A solução para aplicar diversas operações de manipulação em uma base de dados é aplicar o operador pipe: `%>%`.


```r
imdb %>% 
  select(titulo, ano) %>% 
  arrange(ano)
```

```
## # A tibble: 3,807 x 2
##    titulo                                              ano
##    <chr>                                             <int>
##  1 Intolerance: Love's Struggle Throughout the Ages   1916
##  2 Over the Hill to the Poorhouse                     1920
##  3 The Big Parade                                     1925
##  4 The Broadway Melody                                1929
##  5 Hell's Angels                                      1930
##  6 A Farewell to Arms                                 1932
##  7 42nd Street                                        1933
##  8 She Done Him Wrong                                 1933
##  9 It Happened One Night                              1934
## 10 Top Hat                                            1935
## # … with 3,797 more rows
```

O que está sendo feito no código com pipe? Da primeira para a segunda linha, estamos aplicando a função `select()` à base imdb. Da segunda para a terceira, estamos aplicando a função `arrange()` à base resultante da função `select()`.

O resultado desse código é identico às tentativas sem pipe, com a vantagem de termos escrito o código na ordem em que as funções são aplicadas, de termos um código muito mais legível e de não precisarmos utilizar objetos intermediários.

### Filtrando linhas

Para filtrar valores de uma coluna da base, utilizamos a função `filter()`.


```r
imdb %>% filter(nota_imdb > 9)
```

```
## # A tibble: 3 x 15
##   titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##   <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
## 1 The S…  1994 Frank …     142 Color Crime|… USA   A partir de …  25000000
## 2 The G…  1972 Franci…     175 Color Crime|… USA   A partir de …   6000000
## 3 Kickb…  2016 John S…      90 <NA>  Action  USA   Outros         17000000
## # … with 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


Podemos selecionar apenas as colunas título e nota para visualizarmos as notas:


```r
imdb %>% 
  filter(nota_imdb > 9) %>% 
  select(titulo, nota_imdb)
```

```
## # A tibble: 3 x 2
##   titulo                    nota_imdb
##   <chr>                         <dbl>
## 1 The Shawshank Redemption        9.3
## 2 The Godfather                   9.2
## 3 Kickboxer: Vengeance            9.1
```

Podemos estender o filtro para duas ou mais colunas. Para isso, separamos cada operação por uma vírgula.


```r
imdb %>% filter(ano > 2010, nota_imdb > 8.5)
```

```
## # A tibble: 5 x 15
##   titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##   <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
## 1 Inter…  2014 Christ…     169 Color Advent… USA   A partir de … 165000000
## 2 Runni…  2015 Mike M…      88 Color Family  USA   Outros          5000000
## 3 A Beg…  2016 Mitche…      87 Color Comedy… USA   Outros               NA
## 4 Kickb…  2016 John S…      90 <NA>  Action  USA   Outros         17000000
## 5 Butte…  2014 Cary B…      78 Color Docume… USA   Outros           180000
## # … with 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

Também podemos fazer operações com as colunas da base dentro da função filter. O código abaixo devolve uma tabela apenas com os filmes que lucraram.


```r
imdb %>% filter(receita - orcamento > 0)
```

```
## # A tibble: 1,761 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
##  1 Avata…  2009 James …     178 Color Action… USA   A partir de … 237000000
##  2 Pirat…  2007 Gore V…     169 Color Action… USA   A partir de … 300000000
##  3 The D…  2012 Christ…     164 Color Action… USA   A partir de … 250000000
##  4 Spide…  2007 Sam Ra…     156 Color Action… USA   A partir de … 258000000
##  5 Aveng…  2015 Joss W…     141 Color Action… USA   A partir de … 250000000
##  6 Batma…  2016 Zack S…     183 Color Action… USA   A partir de … 250000000
##  7 Pirat…  2006 Gore V…     151 Color Action… USA   A partir de … 225000000
##  8 Man o…  2013 Zack S…     143 Color Action… USA   A partir de … 225000000
##  9 The A…  2012 Joss W…     173 Color Action… USA   A partir de … 220000000
## 10 The A…  2012 Marc W…     153 Color Action… USA   A partir de … 230000000
## # … with 1,751 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

Naturalmente, podemos filtrar colunas categóricas. O exemplo abaixo retorna uma tabela apenas com os filmes com a Angelina Jolie Pitt ou o Brad Pitt no papel principal.


```r
imdb %>%
  filter(ator_1 %in% c('Angelina Jolie Pitt', "Brad Pitt"))
```

```
## # A tibble: 29 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
##  1 Malef…  2014 Robert…      97 Color Action… USA   Livre         180000000
##  2 The C…  2008 David …     166 Color Drama|… USA   A partir de … 150000000
##  3 Kung …  2011 Jennif…      90 Color Action… USA   Livre         150000000
##  4 Troy    2004 Wolfga…     196 Color Advent… USA   A partir de … 175000000
##  5 Kung …  2008 Mark O…      92 Color Action… USA   Livre         130000000
##  6 Salt    2010 Philli…     101 Color Action… USA   A partir de … 110000000
##  7 Ocean…  2004 Steven…     125 Color Crime|… USA   A partir de … 110000000
##  8 Mr. &…  2005 Doug L…     126 Color Action… USA   A partir de … 120000000
##  9 Lara …  2001 Simon …     100 Color Action… USA   A partir de … 115000000
## 10 Ocean…  2001 Steven…     116 Color Crime|… USA   A partir de …  85000000
## # … with 19 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

Para filtrar textos sem correspondência exata, podemos utilizar a função auxiliar `str_detect()` do pacote `{stringr}`. Ela serve para verificar se cada string de um vetor contém um determinado padrão de texto.


```r
library(stringr)

str_detect(
  string = c("a", "aa","abc", "bc", "A", NA), 
  pattern = "a"
)
```

```
## [1]  TRUE  TRUE  TRUE FALSE FALSE    NA
```

Podemos utilizá-la para filtrar apenas os filmes que contêm o gênero ação.


```r
# A coluna gêneros apresenta todos os gêneros dos filmes concatenados
imdb$generos[1:6]
```

```
## [1] "Action|Adventure|Fantasy|Sci-Fi"                          
## [2] "Action|Adventure|Fantasy"                                 
## [3] "Action|Thriller"                                          
## [4] "Action|Adventure|Sci-Fi"                                  
## [5] "Action|Adventure|Romance"                                 
## [6] "Adventure|Animation|Comedy|Family|Fantasy|Musical|Romance"
```

```r
# Podemos detectar se o gênero Action aparece na string
str_detect(
  string = imdb$generos[1:6],
  pattern = "Action"
)
```

```
## [1]  TRUE  TRUE  TRUE  TRUE  TRUE FALSE
```

```r
# Aplicamos essa lógica dentro da função filter, para a coluna completa
imdb %>% filter(str_detect(generos, "Action"))
```

```
## # A tibble: 861 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
##  1 Avata…  2009 James …     178 Color Action… USA   A partir de … 237000000
##  2 Pirat…  2007 Gore V…     169 Color Action… USA   A partir de … 300000000
##  3 The D…  2012 Christ…     164 Color Action… USA   A partir de … 250000000
##  4 John …  2012 Andrew…     132 Color Action… USA   A partir de … 263700000
##  5 Spide…  2007 Sam Ra…     156 Color Action… USA   A partir de … 258000000
##  6 Aveng…  2015 Joss W…     141 Color Action… USA   A partir de … 250000000
##  7 Batma…  2016 Zack S…     183 Color Action… USA   A partir de … 250000000
##  8 Super…  2006 Bryan …     169 Color Action… USA   A partir de … 209000000
##  9 Pirat…  2006 Gore V…     151 Color Action… USA   A partir de … 225000000
## 10 The L…  2013 Gore V…     150 Color Action… USA   A partir de … 215000000
## # … with 851 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

#### Exercícios {-}

Utilize a base `imdb` nos exercícios a seguir.

**1.** Crie um objeto chamado `filmes_pb` apenas com filmes preto e branco.

**2.** Crie um objeto chamado `curtos_legais` com filmes de 90 minutos ou menos de duração e nota no imdb maior do que 8.5.

**3.** Retorne tabelas (`tibbles`) apenas com:

- **a.** filmes coloridos anteriores a 1950;

- **b.** filmes do "Woody Allen" ou do "Wes Anderson";

- **c.** filmes do "Steven Spielberg" ordenados de forma decrescente por ano, mostrando apenas as colunas `titulo` e `ano`;

- **d.**  filmes que tenham "Action" **ou** "Comedy" entre os seus gêneros;

- **e.** filmes que tenham "Action" **e** "Comedy" entre os seus gêneros e tenha `nota_imdb` maior que 8;

- **f.** filmes que não possuem informação tanto de receita quanto de orçamento (isto é, possuem `NA` em ambas as colunas).


### Modificando e criando novas colunas

Para modificar uma coluna existente ou criar uma nova coluna, utilizamos a função `mutate()`. O código abaixo divide os valores da coluna duração por 60, mudando a unidade de medida dessa variável de minutos para horas.


```r
imdb %>% mutate(duracao = duracao/60)
```

```
## # A tibble: 3,807 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <int> <chr>     <dbl> <chr> <chr>   <chr> <chr>             <int>
##  1 Avata…  2009 James …    2.97 Color Action… USA   A partir de … 237000000
##  2 Pirat…  2007 Gore V…    2.82 Color Action… USA   A partir de … 300000000
##  3 The D…  2012 Christ…    2.73 Color Action… USA   A partir de … 250000000
##  4 John …  2012 Andrew…    2.2  Color Action… USA   A partir de … 263700000
##  5 Spide…  2007 Sam Ra…    2.6  Color Action… USA   A partir de … 258000000
##  6 Tangl…  2010 Nathan…    1.67 Color Advent… USA   Livre         260000000
##  7 Aveng…  2015 Joss W…    2.35 Color Action… USA   A partir de … 250000000
##  8 Batma…  2016 Zack S…    3.05 Color Action… USA   A partir de … 250000000
##  9 Super…  2006 Bryan …    2.82 Color Action… USA   A partir de … 209000000
## 10 Pirat…  2006 Gore V…    2.52 Color Action… USA   A partir de … 225000000
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

Também poderíamos ter criado essa variável em uma nova coluna. Repare que a nova coluna `duracao_horas` é colocada no final da tabela.


```r
imdb %>% mutate(duracao_horas = duracao/60)
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
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>,
## #   duracao_horas <dbl>
```

Podemos fazer qualquer operação com uma ou mais colunas. A única regra é que o resultado da operação retorne um vetor com comprimento igual ao número de linhas da base (ou com comprimento 1 para distribuir um mesmo valor em todas as linhas). Você também pode criar/modificar quantas colunas quiser dentro de um mesmo `mutate`.


```r
imdb %>% 
  mutate(lucro = receita - orcamento, pais = "Estados Unidos") %>% 
  select(titulo, lucro, pais)
```

```
## # A tibble: 3,807 x 3
##    titulo                                           lucro pais          
##    <chr>                                            <int> <chr>         
##  1 Avatar                                       523505847 Estados Unidos
##  2 Pirates of the Caribbean: At World's End       9404152 Estados Unidos
##  3 The Dark Knight Rises                        198130642 Estados Unidos
##  4 John Carter                                 -190641321 Estados Unidos
##  5 Spider-Man 3                                  78530303 Estados Unidos
##  6 Tangled                                      -59192738 Estados Unidos
##  7 Avengers: Age of Ultron                      208991599 Estados Unidos
##  8 Batman v Superman: Dawn of Justice            80249062 Estados Unidos
##  9 Superman Returns                              -8930592 Estados Unidos
## 10 Pirates of the Caribbean: Dead Man's Chest   198032628 Estados Unidos
## # … with 3,797 more rows
```

#### Exercícios {-}

Utilize a base `imdb` nos exercícios a seguir.

**1.** Crie uma coluna chamada `prejuizo` (`orcamento - receita`) e salve a nova tabela em um objeto chamado `imdb_prejuizo`. Em seguida, filtre apenas os filmes que deram prejuízo e ordene a tabela por ordem crescente de prejuízo.

**2.** Fazendo apenas uma chamada da função mutate(), crie as seguintes colunas novas na base `imdb`:

- **a.** `lucro = receita - despesa`

- **b.** `lucro_medio`

- **c.** `lucro_relativo = (lucro - lucro_medio)/lucro_medio`

- **d.** `houve_lucro = ifelse(lucro > 0, "sim", "não")`

**3.** Crie uma nova coluna que classifique o filme em `"recente"` (posterior a 2000) e `"antigo"` (de 2000 para trás).

### Summarisando a base

Sumarização é a técnica de se resumir um conjunto de dados utilizando alguma métrica de interesse. A média, a mediana, a variância, a frequência, a proporção, por exemplo, são tipos de sumarização que trazem diferentes informações sobre uma variável. 

Para sumarizar uma coluna da base, utilizamos a função `summarize()`. O código abaixo resume a coluna orçamento pela sua média.


```r
imdb %>% summarize(media_orcamento = mean(orcamento, na.rm = TRUE))
```

```
## # A tibble: 1 x 1
##   media_orcamento
##             <dbl>
## 1       35755986.
```

Repare que a saída da função continua sendo uma tibble.

Podemos calcular diversas sumarizações diferentes em um mesmo `summarize`. Cada sumarização será uma coluna da nova base.


```r
imdb %>% summarise(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  mediana_orcamento = median(orcamento, na.rm = TRUE),
  variancia_orcamento = var(orcamento, na.rm = TRUE)
)
```

```
## # A tibble: 1 x 3
##   media_orcamento mediana_orcamento variancia_orcamento
##             <dbl>             <int>               <dbl>
## 1       35755986.          20000000   1822337181441743.
```

E também sumarizar diversas colunas.


```r
imdb %>% summarize(
  media_orcamento = mean(orcamento, na.rm = TRUE),
  media_receita = mean(receita, na.rm = TRUE),
  media_lucro = mean(receita - orcamento, na.rm = TRUE)
)
```

```
## # A tibble: 1 x 3
##   media_orcamento media_receita media_lucro
##             <dbl>         <dbl>       <dbl>
## 1       35755986.     55214607.   17258230.
```

Muitas vezes queremos sumarizar uma coluna agrupada pelas categorias de uma segunda coluna. Para isso, além do `summarize`, utilizamos também a função `group_by()`.

O código a seguir calcula a receita média dos filmes para cada categoria da coluna "cor".


```r
imdb %>% 
  group_by(cor) %>% 
  summarise(receita_media = mean(receita, na.rm = TRUE))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```
## # A tibble: 3 x 2
##   cor             receita_media
##   <chr>                   <dbl>
## 1 Black and White     36938737.
## 2 Color               55765813.
## 3 <NA>                80014842
```

A única alteração que a função `group_by()` faz na base é a marcação de que a base está agrupada.


```r
imdb %>% group_by(cor)
```

```
## # A tibble: 3,807 x 15
## # Groups:   cor [3]
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

#### Exercícios {-}

Utilize a base `imdb` nos exercícios a seguir.

**1.** Calcule a duração média e mediana dos filmes
da base.

**2.** Calcule o lucro médio dos filmes com duração
menor que 60 minutos.

**3.** Apresente na mesma tabela o lucro médio
dos filmes com duracao menor que 60 minutos
e o lucro médio dos filmes com duracao maior
ou igual a 60 minutos.

**4.** Retorne tabelas (`tibbles`) apenas com:

- **a.** a nota IMDB média dos filmes por tipo de classificacao;

- **b.** a receita média e mediana dos filmes por ano;

- **c.** apenas o nome dos diretores com mais de 10 filmes.

### Juntando duas bases

Podemos juntar duas tabelas a partir de uma (coluna) chave utilizando a função `left_join()`. Como exempo, vamos inicialmente calcular o lucro médio dos filmes de cada diretor e salvar no objeto `tab_lucro_diretor`.


```r
tab_lucro_diretor <- imdb %>%
  group_by(diretor) %>% 
  summarise(lucro_medio = mean(receita - orcamento, na.rm = TRUE))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```r
tab_lucro_diretor
```

```
## # A tibble: 1,813 x 2
##    diretor          lucro_medio
##    <chr>                  <dbl>
##  1 A. Raven Cruz            NaN
##  2 Aaron Hann               NaN
##  3 Aaron Schneider      1676553
##  4 Aaron Seltzer       28546578
##  5 Abel Ferrara       -11272676
##  6 Adam Carolla        -1394057
##  7 Adam Goldberg       -1647420
##  8 Adam Green               NaN
##  9 Adam Jay Epstein         NaN
## 10 Adam Marcus         13435068
## # … with 1,803 more rows
```

E se quisermos colocar essa informação na base original? Basta usar a função `left_join()` utilizando a coluna `diretor` como chave. Observe que a coluna `lucro_medio` aparece agora no fim da tabela.


```r
imdb_com_lucro_medio <- left_join(imdb, tab_lucro_diretor, by = "diretor")

imdb_com_lucro_medio
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
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>,
## #   lucro_medio <dbl>
```

Na tabela `imdb_com_lucro_medio`, como na tabela `imdb`, cada linha continua a representar um filme diferente, mas agora temos também a informação do lucro médio do diretor de cada filme. 

A primeira linha, por exemplo, traz as informações do filme Avatar. O valor do `lucro_medio` nessa linha representa o lucro médio de todos os filmes do James Cameron, que é o diretor de Avatar. Com essa informação, podemos calcular o quanto o lucro do Avatar se afasta do lucro médio do James Cameron.


```r
imdb_com_lucro_medio %>% 
  mutate(
    lucro = receita - orcamento,
    lucro_relativo = (lucro - lucro_medio)/lucro_medio,
    lucro_relativo = scales::percent(lucro_relativo)
  ) %>% 
  select(titulo, diretor, lucro, lucro_medio, lucro_relativo)
```

```
## # A tibble: 3,807 x 5
##    titulo                      diretor          lucro lucro_medio lucro_relativo
##    <chr>                       <chr>            <int>       <dbl> <chr>         
##  1 Avatar                      James Cameron   5.24e8  194620985  168.98736%    
##  2 Pirates of the Caribbean: … Gore Verbins…   9.40e6   36942999. -74.54416%    
##  3 The Dark Knight Rises       Christopher …   1.98e8  101028447  96.11372%     
##  4 John Carter                 Andrew Stant…  -1.91e8   46668146  -508.50417%   
##  5 Spider-Man 3                Sam Raimi       7.85e7   63300090. 24.06033%     
##  6 Tangled                     Nathan Greno   -5.92e7  -59192738  0.00000%      
##  7 Avengers: Age of Ultron     Joss Whedon     2.09e8  250221657  -16.47741%    
##  8 Batman v Superman: Dawn of… Zack Snyder     8.02e7   33149106. 142.08514%    
##  9 Superman Returns            Bryan Singer   -8.93e6   -2887024. 209.33560%    
## 10 Pirates of the Caribbean: … Gore Verbins…   1.98e8   36942999. 436.04913%    
## # … with 3,797 more rows
```

Observamos então que o Avatar obteve um lucro aproximadamente 169% maior que a média dos filmes do James Cameron.

Além da função `left_join()`, também são muito utilizadas as funções `right_join()` e `full_join()`.

- `right_join()`: retorna todas as linhas da base `y` e todas as colunas das bases `x` e `y`. Linhas de `y` sem correspondentes em `x` receberão `NA` na nova base.

- `full_join()`: retorna todas as linhas e colunas de `x`e `y`. Valores sem correspondência entre as bases receberão `NA` na nova base.

A figura a seguir esquematiza as operações dessas funções:

<img src="assets/img/manipulacao/joins.png" width="355" style="display: block; margin: auto;" />

#### Exercícios {-}

**1.** Utilize a base `imdb` para resolver os itens a seguir.

**a.** Salve em um novo objeto uma tabela com a
nota média dos filmes de cada diretor. Essa tabela
deve conter duas colunas (`diretor` e `nota_imdb_media`)
e cada linha deve ser um diretor diferente.

**b.** Use o `left_join()` para trazer a coluna
`nota_imdb_media` da tabela do item anterior
para a tabela `imdb` original.



