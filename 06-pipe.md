# Pipe {#pipe}



O operador `%>%` (*pipe*) foi uma das grandes revoluções recentes do R, tornando a escrita e leitura de códigos mais intuitiva e compreensível. Ele foi introduzido por [Stefan Milton Bache](https://github.com/smbache) no pacote `magrittr`, cujo nome é uma referência ao famoso quadro do pintor belga René Magritte *La Trahison des images (Ceci n'est pas une pipe)*.

<div class="figure">
<img src="https://raw.githubusercontent.com/curso-r/livro-material/master/assets/img/pipe/ceci-nest-pas-une-pipe.jpg" alt="Reprodução do quadro La Trahison des images (Ceci n’est pas une pipe). do pintor René Magritte."  />
<p class="caption">(\#fig:unnamed-chunk-2)Reprodução do quadro La Trahison des images (Ceci n’est pas une pipe). do pintor René Magritte.</p>
</div>

Para começar a utilizar o *pipe*, instale e carregue o pacote `magrittr`.


```r
install.packages("magrittr")
library(magrittr)
```

## O operador pipe

A ideia do operador `%>%` (*pipe*) é bem simples: usar o valor resultante da expressão do lado esquerdo como primeiro argumento da função do lado direito.


```r
# As duas linhas abaixo são equivalentes.

f(x, y)
x %>% f(y)
```

Nos casos mais simples, o *pipe* parece não trazer grandes vantagens. Agora, veja como fica um caso com mais etapas.


```r
# Vamos calcular a raiz quadrada da soma dos valores de 1 a 4. Primeiro, sem o pipe.

x <- c(1, 2, 3, 4)
sqrt(sum(x))
```

```
## [1] 3.162278
```

```r
# Agora com o pipe.

x %>% sum() %>% sqrt()
```

```
## [1] 3.162278
```

O caminho que o código `x %>% sum %>% sqrt` seguiu foi enviar o objeto `x` como argumento da função `sum()` e, em seguida, enviar a saida da expressão `sum(x)` como argumento da função `sqrt()`. Observe que escrevemos o código na mesma ordem em que as operações são realizadas. A utilização de parênteses após o nome das funções não é necessário, mas recomendável.

Se você ainda não está convencido com o poder do *pipe*, fica que vai ter bolo!

No exemplo abaixo, vamos ilustrar um caso em que temos um grande número de funções aninhadas. Veja como a utilização do *pipe* transforma um código confuso e difícil de ser lido em algo simples e intuitivo.



```r
# Receita de bolo sem pipe. Tente entender o que é preciso fazer.

esfrie(
  asse(
    coloque(
      bata(
        acrescente(
          recipiente(
            rep("farinha", 2), 
            "água", 
            "fermento", 
            "leite", 
            "óleo"
          ), 
          "farinha", 
          ate = "macio"
        ), 
        duracao = "3min"
      ), 
      lugar = "forma", 
      tipo = "grande", 
      untada = TRUE
    ), 
    duracao = "50min"
  ), 
  lugar = "geladeira", 
  duracao = "20min"
)


# Veja como o código acima pode ser reescrito utilizando-se o pipe. Agora realmente se parece com uma receita de bolo.

recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
  acrescente("farinha", ate = "macio") %>%
  bata(duracao = "3min") %>%
  coloque(lugar = "forma", tipo = "grande", untada = TRUE) %>%
  asse(duracao = "50min") %>%
  esfrie(lugar = "geladeira", duracao = "20min")
```

Às vezes, queremos que o resultado do lado esquerdo vá para outro argumento do lado direito que não o primeiro. Para isso, utilizamos um `.` como marcador.


```r
# Queremos que o dataset seja recebido pelo segundo argumento (data=) da função "lm".

airquality %>%
  na.omit() %>%
  lm(Ozone ~ Wind + Temp + Solar.R, data = .) %>%
  summary()
```

```
## 
## Call:
## lm(formula = Ozone ~ Wind + Temp + Solar.R, data = .)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -40.485 -14.219  -3.551  10.097  95.619 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) -64.34208   23.05472  -2.791  0.00623 ** 
## Wind         -3.33359    0.65441  -5.094 1.52e-06 ***
## Temp          1.65209    0.25353   6.516 2.42e-09 ***
## Solar.R       0.05982    0.02319   2.580  0.01124 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 21.18 on 107 degrees of freedom
## Multiple R-squared:  0.6059,	Adjusted R-squared:  0.5948 
## F-statistic: 54.83 on 3 and 107 DF,  p-value: < 2.2e-16
```

O *pipe* é a força da gravidade dentro do `tidyverse`. Veremos nos próximos capítulos como as funções de diferentes pacotes interagem perfeitamente graças a esse operador.

### Exercícios {-}

**1.** Reescreva a expressão abaixo utilizando o `%>%`.


```r
round(mean(sum(1:10)/3), digits = 1)
```

**Dica**: utilize a função `magrittr::divide_by()`. Veja o help da função para mais informações.

**2.** Reescreva o código abaixo utilizando o `%>%`.


```r

x <- rnorm(100)

x.pos <- x[x>0]

media <- mean(x.pos)

saida <- round(media, 1)

```

**3.** Sem rodar, diga qual a saída do código abaixo. Consulte o help das funções caso precise.


```r
2 %>%
  add(2) %>%
  c(6, NA) %>%
  mean(na.rm = T) %>%
  equals(5)
```


## Outros operadores

O pacote `{magrittr}` possui outros operadores, que, embora sejam menos utilizados, também são úteis. São eles:

- *Assignment operator* `%<>%`

- *Operador tee* `%T>%`

- *Exposition operator* `%$%`

Imagine que queremos tirar a raiz quadrada de um vetor de números.


```r
x <- c(1, 2, 3, 4, 5)

x %>% sqrt()
```

```
## [1] 1.000000 1.414214 1.732051 2.000000 2.236068
```

Se quisermos sobrescrever o objeto `x` com a raiz quadrada dos seus valores, basta utilizarmos o nosso bom e velho operador de atribuição `<-`. 


```r
x <- x %>% sqrt()
```

Podemos, no entanto, utilizar o operador `%<>%` para reescrever o código acima de uma maneira mais compacta.


```r
x <- c(1, 2, 3, 4, 5)
x %<>% sqrt()
```

Além de mandar o objeto `x` para o primeiro argumento da função `sqrt()`, assim como o `%>%` faria, esse operador também salva o resultado da operação de volta no objeto `x`, o sobrescrevendo.

Este operador pode ser usado sempre que desejamos fazer algo da forma 


```r
objeto <- objeto %>% 
  funcao_1() %>% 
  funcao_2() %>% 
  ...
  funcao_n()
```

O operador `%T>%` retorna o valor do comando anterior a ele, não o resultado do lado direito como o `%>% ` faz. O seguinte exemplo vai imprimir na tela os valores de 1 a 10. Se usássemos o pipe, o código retornaria a soma dos dez números.


```r
1:10 %T>% sum() %>% cat()
```

```
## 1 2 3 4 5 6 7 8 9 10
```

Neste caso, o operador não parece fazer sentido e apenas deixa o código mais complicado, mas se desejamos usar funções como `cat()` ou `plot()` que não retornam nada, o operador se torna muito útil.


```r
# Vamos imprimir na tela os valores de 1 a 10 e depois soma-los.
1:10 %T>% 
  cat() %>% 
  sum()
```

```
## 1 2 3 4 5 6 7 8 9 10
```

```
## [1] 55
```

O operador `%$%` pode ser utilizado para *expor* as colunas de um *data frame* para a função aplicada no lado direito. 


```r
# Podemos chamar qualquer coluna da base diretamente.
mtcars %$% mean(mpg)
```

```
## [1] 20.09062
```

Se não ficou claro o que esse operador está fazendo, imagine que ele transforma todas as colunas da base em objetos (assim como a nefasta função `attach()`), mas sem salvar nada no nosso *environment*.


```r
mtcars %$%
  mpg %>% 
  mean() %>% 
  sqrt()
```

```
## [1] 4.482257
```

Ele faz um papel equivalente ao operador `$`.


```r
mtcars$mpg
```

```
##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
## [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [31] 15.0 21.4
```

```r
mtcars %$% mpg
```

```
##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
## [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [31] 15.0 21.4
```

Para mais informações sobre o `pipe` e outras funções do pacote `{magrittr}`, visite a página [Ceci n'est pas un pipe](http://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html).


