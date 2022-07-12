## Tibbles

*Tibbles* são *data frames* com ajustes que as deixam mais amigáveis a nós cientistas de dados. Elas são parte do pacote `{tibble}`. Assim, para começar a usá-las, instale e carregue o pacote.


```r
install.packages("tibble")
library(tibble)
```




Há duas formas de criar uma *tibble*. A primeira é transformar um *data frame* em *tibble* utilizando a função `as_tibble()`.


```r
as_tibble(mtcars)
```

```
## # A tibble: 32 × 11
##      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
##    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
##  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
##  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
##  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
##  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
##  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
##  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
##  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
##  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
## 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
## # … with 22 more rows
```

Veja que, por padrão, apenas as dez primeiras linhas da base são apresentadas. Além disso, colunas que não couberem na largura da tela serão omitidas. Também são apresentadas a dimensão da tabela e as classes de cada coluna. Compare a diferença de impressão com relação a um *data frame*.


```r
mtcars
```

```
##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

Veja também que, ao contrário dos *data frames*, *tibbles* não utilizam nome nas linhas. 

A segunda forma de criar uma *tibble* é a partir de vetores individuais, utilizando a função `tibble()`.


```r
tibble(
  coluna1 = c("a", "b", "c", "d"),
  coluna2 = 1:4,
  coluna3 = coluna2 ^ 2,
  coluna4 = 0
)
```

```
## # A tibble: 4 × 4
##   coluna1 coluna2 coluna3 coluna4
##   <chr>     <int>   <dbl>   <dbl>
## 1 a             1       1       0
## 2 b             2       4       0
## 3 c             3       9       0
## 4 d             4      16       0
```
Observamos pelo código acima que:

- podemos criar uma coluna a partir de uma função de colunas anteriores (a `coluna3` é uma função da `coluna2`);
- se passarmos um vetor de tamanho 1 a uma das colunas, esse vetor será reciclado, igualando-se ao número de linhas da *tibble* (o `0` na `coluna4` é transformado em `c(0, 0, 0, 0)`).

Uma outra diferença entre *data frames* e *tibbles* está no *subsetting*. *Tibbles* **nunca fazem correspondência parcial**. Tibbles retornam `NULL` e um aviso quando você tenta selecionar uma coluna que não existe.


```r
# O nome da coluna é disp, mas você pode acessá-la
# apenas a procurando por "dis", já que não existe
# nenhuma outra coluna que começa com "dis".
mtcars$dis
```

```
##  [1] 160.0 160.0 108.0 258.0 360.0 225.0 360.0 146.7 140.8 167.6 167.6 275.8
## [13] 275.8 275.8 472.0 460.0 440.0  78.7  75.7  71.1 120.1 318.0 304.0 350.0
## [25] 400.0  79.0 120.3  95.1 351.0 145.0 301.0 121.0
```

```r
# Em tibbles isso não funciona.
mtcars_tibble <- as_tibble(mtcars)
mtcars_tibble$dis
```

```
## Warning: Unknown or uninitialised column: `dis`.
```

```
## NULL
```

Além de nos possibilitar a criar *tibbles*, o pacote `{tibble}` possui algumas funções úteis para manipularmos esses objetos:

- `add_row()` e `add_column()`: para adicionar linhas e colunas a uma *tibble*;

- `rowid_to_column()`: cria uma coluna com um `id` numérico e sequencial para as linhas, começando de `1`.


```r
mtcars %>% 
  rowid_to_column() %>% 
  head(10)
```

```
##    rowid  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1      1 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## 2      2 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## 3      3 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## 4      4 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## 5      5 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## 6      6 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## 7      7 14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## 8      8 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## 9      9 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## 10    10 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
```

- `has_rownames()`: verifica se um *data frame* possui linhas nomeadas.

- `remove_rownames()`: remove o nome das linhas de um *data frame*.

- `rownames_to_column()`: transforma o nome das linhas em uma coluna.


```r
rownames_to_column(mtcars, var = "modelo_do_carro")
```

```
##        modelo_do_carro  mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## 1            Mazda RX4 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## 2        Mazda RX4 Wag 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## 3           Datsun 710 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## 4       Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## 5    Hornet Sportabout 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## 6              Valiant 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
## 7           Duster 360 14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
## 8            Merc 240D 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## 9             Merc 230 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## 10            Merc 280 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
## 11           Merc 280C 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## 12          Merc 450SE 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
## 13          Merc 450SL 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
## 14         Merc 450SLC 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
## 15  Cadillac Fleetwood 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## 16 Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
## 17   Chrysler Imperial 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
## 18            Fiat 128 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## 19         Honda Civic 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## 20      Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## 21       Toyota Corona 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## 22    Dodge Challenger 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## 23         AMC Javelin 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## 24          Camaro Z28 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## 25    Pontiac Firebird 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## 26           Fiat X1-9 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## 27       Porsche 914-2 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## 28        Lotus Europa 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## 29      Ford Pantera L 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## 30        Ferrari Dino 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## 31       Maserati Bora 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
## 32          Volvo 142E 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

- `column_to_rownames()`: transforma uma coluna em nomes das linhas.

Mais informações sobre `tibbles` podem ser encontradas [neste tutorial do RStudio](https://tibble.tidyverse.org/) e [neste capítulo do livro R for Data Science](http://r4ds.had.co.nz/tibbles.html).
