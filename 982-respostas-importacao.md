## Importação

### O pacote readr {-}

**1.** Qual a diferença entre as funções `read_csv()` e `read_csv2()`?

*A função `read_csv() lê arquivos CSV separados por vírgula (padrão norte-americano). A função `read_csv2()` lê arquivos CSV separados por ponto-e-vírgula (padrão brasileiro, já que usamos a vírgula como seperador de decimais).*

---

**2.** Leia o arquivo `imdb.csv` utilizando a função `read_delim()`.


```r
library(readr)

read_delim("imdb.csv", delim = ",")
```


---

**3.** Escreva a base mtcars em um arquivo `mtcars.csv` que não contenha o nome das colunas.


```r
write_csv(mtcars, "mtcars.csv", col_names = FALSE)
```


---

**4.** Use a função `write_rds()` para salvar em arquivos

**a)** Um número.


```r
numero <- 29
write_rds(numero, "numero.rds")
```

**b)** Um vetor de strings.


```r
estados <- c("SP", "RN", "AC", "MG")
write_rds(estados, "estados.rds")
```

**c)** Uma lista com valores númericos, textuais e lógicos.


```r
lista <- list(numero = 1, texto = c("M", "F", "F"), logico = FALSE)
write_rds(lista, "lista.rds")
```

**d)** As 3 primeiras colunas da base `mtcars`.


```r
write_rds(mtcars[,1:3], "mtcars_3_colunas.rds")
```

---

**5.** Utilize a função `read_rds()` para importar de volta para o R os arquivos criados no exercício 4.


```r
read_rds("numero.rds")
read_rds("estados.rds")
read_rds("lista.rds")
read_rds("mtcars_3_colunas.rds")
```

