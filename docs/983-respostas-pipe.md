## Pipe

---


```r
library(magrittr)
```

**1.** Reescreva a expressão abaixo utilizando o `%>%`.


```r
round(mean(sum(1:10)/3), digits = 1)

1:10 %>%
  sum %>%
  divide_by(3) %>%
  round(digits = 1)
```

---

**2.** Reescreva o código abaixo utilizando o `%>%`.


```r
# Setamos a semente que gera números aleatórios para deixar o resultado reprodutível

set.seed(137)

x <- rnorm(100)
x.pos <- x[x>0]
media <- mean(x.pos)
saida <- round(media, 2)
saida
```



```r
set.seed(137)

rnorm(100) %>%
  magrittr::extract(. > 0) %>%
  mean %>%
  round(digits = 2)
```

---

**3.** Sem rodar, diga qual a saída do código abaixo. Consulte o help das funções caso precise.


```r
2 %>%
  add(2) %>%
  c(6, NA) %>%
  mean(na.rm = T) %>%
  equals(5)
```

- *Primeiro, somamos 2 com 2, gerando o valor 4.*
- *Então colocamos esse valor em um vetor com os valores 6 e `NA`.*
- *Em seguida, tiramos a média desse vetor, desconsiderando o `NA`, obtendo o valor 5.*
- *Por fim, testemos se o valor é igual a 5, obtendo o valor `TRUE`.*
