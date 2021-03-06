## O pacote dplyr




### Selecionando colunas {-}

Utilize a base `imdb` nos exercícios a seguir.

**1.** Teste aplicar a função `glimpse()` do pacote `{dplyr}` à base `imdb`. O que ela faz?


```r
glimpse(imdb)
```

```
## Rows: 3,807
## Columns: 15
## $ titulo         <chr> "Avatar ", "Pirates of the Caribbean: At World's End ",…
## $ ano            <dbl> 2009, 2007, 2012, 2012, 2007, 2010, 2015, 2016, 2006, 2…
## $ diretor        <chr> "James Cameron", "Gore Verbinski", "Christopher Nolan",…
## $ duracao        <dbl> 178, 169, 164, 132, 156, 100, 141, 183, 169, 151, 150, …
## $ cor            <chr> "Color", "Color", "Color", "Color", "Color", "Color", "…
## $ generos        <chr> "Action|Adventure|Fantasy|Sci-Fi", "Action|Adventure|Fa…
## $ pais           <chr> "USA", "USA", "USA", "USA", "USA", "USA", "USA", "USA",…
## $ classificacao  <chr> "A partir de 13 anos", "A partir de 13 anos", "A partir…
## $ orcamento      <dbl> 237000000, 300000000, 250000000, 263700000, 258000000, …
## $ receita        <dbl> 760505847, 309404152, 448130642, 73058679, 336530303, 2…
## $ nota_imdb      <dbl> 7.9, 7.1, 8.5, 6.6, 6.2, 7.8, 7.5, 6.9, 6.1, 7.3, 6.5, …
## $ likes_facebook <dbl> 33000, 0, 164000, 24000, 0, 29000, 118000, 197000, 0, 5…
## $ ator_1         <chr> "CCH Pounder", "Johnny Depp", "Tom Hardy", "Daryl Sabar…
## $ ator_2         <chr> "Joel David Moore", "Orlando Bloom", "Christian Bale", …
## $ ator_3         <chr> "Wes Studi", "Jack Davenport", "Joseph Gordon-Levitt", …
```

*A função `glimpse()` traz um resumo da base, contendo o número de linhas, colunas, o nome e tipo das colunas e as primeiras observações de cada coluna.*

---

**2.** Crie uma tabela com apenas as colunas `titulo`, `diretor`, e `orcamento.` Salve em um objeto chamado `imdb_simples`.


```r
imdb_simples <- select(imdb, titulo, diretor, orcamento)
imdb_simples
```

```
## # A tibble: 3,807 x 3
##    titulo                                      diretor           orcamento
##    <chr>                                       <chr>                 <dbl>
##  1 Avatar                                      James Cameron     237000000
##  2 Pirates of the Caribbean: At World's End    Gore Verbinski    300000000
##  3 The Dark Knight Rises                       Christopher Nolan 250000000
##  4 John Carter                                 Andrew Stanton    263700000
##  5 Spider-Man 3                                Sam Raimi         258000000
##  6 Tangled                                     Nathan Greno      260000000
##  7 Avengers: Age of Ultron                     Joss Whedon       250000000
##  8 Batman v Superman: Dawn of Justice          Zack Snyder       250000000
##  9 Superman Returns                            Bryan Singer      209000000
## 10 Pirates of the Caribbean: Dead Man's Chest  Gore Verbinski    225000000
## # … with 3,797 more rows
```

---

**3.** Selecione apenas as colunas `ator_1`, `ator_2` e `ator_3` usando o ajudante `contains()`.


```r
select(imdb, contains("ator"))
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

---

**4.** Usando a função `select()` (e seus ajudantes), escreva códigos que retornem a base IMDB sem as colunas `ator_1`, `ator_2` e `ator_3.` Escreva todas as soluções diferentes que você conseguir pensar. 


```r
select(imdb, -starts_with("ator"))

select(imdb, -ator_1, -ator_2, -ator_3)

select(imdb, -(ator_1:ator_3))

select(imdb, titulo:likes_facebook)

select(imdb, -contains("ator"))
```

### Ordenando a base {-}

**1.** Ordene os filmes em ordem crescente de `ano` e decrescente de `receita` e salve em um objeto chamado `filmes_ordenados`.


```r
filmes_ordenados <- arrange(imdb, ano, desc(receita))
```

---

**2.** Selecione apenas as colunas `titulo` e `orcamento` e então ordene de forma decrescente pelo `orcamento`.


```r
# Aninhando as funções
arrange(select(imdb, titulo, orcamento), desc(orcamento))

# Criando objeto intermediário
imdb_aux <- select(imdb, titulo, orcamento)
arrange(imdb_aux, desc(orcamento))

# Pipe s2
imdb %>% 
  select(titulo, orcamento) %>% 
  arrange(desc(orcamento))
```

### Filtrando linhas {-}

Utilize a base `imdb` nos exercícios a seguir.

**1.** Crie um objeto chamado `filmes_pb` apenas com filmes preto e branco.


```r
# Vendo categorias da variável cor
unique(imdb$cor)
```

```
## [1] "Color"           "Black and White" NA
```

```r
# Filtrando
imdb %>% filter(cor == "Black and White")
```

```
## # A tibble: 149 x 15
##    titulo     ano diretor  duracao cor    generos  pais  classificacao orcamento
##    <chr>    <dbl> <chr>      <dbl> <chr>  <chr>    <chr> <chr>             <dbl>
##  1 Pearl H…  2001 Michael…     184 Black… Action|… USA   A partir de … 140000000
##  2 The Avi…  2004 Martin …     170 Black… Biograp… USA   A partir de … 110000000
##  3 Ali       2001 Michael…     165 Black… Biograp… USA   A partir de … 107000000
##  4 Eragon    2006 Stefen …     104 Black… Action|… USA   Livre         100000000
##  5 Seabisc…  2003 Gary Ro…     140 Black… Drama|H… USA   A partir de …  87000000
##  6 Bewitch…    NA <NA>          25 Black… Comedy|… USA   Outros               NA
##  7 Nine      2009 Rob Mar…     118 Black… Drama|M… USA   A partir de …  80000000
##  8 The Lea…  2003 Stephen…     110 Black… Action|… USA   A partir de …  78000000
##  9 War Hor…  2011 Steven …     146 Black… Drama|W… USA   A partir de …  66000000
## 10 Space C…  2000 Clint E…     130 Black… Action|… USA   A partir de …  65000000
## # … with 139 more rows, and 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

---

**2.** Crie um objeto chamado `curtos_legais` com filmes de 90 minutos ou menos de duração e nota no imdb maior do que 8.5.


```r
curtos_legais <- imdb %>% 
  filter(duracao <= 90, nota_imdb > 8.5)
```

---

**3.** Retorne tabelas (`tibbles`) apenas com:

**a.** filmes coloridos anteriores a 1950;


```r
imdb %>% 
  filter(cor == "Color", ano < 1950)
```

```
## # A tibble: 14 x 15
##    titulo      ano diretor duracao cor   generos   pais  classificacao orcamento
##    <chr>     <dbl> <chr>     <dbl> <chr> <chr>     <chr> <chr>             <dbl>
##  1 Pinocchi…  1940 Norman…      88 Color Animatio… USA   Outros          2600000
##  2 Duel in …  1946 King V…     144 Color Drama|Ro… USA   Outros          8000000
##  3 Tycoon     1947 Richar…      95 Color Adventur… USA   Outros          3209000
##  4 State Fa…  1945 Walter…     100 Color Musical|… USA   Outros               NA
##  5 Gone wit…  1939 Victor…     226 Color Drama|Hi… USA   Outros          3977000
##  6 The Pira…  1948 Vincen…     102 Color Adventur… USA   Outros          3700000
##  7 It's a W…  1946 Frank …     118 Color Drama|Fa… USA   Livre           3180000
##  8 Bathing …  1944 George…     101 Color Comedy|M… USA   Outros          2361000
##  9 Fantasia   1940 James …     120 Color Animatio… USA   Outros          2280000
## 10 She Wore…  1949 John F…     103 Color Western   USA   Outros          1600000
## 11 Spellbou…  1945 Alfred…      95 Color Film-Noi… USA   Outros          1696377
## 12 Snow Whi…  1937 Willia…      83 Color Animatio… USA   Outros          2000000
## 13 Casablan…  1942 Michae…      82 Color Drama|Ro… USA   Livre            950000
## 14 Bambi      1942 James …      70 Color Animatio… USA   Outros               NA
## # … with 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


**b.** filmes do "Woody Allen" ou do "Wes Anderson";


```r
imdb %>% 
  filter(diretor == "Woody Allen" | diretor == "Wes Anderson")
```

```
## # A tibble: 25 x 15
##    titulo      ano diretor duracao cor   generos   pais  classificacao orcamento
##    <chr>     <dbl> <chr>     <dbl> <chr> <chr>     <chr> <chr>             <dbl>
##  1 The Life…  2004 Wes An…     119 Color Adventur… USA   A partir de …  50000000
##  2 Fantasti…  2009 Wes An…      87 Color Adventur… USA   Livre          40000000
##  3 The Gran…  2014 Wes An…      99 Color Adventur… USA   A partir de …  25000000
##  4 The Roya…  2001 Wes An…     110 Color Comedy|D… USA   A partir de …  21000000
##  5 The Curs…  2001 Woody …     103 Color Comedy|C… USA   A partir de …  26000000
##  6 To Rome …  2012 Woody …     112 Color Comedy|R… USA   A partir de …  17000000
##  7 Bullets …  1994 Woody …      98 Color Comedy|C… USA   A partir de …  20000000
##  8 Deconstr…  1997 Woody …      96 Color Comedy    USA   A partir de …  20000000
##  9 Everyone…  1996 Woody …     101 Color Comedy|M… USA   A partir de …  20000000
## 10 Blue Jas…  2013 Woody …      98 Color Drama     USA   A partir de …  18000000
## # … with 15 more rows, and 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


**c.** filmes do "Steven Spielberg" ordenados de forma decrescente por ano, mostrando apenas as colunas `titulo` e `ano`;


```r
imdb %>% 
  filter(diretor == "Steven Spielberg") %>% 
  arrange(desc(ano)) %>% 
  select(titulo, ano)
```

```
## # A tibble: 24 x 2
##    titulo                                                ano
##    <chr>                                               <dbl>
##  1 Bridge of Spies                                      2015
##  2 Lincoln                                              2012
##  3 The Adventures of Tintin                             2011
##  4 War Horse                                            2011
##  5 Indiana Jones and the Kingdom of the Crystal Skull   2008
##  6 War of the Worlds                                    2005
##  7 The Terminal                                         2004
##  8 Minority Report                                      2002
##  9 Catch Me If You Can                                  2002
## 10 A.I. Artificial Intelligence                         2001
## # … with 14 more rows
```


**d.**  filmes que tenham "Action" **ou** "Comedy" entre os seus gêneros;


```r
library(stringr)

# Solução 1
imdb %>% 
  filter(str_detect(generos, "Action") | str_detect(generos, "Comedy"))
```

```
## # A tibble: 2,187 x 15
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <dbl> <chr>      <dbl> <chr> <chr>     <chr> <chr>             <dbl>
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
## # … with 2,177 more rows, and 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

**e.** filmes que tenham "Action" **e** "Comedy" entre os seus gêneros e tenha `nota_imdb` maior que 8;


```r
imdb %>% 
  filter(str_detect(generos, "Action"), str_detect(generos, "Comedy"))
```

```
## # A tibble: 203 x 15
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <dbl> <chr>      <dbl> <chr> <chr>     <chr> <chr>             <dbl>
##  1 Men in …  2012 Barry S…     106 Color Action|A… USA   A partir de … 225000000
##  2 Rush Ho…  2007 Brett R…      91 Color Action|C… USA   A partir de … 140000000
##  3 Monster…  2009 Rob Let…      94 Color Action|A… USA   Livre         175000000
##  4 Wild Wi…  1999 Barry S…     106 Color Action|C… USA   A partir de … 170000000
##  5 Suicide…  2016 David A…     123 Color Action|A… USA   A partir de … 175000000
##  6 Big Her…  2014 Don Hall     102 Color Action|A… USA   Livre         165000000
##  7 Madagas…  2008 Eric Da…      89 Color Action|A… USA   Livre         150000000
##  8 G-Force   2009 Hoyt Ye…      88 Color Action|A… USA   Livre         150000000
##  9 Kung Fu…  2011 Jennife…      90 Color Action|A… USA   Livre         150000000
## 10 Mars Ne…  2011 Simon W…      88 Color Action|A… USA   Livre         150000000
## # … with 193 more rows, and 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


**f.** filmes que não possuem informação tanto de receita quanto de orçamento (isto é, possuem `NA` em ambas as colunas).


```r
imdb %>% 
  filter(is.na(orcamento), is.na(receita))
```

```
## # A tibble: 137 x 15
##    titulo    ano diretor  duracao cor    generos   pais  classificacao orcamento
##    <chr>   <dbl> <chr>      <dbl> <chr>  <chr>     <chr> <chr>             <dbl>
##  1 The A-…    NA <NA>          60 Color  Action|A… USA   Outros               NA
##  2 Ben-Hu…  2016 Timur B…     141 Color  Adventur… USA   A partir de …        NA
##  3 Hannib…    NA <NA>          44 Color  Crime|Dr… USA   Outros               NA
##  4 All Th…  1979 Bob Fos…     123 Color  Comedy|D… USA   A partir de …        NA
##  5 Darede…    NA <NA>          54 <NA>   Action|A… USA   Outros               NA
##  6 Bewitc…    NA <NA>          25 Black… Comedy|F… USA   Outros               NA
##  7 Consta…    NA <NA>          43 Color  Drama|Fa… USA   Outros               NA
##  8 Life       NA <NA>          45 Color  Crime|Dr… USA   Outros               NA
##  9 Sleepy…    NA <NA>          45 Color  Adventur… USA   Outros               NA
## 10 Last M…    NA <NA>          30 Color  Comedy    USA   Outros               NA
## # … with 127 more rows, and 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

### Modificando e criando novas colunas {-}

**1.** Crie uma coluna chamada `prejuizo` (`orcamento - receita`) e salve a nova tabela em um objeto chamado `imdb_prejuizo`. Em seguida, filtre apenas os filmes que deram prejuízo e ordene a tabela por ordem crescente de prejuízo.


```r
imdb_prejuizo <- imdb %>% 
  mutate(prejuizo = orcamento - receita)

imdb_prejuizo %>% 
  filter(prejuizo > 0) %>% 
  arrange(prejuizo)
```

```
## # A tibble: 1,312 x 16
##    titulo     ano diretor   duracao cor   generos  pais  classificacao orcamento
##    <chr>    <dbl> <chr>       <dbl> <chr> <chr>    <chr> <chr>             <dbl>
##  1 The Hor…  2009 Michel O…      93 Color Documen… USA   Outros           160000
##  2 Newlywe…  2011 Edward B…      95 Color Comedy|… USA   Outros             9000
##  3 Shortbu…  2006 John Cam…     101 Color Comedy|… USA   Outros          2000000
##  4 Slam      1998 Marc Lev…     100 Color Drama    USA   A partir de …   1000000
##  5 Pink Na…  1971 James Bi…      65 Color Drama|F… USA   Outros            27000
##  6 The FP    2011 Brandon …      82 Color Comedy   USA   A partir de …     60000
##  7 Assault…  2005 Jean-Fra…     109 Color Action|… USA   A partir de …  20000000
##  8 The Bus…  2002 Sherman …     103 Color Drama|M… USA   Outros           200000
##  9 Latter …  2003 C. Jay C…     107 Color Comedy|… USA   A partir de …    850000
## 10 Happy C…  2014 Joe Swan…      82 Color Comedy|… USA   A partir de …     70000
## # … with 1,302 more rows, and 7 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>,
## #   prejuizo <dbl>
```

---

**2.** Fazendo apenas uma chamada da função mutate(), crie as seguintes colunas novas na base `imdb`:

**a.** `lucro = receita - orcamento`

**b.** `lucro_medio`

**c.** `lucro_relativo = (lucro - lucro_medio)/lucro_medio`

**d.** `houve_lucro = ifelse(lucro > 0, "sim", "não")`


```r
imdb %>% 
  mutate(
    lucro = receita - orcamento,
    lucro_medio = mean(lucro, na.rm = TRUE),
    lucro_relativo = (lucro - lucro_medio) / lucro_medio,
    houve_lucro = ifelse(lucro > 0, "sim", "não")
  )
```

```
## # A tibble: 3,807 x 19
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <dbl> <chr>      <dbl> <chr> <chr>     <chr> <chr>             <dbl>
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
## # … with 3,797 more rows, and 10 more variables: receita <dbl>,
## #   nota_imdb <dbl>, likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>,
## #   ator_3 <chr>, lucro <dbl>, lucro_medio <dbl>, lucro_relativo <dbl>,
## #   houve_lucro <chr>
```

---

**3.** Crie uma nova coluna que classifique o filme em `"recente"` (posterior a 2000) e `"antigo"` (de 2000 para trás).


```r
imdb %>% 
  mutate(antigo_ou_recente = ifelse(ano > 2000, "recente", "antigo"))
```

```
## # A tibble: 3,807 x 16
##    titulo     ano diretor  duracao cor   generos   pais  classificacao orcamento
##    <chr>    <dbl> <chr>      <dbl> <chr> <chr>     <chr> <chr>             <dbl>
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
## # … with 3,797 more rows, and 7 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>,
## #   antigo_ou_recente <chr>
```

### Summarisando a base {-}

Utilize a base `imdb` nos exercícios a seguir.

**1.** Calcule a duração média e mediana dos filmes
da base.


```r
imdb %>% 
  summarise(
    duracao_media = mean(duracao, na.rm = TRUE),
    duracao_mediana = median(duracao, na.rm = TRUE)
  )
```

```
## # A tibble: 1 x 2
##   duracao_media duracao_mediana
##           <dbl>           <dbl>
## 1          106.             103
```

---

**2.** Calcule o lucro médio dos filmes com duração
menor que 60 minutos.


```r
imdb %>% 
  filter(duracao < 60) %>% 
  mutate(lucro = receita - orcamento) %>% 
  summarise(lucro_medio = mean(lucro, na.rm = TRUE))
```

```
## # A tibble: 1 x 1
##   lucro_medio
##         <dbl>
## 1     632454.
```

---

**3.** Apresente na mesma tabela o lucro médio dos filmes com duracao menor que 60 minutos e o lucro médio dos filmes com duracao maior ou igual a 60 minutos.


```r
imdb %>% 
  mutate(
    lucro = receita - orcamento,
    duracao_cat = ifelse(duracao < 60, "menor 60 min", "60 ou mais min")
  ) %>% 
  filter(!is.na(lucro)) %>% 
  group_by(duracao_cat) %>% 
  summarise(
    lucro_medio = mean(lucro, na.rm = TRUE)
  )
```

```
## # A tibble: 2 x 2
##   duracao_cat    lucro_medio
##   <chr>                <dbl>
## 1 60 ou mais min   17274472.
## 2 menor 60 min       632454.
```

---

**4.** Retorne tabelas (`tibbles`) apenas com:

**a.** a nota IMDB média dos filmes por tipo de classificacao;


```r
imdb %>% 
  group_by(classificacao) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE))
```

```
## # A tibble: 4 x 2
##   classificacao       nota_media
##   <chr>                    <dbl>
## 1 A partir de 13 anos       6.18
## 2 A partir de 18 anos       6.47
## 3 Livre                     6.26
## 4 Outros                    6.65
```

**b.** a receita média e mediana dos filmes por ano;


```r
imdb %>% 
  group_by(ano) %>% 
  summarise(
    receita_media = mean(receita, na.rm = TRUE),
    receita_mediana = median(receita, na.rm = TRUE)
  )
```

```
## # A tibble: 91 x 3
##      ano receita_media receita_mediana
##    <dbl>         <dbl>           <dbl>
##  1  1916           NaN              NA
##  2  1920       3000000         3000000
##  3  1925           NaN              NA
##  4  1929       2808000         2808000
##  5  1930           NaN              NA
##  6  1932           NaN              NA
##  7  1933       2300000         2300000
##  8  1934           NaN              NA
##  9  1935       3000000         3000000
## 10  1936        163245          163245
## # … with 81 more rows
```

**c.** apenas o nome dos diretores com mais de 10 filmes.


```r
imdb %>% 
  filter(!is.na(diretor)) %>% 
  group_by(diretor) %>% 
  summarise(num_filmes = n()) %>% 
  filter(num_filmes > 10) %>% 
  select(diretor)
```

```
## # A tibble: 22 x 1
##    diretor             
##    <chr>               
##  1 Barry Levinson      
##  2 Clint Eastwood      
##  3 Francis Ford Coppola
##  4 John Carpenter      
##  5 Kevin Smith         
##  6 Martin Scorsese     
##  7 Michael Bay         
##  8 Renny Harlin        
##  9 Ridley Scott        
## 10 Rob Cohen           
## # … with 12 more rows
```

*Também podemos usar a função `count()`.*


```r
imdb %>% 
  filter(!is.na(diretor)) %>% 
  count(diretor, name = "num_filmes") %>% 
  filter(num_filmes > 10) %>% 
  select(diretor)
```

```
## # A tibble: 22 x 1
##    diretor             
##    <chr>               
##  1 Barry Levinson      
##  2 Clint Eastwood      
##  3 Francis Ford Coppola
##  4 John Carpenter      
##  5 Kevin Smith         
##  6 Martin Scorsese     
##  7 Michael Bay         
##  8 Renny Harlin        
##  9 Ridley Scott        
## 10 Rob Cohen           
## # … with 12 more rows
```


### Juntando duas bases {-}

**1.** Utilize a base `imdb` para resolver os itens a seguir.

**a.** Salve em um novo objeto uma tabela com a
nota média dos filmes de cada diretor. Essa tabela
deve conter duas colunas (`diretor` e `nota_imdb_media`)
e cada linha deve ser um diretor diferente.


```r
nota_diretores <- imdb %>% 
  group_by(diretor) %>% 
  summarise(nota_imdb_media = mean(nota_imdb))

nota_diretores
```

```
## # A tibble: 1,813 x 2
##    diretor          nota_imdb_media
##    <chr>                      <dbl>
##  1 A. Raven Cruz                1.9
##  2 Aaron Hann                   6  
##  3 Aaron Schneider              7.1
##  4 Aaron Seltzer                2.7
##  5 Abel Ferrara                 6.6
##  6 Adam Carolla                 6.1
##  7 Adam Goldberg                5.4
##  8 Adam Green                   5.7
##  9 Adam Jay Epstein             3.8
## 10 Adam Marcus                  4.3
## # … with 1,803 more rows
```


**b.** Use o `left_join()` para trazer a coluna
`nota_imdb_media` da tabela do item anterior
para a tabela `imdb` original.


```r
imdb %>% 
  left_join(nota_diretores, by = "diretor") %>% 
  select(nota_imdb_media, everything())
```

```
## # A tibble: 3,807 x 16
##    nota_imdb_media titulo        ano diretor   duracao cor   generos       pais 
##              <dbl> <chr>       <dbl> <chr>       <dbl> <chr> <chr>         <chr>
##  1            7.88 Avatar       2009 James Ca…     178 Color Action|Adven… USA  
##  2            6.99 Pirates of…  2007 Gore Ver…     169 Color Action|Adven… USA  
##  3            8.43 The Dark K…  2012 Christop…     164 Color Action|Thril… USA  
##  4            7.73 John Carte…  2012 Andrew S…     132 Color Action|Adven… USA  
##  5            6.9  Spider-Man…  2007 Sam Raimi     156 Color Action|Adven… USA  
##  6            7.8  Tangled      2010 Nathan G…     100 Color Adventure|An… USA  
##  7            7.92 Avengers: …  2015 Joss Whe…     141 Color Action|Adven… USA  
##  8            7.18 Batman v S…  2016 Zack Sny…     183 Color Action|Adven… USA  
##  9            7.26 Superman R…  2006 Bryan Si…     169 Color Action|Adven… USA  
## 10            6.99 Pirates of…  2006 Gore Ver…     151 Color Action|Adven… USA  
## # … with 3,797 more rows, and 8 more variables: classificacao <chr>,
## #   orcamento <dbl>, receita <dbl>, nota_imdb <dbl>, likes_facebook <dbl>,
## #   ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

