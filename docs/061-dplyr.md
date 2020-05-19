## O pacote dplyr


O `dplyr` é o pacote mais útil para realizar transformação de dados, aliando simplicidade e eficiência de uma forma elegante. Os scripts em R que fazem uso inteligente dos verbos `dplyr` e as facilidades do operador _pipe_ tendem a ficar mais legíveis e organizados sem perder velocidade de execução.

As principais funções do `dplyr` são:

- `filter()` - filtra linhas
- `select()` - seleciona colunas
- `arrange()` - ordena a base
- `mutate()` - cria/modifica colunas
- `group_by()` - agrupa a base
- `summarise()` - sumariza a base

Todas essas funções seguem as mesmas características:

- O _input_  é sempre uma `tibble` e o _output_  é sempre um `tibble`.
- Colocamos o `tibble` no primeiro argumento e o que queremos fazer nos outros argumentos.
- A utilização é facilitada com o emprego do operador `%>%`.
- O pacote faz uso extensivo de NSE (*non standard evaluation*).

As principais vantagens de se usar o `dplyr` em detrimento das funções do R base são:

- Manipular dados se torna uma tarefa muito mais simples.
- O código fica mais intuitivo de ser escrito e mais simples de ser lido.
- O pacote `dplyr` utiliza `C` e `C++` por trás da maioria das funções, o que geralmente torna o código mais eficiente.
- É possível trabalhar com diferentes fontes de dados, como bases relacionais (SQL) e `data.table`.



Agora, vamos avaliar com mais detalhes as principais funções do pacote `dplyr`.

-----------------------------------------------------

### Filtrando linhas

A função `filter()` filtra linhas. Ela é semelhante à função `subset()`, do R base. O código abaixo retorna apenas filmes com nota maior que nova.





```r
imdb %>%
  filter(nota_imdb > 9)
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

Para fazer várias condições, use os operadores lógicos `&` e `|` ou separe filtros entre vírgulas.


```r
imdb %>%
  filter(ano > 2010 & nota_imdb > 8.5)
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

```r
imdb %>%
  filter(receita > orcamento | nota_imdb > 9)
```

```
## # A tibble: 1,762 x 15
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
## # … with 1,752 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

O operador `%in%` é muito útil na hora de criar filtros. O resultado das operações com `%in%` é um vetor lógico o tamanho do vetor do elemento da esquerda, identificando quais elementos da esquerda batem com algum elemento da direita.


```r
letters %in% c("a", "e", "z")
```

```
##  [1]  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [13] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [25] FALSE  TRUE
```

```r
imdb %>%
  filter(diretor %in% c("Steven Spielberg", "Quentin Tarantino"))
```

```
## # A tibble: 32 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
##  1 India…  2008 Steven…     122 Color Action… USA   A partir de … 185000000
##  2 War o…  2005 Steven…     116 Color Advent… USA   A partir de … 132000000
##  3 The A…  2011 Steven…     107 Color Action… USA   Livre         135000000
##  4 Minor…  2002 Steven…     145 Color Action… USA   A partir de … 102000000
##  5 Djang…  2012 Quenti…     165 Color Drama|… USA   A partir de … 100000000
##  6 A.I. …  2001 Steven…     146 Color Advent… USA   A partir de … 100000000
##  7 The L…  1997 Steven…     129 Color Action… USA   A partir de …  73000000
##  8 The T…  2004 Steven…     128 Color Comedy… USA   A partir de …  60000000
##  9 Inglo…  2009 Quenti…     153 Color Advent… USA   A partir de …  75000000
## 10 Hook    1991 Steven…     142 Color Advent… USA   Livre          70000000
## # … with 22 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

Também podemos usar funções que retornam valores lógicos, como a `str_detect()`, do pacote `stringr`. Esse pacote possui funções para a manipulação de strings, e será abordado com mais detalhes quando falarmos sobre `stringr`.


```r
library(stringr)

imdb %>%
  filter(str_detect(generos, "Action"))
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

-----------------------------------------------------

### Selecionando colunas

A função `select()` seleciona colunas (variáveis). É possível utilizar nomes, índices, intervalos de variáveis ou utilizar as funções `starts_with(x)`, `contains(x)`, `matches(x)`, `one_of(x)` para selecionar as variáveis.


```r
imdb %>%
  select(titulo, ano, orcamento)
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

```r
imdb %>%
  select(starts_with("ator"))
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

O operador `:` pode ser usado para selecionar intervalos de colunas.


```r
imdb %>%
  select(titulo, ator_1:ator_3)
```

```
## # A tibble: 3,807 x 4
##    titulo                            ator_1        ator_2        ator_3         
##    <chr>                             <chr>         <chr>         <chr>          
##  1 Avatar                            CCH Pounder   Joel David M… Wes Studi      
##  2 Pirates of the Caribbean: At Wor… Johnny Depp   Orlando Bloom Jack Davenport 
##  3 The Dark Knight Rises             Tom Hardy     Christian Ba… Joseph Gordon-…
##  4 John Carter                       Daryl Sabara  Samantha Mor… Polly Walker   
##  5 Spider-Man 3                      J.K. Simmons  James Franco  Kirsten Dunst  
##  6 Tangled                           Brad Garrett  Donna Murphy  M.C. Gainey    
##  7 Avengers: Age of Ultron           Chris Hemswo… Robert Downe… Scarlett Johan…
##  8 Batman v Superman: Dawn of Justi… Henry Cavill  Lauren Cohan  Alan D. Purwin 
##  9 Superman Returns                  Kevin Spacey  Marlon Brando Frank Langella 
## 10 Pirates of the Caribbean: Dead M… Johnny Depp   Orlando Bloom Jack Davenport 
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

-----------------------------------------------------

### Ordenando a base

A função `arrange()` ordena a base segundo uma ou mais colunas. O argumento `desc=` pode ser utilizado para gerar uma ordem decrescente.


```r
imdb %>%
  arrange(orcamento) %>%
  select(orcamento, everything())
```

```
## # A tibble: 3,807 x 15
##    orcamento titulo   ano diretor duracao cor   generos pais  classificacao
##        <int> <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>        
##  1       218 Tarna…  2003 Jonath…      88 Color Biogra… USA   Outros       
##  2      1100 My Da…  2004 Jon Gu…      90 Color Docume… USA   Livre        
##  3      1400 A Pla…  2013 Benjam…      76 Color Drama|… USA   Outros       
##  4      3250 The M…  2005 Anthon…      84 Color Crime|… USA   A partir de …
##  5      7000 Prime…  2004 Shane …      77 Color Drama|… USA   A partir de …
##  6      7000 El Ma…  1992 Robert…      81 Color Action… USA   A partir de …
##  7      9000 Newly…  2011 Edward…      95 Color Comedy… USA   Outros       
##  8     10000 Pink …  1972 John W…     108 Color Comedy… USA   A partir de …
##  9     13000 The T…  2007 Jane C…       7 Color Romanc… USA   Outros       
## 10     15000 Paran…  2007 Oren P…      84 Color Horror  USA   A partir de …
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

```r
imdb %>%
  arrange(desc(orcamento)) %>%
  select(orcamento, everything())
```

```
## # A tibble: 3,807 x 15
##    orcamento titulo   ano diretor duracao cor   generos pais  classificacao
##        <int> <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>        
##  1 300000000 Pirat…  2007 Gore V…     169 Color Action… USA   A partir de …
##  2 263700000 John …  2012 Andrew…     132 Color Action… USA   A partir de …
##  3 260000000 Tangl…  2010 Nathan…     100 Color Advent… USA   Livre        
##  4 258000000 Spide…  2007 Sam Ra…     156 Color Action… USA   A partir de …
##  5 258000000 Spide…  2007 Sam Ra…     156 Color Action… USA   A partir de …
##  6 250000000 The D…  2012 Christ…     164 Color Action… USA   A partir de …
##  7 250000000 Aveng…  2015 Joss W…     141 Color Action… USA   A partir de …
##  8 250000000 Batma…  2016 Zack S…     183 Color Action… USA   A partir de …
##  9 250000000 Pirat…  2011 Rob Ma…     136 Color Action… USA   A partir de …
## 10 250000000 Capta…  2016 Anthon…     147 Color Action… USA   A partir de …
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

```r
imdb %>%
  arrange(desc(ano), titulo) %>%
  select(titulo, ano, everything())
```

```
## # A tibble: 3,807 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <int> <chr>     <int> <chr> <chr>   <chr> <chr>             <int>
##  1 10 Cl…  2016 Dan Tr…     104 Color Drama|… USA   A partir de …  15000000
##  2 13 Ho…  2016 Michae…     144 Color Action… USA   A partir de …  50000000
##  3 A Beg…  2016 Mitche…      87 Color Comedy… USA   Outros               NA
##  4 Alice…  2016 James …     113 Color Advent… USA   Livre         170000000
##  5 Alleg…  2016 Robert…     120 Color Action… USA   A partir de … 110000000
##  6 Allel…  2016 Darren…      97 Color Horror… USA   Outros           500000
##  7 Antib…  2016 Danny …      94 Color Horror  USA   Outros          3500000
##  8 Bad M…  2016 Jon Lu…     100 Color Comedy  USA   A partir de …  20000000
##  9 Bad M…  2016 Jon Lu…     100 Color Comedy  USA   A partir de …  20000000
## 10 Batma…  2016 Zack S…     183 Color Action… USA   A partir de … 250000000
## # … with 3,797 more rows, and 6 more variables: receita <int>, nota_imdb <dbl>,
## #   likes_facebook <int>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

-----------------------------------------------------

### Criando e modificando colunas

A função `mutate()` cria ou modifica colunas. Ela é equivalente à função `transform()`, mas aceita várias novas colunas iterativamente. Novas variáveis devem ter o mesmo número de linhas da base original (ou comprimento 1).


```r
# A coluna "duracao" é sobrescrita
imdb %>%
  mutate(duracao = duracao/60) %>%
  select(duracao)
```

```
## # A tibble: 3,807 x 1
##    duracao
##      <dbl>
##  1    2.97
##  2    2.82
##  3    2.73
##  4    2.2 
##  5    2.6 
##  6    1.67
##  7    2.35
##  8    3.05
##  9    2.82
## 10    2.52
## # … with 3,797 more rows
```

```r
# Criamos uma nova coluna na base
imdb %>%
  mutate(duracao_horas = duracao/60) %>%
  select(duracao, duracao_horas)
```

```
## # A tibble: 3,807 x 2
##    duracao duracao_horas
##      <int>         <dbl>
##  1     178          2.97
##  2     169          2.82
##  3     164          2.73
##  4     132          2.2 
##  5     156          2.6 
##  6     100          1.67
##  7     141          2.35
##  8     183          3.05
##  9     169          2.82
## 10     151          2.52
## # … with 3,797 more rows
```

```r
# Podemos fazer diversas operações em um mesmo mutate.
imdb %>%
  mutate(
    lucro = receita - orcamento,
    resultado = ifelse(lucro < 0, "prejuizo", "lucro")
  ) %>%
  select(lucro, resultado)
```

```
## # A tibble: 3,807 x 2
##         lucro resultado
##         <int> <chr>    
##  1  523505847 lucro    
##  2    9404152 lucro    
##  3  198130642 lucro    
##  4 -190641321 prejuizo 
##  5   78530303 lucro    
##  6  -59192738 prejuizo 
##  7  208991599 lucro    
##  8   80249062 lucro    
##  9   -8930592 prejuizo 
## 10  198032628 lucro    
## # … with 3,797 more rows
```

-----------------------------------------------------

### Summarisando a base

A função `summarise()` sumariza a base. Ela aplica uma função às variáveis, retornando um vetor de tamanho `1`. Ela é utilizada em conjunto da função `group_by()`. A função `n()` costuma ser bastante utilizada com a função summarise().



```r
imdb %>%
  summarise(media_orcamento = mean(orcamento, na.rm = TRUE))
```

```
## # A tibble: 1 x 1
##   media_orcamento
##             <dbl>
## 1       35755986.
```

```r
imdb %>%
  summarise(
    media_orcamento = mean(orcamento, na.rm = TRUE),
    mediana_orcamento = median(orcamento, na.rm = TRUE),
    qtd = n(),
    qtd_diretores = n_distinct(diretor)
  )
```

```
## # A tibble: 1 x 4
##   media_orcamento mediana_orcamento   qtd qtd_diretores
##             <dbl>             <int> <int>         <int>
## 1       35755986.          20000000  3807          1813
```

```r
imdb %>%
  group_by(ano) %>%
  summarise(qtd_filmes = n())
```

```
## # A tibble: 91 x 2
##      ano qtd_filmes
##    <int>      <int>
##  1  1916          1
##  2  1920          1
##  3  1925          1
##  4  1929          1
##  5  1930          1
##  6  1932          1
##  7  1933          2
##  8  1934          1
##  9  1935          1
## 10  1936          2
## # … with 81 more rows
```

```r
imdb %>%
  group_by(diretor) %>%
  summarise(orcamento_medio = mean(orcamento, na.rm = TRUE))
```

```
## # A tibble: 1,813 x 2
##    diretor          orcamento_medio
##    <chr>                      <dbl>
##  1 A. Raven Cruz            1000000
##  2 Aaron Hann                   NaN
##  3 Aaron Schneider          7500000
##  4 Aaron Seltzer           20000000
##  5 Abel Ferrara            12500000
##  6 Adam Carolla             1500000
##  7 Adam Goldberg            1650000
##  8 Adam Green               1500000
##  9 Adam Jay Epstein             NaN
## 10 Adam Marcus              2500000
## # … with 1,803 more rows
```

### Juntando duas bases

Para juntar duas tabelas de dados, podemos utilizar a família de funções `_join()` do `dplyr`. Essas funções geralmente recebem três argumentos: uma base esquerda (`x=`), uma base direita (`y=`) e uma chave `by=`. As principais funções `_join()` são:

- `left_join(x, y)`: retorna todas as linhas da base `x` e todas as colunas das bases `x` e `y`. Linhas de `x` sem correspondentes em `y` receberão `NA` na nova base.
- `right_join()`: retorna todas as linhas da base `y` e todas as colunas das bases `x` e `y`. Linhas de `y` sem correspondentes em `x` receberão `NA` na nova base.
- `full_join()`: retorna todas as linhas e colunas de `x`e `y`. Valores sem correspondência entre as bases receberão `NA` na nova base.

A figura a seguir esquematiza as operações dessas funções:

<img src="img/manipulacao/joins.png" style="display: block; margin: auto;" />

A figura a seguir mostra o que acontece quando temos chaves duplicadas em um `left_join()`. A ideia é equivalante para as outras funções.

<img src="img/manipulacao/left-join.png" style="display: block; margin: auto;" />


