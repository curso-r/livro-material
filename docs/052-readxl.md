## readxl {#readxl}

O pacote `readxl` do tydiverse contém funções para importação com os formatos `.xls` e `xlsx`.




```r
readxl::read_xls(path = "assets/data/imdb.xls")
readxl::read_xlsx(path = "assets/data/imdb.xlsx")
```

A funçao `read_excel()` auto detecta a extensão do arquivo.


```r
read_excel(path = "assets/data/imdb.xls")
read_excel(path = "assets/data/imdb.xlsx")
```

O pacote disponibiliza 5 exemplos de arquivos com formato `.xls` e `.xlsx`.


```r
readxl_example()
```

```
##  [1] "clippy.xls"    "clippy.xlsx"   "datasets.xls"  "datasets.xlsx"
##  [5] "deaths.xls"    "deaths.xlsx"   "geometry.xls"  "geometry.xlsx"
##  [9] "type-me.xls"   "type-me.xlsx"
```

Vamos acessar o arquivo datasets.xls.


```r
datasets <- readxl_example("datasets.xls")
read_xls(datasets)
```

```
## # A tibble: 150 x 5
##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
##           <dbl>       <dbl>        <dbl>       <dbl> <chr>  
##  1          5.1         3.5          1.4         0.2 setosa 
##  2          4.9         3            1.4         0.2 setosa 
##  3          4.7         3.2          1.3         0.2 setosa 
##  4          4.6         3.1          1.5         0.2 setosa 
##  5          5           3.6          1.4         0.2 setosa 
##  6          5.4         3.9          1.7         0.4 setosa 
##  7          4.6         3.4          1.4         0.3 setosa 
##  8          5           3.4          1.5         0.2 setosa 
##  9          4.4         2.9          1.4         0.2 setosa 
## 10          4.9         3.1          1.5         0.1 setosa 
## # … with 140 more rows
```

No Excel, um arquivo pode ter várias planilhas. Você pode ver quais planilhas fazem parte do arquivo:


```r
excel_sheets(datasets)
```

```
## [1] "iris"     "mtcars"   "chickwts" "quakes"
```

Observe que quando usamos a função `read_xls(datasets)`, o R transformou em tibble apenas a primeira planilha do arquivo. Caso essa não for a tabela que você deseja acessar, não se preocupe! Podemos resolver seu problema de forma simples.


```r
read_xls(datasets,sheet = 'chickwts')
```

```
## # A tibble: 71 x 2
##    weight feed     
##     <dbl> <chr>    
##  1    179 horsebean
##  2    160 horsebean
##  3    136 horsebean
##  4    227 horsebean
##  5    217 horsebean
##  6    168 horsebean
##  7    108 horsebean
##  8    124 horsebean
##  9    143 horsebean
## 10    140 horsebean
## # … with 61 more rows
```

Também é possivel fazer uma seleção das células da planilha que você deseja importar usando o argumento `range = ` da função `read_excel`. Podemos indicar quais colunas ou linhas desejamos com as funções `cell_cols()` e `cell_rows()` respectivamente. Ou podemos difinir a dimensão dos dados a partir de uma célula com a função `anchored()`. Veja todas as fuções disponíveis neste [manual](https://cran.r-project.org/web/packages/cellranger/cellranger.pdf).


```r
read_xls(datasets,sheet = 'chickwts',range = anchored('A3',dim = c(5,2)),col_names = F)
```

```
## New names:
## * `` -> ...1
## * `` -> ...2
```

```
## # A tibble: 5 x 2
##    ...1 ...2     
##   <dbl> <chr>    
## 1   160 horsebean
## 2   136 horsebean
## 3   227 horsebean
## 4   217 horsebean
## 5   168 horsebean
```


