## O pacote dplyr




```r
library(dplyr)
```


### Selecionando colunas {-}

Utilize a base `imdb` nos exercícios a seguir.

**1.** Teste aplicar a função `glimpse()` do pacote `{dplyr}` à base `imdb`. O que ela faz?


```r
glimpse(imdb)
```

```
## Rows: 11,340
## Columns: 20
## $ id_filme             <chr> "tt0092699", "tt0037931", "tt0183505", "tt0033945…
## $ titulo               <chr> "Broadcast News", "Murder, He Says", "Me, Myself …
## $ ano                  <dbl> 1987, 1945, 2000, 1941, 2005, 2015, 1987, 2008, 1…
## $ data_lancamento      <chr> "1988-04-01", "1945-06-23", "2000-09-08", "1947-0…
## $ generos              <chr> "Comedy, Drama, Romance", "Comedy, Crime, Mystery…
## $ duracao              <dbl> 133, 91, 116, 71, 99, 87, 114, 104, 95, 111, 95, …
## $ pais                 <chr> "USA", "USA", "USA", "USA", "USA", "USA", "USA", …
## $ idioma               <chr> "English, Spanish, French, German", "English", "E…
## $ orcamento            <dbl> 20000000, NA, 51000000, NA, NA, NA, 15000000, 350…
## $ receita              <dbl> 67331309, NA, 149270999, NA, 309404, NA, 35509515…
## $ receita_eua          <dbl> 51249404, NA, 90570999, NA, 309404, NA, 35509515,…
## $ nota_imdb            <dbl> 7.2, 7.1, 6.6, 7.2, 5.9, 6.1, 7.1, 5.5, 7.1, 5.7,…
## $ num_avaliacoes       <dbl> 26257, 1639, 219069, 2108, 2953, 2364, 34513, 133…
## $ direcao              <chr> "James L. Brooks", "George Marshall", "Bobby Farr…
## $ roteiro              <chr> "James L. Brooks", "Lou Breslow, Jack Moffitt", "…
## $ producao             <chr> "Amercent Films", "Paramount Pictures", "Twentiet…
## $ elenco               <chr> "William Hurt, Albert Brooks, Holly Hunter, Rober…
## $ descricao            <chr> "Take two rival television reporters: one handsom…
## $ num_criticas_publico <dbl> 142, 35, 502, 35, 48, 26, 125, 45, 145, 52, 179, …
## $ num_criticas_critica <dbl> 62, 10, 161, 18, 15, 14, 72, 74, 55, 29, 121, 12,…
```

*A função `glimpse()` traz um resumo da base, contendo o número de linhas, colunas, o nome e tipo das colunas e as primeiras observações de cada coluna.*

---

**2.** Crie uma tabela com apenas as colunas `titulo`, `direcao`, e `orcamento.` Salve em um objeto chamado `imdb_simples`.


```r
imdb_simples <- select(imdb, titulo, direcao, orcamento)
imdb_simples
```

```
## # A tibble: 11,340 × 3
##    titulo                            direcao                        orcamento
##    <chr>                             <chr>                              <dbl>
##  1 Broadcast News                    James L. Brooks                 20000000
##  2 Murder, He Says                   George Marshall                       NA
##  3 Me, Myself & Irene                Bobby Farrelly, Peter Farrelly  51000000
##  4 Never Give a Sucker an Even Break Edward F. Cline                       NA
##  5 Adam & Steve                      Craig Chester                         NA
##  6 Henry Gamble's Birthday Party     Stephen Cone                          NA
##  7 No Way Out                        Roger Donaldson                 15000000
##  8 Welcome Home, Roscoe Jenkins      Malcolm D. Lee                  35000000
##  9 Some Kind of Wonderful            Howard Deutch                         NA
## 10 The Family That Preys             Tyler Perry                           NA
## # … with 11,330 more rows
```

---

**3.** Selecione apenas as colunas `duracao`, `direcao`, `descricao` e `producao` usando a função auxiliar `contains()`.


```r
select(imdb, contains("cao"))
```

```
## # A tibble: 11,340 × 4
##    duracao direcao                        producao                     descricao
##      <dbl> <chr>                          <chr>                        <chr>    
##  1     133 James L. Brooks                Amercent Films               Take two…
##  2      91 George Marshall                Paramount Pictures           A pollst…
##  3     116 Bobby Farrelly, Peter Farrelly Twentieth Century Fox        A nice-g…
##  4      71 Edward F. Cline                Universal Pictures           A filmma…
##  5      99 Craig Chester                  Funny Boy Films              Follows …
##  6      87 Stephen Cone                   Chicago Media Project        Preacher…
##  7     114 Roger Donaldson                Orion Pictures               A coveru…
##  8     104 Malcolm D. Lee                 Universal Pictures           Dr. RJ S…
##  9      95 Howard Deutch                  Hughes Entertainment         When Kei…
## 10     111 Tyler Perry                    Louisiana Producers Film So… Two fami…
## # … with 11,330 more rows
```

---

**4.** Usando a função `select()` (e suas funções auxiliares), escreva códigos que retornem a base IMDB sem as colunas `num_avaliacoes`, `num_criticas_publico` e `num_criticas_critica`. Escreva todas as soluções diferentes que você conseguir pensar. 


```r
select(imdb, -starts_with("num"))

select(imdb, -num_avaliacoes, -num_criticas_publico, -num_criticas_critica)

select(imdb, id_filme:nota_imdb, direcao)

select(imdb, -contains("num"))
```

### Ordenando a base {-}

**1.** Ordene os filmes em ordem crescente de `ano` e decrescente de `receita` e salve em um objeto chamado `filmes_ordenados`.


```r
filmes_ordenados <- arrange(imdb, ano, desc(receita))
filmes_ordenados
```

```
## # A tibble: 11,340 × 20
##    id_filme  titulo   ano data_lancamento generos duracao pais  idioma orcamento
##    <chr>     <chr>  <dbl> <chr>           <chr>     <dbl> <chr> <chr>      <dbl>
##  1 tt0004707 Tilli…  1914 1914-12-21      Comedy       82 USA   None,…     50000
##  2 tt0004181 Judit…  1914 1914-03-08      Drama        61 USA   Engli…     40000
##  3 tt0003643 The A…  1914 1914-08-24      Crime,…      78 USA   Engli…        NA
##  4 tt0005960 The R…  1915 1915-09-13      Biogra…      72 USA   Engli…        NA
##  5 tt0005078 The C…  1915 1915-12-13      Drama,…      59 USA   Engli…     17311
##  6 tt0004972 The B…  1915 1915-03-21      Drama,…     195 USA   None      100000
##  7 tt0006864 Intol…  1916 1918-02-24      Drama,…     163 USA   Engli…    385907
##  8 tt0006333 20,00…  1916 1916-12-24      Action…     105 USA   Engli…    200000
##  9 tt0008443 The P…  1917 1917-03-05      Comedy…      65 USA   Engli…        NA
## 10 tt0009611 Shoul…  1918 1918-10-27      Comedy…      45 USA   None,…        NA
## # … with 11,330 more rows, and 11 more variables: receita <dbl>,
## #   receita_eua <dbl>, nota_imdb <dbl>, num_avaliacoes <dbl>, direcao <chr>,
## #   roteiro <chr>, producao <chr>, elenco <chr>, descricao <chr>,
## #   num_criticas_publico <dbl>, num_criticas_critica <dbl>
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

**1.** Crie um objeto chamado `filmes_ingles` apenas com filmes que sejam apenas no idioma inglês (`English`).


```r
# Vendo categorias da variável cor
unique(imdb$idioma)
```

```
##   [1] "English, Spanish, French, German"                                                       
##   [2] "English"                                                                                
##   [3] "English, German"                                                                        
##   [4] "English, Russian"                                                                       
##   [5] "English, French"                                                                        
##   [6] "English, Hebrew, Russian, Yiddish"                                                      
##   [7] "English, Italian, German"                                                               
##   [8] "English, Ukrainian"                                                                     
##   [9] "English, Pushto, Dari, French"                                                          
##  [10] "English, Spanish"                                                                       
##  [11] "English, Russian, Ukrainian"                                                            
##  [12] "English, Yiddish"                                                                       
##  [13] "English, German, French"                                                                
##  [14] "English, Japanese"                                                                      
##  [15] "English, Danish, German"                                                                
##  [16] "English, Italian"                                                                       
##  [17] "English, German, Russian"                                                               
##  [18] "English, French, German"                                                                
##  [19] "English, None"                                                                          
##  [20] "English, Hebrew"                                                                        
##  [21] "English, French, Latin"                                                                 
##  [22] "English, Polynesian, French, Dutch"                                                     
##  [23] "English, Chinese"                                                                       
##  [24] "English, French, Spanish, Ladino, Hebrew, Italian, Portuguese, Latin"                   
##  [25] "English, Welsh, Latin, French"                                                          
##  [26] "English, Spanish, Cantonese"                                                            
##  [27] NA                                                                                       
##  [28] "English, Japanese, Navajo"                                                              
##  [29] "English, Japanese, French, Russian"                                                     
##  [30] "English, Portuguese"                                                                    
##  [31] "English, Portuguese, Spanish"                                                           
##  [32] "English, Hungarian, Latin"                                                              
##  [33] "English, German, Spanish"                                                               
##  [34] "English, Mandarin, Spanish, Russian"                                                    
##  [35] "English, Spanish, Italian"                                                              
##  [36] "English, Turkish, French, German"                                                       
##  [37] "English, Korean"                                                                        
##  [38] "English, German, Italian"                                                               
##  [39] "English, Swedish, Latin, German"                                                        
##  [40] "English, Latin"                                                                         
##  [41] "English, Greek, Japanese"                                                               
##  [42] "English, Spanish, French, Korean"                                                       
##  [43] "English, Spanish, Hindi"                                                                
##  [44] "Icelandic, Swedish, English"                                                            
##  [45] "English, Swahili"                                                                       
##  [46] "English, Italian, Arabic"                                                               
##  [47] "None, English"                                                                          
##  [48] "English, Italian, German, French"                                                       
##  [49] "English, Cantonese"                                                                     
##  [50] "English, Russian, French, Hawaiian, Spanish"                                            
##  [51] "English, Spanish, Latin"                                                                
##  [52] "English, Thai"                                                                          
##  [53] "English, Italian, Russian, Spanish, German"                                             
##  [54] "English, French, Spanish, Korean"                                                       
##  [55] "English, Spanish, Russian"                                                              
##  [56] "English, Spanish, French"                                                               
##  [57] "English, Spanish, Hungarian"                                                            
##  [58] "Bosnian, Serbian, Croatian, English"                                                    
##  [59] "English, Italian, Latin"                                                                
##  [60] "English, Cantonese, German"                                                             
##  [61] "English, Cheyenne, French"                                                              
##  [62] "English, German, Turkish, French"                                                       
##  [63] "English, French, Chinese, Urdu, Mohawk"                                                 
##  [64] "English, Mandarin"                                                                      
##  [65] "English, Arabic"                                                                        
##  [66] "English, Mandarin, German"                                                              
##  [67] "English, German, Ukrainian"                                                             
##  [68] "English, French, North American Indian"                                                 
##  [69] "English, Hungarian, German, Spanish"                                                    
##  [70] "English, Spanish, Arabic"                                                               
##  [71] "English, French, Portuguese"                                                            
##  [72] "English, Arabic, Italian"                                                               
##  [73] "English, Hebrew, Mandarin"                                                              
##  [74] "English, Mandarin, Punjabi"                                                             
##  [75] "English, Hawaiian"                                                                      
##  [76] "English, Icelandic, Italian"                                                            
##  [77] "English, American Sign Language"                                                        
##  [78] "English, Dutch"                                                                         
##  [79] "Spanish, English"                                                                       
##  [80] "English, Russian, Spanish"                                                              
##  [81] "English, Hindi, Italian"                                                                
##  [82] "English, Persian, Greek, Arabic, Latin"                                                 
##  [83] "English, Swedish"                                                                       
##  [84] "English, Spanish, Russian, Italian, French"                                             
##  [85] "English, Japanese, French"                                                              
##  [86] "English, German, Latin"                                                                 
##  [87] "English, Bulgarian"                                                                     
##  [88] "English, Serbian"                                                                       
##  [89] "English, Italian, Latin, Spanish, German"                                               
##  [90] "English, Spanish, Japanese"                                                             
##  [91] "English, Spanish, French, American Sign Language"                                       
##  [92] "English, French, Czech"                                                                 
##  [93] "Mandarin, English, Cantonese, Vietnamese, Polish"                                       
##  [94] "English, Brazilian Sign Language"                                                       
##  [95] "English, Spanish, Hungarian, Czech"                                                     
##  [96] "English, French, Spanish"                                                               
##  [97] "English, Klingon"                                                                       
##  [98] "French, English"                                                                        
##  [99] "English, Italian, Yiddish"                                                              
## [100] "None"                                                                                   
## [101] "English, Navajo, Spanish"                                                               
## [102] "English, German, Yiddish"                                                               
## [103] "English, Hebrew, Russian"                                                               
## [104] "English, Hungarian"                                                                     
## [105] "English, Latin, Italian, Spanish"                                                       
## [106] "English, Mende, Spanish, Portuguese"                                                    
## [107] "English, Italian, Spanish, Korean"                                                      
## [108] "English, Athapascan languages"                                                          
## [109] "English, Esperanto"                                                                     
## [110] "English, Latin, Greek, French, German, Arabic, Kurdish"                                 
## [111] "English, Finnish"                                                                       
## [112] "English, French, German, Spanish, Yiddish"                                              
## [113] "English, German, Arabic, Urdu"                                                          
## [114] "English, French, Indonesian"                                                            
## [115] "English, Indian Sign Language, North American Indian"                                   
## [116] "English, Tagalog, Cantonese, Mandarin, Spanish"                                         
## [117] "English, Chinese, German"                                                               
## [118] "English, French, German, Spanish"                                                       
## [119] "English, German, Swedish, Norwegian, Danish, French"                                    
## [120] "English, Arabic, Acholi"                                                                
## [121] "English, Japanese, Spanish"                                                             
## [122] "English, German, French, Latin"                                                         
## [123] "English, Navajo, Japanese"                                                              
## [124] "English, Cantonese, Korean"                                                             
## [125] "English, Serbo-Croatian"                                                                
## [126] "Spanish"                                                                                
## [127] "English, Arabic, French, Italian"                                                       
## [128] "English, Hebrew, Latin, Yiddish"                                                        
## [129] "English, Italian, Cantonese"                                                            
## [130] "English, Italian, Japanese, Spanish"                                                    
## [131] "English, French, German, Latin"                                                         
## [132] "English, Russian, French"                                                               
## [133] "English, Japanese, Italian, French"                                                     
## [134] "English, Russian, Punjabi, Arabic"                                                      
## [135] "English, Hawaiian, Russian"                                                             
## [136] "English, Aramaic"                                                                       
## [137] "English, Dari"                                                                          
## [138] "English, German, Cantonese, Japanese, Hungarian, Arabic"                                
## [139] "English, Brazilian Sign Language, Spanish"                                              
## [140] "English, Swedish, German"                                                               
## [141] "English, Spanish, Italian, Inuktitut, Hindi"                                            
## [142] "English, Spanish, Greek, Ancient (to 1453)"                                             
## [143] "English, Mandarin, Spanish"                                                             
## [144] "English, French, Cantonese, Japanese"                                                   
## [145] "English, Apache languages, Spanish"                                                     
## [146] "Portuguese, English, Spanish, German"                                                   
## [147] "English, Indonesian"                                                                    
## [148] "English, Vietnamese"                                                                    
## [149] "English, Russian, Arabic, Latin"                                                        
## [150] "English, Spanish, Portuguese"                                                           
## [151] "English, Urdu"                                                                          
## [152] "English, Italian, Spanish"                                                              
## [153] "English, Spanish, German, Russian"                                                      
## [154] "English, French, Arabic"                                                                
## [155] "Cantonese, English"                                                                     
## [156] "English, Spanish, Sioux"                                                                
## [157] "English, Serbo-Croatian, Spanish"                                                       
## [158] "English, Spanish, Assyrian Neo-Aramaic"                                                 
## [159] "English, Akan"                                                                          
## [160] "English, Ukrainian, Russian"                                                            
## [161] "English, German, Cantonese"                                                             
## [162] "English, Irish, Hebrew"                                                                 
## [163] "English, Vietnamese, French"                                                            
## [164] "English, Spanish, German"                                                               
## [165] "English, Saami"                                                                         
## [166] "English, Latin, Swedish, Norse, Old, Danish, Arabic"                                    
## [167] "English, French, Hindi, Russian"                                                        
## [168] "English, Latin, French"                                                                 
## [169] "English, Italian, Czech"                                                                
## [170] "English, Swahili, Kirundi, French"                                                      
## [171] "English, Spanish, Greek"                                                                
## [172] "English, Italian, French"                                                               
## [173] "English, Klingon, German"                                                               
## [174] "English, Arabic, Spanish"                                                               
## [175] "English, French, Italian, Russian, Spanish"                                             
## [176] "English, Sioux"                                                                         
## [177] "English, Russian, Spanish, Italian"                                                     
## [178] "English, Russian, Chinese"                                                              
## [179] "English, French, Italian, German"                                                       
## [180] "English, Hindi"                                                                         
## [181] "English, French, German, Italian"                                                       
## [182] "English, Chinese, Japanese"                                                             
## [183] "English, French, Romanian, Latin"                                                       
## [184] "English, French, Arabic, German, Dutch"                                                 
## [185] "English, Danish"                                                                        
## [186] "English, Spanish, Arabic, Polish, Turkish, Russian, Italian, Persian"                   
## [187] "English, French, Spanish, Arabic, Italian"                                              
## [188] "English, Polynesian"                                                                    
## [189] "English, Hebrew, Arabic"                                                                
## [190] "Portuguese, English"                                                                    
## [191] "English, Irish"                                                                         
## [192] "English, Sign Languages"                                                                
## [193] "Greek, English, Italian"                                                                
## [194] "English, Spanish, Russian, Italian"                                                     
## [195] "English, Polish"                                                                        
## [196] "English, Polish, German, Arabic, Egyptian (Ancient)"                                    
## [197] "English, Korean, Spanish, Japanese, Latin"                                              
## [198] "English, American Sign Language, Spanish"                                               
## [199] "English, German, Portuguese, French"                                                    
## [200] "English, Finnish, German"                                                               
## [201] "Russian, English"                                                                       
## [202] "English, Spanish, French, Russian"                                                      
## [203] "English, Hungarian, Hebrew"                                                             
## [204] "English, Pushto"                                                                        
## [205] "English, French, Russian"                                                               
## [206] "English, Klingon, Russian, French"                                                      
## [207] "English, Syriac, Assyrian Neo-Aramaic"                                                  
## [208] "English, Armenian"                                                                      
## [209] "English, Ibo"                                                                           
## [210] "English, Spanish, French, Japanese"                                                     
## [211] "English, Czech, Serbian"                                                                
## [212] "English, French, Italian"                                                               
## [213] "Esperanto"                                                                              
## [214] "English, German, Italian, French"                                                       
## [215] "English, Swahili, Xhosa, Zulu"                                                          
## [216] "English, German, Italian, Hindi"                                                        
## [217] "English, Korean, Russian, Spanish"                                                      
## [218] "English, Spanish, Mandarin"                                                             
## [219] "English, Spanish, French, Romanian"                                                     
## [220] "English, Russian, Sign Languages"                                                       
## [221] "English, Hindi, German, Punjabi, Tibetan, French"                                       
## [222] "English, Filipino"                                                                      
## [223] "English, Hebrew, Spanish"                                                               
## [224] "English, Italian, Spanish, Latin, Sicilian"                                             
## [225] "English, Ukrainian, Spanish"                                                            
## [226] "English, Mohawk, French"                                                                
## [227] "English, Spanish, Chinese, Russian, Portuguese"                                         
## [228] "English, Latin, Spanish"                                                                
## [229] "English, Romanian, Spanish"                                                             
## [230] "English, German, Japanese, Serbian"                                                     
## [231] "English, Arapaho"                                                                       
## [232] "English, Japanese, Russian, Spanish"                                                    
## [233] "English, French, Ukrainian"                                                             
## [234] "English, Ukrainian, French, Italian, Spanish"                                           
## [235] "English, Romany, Romanian, Ukrainian"                                                   
## [236] "English, Korean, Icelandic, Russian"                                                    
## [237] "English, Portuguese, Tupi, Spanish, German"                                             
## [238] "English, Swedish, French, Italian, Russian"                                             
## [239] "English, French, Wolof, Spanish"                                                        
## [240] "English, French, Latin, Spanish"                                                        
## [241] "English, Welsh"                                                                         
## [242] "English, German, Norwegian"                                                             
## [243] "English, Greek"                                                                         
## [244] "English, Portuguese, French"                                                            
## [245] "English, Portuguese, French, Japanese"                                                  
## [246] "French, Russian, Polish, English"                                                       
## [247] "Uzbek, English, Dari, Russian, Spanish"                                                 
## [248] "English, Japanese, Cantonese, Mandarin"                                                 
## [249] "English, Inuktitut"                                                                     
## [250] "English, French, Swedish"                                                               
## [251] "English, Afrikaans"                                                                     
## [252] "English, French, Spanish, Hindi"                                                        
## [253] "English, Hawaiian, French"                                                              
## [254] "English, Italian, Latin, French"                                                        
## [255] "English, Swedish, Italian, Portuguese, French"                                          
## [256] "English, Spanish, Korean"                                                               
## [257] "Spanish, English, Mandarin, French, Hindi"                                              
## [258] "English, Spanish, Quechua"                                                              
## [259] "English, Tamil"                                                                         
## [260] "English, Portuguese, Swedish"                                                           
## [261] "English, Russian, Indonesian"                                                           
## [262] "English, Cornish"                                                                       
## [263] "English, Norwegian"                                                                     
## [264] "English, Polish, German"                                                                
## [265] "English, Russian, Mandarin"                                                             
## [266] "English, Finnish, Spanish, French"                                                      
## [267] "English, Russian, Portuguese"                                                           
## [268] "English, Thai, French"                                                                  
## [269] "English, French, Russian, German, Spanish, Greek"                                       
## [270] "English, French, German, Russian"                                                       
## [271] "English, Irish, Greek"                                                                  
## [272] "English, Russian, Hindi"                                                                
## [273] "English, Russian, Spanish, Korean, Greek"                                               
## [274] "English, Albanian"                                                                      
## [275] "English, Italian, Spanish, German"                                                      
## [276] "English, Navajo"                                                                        
## [277] "English, Italian, French, Japanese"                                                     
## [278] "English, Russian, Japanese, Indonesian, Mandarin, Italian, Arabic, Latin"               
## [279] "English, Mandarin, Russian"                                                             
## [280] "English, Latin, Hungarian"                                                              
## [281] "English, Arabic, French"                                                                
## [282] "English, German, Hebrew, Spanish, Arabic, Nepali"                                       
## [283] "English, Mandarin, Hindi"                                                               
## [284] "English, Greek, Spanish"                                                                
## [285] "English, German, Greek, Arabic"                                                         
## [286] "English, Cantonese, Spanish"                                                            
## [287] "English, Persian, Assyrian Neo-Aramaic"                                                 
## [288] "English, French, Bulgarian"                                                             
## [289] "English, Apache languages"                                                              
## [290] "English, Spanish, Sanskrit"                                                             
## [291] "English, Albanian, Spanish"                                                             
## [292] "English, German, French, Russian, Arabic, Italian"                                      
## [293] "English, Italian, Portuguese"                                                           
## [294] "English, French, Albanian, Spanish, Hungarian"                                          
## [295] "English, Spanish, French, German, Italian, Hebrew"                                      
## [296] "English, French, Russian, Hindi"                                                        
## [297] "English, Tonga"                                                                         
## [298] "English, Yiddish, Hebrew"                                                               
## [299] "English, Bulgarian, Spanish, Russian, Mandarin, German, French"                         
## [300] "English, Persian"                                                                       
## [301] "English, French, Spanish, Italian, Sign Languages, Russian"                             
## [302] "English, Italian, Russian"                                                              
## [303] "English, Cantonese, Dutch, French, Italian"                                             
## [304] "English, Hebrew, German"                                                                
## [305] "English, Serbo-Croatian, Spanish, Czech"                                                
## [306] "Italian, English, German"                                                               
## [307] "English, French, Czech, Japanese"                                                       
## [308] "English, Syriac, German, Greek, Hebrew, Latin, Aramaic"                                 
## [309] "English, Norwegian, Latin, French"                                                      
## [310] "English, French, Turkish, German, Greek, Italian"                                       
## [311] "English, German, Korean"                                                                
## [312] "English, Crow, French"                                                                  
## [313] "English, Algonquin"                                                                     
## [314] "English, French, Spanish, Italian, German"                                              
## [315] "English, Cantonese, Italian"                                                            
## [316] "English, French, Spanish, Italian"                                                      
## [317] "English, French, German, Czech"                                                         
## [318] "English, Hebrew, French"                                                                
## [319] "Spanish, Hungarian"                                                                     
## [320] "English, Romanian"                                                                      
## [321] "English, Norwegian, French"                                                             
## [322] "English, French, German, Serbian"                                                       
## [323] "English, French, Persian"                                                               
## [324] "English, Czech"                                                                         
## [325] "English, French, Cantonese"                                                             
## [326] "English, Turkish"                                                                       
## [327] "English, Persian, Ukrainian"                                                            
## [328] "English, Mandarin, Shanghainese"                                                        
## [329] "English, French, Italian, Hindi"                                                        
## [330] "English, Mandarin, Spanish, French"                                                     
## [331] "English, Russian, Hungarian"                                                            
## [332] "English, Icelandic"                                                                     
## [333] "English, Japanese, Korean"                                                              
## [334] "Italian, Chinese, English"                                                              
## [335] "English, French, Japanese"                                                              
## [336] "English, Spanish, Chinese"                                                              
## [337] "English, French, German, Chinese, Italian, Arabic"                                      
## [338] "English, French, German, Hebrew, Spanish, Polish, Norwegian"                            
## [339] "English, Persian, French, Spanish"                                                      
## [340] "English, French, Vietnamese"                                                            
## [341] "English, German, Italian, Japanese"                                                     
## [342] "English, Chinese, Spanish, French, Ukrainian"                                           
## [343] "French, Spanish, English"                                                               
## [344] "English, French, Arabic, German"                                                        
## [345] "English, French, Tibetan, Mandarin, Russian, Hindi, Portuguese, Latin, Italian, Spanish"
## [346] "Latin, French, English"                                                                 
## [347] "English, Basque, French, Spanish"                                                       
## [348] "English, French, German, Italian, Spanish"                                              
## [349] "English, Mandarin, Korean"                                                              
## [350] "English, Croatian, Chinese"                                                             
## [351] "English, French, German, Polish"                                                        
## [352] "English, French, Arabic, Romanian"                                                      
## [353] "English, Indonesian, French"                                                            
## [354] "English, Dutch, French, Italian, Mandarin"                                              
## [355] "English, German, Hebrew, French"                                                        
## [356] "English, Russian, Esperanto"                                                            
## [357] "English, German, French, Swedish"                                                       
## [358] "English, French, Portuguese, Spanish"                                                   
## [359] "English, Berber languages, French"                                                      
## [360] "English, Japanese, German"                                                              
## [361] "English, Italian, Japanese, Yiddish"                                                    
## [362] "English, Spanish, Urdu, Russian"                                                        
## [363] "Persian, English"                                                                       
## [364] "English, Nahuatl"                                                                       
## [365] "English, Mandarin, Cantonese"                                                           
## [366] "English, French, Sioux"                                                                 
## [367] "English, Japanese, Italian"                                                             
## [368] "English, Romanian, Russian"                                                             
## [369] "English, Mandarin, Italian"                                                             
## [370] "English, Italian, Japanese"                                                             
## [371] "English, Cantonese, Latin"                                                              
## [372] "English, German, Italian, Arabic"                                                       
## [373] "English, French, German, Spanish, Hawaiian, Japanese, Italian, Hebrew"                  
## [374] "English, Catalan, Spanish"                                                              
## [375] "English, French, Latin, Scottish Gaelic, Italian"                                       
## [376] "English, Japanese, Russian"                                                             
## [377] "Aramaic, Latin, Hebrew"                                                                 
## [378] "English, French, German, Dutch, Italian"                                                
## [379] "Maori, English"                                                                         
## [380] "English, Korean, Persian, Spanish, Arabic"                                              
## [381] "English, Chinese, Russian"                                                              
## [382] "English, Romanian, Greek, Bulgarian, Latin"                                             
## [383] "English, Italian, Ukrainian"                                                            
## [384] "English, Cantonese, Japanese"                                                           
## [385] "English, Japanese, Xhosa, German"                                                       
## [386] "English, French, Spanish, Japanese"                                                     
## [387] "Mandarin, English"                                                                      
## [388] "English, French, Latin, Arabic"                                                         
## [389] "English, Spanish, Hebrew"                                                               
## [390] "English, Mandarin, Greek"                                                               
## [391] "English, Portuguese, Japanese"                                                          
## [392] "English, Russian, Spanish, Romanian"                                                    
## [393] "English, Serbo-Croatian, Russian, French, Polish, German, Ukrainian"                    
## [394] "English, German, Spanish, Serbian"                                                      
## [395] "German, English"                                                                        
## [396] "English, Norwegian, French, Spanish"                                                    
## [397] "English, German, Swedish, American Sign Language"                                       
## [398] "English, German, Dutch, Polish, Latin"                                                  
## [399] "English, Polish, Spanish"                                                               
## [400] "English, Russian, Italian, Mandarin, French"                                            
## [401] "English, Italian, Mandarin, Spanish"                                                    
## [402] "Russian, English, French, German, Swedish, Italian"                                     
## [403] "English, Papiamento"                                                                    
## [404] "English, Italian, German, Latin"                                                        
## [405] "English, Polish, Russian"                                                               
## [406] "English, Japanese, Vietnamese"                                                          
## [407] "English, French, Arabic, Spanish"                                                       
## [408] "English, Japanese, Italian, Hawaiian, German, French"                                   
## [409] "English, Spanish, Yiddish, Italian"                                                     
## [410] "English, Swedish, Norwegian, Danish, Icelandic, French"                                 
## [411] "English, Italian, Swedish"                                                              
## [412] "English, Min Nan, Mandarin"                                                             
## [413] "English, French, Japanese, Italian, North American Indian"                              
## [414] "American Sign Language, English"                                                        
## [415] "English, Swedish, French, German"                                                       
## [416] "English, Sioux, Cantonese"                                                              
## [417] "English, Hindi, French, German, Mandarin"                                               
## [418] "English, French, Chinese"                                                               
## [419] "English, French, Italian, Japanese"                                                     
## [420] "English, Italian, Japanese, Russian"                                                    
## [421] "English, German, French, Russian, Italian"                                              
## [422] "English, French, Hebrew, Yiddish"                                                       
## [423] "English, Mandarin, French"                                                              
## [424] "English, German, Russian, French"                                                       
## [425] "English, Hawaiian, German, Japanese"                                                    
## [426] "English, Hebrew, Arabic, Spanish"                                                       
## [427] "English, Slovak, French"                                                                
## [428] "English, Italian, Mandarin"                                                             
## [429] "Maya, English, Spanish"                                                                 
## [430] "English, Hebrew, German, Polish, Latin"                                                 
## [431] "English, French, Romanian, Dutch, Mandarin"                                             
## [432] "English, Sinhalese, Hindi"                                                              
## [433] "English, Thai, Spanish"                                                                 
## [434] "English, Greek, French, Spanish"                                                        
## [435] "Spanish, French, English"                                                               
## [436] "English, Cantonese, Mandarin"                                                           
## [437] "English, Cantonese, Spanish, Russian"                                                   
## [438] "English, Somali"                                                                        
## [439] "English, Spanish, Latin, French"                                                        
## [440] "English, Chinese, Vietnamese"                                                           
## [441] "English, American Sign Language, Dutch, Italian, Russian, Swahili"                      
## [442] "English, French, German, Greek, Ancient (to 1453)"                                      
## [443] "English, Malay, Japanese"                                                               
## [444] "English, American Sign Language, Spanish, Latin"                                        
## [445] "English, Spanish, Russian, German, Lingala"                                             
## [446] "English, Polynesian, Spanish"                                                           
## [447] "Arabic, English"                                                                        
## [448] "English, Polish, Latin"                                                                 
## [449] "English, German, Xhosa, Russian, Romanian, Hindi"                                       
## [450] "English, German, French, Russian, Spanish"                                              
## [451] "English, Vietnamese, German, Danish"                                                    
## [452] "English, Spanish, Latin, French, German"                                                
## [453] "English, Afrikaans, Maori, Zulu, Xhosa, Southern Sotho"                                 
## [454] "English, French, American Sign Language"                                                
## [455] "Korean, English, Spanish"                                                               
## [456] "English, German, Portuguese, Turkish, French"                                           
## [457] "English, Cantonese, Mandarin, Spanish"                                                  
## [458] "English, Thai, Spanish, Hebrew, French"                                                 
## [459] "English, Icelandic, Filipino, Portuguese, French, Tagalog, German, Italian"             
## [460] "Yiddish, English, Spanish"                                                              
## [461] "English, American Sign Language, Portuguese"                                            
## [462] "Arabic, Hindi, English"                                                                 
## [463] "English, French, German, Arabic"                                                        
## [464] "English, Middle English, Old English, Latin, German"                                    
## [465] "English, Spanish, Russian, Arabic, French"                                              
## [466] "English, Vietnamese, Spanish, Thai"                                                     
## [467] "English, Inuktitut, Croatian, Serbian"                                                  
## [468] "English, American Sign Language, Latin"                                                 
## [469] "English, French, Spanish, Swahili"                                                      
## [470] "English, Japanese, Mandarin, Russian, Cantonese"                                        
## [471] "English, Finnish, French, Vietnamese"                                                   
## [472] "English, Turkish, Greek, Mandarin, French"                                              
## [473] "English, Belarusian"                                                                    
## [474] "Japanese"                                                                               
## [475] "Japanese, Mandarin, English"                                                            
## [476] "English, Spanish, Cantonese, Italian"                                                   
## [477] "English, French, German, Vietnamese"                                                    
## [478] "English, Japanese, French, Arabic"                                                      
## [479] "English, French, Turkish, Hebrew, Arabic, Spanish"                                      
## [480] "Persian"                                                                                
## [481] "English, Spanish, French, Arabic"                                                       
## [482] "English, French, German, Russian, Japanese, Latin"                                      
## [483] "English, German, French, Italian"                                                       
## [484] "Greek, American Sign Language, English, Portuguese, Spanish, German, French"            
## [485] "English, Russian, German, French, Finnish, Italian"                                     
## [486] "English, German, Dutch, Danish, French, American Sign Language"                         
## [487] "English, Hungarian, Spanish"                                                            
## [488] "English, Japanese, Chinese, Spanish"                                                    
## [489] "English, German, Japanese"                                                              
## [490] "English, Italian, Spanish, French"                                                      
## [491] "English, Spanish, Yiddish"                                                              
## [492] "Japanese, English, German"                                                              
## [493] "English, Serbian, French"                                                               
## [494] "English, German, Polish"                                                                
## [495] "English, Japanese, Arabic, Persian"                                                     
## [496] "English, Spanish, Latin, Italian"                                                       
## [497] "English, Swahili, Nama, Xhosa, Korean"                                                  
## [498] "English, Hindi, Bengali"                                                                
## [499] "English, Mandarin, Persian"                                                             
## [500] "English, Hebrew, Yiddish"                                                               
## [501] "English, Hebrew, French, German"                                                        
## [502] "English, Cantonese, Russian, Hindi, Spanish"                                            
## [503] "English, Russian, Serbian, Bosnian, Croatian, Polish"                                   
## [504] "English, German, Romanian"                                                              
## [505] "English, Vietnamese, Spanish"                                                           
## [506] "Afrikaans, Zulu, English"                                                               
## [507] "English, Spanish, Chinese, Latin"                                                       
## [508] "English, French, Italian, Cantonese"                                                    
## [509] "English, Italian, Serbo-Croatian"                                                       
## [510] "English, Turkmen, Cantonese, Italian, Spanish, Ukrainian, French"                       
## [511] "English, Chinese, Spanish"                                                              
## [512] "English, Japanese, Italian, French, Latin"                                              
## [513] "English, Korean, French"                                                                
## [514] "English, Russian, Vietnamese, French, Cantonese"                                        
## [515] "English, Cantonese, Ukrainian"                                                          
## [516] "English, French, Khmer, Russian"                                                        
## [517] "English, Japanese, German, Spanish"                                                     
## [518] "English, North American Indian"                                                         
## [519] "English, Russian, Serbian"                                                              
## [520] "English, American Sign Language, Chinese"                                               
## [521] "English, German, French, Russian"                                                       
## [522] "English, Navajo, Mandarin"                                                              
## [523] "English, Spanish, Bulgarian"                                                            
## [524] "English, Dutch, German, Latvian"                                                        
## [525] "English, Italian, Russian, French, Chinese"                                             
## [526] "English, Russian, Korean"                                                               
## [527] "English, Quechua, Romanian, Spanish"                                                    
## [528] "English, Japanese, Mandarin"                                                            
## [529] "English, Italian, Irish, Yiddish"                                                       
## [530] "English, Mandarin, Cantonese, Hokkien, French, Malay"                                   
## [531] "English, Japanese, German, French"                                                      
## [532] "English, Lao"                                                                           
## [533] "English, French, German, Arabic, Italian, Japanese"                                     
## [534] "English, German, Spanish, Russian, Czech"                                               
## [535] "English, Russian, Polish"                                                               
## [536] "English, Japanese, Mandarin, Shanghainese"                                              
## [537] "English, Hawaiian, Mandarin, None"                                                      
## [538] "English, Latin, Hebrew"                                                                 
## [539] "English, French, Swahili"                                                               
## [540] "English, Ukrainian, German, French"                                                     
## [541] "English, Yiddish, German"                                                               
## [542] "English, German, Polish, French"
```

```r
# Filtrando
filmes_ingles <- imdb %>% filter(idioma == "English")
```

---

**2.** Crie um objeto chamado `curtos_legais` com filmes de 90 minutos ou menos de duração e nota no imdb maior do que 8.5.


```r
curtos_legais <- imdb %>% 
  filter(duracao <= 90, nota_imdb > 8.5)
```

---

**3.** Retorne tabelas (`tibbles`) apenas com:

**a.** filmes de ação anteriores a 1950;


```r
library(stringr)

imdb %>% 
  filter(str_detect(generos, "Action"), ano < 1950)
```

```
## # A tibble: 102 × 20
##    id_filme  titulo   ano data_lancamento generos duracao pais  idioma orcamento
##    <chr>     <chr>  <dbl> <chr>           <chr>     <dbl> <chr> <chr>      <dbl>
##  1 tt0041098 Afric…  1949 1950-04-08      Action…      79 USA   Engli…        NA
##  2 tt0037098 The M…  1944 1944-12-22      Action…      60 USA   Engli…        NA
##  3 tt0034889 In Ol…  1942 1947-06-25      Action…      88 USA   Engli…        NA
##  4 tt0040946 Wake …  1948 1949-03-01      Action…     106 USA   Engli…   1200343
##  5 tt0029843 The A…  1938 1939-01-26      Action…     102 USA   Engli…   1900000
##  6 tt0034522 The B…  1942 1942-12-04      Action…      87 USA   Engli…        NA
##  7 tt0024902 Blue …  1934 1934-05-10      Action…      54 USA   Engli…        NA
##  8 tt0041841 Sands…  1949 1950-03-01      Action…     100 USA   Engli…   1000000
##  9 tt0027438 The C…  1936 1936-10-20      Action…     115 USA   Engli…   1200000
## 10 tt0040076 Adven…  1948 1949-04-28      Action…     110 USA   Engli…   3500000
## # … with 92 more rows, and 11 more variables: receita <dbl>, receita_eua <dbl>,
## #   nota_imdb <dbl>, num_avaliacoes <dbl>, direcao <chr>, roteiro <chr>,
## #   producao <chr>, elenco <chr>, descricao <chr>, num_criticas_publico <dbl>,
## #   num_criticas_critica <dbl>
```


**b.** filmes dirigidos por "Woody Allen" ou "Wes Anderson";


```r
imdb %>% 
  filter(direcao == "Woody Allen" | direcao == "Wes Anderson")
```

```
## # A tibble: 42 × 20
##    id_filme  titulo   ano data_lancamento generos duracao pais  idioma orcamento
##    <chr>     <chr>  <dbl> <chr>           <chr>     <dbl> <chr> <chr>      <dbl>
##  1 tt0094663 Anoth…  1988 1989-03-17      Drama        81 USA   Engli…  10000000
##  2 tt1748122 Moonr…  2012 2012-12-05      Comedy…      94 USA   Engli…  16000000
##  3 tt0084329 A Mid…  1982 1982-09-24      Comedy       88 USA   Engli…        NA
##  4 tt0070707 Sleep…  1973 1974-03-15      Comedy…      89 USA   Engli…   2000000
##  5 tt0068555 Every…  1972 1973-03-23      Comedy       88 USA   Engli…   2000000
##  6 tt0065063 Take …  1969 1972-12-21      Comedy…      85 USA   Engli…   1500000
##  7 tt0278823 Holly…  2002 2002-10-31      Comedy…     112 USA   Engli…  16000000
##  8 tt0378947 Melin…  2004 2004-12-22      Comedy…      99 USA   Engli…        NA
##  9 tt0113819 Might…  1995 1996-01-26      Comedy…      95 USA   Engli…  15000000
## 10 tt0091167 Hanna…  1986 1986-05-22      Comedy…     107 USA   Engli…   6400000
## # … with 32 more rows, and 11 more variables: receita <dbl>, receita_eua <dbl>,
## #   nota_imdb <dbl>, num_avaliacoes <dbl>, direcao <chr>, roteiro <chr>,
## #   producao <chr>, elenco <chr>, descricao <chr>, num_criticas_publico <dbl>,
## #   num_criticas_critica <dbl>
```


**c.** filmes do "Steven Spielberg" ordenados de forma decrescente por ano, mostrando apenas as colunas `titulo` e `ano`;


```r
imdb %>% 
  filter(direcao == "Steven Spielberg") %>% 
  arrange(desc(ano)) %>% 
  select(titulo, ano)
```

```
## # A tibble: 21 × 2
##    titulo                                               ano
##    <chr>                                              <dbl>
##  1 Indiana Jones and the Kingdom of the Crystal Skull  2008
##  2 War of the Worlds                                   2005
##  3 The Terminal                                        2004
##  4 Minority Report                                     2002
##  5 Saving Private Ryan                                 1998
##  6 Amistad                                             1997
##  7 The Lost World: Jurassic Park                       1997
##  8 Schindler's List                                    1993
##  9 Jurassic Park                                       1993
## 10 Hook                                                1991
## # … with 11 more rows
```


**d.**  filmes que tenham "Action" **ou** "Comedy" entre os seus gêneros;


```r
library(stringr)

# Solução 1
imdb %>% 
  filter(str_detect(generos, "Action") | str_detect(generos, "Comedy"))
```

```
## # A tibble: 6,035 × 20
##    id_filme  titulo   ano data_lancamento generos duracao pais  idioma orcamento
##    <chr>     <chr>  <dbl> <chr>           <chr>     <dbl> <chr> <chr>      <dbl>
##  1 tt0092699 Broad…  1987 1988-04-01      Comedy…     133 USA   Engli…  20000000
##  2 tt0037931 Murde…  1945 1945-06-23      Comedy…      91 USA   Engli…        NA
##  3 tt0183505 Me, M…  2000 2000-09-08      Comedy      116 USA   Engli…  51000000
##  4 tt0033945 Never…  1941 1947-05-02      Comedy…      71 USA   Engli…        NA
##  5 tt0372122 Adam …  2005 2007-05-17      Comedy…      99 USA   Engli…        NA
##  6 tt0093640 No Wa…  1987 1987-12-11      Action…     114 USA   Engli…  15000000
##  7 tt0494652 Welco…  2008 2008-02-08      Comedy…     104 USA   Engli…  35000000
##  8 tt0110668 Night…  1995 1995-02-04      Action…      93 USA   Engli…        NA
##  9 tt0025101 Fashi…  1934 1934-02-14      Comedy…      78 USA   Engli…        NA
## 10 tt1488555 The C…  2011 2011-12-09      Comedy…     112 USA   Engli…  52000000
## # … with 6,025 more rows, and 11 more variables: receita <dbl>,
## #   receita_eua <dbl>, nota_imdb <dbl>, num_avaliacoes <dbl>, direcao <chr>,
## #   roteiro <chr>, producao <chr>, elenco <chr>, descricao <chr>,
## #   num_criticas_publico <dbl>, num_criticas_critica <dbl>
```

**e.** filmes que tenham "Action" **e** "Comedy" entre os seus gêneros e tenha `nota_imdb` maior que 8;


```r
imdb %>% 
  filter(str_detect(generos, "Action"), str_detect(generos, "Comedy"), nota_imdb > 8)
```

```
## # A tibble: 4 × 20
##   id_filme  titulo    ano data_lancamento generos duracao pais  idioma orcamento
##   <chr>     <chr>   <dbl> <chr>           <chr>     <dbl> <chr> <chr>      <dbl>
## 1 tt4730224 An Hou…  2018 2018-06-12      Action…      96 USA   Engli…     60000
## 2 tt0015324 Sherlo…  1924 1924-05-11      Action…      45 USA   Engli…        NA
## 3 tt0017925 The Ge…  1926 1927-03-30      Action…      67 USA   Engli…    750000
## 4 tt0014429 Safety…  1923 1924-12-08      Action…      74 USA   Engli…    121000
## # … with 11 more variables: receita <dbl>, receita_eua <dbl>, nota_imdb <dbl>,
## #   num_avaliacoes <dbl>, direcao <chr>, roteiro <chr>, producao <chr>,
## #   elenco <chr>, descricao <chr>, num_criticas_publico <dbl>,
## #   num_criticas_critica <dbl>
```


**f.** filmes que não possuem informação tanto de receita quanto de orçamento (isto é, possuem `NA` em ambas as colunas).


```r
imdb %>% 
  filter(is.na(orcamento), is.na(receita))
```

```
## # A tibble: 2,921 × 20
##    id_filme  titulo   ano data_lancamento generos duracao pais  idioma orcamento
##    <chr>     <chr>  <dbl> <chr>           <chr>     <dbl> <chr> <chr>      <dbl>
##  1 tt0037931 Murde…  1945 1945-06-23      Comedy…      91 USA   Engli…        NA
##  2 tt0033945 Never…  1941 1947-05-02      Comedy…      71 USA   Engli…        NA
##  3 tt3703836 Henry…  2015 2016-01-08      Drama        87 USA   Engli…        NA
##  4 tt0110668 Night…  1995 1995-02-04      Action…      93 USA   Engli…        NA
##  5 tt0035784 Dead …  1943 1943-04-12      Drama,…      64 USA   Engli…        NA
##  6 tt0025101 Fashi…  1934 1934-02-14      Comedy…      78 USA   Engli…        NA
##  7 tt1242423 Dear …  2009 2011-07-01      Comedy       87 USA   Engli…        NA
##  8 tt0046353 Split…  1953 1953-05-02      Crime,…      85 USA   Engli…        NA
##  9 tt0482461 Barry…  2010 2018            Comedy…      95 USA   Engli…        NA
## 10 tt0029992 A Chr…  1938 1938-12-16      Drama,…      69 USA   Engli…        NA
## # … with 2,911 more rows, and 11 more variables: receita <dbl>,
## #   receita_eua <dbl>, nota_imdb <dbl>, num_avaliacoes <dbl>, direcao <chr>,
## #   roteiro <chr>, producao <chr>, elenco <chr>, descricao <chr>,
## #   num_criticas_publico <dbl>, num_criticas_critica <dbl>
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
## # A tibble: 1,795 × 21
##    id_filme  titulo   ano data_lancamento generos duracao pais  idioma orcamento
##    <chr>     <chr>  <dbl> <chr>           <chr>     <dbl> <chr> <chr>      <dbl>
##  1 tt2063781 Smash…  2012 2012-12-14      Drama        81 USA   Engli…    500000
##  2 tt1880418 Newly…  2011 2011-11-04      Comedy…      95 USA   Engli…      9000
##  3 tt0067961 Wanda   1970 1971-01-14      Crime,…     102 USA   Engli…    115000
##  4 tt0073043 The G…  1975 1975-10-01      Horror…      84 USA   Engli…    300000
##  5 tt0083745 Come …  1982 1983-04-06      Comedy…     109 USA   Engli…    850000
##  6 tt0045826 Glen …  1953 1953-04-01      Drama        65 USA   Engli…     20000
##  7 tt0365960 Zero …  2002 2004-01-23      Drama        92 USA   Engli…     20000
##  8 tt0086058 The O…  1983 1983-11-04      Action…     103 USA   Engli…   6500000
##  9 tt0037638 Detour  1945 1946-01-25      Crime,…      68 USA   Engli…     30000
## 10 tt1294161 The E…  2009 2010-05-06      Drama        79 USA   Engli…     40000
## # … with 1,785 more rows, and 12 more variables: receita <dbl>,
## #   receita_eua <dbl>, nota_imdb <dbl>, num_avaliacoes <dbl>, direcao <chr>,
## #   roteiro <chr>, producao <chr>, elenco <chr>, descricao <chr>,
## #   num_criticas_publico <dbl>, num_criticas_critica <dbl>, prejuizo <dbl>
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
## # A tibble: 11,340 × 24
##    id_filme  titulo   ano data_lancamento generos duracao pais  idioma orcamento
##    <chr>     <chr>  <dbl> <chr>           <chr>     <dbl> <chr> <chr>      <dbl>
##  1 tt0092699 Broad…  1987 1988-04-01      Comedy…     133 USA   Engli…  20000000
##  2 tt0037931 Murde…  1945 1945-06-23      Comedy…      91 USA   Engli…        NA
##  3 tt0183505 Me, M…  2000 2000-09-08      Comedy      116 USA   Engli…  51000000
##  4 tt0033945 Never…  1941 1947-05-02      Comedy…      71 USA   Engli…        NA
##  5 tt0372122 Adam …  2005 2007-05-17      Comedy…      99 USA   Engli…        NA
##  6 tt3703836 Henry…  2015 2016-01-08      Drama        87 USA   Engli…        NA
##  7 tt0093640 No Wa…  1987 1987-12-11      Action…     114 USA   Engli…  15000000
##  8 tt0494652 Welco…  2008 2008-02-08      Comedy…     104 USA   Engli…  35000000
##  9 tt0094006 Some …  1987 1988-01-13      Drama,…      95 USA   Engli…        NA
## 10 tt1142798 The F…  2008 2008-09-12      Drama       111 USA   Engli…        NA
## # … with 11,330 more rows, and 15 more variables: receita <dbl>,
## #   receita_eua <dbl>, nota_imdb <dbl>, num_avaliacoes <dbl>, direcao <chr>,
## #   roteiro <chr>, producao <chr>, elenco <chr>, descricao <chr>,
## #   num_criticas_publico <dbl>, num_criticas_critica <dbl>, lucro <dbl>,
## #   lucro_medio <dbl>, lucro_relativo <dbl>, houve_lucro <chr>
```

---

**3.** Crie uma nova coluna que classifique o filme em `"recente"` (posterior a 2000) e `"antigo"` (de 2000 para trás).


```r
imdb %>% 
  mutate(antigo_ou_recente = ifelse(ano > 2000, "recente", "antigo"))
```

```
## # A tibble: 11,340 × 21
##    id_filme  titulo   ano data_lancamento generos duracao pais  idioma orcamento
##    <chr>     <chr>  <dbl> <chr>           <chr>     <dbl> <chr> <chr>      <dbl>
##  1 tt0092699 Broad…  1987 1988-04-01      Comedy…     133 USA   Engli…  20000000
##  2 tt0037931 Murde…  1945 1945-06-23      Comedy…      91 USA   Engli…        NA
##  3 tt0183505 Me, M…  2000 2000-09-08      Comedy      116 USA   Engli…  51000000
##  4 tt0033945 Never…  1941 1947-05-02      Comedy…      71 USA   Engli…        NA
##  5 tt0372122 Adam …  2005 2007-05-17      Comedy…      99 USA   Engli…        NA
##  6 tt3703836 Henry…  2015 2016-01-08      Drama        87 USA   Engli…        NA
##  7 tt0093640 No Wa…  1987 1987-12-11      Action…     114 USA   Engli…  15000000
##  8 tt0494652 Welco…  2008 2008-02-08      Comedy…     104 USA   Engli…  35000000
##  9 tt0094006 Some …  1987 1988-01-13      Drama,…      95 USA   Engli…        NA
## 10 tt1142798 The F…  2008 2008-09-12      Drama       111 USA   Engli…        NA
## # … with 11,330 more rows, and 12 more variables: receita <dbl>,
## #   receita_eua <dbl>, nota_imdb <dbl>, num_avaliacoes <dbl>, direcao <chr>,
## #   roteiro <chr>, producao <chr>, elenco <chr>, descricao <chr>,
## #   num_criticas_publico <dbl>, num_criticas_critica <dbl>,
## #   antigo_ou_recente <chr>
```

### Sumarizando a base {-}

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
## # A tibble: 1 × 2
##   duracao_media duracao_mediana
##           <dbl>           <dbl>
## 1          99.7              97
```

---

**2.** Calcule o lucro médio dos filmes com duração maior que 2 horas (ou seja, 120 minutos).


```r
imdb %>% 
  filter(duracao > 120) %>% 
  mutate(lucro = receita - orcamento) %>% 
  summarise(lucro_medio = mean(lucro, na.rm = TRUE))
```

```
## # A tibble: 1 × 1
##   lucro_medio
##         <dbl>
## 1  126496589.
```

---

**3.** Apresente na mesma tabela o lucro médio dos filmes com duracao menor que 120 minutos e o lucro médio dos filmes com duracao maior ou igual a 120 minutos.


```r
imdb %>% 
  mutate(
    lucro = receita - orcamento,
    duracao_cat = ifelse(duracao < 120, "menor 2h", "2h ou mais")
  ) %>% 
  filter(!is.na(lucro)) %>% 
  group_by(duracao_cat) %>% 
  summarise(
    lucro_medio = mean(lucro, na.rm = TRUE)
  )
```

```
## # A tibble: 2 × 2
##   duracao_cat lucro_medio
##   <chr>             <dbl>
## 1 2h ou mais   121255603.
## 2 menor 2h      35676085.
```

---

**4.** Retorne tabelas (`tibbles`) apenas com:

**a.** a nota IMDB média dos filmes por ano de lançamento;


```r
imdb %>% 
  group_by(ano) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE))
```

```
## # A tibble: 108 × 2
##      ano nota_media
##    <dbl>      <dbl>
##  1  1914       6.27
##  2  1915       6.57
##  3  1916       7   
##  4  1917       6.7 
##  5  1918       6.63
##  6  1919       6.9 
##  7  1920       6.76
##  8  1921       7.07
##  9  1922       6.9 
## 10  1923       7.27
## # … with 98 more rows
```

**b.** a receita média e mediana dos filmes por ano;


```r
imdb %>% 
  filter(!is.na(receita)) %>% 
  group_by(ano) %>% 
  summarise(
    receita_media = mean(receita, na.rm = TRUE),
    receita_mediana = median(receita, na.rm = TRUE)
  )
```

```
## # A tibble: 95 × 3
##      ano receita_media receita_mediana
##    <dbl>         <dbl>           <dbl>
##  1  1921      4605294.        4605294.
##  2  1923        11233           11233 
##  3  1925      2406972         2834000 
##  4  1927        42231.           4841 
##  5  1928       589574.          26916 
##  6  1929      5277780         5277780 
##  7  1931        37363.          31312.
##  8  1932       448907           34649 
##  9  1933        33289           14352.
## 10  1934      2198358.           9800 
## # … with 85 more rows
```

**c.** apenas o nome das pessoas que dirigiram mais de 10 filmes.


```r
imdb %>% 
  filter(!is.na(direcao)) %>% 
  group_by(direcao) %>% 
  summarise(num_filmes = n()) %>% 
  filter(num_filmes > 10) %>% 
  select(direcao)
```

```
## # A tibble: 134 × 1
##    direcao           
##    <chr>             
##  1 Alan J. Pakula    
##  2 Alan Rudolph      
##  3 Albert Pyun       
##  4 Alfred Hitchcock  
##  5 Andrew V. McLaglen
##  6 Anthony Mann      
##  7 Arthur Hiller     
##  8 Arthur Penn       
##  9 Barry Levinson    
## 10 Billy Wilder      
## # … with 124 more rows
```

*Também podemos usar a função `count()`.*


```r
imdb %>% 
  filter(!is.na(direcao)) %>% 
  count(direcao, name = "num_filmes") %>% 
  filter(num_filmes > 10) %>% 
  select(direcao)
```

```
## # A tibble: 134 × 1
##    direcao           
##    <chr>             
##  1 Alan J. Pakula    
##  2 Alan Rudolph      
##  3 Albert Pyun       
##  4 Alfred Hitchcock  
##  5 Andrew V. McLaglen
##  6 Anthony Mann      
##  7 Arthur Hiller     
##  8 Arthur Penn       
##  9 Barry Levinson    
## 10 Billy Wilder      
## # … with 124 more rows
```


### Juntando duas bases {-}

**1.** Utilize a base `imdb` para resolver os itens a seguir.

**a.** Salve em um novo objeto uma tabela com a
nota média dos filmes de cada pessoa que dirigiu filmes. Essa tabela
deve conter duas colunas (`direcao` e `nota_imdb_media`)
e cada linha deve ser um pessoa diferente.


```r
nota_direcao <- imdb %>% 
  group_by(direcao) %>% 
  summarise(nota_imdb_media = mean(nota_imdb))

nota_direcao
```

```
## # A tibble: 5,140 × 2
##    direcao                           nota_imdb_media
##    <chr>                                       <dbl>
##  1 A. Edward Sutherland                         6.62
##  2 A.J. Edwards                                 6.1 
##  3 A.T. White                                   5.3 
##  4 Aaron Blaise, Robert Walker                  6.8 
##  5 Aaron Hann, Mario Miscione                   6   
##  6 Aaron Harvey                                 4.97
##  7 Aaron Horvath, Peter Rida Michail            6.8 
##  8 Aaron K. Carter                              8.2 
##  9 Aaron Katz                                   6   
## 10 Aaron Kaufman                                4.5 
## # … with 5,130 more rows
```


**b.** Use o `left_join()` para trazer a coluna
`nota_imdb_media` da tabela do item anterior
para a tabela `imdb` original.


```r
imdb %>% 
  left_join(nota_direcao, by = "direcao") %>% 
  select(nota_imdb_media, everything())
```

```
## # A tibble: 11,340 × 21
##    nota_imdb_media id_filme  titulo    ano data_lancamento generos duracao pais 
##              <dbl> <chr>     <chr>   <dbl> <chr>           <chr>     <dbl> <chr>
##  1            6.6  tt0092699 Broadc…  1987 1988-04-01      Comedy…     133 USA  
##  2            6.8  tt0037931 Murder…  1945 1945-06-23      Comedy…      91 USA  
##  3            6.1  tt0183505 Me, My…  2000 2000-09-08      Comedy      116 USA  
##  4            7.02 tt0033945 Never …  1941 1947-05-02      Comedy…      71 USA  
##  5            5.9  tt0372122 Adam &…  2005 2007-05-17      Comedy…      99 USA  
##  6            6.4  tt3703836 Henry …  2015 2016-01-08      Drama        87 USA  
##  7            6.29 tt0093640 No Way…  1987 1987-12-11      Action…     114 USA  
##  8            6.1  tt0494652 Welcom…  2008 2008-02-08      Comedy…     104 USA  
##  9            6.43 tt0094006 Some K…  1987 1988-01-13      Drama,…      95 USA  
## 10            5.02 tt1142798 The Fa…  2008 2008-09-12      Drama       111 USA  
## # … with 11,330 more rows, and 13 more variables: idioma <chr>,
## #   orcamento <dbl>, receita <dbl>, receita_eua <dbl>, nota_imdb <dbl>,
## #   num_avaliacoes <dbl>, direcao <chr>, roteiro <chr>, producao <chr>,
## #   elenco <chr>, descricao <chr>, num_criticas_publico <dbl>,
## #   num_criticas_critica <dbl>
```

