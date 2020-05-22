## haven {#haven}

Para ler arquivos gerados por outros softwares, como SPSS, SAS e STATA, você pode usar as funções do pacote `haven`. Este pacote faz parte do `tidyverse` e é um wrapper da biblioteca ReadStat, escrita em C.



```r
library(haven)

imdb_sas <- read_sas("assets/data/imdb.sas7bdat")
imdb_spss <- read_spss("assets/data/imdb.sav")
imdb_dta <- read_dta("assets/data/imdb.dta")
```

É possível salvar ou escrever bases em SAS e STATA com as funções `write_sas` e `write_dta`.


```r
write_dta(mtcars, 'assets/data/mtcars.dta')
```


Quando importamos arquivos gerados pelo SAS SPSS ou STATA para o R, os rótulos de uma variável podem não ser importados de forma correta.  O pacote `haven` tem uma soluçao para este problema. 


```r
x <- labelled(c(1,1,2,3,2,2,1,2), c(Ruim = 1, Bom = 2, Otimo = 3))
```

`labelled()` adiciona rótulos à valores de uma variável. Para verificar quais são estes rótulos, podemos usar a função `print_labels()`.


```r
print_labels(x)
```

```
## 
## Labels:
##  value label
##      1  Ruim
##      2   Bom
##      3 Otimo
```
Existe uma função similar a `labelled()`, exclusiva para o SPSS, que além de rotular as variáveis, também defini quais símbolos representam valores faltantes, dado que em SPSS pode haver mais de um tipo de *missing*.


```r
x1 <- labelled_spss(c(1,3,0,2,2,1,0,2,4), c(Ruim = 1,Bom = 2, Otimo = 3), na_values = c(0,4))
    
is.na(x1)
```

```
## [1] FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE
```
Agora que já definimos os *missings* "especiais", podemos transformá-los no *missing* padrão do R, representado pelo símbolo *NA*.

```r
x1 <- zap_missing(x1)
x1
```

```
## <Labelled double>
## [1]  1  3 NA  2  2  1 NA  2 NA
## 
## Labels:
##  value label
##      1  Ruim
##      2   Bom
##      3 Otimo
```
Existem outras funções `zap_` interessantes no [pacote](https://cran.r-project.org/web/packages/haven/haven.pdf).


Após rotular os valores do vetor, podemos convertê-los, por exemplo, em fator. Para isso, usamos uma função do pacote `haven`.
A função base `as.factor()` também poderia ser usada, mas quando a usamos, os rótulos não são considerados.


```r
x_base <- base::as.factor(x)
levels(x_base)
```

```
## [1] "1" "2" "3"
```

```r
x_factor <- haven::as_factor(x)
levels(x_factor)
```

```
## [1] "Ruim"  "Bom"   "Otimo"
```



