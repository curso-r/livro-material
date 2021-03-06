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

Neste capítulo, vamos trabalhar com uma base de filmes do IMDB. Essa base pode ser baixada [clicando aqui](https://github.com/curso-r/livro-material/raw/master/assets/data/imdb.rds).

Assim, utilizaremos o objeto `imdb` para acessar os dados.





```r
imdb <- readr::read_rds("imdb.rds")
imdb
```


```
## # A tibble: 3,807 x 15
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <int> <chr>      <int> <chr> <chr>     <chr> <chr>             <int>
##  1 Avatar    2009 James C…     178 Color Action|A… USA   A partir de … 237000000
##  2 Pirates…  2007 Gore Ve…     169 Color Action|A… USA   A partir de … 300000000
##  3 The Dar…  2012 Christo…     164 Color Action|T… USA   A partir de … 250000000
##  4 John Ca…  2012 Andrew …     132 Color Action|A… USA   A partir de … 263700000
##  5 Spider-…  2007 Sam Rai…     156 Color Action|A… USA   A partir de … 258000000
##  6 Tangled   2010 Nathan …     100 Color Adventur… USA   Livre         260000000
##  7 Avenger…  2015 Joss Wh…     141 Color Action|A… USA   A partir de … 250000000
##  8 Batman …  2016 Zack Sn…     183 Color Action|A… USA   A partir de … 250000000
##  9 Superma…  2006 Bryan S…     169 Color Action|A… USA   A partir de … 209000000
## 10 Pirates…  2006 Gore Ve…     151 Color Action|A… USA   A partir de … 225000000
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
##    titulo  duracao cor   generos pais  classificacao orcamento receita nota_imdb
##    <chr>     <int> <chr> <chr>   <chr> <chr>             <int>   <int>     <dbl>
##  1 Avatar      178 Color Action… USA   A partir de … 237000000  7.61e8       7.9
##  2 Pirate…     169 Color Action… USA   A partir de … 300000000  3.09e8       7.1
##  3 The Da…     164 Color Action… USA   A partir de … 250000000  4.48e8       8.5
##  4 John C…     132 Color Action… USA   A partir de … 263700000  7.31e7       6.6
##  5 Spider…     156 Color Action… USA   A partir de … 258000000  3.37e8       6.2
##  6 Tangle…     100 Color Advent… USA   Livre         260000000  2.01e8       7.8
##  7 Avenge…     141 Color Action… USA   A partir de … 250000000  4.59e8       7.5
##  8 Batman…     183 Color Action… USA   A partir de … 250000000  3.30e8       6.9
##  9 Superm…     169 Color Action… USA   A partir de … 209000000  2.00e8       6.1
## 10 Pirate…     151 Color Action… USA   A partir de … 225000000  4.23e8       7.3
## # … with 3,797 more rows, and 4 more variables: likes_facebook <int>,
## #   ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

```r
imdb %>%
  select(-starts_with("ator"))
```

```
## # A tibble: 3,807 x 12
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <int> <chr>      <int> <chr> <chr>     <chr> <chr>             <int>
##  1 Avatar    2009 James C…     178 Color Action|A… USA   A partir de … 237000000
##  2 Pirates…  2007 Gore Ve…     169 Color Action|A… USA   A partir de … 300000000
##  3 The Dar…  2012 Christo…     164 Color Action|T… USA   A partir de … 250000000
##  4 John Ca…  2012 Andrew …     132 Color Action|A… USA   A partir de … 263700000
##  5 Spider-…  2007 Sam Rai…     156 Color Action|A… USA   A partir de … 258000000
##  6 Tangled   2010 Nathan …     100 Color Adventur… USA   Livre         260000000
##  7 Avenger…  2015 Joss Wh…     141 Color Action|A… USA   A partir de … 250000000
##  8 Batman …  2016 Zack Sn…     183 Color Action|A… USA   A partir de … 250000000
##  9 Superma…  2006 Bryan S…     169 Color Action|A… USA   A partir de … 209000000
## 10 Pirates…  2006 Gore Ve…     151 Color Action|A… USA   A partir de … 225000000
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
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <int> <chr>      <int> <chr> <chr>     <chr> <chr>             <int>
##  1 Tarnati…  2003 Jonatha…      88 Color Biograph… USA   Outros              218
##  2 My Date…  2004 Jon Gunn      90 Color Document… USA   Livre              1100
##  3 A Plagu…  2013 Benjami…      76 Color Drama|Ho… USA   Outros             1400
##  4 The Mon…  2005 Anthony…      84 Color Crime|Dr… USA   A partir de …      3250
##  5 Primer    2004 Shane C…      77 Color Drama|Sc… USA   A partir de …      7000
##  6 El Mari…  1992 Robert …      81 Color Action|C… USA   A partir de …      7000
##  7 Newlywe…  2011 Edward …      95 Color Comedy|D… USA   Outros             9000
##  8 Pink Fl…  1972 John Wa…     108 Color Comedy|C… USA   A partir de …     10000
##  9 The Tou…  2007 Jane Cl…       7 Color Romance|… USA   Outros            13000
## 10 Paranor…  2007 Oren Pe…      84 Color Horror    USA   A partir de …     15000
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

Também podemos ordenar de forma decrescente usando a função `desc()`.


```r
arrange(imdb, desc(orcamento))
```

```
## # A tibble: 3,807 x 15
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <int> <chr>      <int> <chr> <chr>     <chr> <chr>             <int>
##  1 Pirates…  2007 Gore Ve…     169 Color Action|A… USA   A partir de … 300000000
##  2 John Ca…  2012 Andrew …     132 Color Action|A… USA   A partir de … 263700000
##  3 Tangled   2010 Nathan …     100 Color Adventur… USA   Livre         260000000
##  4 Spider-…  2007 Sam Rai…     156 Color Action|A… USA   A partir de … 258000000
##  5 Spider-…  2007 Sam Rai…     156 Color Action|A… USA   A partir de … 258000000
##  6 The Dar…  2012 Christo…     164 Color Action|T… USA   A partir de … 250000000
##  7 Avenger…  2015 Joss Wh…     141 Color Action|A… USA   A partir de … 250000000
##  8 Batman …  2016 Zack Sn…     183 Color Action|A… USA   A partir de … 250000000
##  9 Pirates…  2011 Rob Mar…     136 Color Action|A… USA   A partir de … 250000000
## 10 Captain…  2016 Anthony…     147 Color Action|A… USA   A partir de … 250000000
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


E claro, ordenar segundo duas ou mais colunas.


```r
arrange(imdb, desc(ano), desc(orcamento))
```

```
## # A tibble: 3,807 x 15
##    titulo      ano diretor  duracao cor   generos  pais  classificacao orcamento
##    <chr>     <int> <chr>      <int> <chr> <chr>    <chr> <chr>             <int>
##  1 Batman v…  2016 Zack Sn…     183 Color Action|… USA   A partir de … 250000000
##  2 Captain …  2016 Anthony…     147 Color Action|… USA   A partir de … 250000000
##  3 Star Tre…  2016 Justin …     122 Color Action|… USA   A partir de … 185000000
##  4 The Lege…  2016 David Y…     110 Color Action|… USA   A partir de … 180000000
##  5 The Lege…  2016 David Y…     110 Color Action|… USA   A partir de … 180000000
##  6 X-Men: A…  2016 Bryan S…     144 Color Action|… USA   A partir de … 178000000
##  7 Suicide …  2016 David A…     123 Color Action|… USA   A partir de … 175000000
##  8 Alice Th…  2016 James B…     113 Color Adventu… USA   Livre         170000000
##  9 Independ…  2016 Roland …     120 Color Action|… USA   A partir de … 165000000
## 10 Warcraft   2016 Duncan …     123 Color Action|… USA   A partir de … 160000000
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
##   titulo      ano diretor   duracao cor   generos  pais  classificacao orcamento
##   <chr>     <int> <chr>       <int> <chr> <chr>    <chr> <chr>             <int>
## 1 The Shaw…  1994 Frank Da…     142 Color Crime|D… USA   A partir de …  25000000
## 2 The Godf…  1972 Francis …     175 Color Crime|D… USA   A partir de …   6000000
## 3 Kickboxe…  2016 John Sto…      90 <NA>  Action   USA   Outros         17000000
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
##   titulo      ano diretor   duracao cor   generos  pais  classificacao orcamento
##   <chr>     <int> <chr>       <int> <chr> <chr>    <chr> <chr>             <int>
## 1 Interste…  2014 Christop…     169 Color Adventu… USA   A partir de … 165000000
## 2 Running …  2015 Mike May…      88 Color Family   USA   Outros          5000000
## 3 A Beginn…  2016 Mitchell…      87 Color Comedy|… USA   Outros               NA
## 4 Kickboxe…  2016 John Sto…      90 <NA>  Action   USA   Outros         17000000
## 5 Butterfl…  2014 Cary Bell      78 Color Documen… USA   Outros           180000
## # … with 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

Também podemos fazer operações com as colunas da base dentro da função filter. O código abaixo devolve uma tabela apenas com os filmes que lucraram.


```r
imdb %>% filter(receita - orcamento > 0)
```

```
## # A tibble: 1,761 x 15
##    titulo      ano diretor  duracao cor   generos  pais  classificacao orcamento
##    <chr>     <int> <chr>      <int> <chr> <chr>    <chr> <chr>             <int>
##  1 Avatar     2009 James C…     178 Color Action|… USA   A partir de … 237000000
##  2 Pirates …  2007 Gore Ve…     169 Color Action|… USA   A partir de … 300000000
##  3 The Dark…  2012 Christo…     164 Color Action|… USA   A partir de … 250000000
##  4 Spider-M…  2007 Sam Rai…     156 Color Action|… USA   A partir de … 258000000
##  5 Avengers…  2015 Joss Wh…     141 Color Action|… USA   A partir de … 250000000
##  6 Batman v…  2016 Zack Sn…     183 Color Action|… USA   A partir de … 250000000
##  7 Pirates …  2006 Gore Ve…     151 Color Action|… USA   A partir de … 225000000
##  8 Man of S…  2013 Zack Sn…     143 Color Action|… USA   A partir de … 225000000
##  9 The Aven…  2012 Joss Wh…     173 Color Action|… USA   A partir de … 220000000
## 10 The Amaz…  2012 Marc We…     153 Color Action|… USA   A partir de … 230000000
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
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <int> <chr>      <int> <chr> <chr>     <chr> <chr>             <int>
##  1 Malefic…  2014 Robert …      97 Color Action|A… USA   Livre         180000000
##  2 The Cur…  2008 David F…     166 Color Drama|Fa… USA   A partir de … 150000000
##  3 Kung Fu…  2011 Jennife…      90 Color Action|A… USA   Livre         150000000
##  4 Troy      2004 Wolfgan…     196 Color Adventure USA   A partir de … 175000000
##  5 Kung Fu…  2008 Mark Os…      92 Color Action|A… USA   Livre         130000000
##  6 Salt      2010 Phillip…     101 Color Action|C… USA   A partir de … 110000000
##  7 Ocean's…  2004 Steven …     125 Color Crime|Th… USA   A partir de … 110000000
##  8 Mr. & M…  2005 Doug Li…     126 Color Action|C… USA   A partir de … 120000000
##  9 Lara Cr…  2001 Simon W…     100 Color Action|A… USA   A partir de … 115000000
## 10 Ocean's…  2001 Steven …     116 Color Crime|Th… USA   A partir de …  85000000
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
##    titulo      ano diretor  duracao cor   generos  pais  classificacao orcamento
##    <chr>     <int> <chr>      <int> <chr> <chr>    <chr> <chr>             <int>
##  1 Avatar     2009 James C…     178 Color Action|… USA   A partir de … 237000000
##  2 Pirates …  2007 Gore Ve…     169 Color Action|… USA   A partir de … 300000000
##  3 The Dark…  2012 Christo…     164 Color Action|… USA   A partir de … 250000000
##  4 John Car…  2012 Andrew …     132 Color Action|… USA   A partir de … 263700000
##  5 Spider-M…  2007 Sam Rai…     156 Color Action|… USA   A partir de … 258000000
##  6 Avengers…  2015 Joss Wh…     141 Color Action|… USA   A partir de … 250000000
##  7 Batman v…  2016 Zack Sn…     183 Color Action|… USA   A partir de … 250000000
##  8 Superman…  2006 Bryan S…     169 Color Action|… USA   A partir de … 209000000
##  9 Pirates …  2006 Gore Ve…     151 Color Action|… USA   A partir de … 225000000
## 10 The Lone…  2013 Gore Ve…     150 Color Action|… USA   A partir de … 215000000
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
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <int> <chr>      <dbl> <chr> <chr>     <chr> <chr>             <int>
##  1 Avatar    2009 James C…    2.97 Color Action|A… USA   A partir de … 237000000
##  2 Pirates…  2007 Gore Ve…    2.82 Color Action|A… USA   A partir de … 300000000
##  3 The Dar…  2012 Christo…    2.73 Color Action|T… USA   A partir de … 250000000
##  4 John Ca…  2012 Andrew …    2.2  Color Action|A… USA   A partir de … 263700000
##  5 Spider-…  2007 Sam Rai…    2.6  Color Action|A… USA   A partir de … 258000000
##  6 Tangled   2010 Nathan …    1.67 Color Adventur… USA   Livre         260000000
##  7 Avenger…  2015 Joss Wh…    2.35 Color Action|A… USA   A partir de … 250000000
##  8 Batman …  2016 Zack Sn…    3.05 Color Action|A… USA   A partir de … 250000000
##  9 Superma…  2006 Bryan S…    2.82 Color Action|A… USA   A partir de … 209000000
## 10 Pirates…  2006 Gore Ve…    2.52 Color Action|A… USA   A partir de … 225000000
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

Também poderíamos ter criado essa variável em uma nova coluna. Repare que a nova coluna `duracao_horas` é colocada no final da tabela.


```r
imdb %>% mutate(duracao_horas = duracao/60)
```

```
## # A tibble: 3,807 x 16
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <int> <chr>      <int> <chr> <chr>     <chr> <chr>             <int>
##  1 Avatar    2009 James C…     178 Color Action|A… USA   A partir de … 237000000
##  2 Pirates…  2007 Gore Ve…     169 Color Action|A… USA   A partir de … 300000000
##  3 The Dar…  2012 Christo…     164 Color Action|T… USA   A partir de … 250000000
##  4 John Ca…  2012 Andrew …     132 Color Action|A… USA   A partir de … 263700000
##  5 Spider-…  2007 Sam Rai…     156 Color Action|A… USA   A partir de … 258000000
##  6 Tangled   2010 Nathan …     100 Color Adventur… USA   Livre         260000000
##  7 Avenger…  2015 Joss Wh…     141 Color Action|A… USA   A partir de … 250000000
##  8 Batman …  2016 Zack Sn…     183 Color Action|A… USA   A partir de … 250000000
##  9 Superma…  2006 Bryan S…     169 Color Action|A… USA   A partir de … 209000000
## 10 Pirates…  2006 Gore Ve…     151 Color Action|A… USA   A partir de … 225000000
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

- **a.** `lucro = receita - orcamento`

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
## 1       35755986.          20000000             1.82e15
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
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <int> <chr>      <int> <chr> <chr>     <chr> <chr>             <int>
##  1 Avatar    2009 James C…     178 Color Action|A… USA   A partir de … 237000000
##  2 Pirates…  2007 Gore Ve…     169 Color Action|A… USA   A partir de … 300000000
##  3 The Dar…  2012 Christo…     164 Color Action|T… USA   A partir de … 250000000
##  4 John Ca…  2012 Andrew …     132 Color Action|A… USA   A partir de … 263700000
##  5 Spider-…  2007 Sam Rai…     156 Color Action|A… USA   A partir de … 258000000
##  6 Tangled   2010 Nathan …     100 Color Adventur… USA   Livre         260000000
##  7 Avenger…  2015 Joss Wh…     141 Color Action|A… USA   A partir de … 250000000
##  8 Batman …  2016 Zack Sn…     183 Color Action|A… USA   A partir de … 250000000
##  9 Superma…  2006 Bryan S…     169 Color Action|A… USA   A partir de … 209000000
## 10 Pirates…  2006 Gore Ve…     151 Color Action|A… USA   A partir de … 225000000
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

#### Exercícios {-}

Utilize a base `imdb` nos exercícios a seguir.

**1.** Calcule a duração média e mediana dos filmes da base.

**2.** Calcule o lucro médio dos filmes com duração menor que 60 minutos.

**3.** Apresente na mesma tabela o lucro médio dos filmes com duracao menor que 60 minutos e o lucro médio dos filmes com duracao maior ou igual a 60 minutos.

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
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <int> <chr>      <int> <chr> <chr>     <chr> <chr>             <int>
##  1 Avatar    2009 James C…     178 Color Action|A… USA   A partir de … 237000000
##  2 Pirates…  2007 Gore Ve…     169 Color Action|A… USA   A partir de … 300000000
##  3 The Dar…  2012 Christo…     164 Color Action|T… USA   A partir de … 250000000
##  4 John Ca…  2012 Andrew …     132 Color Action|A… USA   A partir de … 263700000
##  5 Spider-…  2007 Sam Rai…     156 Color Action|A… USA   A partir de … 258000000
##  6 Tangled   2010 Nathan …     100 Color Adventur… USA   Livre         260000000
##  7 Avenger…  2015 Joss Wh…     141 Color Action|A… USA   A partir de … 250000000
##  8 Batman …  2016 Zack Sn…     183 Color Action|A… USA   A partir de … 250000000
##  9 Superma…  2006 Bryan S…     169 Color Action|A… USA   A partir de … 209000000
## 10 Pirates…  2006 Gore Ve…     151 Color Action|A… USA   A partir de … 225000000
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

<img src="assets/img/manipulacao/joins.png" width="710" style="display: block; margin: auto;" />

#### Exercícios {-}

**1.** Utilize a base `imdb` para resolver os itens a seguir.

**a.** Salve em um novo objeto uma tabela com a
nota média dos filmes de cada diretor. Essa tabela
deve conter duas colunas (`diretor` e `nota_imdb_media`)
e cada linha deve ser um diretor diferente.

**b.** Use o `left_join()` para trazer a coluna
`nota_imdb_media` da tabela do item anterior
para a tabela `imdb` original.


### dplyr 1.0

A versão 1.0 do pacote `dplyr` foi oficialmente lançada em junho de 2020 e contou com diversas novidades. Vamos falar das principais mudanças:

- A nova função `across()`, que facilita aplicar uma mesma operação em várias colunas.

- A repaginada função `rowwise()`, para fazer operações por linha.

- Novas funcionalidades das funções `select()` e `rename()` e a nova função `relocate()`.

Para trabalhar essas funções, vamos utilizar a base `casas` do pacote `dados`. Para instalar esse pacote, rode os códigos abaixo:


```r
install.packages("remotes")
remotes::install_github("cienciadedatos/dados")
```

Para trazer os dados para o nosso *environment*, podemos rodar:


```r
casas <- dados::casas
```

A base `casas` possui dados de venda de casas na cidade de Ames, nos Estados Unidos. São  2930 linhas e 77 colunas, sendo que cada linha corresponde a uma casa vendida e cada coluna a uma característica da casa ou da venda. Essa versão é uma tradução da base original, que pode ser encontrada no pacote `AmesHousing`:


```r
install.packages("AmesHousing")
data(ames_raw, package = "AmesHousing")
```

#### A função `across()` {-}

A função `across()` substitui a família de verbos `_all()`, `_if` e `_at()`. A ideia é facilitar a aplicação de uma operação a diversas colunas da base. Para sumarizar a base para mais de uma variável, antigamente poderíamos fazer:


```r
casas %>%
  group_by(geral_qualidade) %>%
  summarise(
    lote_area_media = mean(lote_area, na.rm = TRUE),
    venda_valor_medio = mean(venda_valor, na.rm = TRUE)
  )
```

```
## # A tibble: 10 x 3
##    geral_qualidade lote_area_media venda_valor_medio
##    <chr>                     <dbl>             <dbl>
##  1 abaixo da média           8464.           106485.
##  2 acima da média            9788.           162130.
##  3 boa                      10309.           205026.
##  4 excelente                12777.           368337.
##  5 média                     9996.           134753.
##  6 muito boa                10618.           270914.
##  7 Muito excelente          18071.           450217.
##  8 muito ruim               15214.            48725 
##  9 regular                   9439.            83186.
## 10 ruim                      9326.            52325.
```

Ou então utilizar a função `summarise_at()`:


```r
casas %>%
  group_by(geral_qualidade) %>%
  summarise_at(
    .vars = vars(lote_area, venda_valor),
    list(mean),
    na.rm = TRUE
  )
```

```
## # A tibble: 10 x 3
##    geral_qualidade lote_area venda_valor
##    <chr>               <dbl>       <dbl>
##  1 abaixo da média     8464.     106485.
##  2 acima da média      9788.     162130.
##  3 boa                10309.     205026.
##  4 excelente          12777.     368337.
##  5 média               9996.     134753.
##  6 muito boa          10618.     270914.
##  7 Muito excelente    18071.     450217.
##  8 muito ruim         15214.      48725 
##  9 regular             9439.      83186.
## 10 ruim                9326.      52325.
```

Com a nova função `across()`, fazemos:


```r
casas %>%
  group_by(geral_qualidade) %>%
  summarise(across(
    .cols = c(lote_area, venda_valor),
    .fns = mean, 
    na.rm = TRUE
  ))
```

```
## # A tibble: 10 x 3
##    geral_qualidade lote_area venda_valor
##    <chr>               <dbl>       <dbl>
##  1 abaixo da média     8464.     106485.
##  2 acima da média      9788.     162130.
##  3 boa                10309.     205026.
##  4 excelente          12777.     368337.
##  5 média               9996.     134753.
##  6 muito boa          10618.     270914.
##  7 Muito excelente    18071.     450217.
##  8 muito ruim         15214.      48725 
##  9 regular             9439.      83186.
## 10 ruim                9326.      52325.
```

A sintaxe é parecida com a função `summarise_at()`, mas agora não precisamos mais usar a função `vars()` e nem usar `list(nome_da_funcao)`para definir a função aplicada nas colunas.

Usando `across()`, podemos facilmente aplicar uma função em todas as colunas da nossa base. Abaixo, calculamos o número de valores distintos para todas as variáveis da base `casas`. O padrão do parâmetro `.cols` é `everithing()`, que representa "todas as colunas".


```r
casas %>% 
  summarise(across(.fns = n_distinct))
```

```
## # A tibble: 1 x 82
##   ordem   pid moradia_classe moradia_zoneamento lote_fachada lote_area rua_tipo
##   <int> <int>          <int>              <int>        <int>     <int>    <int>
## 1  2930  2930             16                  7          129      1960        2
## # … with 75 more variables: beco_tipo <int>, lote_formato <int>,
## #   terreno_contorno <int>, utilidades <int>, lote_config <int>,
## #   terreno_declive <int>, vizinhanca <int>, condicao_1 <int>,
## #   condicao_2 <int>, moradia_tipo <int>, moradia_estilo <int>,
## #   geral_qualidade <int>, geral_condicao <int>, construcao_ano <int>,
## #   remodelacao_ano <int>, telhado_estilo <int>, telhado_material <int>,
## #   exterior_cobertura_1 <int>, exterior_cobertura_2 <int>,
## #   alvenaria_tipo <int>, alvenaria_area <int>, exterior_qualidade <int>,
## #   exterior_condicao <int>, fundacao_tipo <int>, porao_qualidade <int>,
## #   porao_condicao <int>, porao_exposicao <int>, porao_acabamento_1 <int>,
## #   porao_area_com_acabamento_1 <int>, porao_acabamento_2 <int>,
## #   porao_area_com_acabamento_2 <int>, porao_area_sem_acabamento <int>,
## #   porao_area_total <int>, porao_num_banheiros <int>,
## #   porao_num_banheiros_lavabos <int>, aquecimento_tipo <int>,
## #   aquecimento_qualidade_condicao <int>, ar_condicionado_central <int>,
## #   sistema_eletrico_tipo <int>, primeiro_andar_area <int>,
## #   segundo_andar_area <int>, acabamento_baixa_qualidade_area <int>,
## #   acima_solo_area <int>, acima_solo_num_banheiros <int>,
## #   acima_solo_num_lavabos <int>, acima_solo_num_quartos <int>,
## #   acima_solo_num_cozinhas <int>, cozinha_qualidade <int>,
## #   acima_solo_num_comodos <int>, funcional <int>, total_num_lareiras <int>,
## #   lareira_qualidade <int>, garagem_tipo <int>, garagem_ano_construcao <int>,
## #   garagem_acabamento <int>, garagem_capacidade_carros <int>,
## #   garagem_area <int>, garagem_qualidade <int>, garagem_condicao <int>,
## #   entrada_veiculo_pavimentada <int>, deck_madeira_area <int>,
## #   varanda_aberta_area <int>, varanda_fechada_area <int>,
## #   varanda_3ssn_area <int>, varanda_com_tela_area <int>, piscina_area <int>,
## #   piscina_qualidade <int>, cerca_qualidade <int>,
## #   funcionalidades_diversas <int>, funcionalidades_valor <int>,
## #   venda_mes <int>, venda_ano <int>, venda_tipo <int>, venda_condicao <int>,
## #   venda_valor <int>
```

Para fazer essa mesma operação, antes utilizaríamos a função `summarise_all()`.


```r
casas %>% 
  summarise_all(.funs = ~n_distinct(.x))
```

```
## # A tibble: 1 x 82
##   ordem   pid moradia_classe moradia_zoneamento lote_fachada lote_area rua_tipo
##   <int> <int>          <int>              <int>        <int>     <int>    <int>
## 1  2930  2930             16                  7          129      1960        2
## # … with 75 more variables: beco_tipo <int>, lote_formato <int>,
## #   terreno_contorno <int>, utilidades <int>, lote_config <int>,
## #   terreno_declive <int>, vizinhanca <int>, condicao_1 <int>,
## #   condicao_2 <int>, moradia_tipo <int>, moradia_estilo <int>,
## #   geral_qualidade <int>, geral_condicao <int>, construcao_ano <int>,
## #   remodelacao_ano <int>, telhado_estilo <int>, telhado_material <int>,
## #   exterior_cobertura_1 <int>, exterior_cobertura_2 <int>,
## #   alvenaria_tipo <int>, alvenaria_area <int>, exterior_qualidade <int>,
## #   exterior_condicao <int>, fundacao_tipo <int>, porao_qualidade <int>,
## #   porao_condicao <int>, porao_exposicao <int>, porao_acabamento_1 <int>,
## #   porao_area_com_acabamento_1 <int>, porao_acabamento_2 <int>,
## #   porao_area_com_acabamento_2 <int>, porao_area_sem_acabamento <int>,
## #   porao_area_total <int>, porao_num_banheiros <int>,
## #   porao_num_banheiros_lavabos <int>, aquecimento_tipo <int>,
## #   aquecimento_qualidade_condicao <int>, ar_condicionado_central <int>,
## #   sistema_eletrico_tipo <int>, primeiro_andar_area <int>,
## #   segundo_andar_area <int>, acabamento_baixa_qualidade_area <int>,
## #   acima_solo_area <int>, acima_solo_num_banheiros <int>,
## #   acima_solo_num_lavabos <int>, acima_solo_num_quartos <int>,
## #   acima_solo_num_cozinhas <int>, cozinha_qualidade <int>,
## #   acima_solo_num_comodos <int>, funcional <int>, total_num_lareiras <int>,
## #   lareira_qualidade <int>, garagem_tipo <int>, garagem_ano_construcao <int>,
## #   garagem_acabamento <int>, garagem_capacidade_carros <int>,
## #   garagem_area <int>, garagem_qualidade <int>, garagem_condicao <int>,
## #   entrada_veiculo_pavimentada <int>, deck_madeira_area <int>,
## #   varanda_aberta_area <int>, varanda_fechada_area <int>,
## #   varanda_3ssn_area <int>, varanda_com_tela_area <int>, piscina_area <int>,
## #   piscina_qualidade <int>, cerca_qualidade <int>,
## #   funcionalidades_diversas <int>, funcionalidades_valor <int>,
## #   venda_mes <int>, venda_ano <int>, venda_tipo <int>, venda_condicao <int>,
## #   venda_valor <int>
```

Se quisermos selecionar as colunas a serem modificadas a partir de um teste lógico, utilizamos o ajudante `where()`.

No exemplo abaixo, calculamos o número de valores distintos das colunas de categóricas.


```r
casas %>%
  summarise(across(where(is.character), n_distinct))
```

```
## # A tibble: 1 x 47
##     pid moradia_classe moradia_zoneamento rua_tipo beco_tipo lote_formato
##   <int>          <int>              <int>    <int>     <int>        <int>
## 1  2930             16                  7        2         3            4
## # … with 41 more variables: terreno_contorno <int>, utilidades <int>,
## #   lote_config <int>, terreno_declive <int>, vizinhanca <int>,
## #   condicao_1 <int>, condicao_2 <int>, moradia_tipo <int>,
## #   moradia_estilo <int>, geral_qualidade <int>, geral_condicao <int>,
## #   telhado_estilo <int>, telhado_material <int>, exterior_cobertura_1 <int>,
## #   exterior_cobertura_2 <int>, alvenaria_tipo <int>, exterior_qualidade <int>,
## #   exterior_condicao <int>, fundacao_tipo <int>, porao_qualidade <int>,
## #   porao_condicao <int>, porao_exposicao <int>, porao_acabamento_1 <int>,
## #   porao_acabamento_2 <int>, aquecimento_tipo <int>,
## #   aquecimento_qualidade_condicao <int>, ar_condicionado_central <int>,
## #   sistema_eletrico_tipo <int>, cozinha_qualidade <int>, funcional <int>,
## #   lareira_qualidade <int>, garagem_tipo <int>, garagem_acabamento <int>,
## #   garagem_qualidade <int>, garagem_condicao <int>,
## #   entrada_veiculo_pavimentada <int>, piscina_qualidade <int>,
## #   cerca_qualidade <int>, funcionalidades_diversas <int>, venda_tipo <int>,
## #   venda_condicao <int>
```

Todas as colunas da base resultante eram colunas com classe `character` na base `casas`.

Anteriormente, utilizávamos a função `summarise_if()`.


```r
casas %>%
  summarise_if(is.character, n_distinct)
```

```
## # A tibble: 1 x 47
##     pid moradia_classe moradia_zoneamento rua_tipo beco_tipo lote_formato
##   <int>          <int>              <int>    <int>     <int>        <int>
## 1  2930             16                  7        2         3            4
## # … with 41 more variables: terreno_contorno <int>, utilidades <int>,
## #   lote_config <int>, terreno_declive <int>, vizinhanca <int>,
## #   condicao_1 <int>, condicao_2 <int>, moradia_tipo <int>,
## #   moradia_estilo <int>, geral_qualidade <int>, geral_condicao <int>,
## #   telhado_estilo <int>, telhado_material <int>, exterior_cobertura_1 <int>,
## #   exterior_cobertura_2 <int>, alvenaria_tipo <int>, exterior_qualidade <int>,
## #   exterior_condicao <int>, fundacao_tipo <int>, porao_qualidade <int>,
## #   porao_condicao <int>, porao_exposicao <int>, porao_acabamento_1 <int>,
## #   porao_acabamento_2 <int>, aquecimento_tipo <int>,
## #   aquecimento_qualidade_condicao <int>, ar_condicionado_central <int>,
## #   sistema_eletrico_tipo <int>, cozinha_qualidade <int>, funcional <int>,
## #   lareira_qualidade <int>, garagem_tipo <int>, garagem_acabamento <int>,
## #   garagem_qualidade <int>, garagem_condicao <int>,
## #   entrada_veiculo_pavimentada <int>, piscina_qualidade <int>,
## #   cerca_qualidade <int>, funcionalidades_diversas <int>, venda_tipo <int>,
## #   venda_condicao <int>
```

Com o `across()`, podemos combinar os efeitos de um `summarise_if()` e um `summarise_at()` em um único `summarise()`. A seguir, calculamos as áreas médias, garantindo que pegamos apenas variáveis numéricas.


```r
casas %>%
  summarise(across(where(is.numeric) & contains("_area"), mean, na.rm = TRUE))
```

```
## # A tibble: 1 x 17
##   lote_area alvenaria_area porao_area_com_ac… porao_area_com_a… porao_area_sem_…
##       <dbl>          <dbl>              <dbl>             <dbl>            <dbl>
## 1    10148.           102.               443.              49.7             559.
## # … with 12 more variables: porao_area_total <dbl>, primeiro_andar_area <dbl>,
## #   segundo_andar_area <dbl>, acabamento_baixa_qualidade_area <dbl>,
## #   acima_solo_area <dbl>, garagem_area <dbl>, deck_madeira_area <dbl>,
## #   varanda_aberta_area <dbl>, varanda_fechada_area <dbl>,
## #   varanda_3ssn_area <dbl>, varanda_com_tela_area <dbl>, piscina_area <dbl>
```

Além disso, com a função `across()`, podemos fazer sumarizações complexas que não seria possível utilizando apenas as funções `summarise()`, `summarise_if()` e `summarise_at()`. No exemplo a seguir, calculamos a média das áreas, o número de `NAs` de variáveis categóricas e o número de casas para cada tipo de fundação. Tudo em um mesmo `summarise()`!


```r
casas %>%
  group_by(fundacao_tipo) %>%
  summarise(
    across(where(is.numeric) & contains("area"), mean, na.rm = TRUE),
    across(where(is.character), ~sum(is.na(.x))),
    n_obs = n(),
  ) %>% 
  select(1:4, n_obs)
```

```
## # A tibble: 6 x 5
##   fundacao_tipo       lote_area alvenaria_area porao_area_com_acabamento_1 n_obs
##   <chr>                   <dbl>          <dbl>                       <dbl> <int>
## 1 bloco de concreto      10616.           85.0                       468.   1244
## 2 concreto derrramado    10054.          144.                        506.   1310
## 3 laje                   10250.           35.2                         0      49
## 4 madeira                 9838.           16                         812.      5
## 5 pedra                   8659.            0                          43.9    11
## 6 tijolo e telha          8712.           10.2                       151.    311
```

Embora a nova sintaxe, usando `across()`, não seja muito diferente do que fazíamos antes, realizar sumarizações complexas não é a única vantagem desse novo *framework*.

O `across()` pode ser utilizado em todos os verbos do `{dplyr}` (com exceção do `select()` e `rename()`, já que ele não trás vantagens com relação ao que já podia ser feito) e isso unifica o modo de fazermos essas operações no `dplyr`. Em vez de termos uma família de funções para cada verbo, temos agora apenas o próprio verbo e a função `across()`.

Vamos ver um exemplo para o `mutate()` e para o `filter()`.

O código abaixo transforma todas as variáveis que possuem "area" no nome, passando os valores de pés quadrados para metros quadrados.


```r
casas %>%
  mutate(across(
    contains("area"),
    ~ .x / 10.764
  ))
```

Já o código a seguir filtra apenas as casas que possuem varanda aberta, cerca e lareira (o `NA` nessa base significa que a casa não possui tal característica).


```r
casas %>%
  filter(across(
    c(varanda_aberta_area, cerca_qualidade, lareira_qualidade),
    ~!is.na(.x)
  )) 
```

Não precisamos do `across()` na hora de selecionar colunas. A função `select()` já usa naturalmente o mecanismo de seleção de colunas que o `across()` proporciona.


```r
casas %>%
  select(where(is.numeric))
```

```
## # A tibble: 2,930 x 35
##    ordem lote_fachada lote_area construcao_ano remodelacao_ano alvenaria_area
##    <int>        <int>     <int>          <int>           <int>          <int>
##  1     1          141     31770           1960            1960            112
##  2     2           80     11622           1961            1961              0
##  3     3           81     14267           1958            1958            108
##  4     4           93     11160           1968            1968              0
##  5     5           74     13830           1997            1998              0
##  6     6           78      9978           1998            1998             20
##  7     7           41      4920           2001            2001              0
##  8     8           43      5005           1992            1992              0
##  9     9           39      5389           1995            1996              0
## 10    10           60      7500           1999            1999              0
## # … with 2,920 more rows, and 29 more variables:
## #   porao_area_com_acabamento_1 <int>, porao_area_com_acabamento_2 <int>,
## #   porao_area_sem_acabamento <int>, porao_area_total <int>,
## #   porao_num_banheiros <int>, porao_num_banheiros_lavabos <int>,
## #   primeiro_andar_area <int>, segundo_andar_area <int>,
## #   acabamento_baixa_qualidade_area <int>, acima_solo_area <int>,
## #   acima_solo_num_banheiros <int>, acima_solo_num_lavabos <int>,
## #   acima_solo_num_quartos <int>, acima_solo_num_cozinhas <int>,
## #   acima_solo_num_comodos <int>, total_num_lareiras <int>,
## #   garagem_ano_construcao <int>, garagem_capacidade_carros <int>,
## #   garagem_area <int>, deck_madeira_area <int>, varanda_aberta_area <int>,
## #   varanda_fechada_area <int>, varanda_3ssn_area <int>,
## #   varanda_com_tela_area <int>, piscina_area <int>,
## #   funcionalidades_valor <int>, venda_mes <int>, venda_ano <int>,
## #   venda_valor <int>
```

O mesmo vale para o `rename()`. Se quisermos renomer várias colunas, a partir de uma função, utilizamos o `rename_with()`.


```r
casas %>%
  rename_with(toupper, contains("venda"))
```

```
## # A tibble: 2,930 x 82
##    ordem pid    moradia_classe  moradia_zoneame… lote_fachada lote_area rua_tipo
##    <int> <chr>  <chr>           <chr>                   <int>     <int> <chr>   
##  1     1 05263… 020             Residencial bai…          141     31770 pavimen…
##  2     2 05263… 020             Residencial alt…           80     11622 pavimen…
##  3     3 05263… 020             Residencial bai…           81     14267 pavimen…
##  4     4 05263… 020             Residencial bai…           93     11160 pavimen…
##  5     5 05271… 060             Residencial bai…           74     13830 pavimen…
##  6     6 05271… 060             Residencial bai…           78      9978 pavimen…
##  7     7 05271… desenvolviment… Residencial bai…           41      4920 pavimen…
##  8     8 05271… desenvolviment… Residencial bai…           43      5005 pavimen…
##  9     9 05271… desenvolviment… Residencial bai…           39      5389 pavimen…
## 10    10 05271… 060             Residencial bai…           60      7500 pavimen…
## # … with 2,920 more rows, and 75 more variables: beco_tipo <chr>,
## #   lote_formato <chr>, terreno_contorno <chr>, utilidades <chr>,
## #   lote_config <chr>, terreno_declive <chr>, vizinhanca <chr>,
## #   condicao_1 <chr>, condicao_2 <chr>, moradia_tipo <chr>,
## #   moradia_estilo <chr>, geral_qualidade <chr>, geral_condicao <chr>,
## #   construcao_ano <int>, remodelacao_ano <int>, telhado_estilo <chr>,
## #   telhado_material <chr>, exterior_cobertura_1 <chr>,
## #   exterior_cobertura_2 <chr>, alvenaria_tipo <chr>, alvenaria_area <int>,
## #   exterior_qualidade <chr>, exterior_condicao <chr>, fundacao_tipo <chr>,
## #   porao_qualidade <chr>, porao_condicao <chr>, porao_exposicao <chr>,
## #   porao_acabamento_1 <chr>, porao_area_com_acabamento_1 <int>,
## #   porao_acabamento_2 <chr>, porao_area_com_acabamento_2 <int>,
## #   porao_area_sem_acabamento <int>, porao_area_total <int>,
## #   porao_num_banheiros <int>, porao_num_banheiros_lavabos <int>,
## #   aquecimento_tipo <chr>, aquecimento_qualidade_condicao <chr>,
## #   ar_condicionado_central <chr>, sistema_eletrico_tipo <chr>,
## #   primeiro_andar_area <int>, segundo_andar_area <int>,
## #   acabamento_baixa_qualidade_area <int>, acima_solo_area <int>,
## #   acima_solo_num_banheiros <int>, acima_solo_num_lavabos <int>,
## #   acima_solo_num_quartos <int>, acima_solo_num_cozinhas <int>,
## #   cozinha_qualidade <chr>, acima_solo_num_comodos <int>, funcional <chr>,
## #   total_num_lareiras <int>, lareira_qualidade <chr>, garagem_tipo <chr>,
## #   garagem_ano_construcao <int>, garagem_acabamento <chr>,
## #   garagem_capacidade_carros <int>, garagem_area <int>,
## #   garagem_qualidade <chr>, garagem_condicao <chr>,
## #   entrada_veiculo_pavimentada <chr>, deck_madeira_area <int>,
## #   varanda_aberta_area <int>, varanda_fechada_area <int>,
## #   varanda_3ssn_area <int>, varanda_com_tela_area <int>, piscina_area <int>,
## #   piscina_qualidade <chr>, cerca_qualidade <chr>,
## #   funcionalidades_diversas <chr>, funcionalidades_valor <int>,
## #   VENDA_MES <int>, VENDA_ANO <int>, VENDA_TIPO <chr>, VENDA_CONDICAO <chr>,
## #   VENDA_VALOR <int>
```

#### A função `relocate()` {-}

O `{dplyr}` possui agora uma função própria para reorganizar colunas: `relocate()`. Por padrão, ela coloca uma ou mais colunas no começo da base.


```r
casas %>%
  relocate(venda_valor, venda_tipo)
```

```
## # A tibble: 2,930 x 82
##    venda_valor venda_tipo ordem pid    moradia_classe          moradia_zoneamen…
##          <int> <chr>      <int> <chr>  <chr>                   <chr>            
##  1      215000 "WD "          1 05263… 020                     Residencial baix…
##  2      105000 "WD "          2 05263… 020                     Residencial alta…
##  3      172000 "WD "          3 05263… 020                     Residencial baix…
##  4      244000 "WD "          4 05263… 020                     Residencial baix…
##  5      189900 "WD "          5 05271… 060                     Residencial baix…
##  6      195500 "WD "          6 05271… 060                     Residencial baix…
##  7      213500 "WD "          7 05271… desenvolvimento de uni… Residencial baix…
##  8      191500 "WD "          8 05271… desenvolvimento de uni… Residencial baix…
##  9      236500 "WD "          9 05271… desenvolvimento de uni… Residencial baix…
## 10      189000 "WD "         10 05271… 060                     Residencial baix…
## # … with 2,920 more rows, and 76 more variables: lote_fachada <int>,
## #   lote_area <int>, rua_tipo <chr>, beco_tipo <chr>, lote_formato <chr>,
## #   terreno_contorno <chr>, utilidades <chr>, lote_config <chr>,
## #   terreno_declive <chr>, vizinhanca <chr>, condicao_1 <chr>,
## #   condicao_2 <chr>, moradia_tipo <chr>, moradia_estilo <chr>,
## #   geral_qualidade <chr>, geral_condicao <chr>, construcao_ano <int>,
## #   remodelacao_ano <int>, telhado_estilo <chr>, telhado_material <chr>,
## #   exterior_cobertura_1 <chr>, exterior_cobertura_2 <chr>,
## #   alvenaria_tipo <chr>, alvenaria_area <int>, exterior_qualidade <chr>,
## #   exterior_condicao <chr>, fundacao_tipo <chr>, porao_qualidade <chr>,
## #   porao_condicao <chr>, porao_exposicao <chr>, porao_acabamento_1 <chr>,
## #   porao_area_com_acabamento_1 <int>, porao_acabamento_2 <chr>,
## #   porao_area_com_acabamento_2 <int>, porao_area_sem_acabamento <int>,
## #   porao_area_total <int>, porao_num_banheiros <int>,
## #   porao_num_banheiros_lavabos <int>, aquecimento_tipo <chr>,
## #   aquecimento_qualidade_condicao <chr>, ar_condicionado_central <chr>,
## #   sistema_eletrico_tipo <chr>, primeiro_andar_area <int>,
## #   segundo_andar_area <int>, acabamento_baixa_qualidade_area <int>,
## #   acima_solo_area <int>, acima_solo_num_banheiros <int>,
## #   acima_solo_num_lavabos <int>, acima_solo_num_quartos <int>,
## #   acima_solo_num_cozinhas <int>, cozinha_qualidade <chr>,
## #   acima_solo_num_comodos <int>, funcional <chr>, total_num_lareiras <int>,
## #   lareira_qualidade <chr>, garagem_tipo <chr>, garagem_ano_construcao <int>,
## #   garagem_acabamento <chr>, garagem_capacidade_carros <int>,
## #   garagem_area <int>, garagem_qualidade <chr>, garagem_condicao <chr>,
## #   entrada_veiculo_pavimentada <chr>, deck_madeira_area <int>,
## #   varanda_aberta_area <int>, varanda_fechada_area <int>,
## #   varanda_3ssn_area <int>, varanda_com_tela_area <int>, piscina_area <int>,
## #   piscina_qualidade <chr>, cerca_qualidade <chr>,
## #   funcionalidades_diversas <chr>, funcionalidades_valor <int>,
## #   venda_mes <int>, venda_ano <int>, venda_condicao <chr>
```

Podemos usar os argumentos `.after` e `.before` para fazer mudanças mais complexas.

O código baixo coloca a coluna `venda_ano` depois da coluna `construcao_ano`.


```r
casas %>%
  relocate(venda_ano, .after = construcao_ano)
```


O código baixo coloca a coluna `venda_ano` antes da coluna `construcao_ano`.


```r
casas %>%
  relocate(venda_ano, .before = construcao_ano)
```

#### A função `rowwise()` {-}

Por fim, vamos discutir operações feitas por linha. Tome como exemplo a tabela abaixo. Ela apresenta as notas de alunos em quatro provas.


```r
tab_notas <- tibble(
  student_id = 1:5,
  prova1 = sample(0:10, 5),
  prova2 = sample(0:10, 5),
  prova3 = sample(0:10, 5),
  prova4 = sample(0:10, 5)
)

tab_notas
```

```
## # A tibble: 5 x 5
##   student_id prova1 prova2 prova3 prova4
##        <int>  <int>  <int>  <int>  <int>
## 1          1      5      7      6      1
## 2          2      4      3      7      7
## 3          3      0      0      9      8
## 4          4      2      6     10      5
## 5          5      3     10      8      3
```

Se quisermos gerar uma coluna com a nota média de cada aluno nas quatro provas, não poderíamos usar o `mutate()` diretamente.


```r
tab_notas %>% mutate(media = mean(c(prova1, prova2, prova3, prova4)))
```

```
## # A tibble: 5 x 6
##   student_id prova1 prova2 prova3 prova4 media
##        <int>  <int>  <int>  <int>  <int> <dbl>
## 1          1      5      7      6      1   5.2
## 2          2      4      3      7      7   5.2
## 3          3      0      0      9      8   5.2
## 4          4      2      6     10      5   5.2
## 5          5      3     10      8      3   5.2
```

Neste caso, todas as colunas estão sendo empilhadas e gerando uma única média, passada a todas as linhas da coluna `media`.

Para fazermos a conta para cada aluno, podemos agrupar por aluno. Agora sim a média é calculada apenas nas notas de cada estudante.


```r
tab_notas %>%
  group_by(student_id) %>%
  mutate(media = mean(c(prova1, prova2, prova3, prova4)))
```

```
## # A tibble: 5 x 6
## # Groups:   student_id [5]
##   student_id prova1 prova2 prova3 prova4 media
##        <int>  <int>  <int>  <int>  <int> <dbl>
## 1          1      5      7      6      1  4.75
## 2          2      4      3      7      7  5.25
## 3          3      0      0      9      8  4.25
## 4          4      2      6     10      5  5.75
## 5          5      3     10      8      3  6
```

Também podemos nos aproveitar da sintaxe do `across()` neste caso. Para isso, precisamos substutir a função `c()` pela função `c_across()`.


```r
tab_notas %>%
  group_by(student_id) %>%
  mutate(media = mean(c_across(starts_with("prova"))))
```

```
## # A tibble: 5 x 6
## # Groups:   student_id [5]
##   student_id prova1 prova2 prova3 prova4 media
##        <int>  <int>  <int>  <int>  <int> <dbl>
## 1          1      5      7      6      1  4.75
## 2          2      4      3      7      7  5.25
## 3          3      0      0      9      8  4.25
## 4          4      2      6     10      5  5.75
## 5          5      3     10      8      3  6
```

Equivalentemente ao `group_by()`, neste caso, podemos usar a função `rowwise()`.


```r
tab_notas %>%
  rowwise(student_id) %>%
  mutate(media = mean(c_across(starts_with("prova"))))
```

```
## # A tibble: 5 x 6
## # Rowwise:  student_id
##   student_id prova1 prova2 prova3 prova4 media
##        <int>  <int>  <int>  <int>  <int> <dbl>
## 1          1      5      7      6      1  4.75
## 2          2      4      3      7      7  5.25
## 3          3      0      0      9      8  4.25
## 4          4      2      6     10      5  5.75
## 5          5      3     10      8      3  6
```

Ela é muito útil quando queremos fazer operação por linhas, mas não temos uma coluna de identificação. Por padrão, se não indicarmos nenhuma coluna, cada linha será um "grupo".


```r
tab_notas %>%
  rowwise() %>%
  mutate(media = mean(c_across(starts_with("prova"))))
```

```
## # A tibble: 5 x 6
## # Rowwise: 
##   student_id prova1 prova2 prova3 prova4 media
##        <int>  <int>  <int>  <int>  <int> <dbl>
## 1          1      5      7      6      1  4.75
## 2          2      4      3      7      7  5.25
## 3          3      0      0      9      8  4.25
## 4          4      2      6     10      5  5.75
## 5          5      3     10      8      3  6
```

Veja que `student_id` não é passada para a função `rowwise()`. Não precisaríamos dessa coluna na base para reproduzir a geração da columa `media` neste caso.

#### Exercícios {-}

A base `casas` abaixo pode ser encontrada a partir do código abaixo:


```r
remotes::install_github("cienciadedatos/dados")
dados::casas
```


**1.** Reescreva os códigos abaixo utilizando as funções `across()` e `where()`.

**a.** 


```r
casas %>%
  group_by(geral_qualidade) %>%
  summarise(
    acima_solo_area_media = mean(acima_solo_area, na.rm = TRUE),
    garagem_area_media = mean(garagem_area, na.rm = TRUE),
    valor_venda_medio = mean(venda_valor, na.rm = TRUE)
  )
```

**b.**


```r
casas %>%
  filter_at(
    vars(porao_qualidade, varanda_fechada_area, cerca_qualidade),
    ~!is.na(.x)
  )
```

**c.**


```r
casas %>%
  mutate_if(is.character, ~tidyr::replace_na(.x, replace = "Não possui"))
```

**2.** Utilizando a base `casas`, resolva os itens a seguir.

- **a.** Usando o `case_when()` crie um código para categorizar a variável venda_valor da seguinte maneira:

  - **barata**: \$0 a \$129.500  
  - **preço mediano**: \$129.500 a \$180.796
  - **cara**: \$ 180.796 a \$213.500
  - **muito cara**: maior que \$213.500

<div style = "height: 10px;"></div>

- **b.** Utilize o código feito na letra (a) para agrupar a base `casas` pela variável venda_valor categorizada e calcular todas as áreas médias para cada uma dessas categorias.

**3.** Escreva um código que receba a base `casas` e retorne uma tabela com apenas

- **a.** as colunas referentes à garagem da casa.

- **b.** as colunas referentes a variáveis de qualidade.

- **c.** colunas numéricas que representam áreas da casa e do terreno.

- **d.** colunas numéricas.

- **e.** colunas referentes à piscina, porão e o valor de venda.

**4.** Usando a função `rename_with()`, troque todos os `"_"` dos nomes das colunas por um espaço `" "`.

**5.** Escreva um código para colocar todas as colunas relativas a venda no começo da base `casas`.

**6.** 5. Escreva um código para colocar todas as colunas numéricas da base `casas` no começo da tabela e todas as colunas categóricas no final.


