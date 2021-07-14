

## O pacote forcats


```r
library(dplyr)
library(forcats)
library(ggplot2)
```

**1.** Qual a diferença nos fatores criados com os códigos abaixo?


```r
fator1 <- as.factor(c("c", "a", "z", "B"))
fator2 <- forcats::as_factor(c("c", "a", "z", "B"))
```

A função do R base `as.factor()` ordena os níveis do fator em ordem alfabética. A função `as_factor()` do pacote `forcats` ordena os níveis do fator na ordem que eles aparecem no vetor.

---

**2.** Ordene os níveis do fator `frutas` conforme a sua preferência, isto é, as que você mais gosta primeiro e as que você menos gosta por último.


```r
frutas <- as.factor(c("maçã", "banana", "mamão", "laranja", "melancia"))
frutas
## [1] maçã     banana   mamão    laranja  melancia
## Levels: banana laranja maçã mamão melancia

# preferência do Willy
lvls_reorder(frutas, c(4, 5, 1, 3, 2))
## [1] maçã     banana   mamão    laranja  melancia
## Levels: mamão melancia banana maçã laranja
```

---

**3.** Com base no vetor `series`, resolva os itens a seguir.


```r
series <- as.factor(c("Game of Thrones", "How I Met your Mother", "Friends", "Lost", "The Office", "Breaking Bad"))
```

**a.** Ordene os níveis do vetor `series` conforme a sua preferência, isto é, as que você mais gosta primeiro e as que você menos gosta por último. 


```r
levels(series)
## [1] "Breaking Bad"          "Friends"               "Game of Thrones"      
## [4] "How I Met your Mother" "Lost"                  "The Office"

# preferência do Willy
series <- lvls_reorder(series, c(6, 5, 1, 3, 2, 4))
```


**b.** Junte ao vetor `series` o vetor `novas_series` a seguir, reordenando os níveis para manter a sua ordem de preferência.


```r
novas_series <- as.factor(c("Stranger Things", "The Boys", "Queen's Gambit"))

series <- series %>% 
  fct_c(novas_series) 

levels(series)
## [1] "The Office"            "Lost"                  "Breaking Bad"         
## [4] "Game of Thrones"       "Friends"               "How I Met your Mother"
## [7] "Queen's Gambit"        "Stranger Things"       "The Boys"

series <- lvls_reorder(series, c(1:7, 9, 8))
levels(series)
## [1] "The Office"            "Lost"                  "Breaking Bad"         
## [4] "Game of Thrones"       "Friends"               "How I Met your Mother"
## [7] "Queen's Gambit"        "The Boys"              "Stranger Things"
```

**c.** Renomeie o níveis do vetor criado no item (b) para os nomes em Português das séries. Mantenha o mesmo nome caso não haja tradução.


```r
series %>% 
  fct_recode(
    "A Guerra dos Tronos" = "Game of Thrones",
    "Como Eu Conheci Sua Mãe" = "How I Met your Mother",
    "A Química do Mal" = "Breaking Bad",
    "O Gambito da Rainha" = "Queen's Gambit"
  )
## [1] A Guerra dos Tronos     Como Eu Conheci Sua Mãe Friends                
## [4] Lost                    The Office              A Química do Mal       
## [7] Stranger Things         The Boys                O Gambito da Rainha    
## 9 Levels: The Office Lost A Química do Mal A Guerra dos Tronos ... Stranger Things
```

---

**4.** Ordene as categorias do eixo y do gráfico abaixo para que os pontos no eixo x fique em ordem crescente.


```r
mtcars %>% 
  tibble::rownames_to_column("modelo") %>% 
  mutate(modelo = fct_reorder(modelo, mpg)) %>% 
  ggplot(aes(x = mpg, y = modelo)) +
  geom_point()
```

<img src="9845-respostas-forcats_files/figure-epub3/unnamed-chunk-9-1.png" style="display: block; margin: auto;" />

---

**5.** Utilize a base `dados::casas` para fazer um gráfico de barras mostrando as vizinhanças (coluna `vizinhanca`) com casas mais caras (segundo a coluna `venda_valor`). O gráfico deve conter as 9 vizinhanças mais frequentes e as demais devem ser agrupadas em uma categoria chamada `Outras vizinhanças`.


```r
dados::casas %>% 
  mutate(vizinhanca = fct_lump_n(vizinhanca, 9, other_level = "Outras vizinhanças")) %>% 
  group_by(vizinhanca) %>% 
  summarise(venda_valor = mean(venda_valor, na.rm = TRUE)) %>% 
  mutate(vizinhanca = fct_reorder(vizinhanca, venda_valor)) %>% 
  ggplot(aes(x = venda_valor, y = vizinhanca)) +
  geom_col()
```

<img src="9845-respostas-forcats_files/figure-epub3/unnamed-chunk-10-1.png" style="display: block; margin: auto;" />



