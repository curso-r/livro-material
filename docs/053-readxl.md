## Os pacotes readxl e writexl {#readxl}

Para ler planilhas do Excel (arquivos `.xlsx` ou `.xls`), basta utilizarmos a função `read_excel()` do pacote `readxl`. Instale o pacote antes caso você ainda não o tenha instalado.





```r
install.packages("readxl")
library(readxl)

imdb_xlsx <- read_xls("dados/imdb.xlss")
imdb_xlsx <- read_xlsx("dados/imdb.xlsx")
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

Vamos pegar o caminho até o arquivo `datasets.xlsx` usando a função `readxl_example()`. 


```r
caminho_datasets <- readxl_example("datasets.xlsx")
caminho_datasets
```

```
## [1] "/Library/Frameworks/R.framework/Versions/4.0/Resources/library/readxl/extdata/datasets.xlsx"
```

No Excel, um arquivo pode ter várias planilhas. Esse é o caso do arquivo `datasets.xlsx`. Você pode ver quais planilhas fazem parte do arquivo utilizando a função `excel_sheets()`.


```r
excel_sheets(caminho_datasets)
```

```
## [1] "iris"     "mtcars"   "chickwts" "quakes"
```

Por padrão, as funções de leitura trarão apenas a primeira planilha do arquivo. Para trazer outra planilha, basta utilizarmos o argumento `sheet`.


```r
# Pega a primeira planilha
read_excel(caminho_datasets)
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

```r
# Pega a segunda planilha
read_excel(caminho_datasets, sheet = 2)
```

```
## # A tibble: 32 x 11
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

```r
# Pega a planilha selecionada
read_excel(caminho_datasets, sheet = 'chickwts')
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

A seguir, listamos outros argumentos úteis da função `read_excel()`:

- `col_names` indica se a primeira linha representa o nome das colunas;

- `col_types=` para definir a classe das colunas;

- `skip=` para pular linhas no começo da planilha;

- `na=` indica quais strings devem ser interpretadas como NA.

Também podemos escrever um arquivo Excel (com extensão `.xlsx`) utilizando a função `write_xlsx()` do pacote `writexl`.


```r
install.packages("writexl")
library(writexl)

write_excel(mtcars, "imdb.xlsx")
```

