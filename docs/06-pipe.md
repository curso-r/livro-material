# Pipe {#pipe}




## O operador pipe

O operador `%>%` (*pipe*) foi uma das grandes revoluções recentes do R, tornando a leitura de códigos mais lógica, fácil e compreensível. Ele foi introduzido por [Stefan Milton Bache](https://github.com/smbache) no pacote `magrittr` e já existem diversos pacotes construidos para facilitar a sua utilizaçăo.

Para começar a utilizar o *pipe*, instale e carregue o pacote `magrittr`.


```r
install.packages("magrittr")

library(magrittr)
```




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

O caminho que o código `x %>% sum %>% sqrt` seguiu foi enviar o objeto `x` como argumento da função `sum()` e, em seguida, enviar a saida da expressão `sum(x)` como argumento da função `sqrt()`. Observe que escrevemos o código na mesma ordem das operações. A utilização de parênteses após o nome das funções não é necessário, mas recomendável.

Se você ainda não está convencido com o poder do *pipe*, fica que vai ter bolo!

No exemplo abaixo, vamos ilustrar um caso em que temos um grande número de funções aninhadas. Veja como a utilização do *pipe* transforma um código confuso e difícil de ser lido em algo simples e intuitivo.



```r
# Receita de bolo sem pipe. Tente entender o que é preciso fazer.

esfrie(asse(coloque(bata(acrescente(recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo"), "farinha", até = "macio"), duração = "3min"), lugar = "forma", tipo = "grande", untada = TRUE), duração = "50min"), "geladeira", "20min")


# Veja como o código acima pode ser reescrito utilizando-se o pipe. Agora realmente se parece com uma receita de bolo.

recipiente(rep("farinha", 2), "água", "fermento", "leite", "óleo") %>%
  acrescente("farinha", até = "macio") %>%
  bata(duração = "3min") %>%
  coloque(lugar = "forma", tipo = "grande", untada = TRUE) %>%
  asse(duração = "50min") %>%
  esfrie("geladeira", "20min")
```

Às vezes, queremos que o resultado do lado esquerdo vá para outro argumento do lado direito que não o primeiro. Para isso, utilizamos um `.` como marcador.


```r
# Queremos que o dataset seja recebido pelo segundo argumento (data=) da função "lm".

airquality %>%
  na.omit %>%
  lm(Ozone ~ Wind + Temp + Solar.R, data = .) %>%
  summary
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

Também é possível definir funções na sua *pipeline*.

```r
c(1,2,3) %>%
  (function(x){
    sum(x)
  })
```

```
## [1] 6
```


O *pipe* é a força da gravidade dentro do `tidyverse`. Veremos nas próximas seções como as funções de diferentes pacotes interagem perfeitamente graças a esse operador.



## Outros operadores
Existem outros operadores do mesmo pacote, que apesar de menos usados, também são úteis.

São eles:

- Assignment operator `%<>%`

- Operador tee `%T>%`

- Exposition operator `%$%`

### Operador de atribuição ( Assignment operator )
Quando queremos sobrescrever um objeto, é comum utilizarmos o operador ` <- `. Por exemplo, se queremos somar 10 a cada valor do vetor $x$, podemos fazer:


```r
x <- c(1,2,3,4)
x <- x %>%  add(10)
x
```

```
## [1] 11 12 13 14
```
Com o operador de atribuição, o código acima se reduz a




```r
x %<>% add(10)
```

Este operador pode ser usado sempre que desejamos fazer algo da forma `objeto <- objeto %>% função`

### Operador tee


O operador tee retorna o valor do comando anterior a `%T>%`, não o resultado do lado direito dele como o pipe faz. O seguinte exemplo vai imprimir na tela os valores de 1 a 10. Se usássemos o pipe, o código retornaria a soma dos dez números.

```r
1:10 %T>% sum() %>% cat()
```

```
## 1 2 3 4 5 6 7 8 9 10
```
Neste caso, o operador não parece fazer sentido e apenas deixa o código mais complicado, mas se desejamos usar funções como `cat()` ou `plot()` que não retornam nada, o operador se torna muito útil.

Vamos imprimir na tela os valores de 1 a 10 e depois soma-los.

```r
1:10  %T>% cat() %>% sum()
```

```
## 1 2 3 4 5 6 7 8 9 10
```

```
## [1] 55
```

### Exposition operator
Usamos o operador `%$%`para salvar o valor resultante da expressão do lado esquerdo, podendo usar como quiser do lado direito.

Por exemplo, para obter o primeiro elemento de um vetor, podemos fazer:

```r
data.frame(z=1:10)%$% z[1]
```

```
## [1] 1
```

Para mais informações sobre o `pipe`, outros operadores relacionados e exemplos de utilização, visite a página [Ceci n'est pas un pipe](http://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html).

## Exercícios

--------------------------------------------------------------------------------

**1.** Reescreva a expressão abaixo utilizando o `%>%`.


```r
round(mean(sum(1:10)/3), digits = 1)
```

**Dica**: utilize a função `magrittr::divide_by()`. Veja o help da função para mais informações.

--------------------------------------------------------------------------------

**2.** Reescreva o código abaixo utilizando o `%>%`.


```r

x <- rnorm(100)

x.pos <- x[x>0]

media <- mean(x.pos)

saida <- round(media, 1)

```

--------------------------------------------------------------------------------

**3.** Sem rodar, diga qual a saída do código abaixo. Consulte o help das funções caso precise.


```r
2 %>%
  add(2) %>%
  c(6, NA) %>%
  mean(na.rm = T) %>%
  equals(5)
```

--------------------------------------------------------------------------------

**4.** Leia o capítulo sobre *pipes* do [R for data science](http://r4ds.had.co.nz/pipes.html). É curto e vale muito a pena.

--------------------------------------------------------------------------------

**5.** Pegue algum script que você já tenha programado em R e o reescreva utilizando o operador *pipe*. Se você não tiver nenhum, não se preocupe. Utilizaremos **bastante** o *pipe* daqui pra frente.

## Respostas

Não há apenas uma maneira de resolver os exercícios. Você pode encontrar soluções diferentes das nossas, algumas vezes mais eficientes, outras vezes menos. Quando estiver fazendo suas análises, tente buscar o equilíbrio entre eficiência e praticidade. Economizar 1 hora com a execução do código pode não valer a pena se você demorou 2 horas a mais para programá-lo.

--------------------------------------------------------------------------------

**1.** Reescreva a expressão abaixo utilizando o `%>%`.


```r
round(mean(sum(1:10)/3), digits = 1)
## [1] 18.3

1:10 %>%
  sum %>%
  divide_by(3) %>%
  round(digits = 1)
## [1] 18.3
```

--------------------------------------------------------------------------------

**2.** Reescreva o código abaixo utilizando o `%>%`.


```r
# Setamos a semente que gera números aleatórios para deixar o resultado reprodutível

set.seed(137)

x <- rnorm(100)
x.pos <- x[x>0]
media <- mean(x.pos)
saida <- round(media, 2)
saida
## [1] 0.78
```



```r
set.seed(137)

rnorm(100) %>%
  magrittr::extract(. > 0) %>%
  mean %>%
  round(digits = 2)
## [1] 0.78
```

--------------------------------------------------------------------------------

**3.** Sem rodar, diga qual a saída do código abaixo. Consulte o help das funções caso precise.


```r
2 %>%
  add(2) %>%
  c(6, NA) %>%
  mean(na.rm = T) %>%
  equals(5)
```

- Primeiro, somamos 2 com 2, gerando o valor 4.
- Então colocamos esse valor em um vetor com os valores 6 e `NA`.
- Em seguida, tiramos a média desse vetor, desconsiderando o `NA`, obtendo o valor 5.
- Por fim, testemos se o valor é igual a 5, obtendo o valor `TRUE`.
