# Respostas



Não há apenas uma maneira de resolver os exercícios. Você pode encontrar soluções diferentes das nossas, algumas vezes mais práticas e eficientes, outras vezes menos. Quando estiver fazendo suas análises, tente buscar o equilíbrio entre eficiência e pragmatismo. Economizar 1 hora com a execução do código pode não valer a pena se você demorou 2 horas a mais para programá-lo.

## R básico

### R como calculadora {-}

**1.** Qual a diferença entre o R e o RStudio?

*O R é uma linguagem de programação e um programa que instalamos no nosso computador para interpretar código em linguagem R. O RStudio é um ambiente de desenvolvimento para programação em R, isto é, é um programa que nos ajuda a trabalhar com a linguagem R.*

---

**2.** Podemos usar o RStudio sem o R? E o R sem o RStudio?

*Não podemos usar o RStudio sem o R, pois o programa R é que interpreta os nossos códigos e devolve os resultados. Por outro lado, podemos usar o R sem o RStudio (ou qualquer outro ambiente de desenvolvimento), mas a nossa vida de pessoa programadora se torna muito mais difícil.*

---

**3.** Precisamos compilar nossos códigos de R?

*Não. Um código em R é interpretado linha a linha, isto é, podemos ir rodando nosso código parcialmente, conforme vamos escrevendo.*

---

**4.** Calcule o número de ouro no R. Dica: o número de ouro é dado pela expressão $\frac{1 + \sqrt{5}}{2}$.


```r
(1 + sqrt(5))/2
## [1] 1.618034
```

### Objetos {-}

**1.** Qual a diferença entre os códigos abaixo?


```r
# Código 1
33 / 11

# Código 2
divisao <- 33 / 11
```

*O primeiro código calcula a divisão de 33 por 11 e devolve o resultado na tela. O segundo código faz o mesmo cálculo, mas guardo o resultado no objeto `divisao`, isto é, o resultado não é retornado na tela.*

---

**2.** Multiplique a sua idade por meses e salve o resultado em um objeto chamado `idade_em_meses`. Em seguida, multiplique esse objeto por 30 e salve o resultado em um objeto chamado `idade_em_dias`.


```r
idade_em_meses <- 31 * 12

idade_em_dias <- idade_em_meses * 30
```


---

**3.** Por que o nome `meu-objeto` não pode ser utilizado para criar um objeto? O que significa a mensagem de erro resultante?


```r
meu-objeto <- 1
## Error in meu - objeto <- 1: object 'meu' not found
```

*Porque o sinal `-` é utilizado pelo R como o operador de subtração. O código acima está sendo interpretado como a subtração dos objetos `meu` e `objeto`. Como nenhum dos objetos existe na sessão, é devolvido um erro dizendo que o objeto `meu` (o primeiro deles) não foi encontrado.*

*No entanto, mesmo que os objetos existissem, seria retornado um erro. Neste caso, seria um erro de sintaxe, pois o R não sabe como interpretar a atribuição do valor ` 3` à operação `meu - objeto`. Veja que a mensagem de erro não é muito intuitiva, pois o R entende que `-<-` é uma função que esquecemos de definir.*


```r
meu <- 1
objeto <- 2
meu-objeto <- 1
## Error in meu - objeto <- 1: could not find function "-<-"
```

### Vetores {-}

**1.** Guarde em um objeto a sequência de números de 0 a 5 e resolva os itens abaixos.

**a.** Use subsetting para fazer o R devolver o primeiro número dessa sequência. Em seguida, faça o R devolver o último número da sequência.


```r
vetor <- 0:5

# Primeiro elemento
vetor[1]
## [1] 0

# Último elemento
vetor[6]
## [1] 5
```

**b.** Multiplique todos os valores do vetor por -1. Guarde o resultado em
um novo objeto chamado `vetor_negativo`.


```r
vetor_negativo <- vetor * -1
vetor_negativo
## [1]  0 -1 -2 -3 -4 -5
```

---

**2.** O que é reciclagem? Escreva um código em R que exemplifique esse comportamento.

*Reciclagem é a repetição de valores de um vetor para que uma operação com vetores de tamanhos diferentes possa ser realizada. Embora pareça um comportamento estranho, utilizamos a reciclagem o tempo todo dentro do R, muitas vezes sem perceber. No exemplo a seguir, os valores do `vetor_menor` serão repetidos (reciclados) até o dois vetores terem o mesmo tamanho. Então, o primeiro valor do vetor menor será somado com o promeiro valor do vetor maior, o segundo do menor somado com o segundo do maior e assim por diante.*


```r
# Exemplo
vetor_menor <- c(1, 3)
vetor_maior <- c(1, 2, 3, 4)

vetor_menor + vetor_maior
## [1] 2 5 4 7
```

---

**3.** O que é coerção? Escreva um código em R que exemplifique esse comportamento.

*Coerção é a homogenização da classe dos valores de um vetor. Se construirmos um vetor com valores de classes diferentes, todos os valores serão reprimidos para a classe mais dominante entre eles. No exemplo abaixo, todos os valores do vetor foram transformados em `character`, pois `character` é mais dominante do que as demais classes presentes (`numeric` e `logical`).*

*Considerando apenas as principais classes, temos a seguinte ordem de dominância: `character > numeric > integer > logical`*.


```r
c(1, -3, "a", TRUE)
## [1] "1"    "-3"   "a"    "TRUE"
```

---

**4.** Por que a coerção pode ser um problema na hora de importarmos bases de dados para o R?

*Porque as colunas podem acabar sendo importadas com uma classe diferente daquela que estamos esperando e nenhum erro ou warning será devolvido. Por exemplo, se uma coluna da base que deveria ser numérica tiver, por algum descuido, qualquer tipo de caracter não numérico (texto), toda a coluna será importada como texto.*

*O caso mais comum desse problema é gerado pelo separador de decimais. Se não especificarmos corretamente qual é o separador de decimais que estamos utilizando na nossa base de dados na hora da importação, qualquer coluna com valores decimais será importada como texto.*

**5.** Use a função `sum()` para somar os valores de 1 a 100.


```r
sum(1:100)
## [1] 5050
```

### Testes lógicos

**1.** Escreva um código em R que devolva apenas os valores maiores
ou iguais a 10 do vetor abaixo:


```r
vetor <- c(4, 8, 15, 16, 23, 42)

# Resposta
vetor[vetor >= 10]
## [1] 15 16 23 42
```



## Pipe

--------------------------------------------------------------------------------

**1.** Reescreva a expressão abaixo utilizando o `%>%`.


```r
round(mean(sum(1:10)/3), digits = 1)

1:10 %>%
  sum %>%
  divide_by(3) %>%
  round(digits = 1)
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
```



```r
set.seed(137)

rnorm(100) %>%
  magrittr::extract(. > 0) %>%
  mean %>%
  round(digits = 2)
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

<!-- -------------------------------------------------------------------------------- -->

<!-- **2.** Qual o resultado da divisão de 1 por 0 no R? E de -1 por 0? -->

<!-- **Resposta:** -->

<!-- Infinito e -Infinito. -->

<!-- ```{r} -->
<!-- 1/0 -->
<!-- -1/0 -->
<!-- ``` -->

<!-- -------------------------------------------------------------------------------- -->

<!-- **3.** Quais as diferenças entre `NaN`, `NULL`, `NA` e `Inf`? Digite expressões que retornam cada um desses resultados. -->

<!-- **Resposta:** -->

<!-- ```{r} -->
<!-- # NaN é o resultado de uma operação matemática inválida.  -->
<!-- # Significa Not A Number. -->

<!-- 0/0 -->
<!-- ``` -->


<!-- ```{r eval=FALSE} -->
<!-- # NULL é o vazio do R. É como se o objeto não existisse. -->

<!-- NULL -->
<!-- a = NULL -->
<!-- ``` -->


<!-- ```{r } -->
<!-- # veja que um vetor, mesmo sem elementos não é NULL -->

<!-- is.null(integer(length = 0))  -->

<!-- # NA é uma constante lógica do R. Siginifica Not Availlable.  -->
<!-- # NA pode ser convertido para quase todos os tipos de vetores do R.  -->
<!-- # É usado principalmente para indicar valores faltantes. -->

<!-- NA -->
<!-- as.numeric(c("1", "2", "a")) -->

<!-- # Inf é significa infinito. É o resultado de operações matemáticas  -->
<!-- # cujo limite é infinito. -->

<!-- 1/0 -->
<!-- 1/Inf -->
<!-- ``` -->

<!-- -------------------------------------------------------------------------------- -->

<!-- **4.** Sem rodar o código, calcule o que a expressão `5 + 3 * 10 %/% 3 == 15` vai resultar no R. Em seguida, apenas utilizando parênteses, faço a expressão retornar o valore contrário (i.e., se originariamente for `TRUE`, faça retornar `FALSE`). -->

<!-- **Resposta:** -->

<!-- O resultado da parte esquerda é 14, por isso a expressão retornará `FALSE`. Para fazê-la retornar `TRUE`, basta colocar parênteses em volta de `3 * 10`. -->

<!-- ```{r} -->
<!-- 5 + (3 * 10) %/% 3 == 15 -->
<!-- ``` -->

<!-- -------------------------------------------------------------------------------- -->

<!-- **5.** Por que o código abaixo retorna erro? Arrume o código para retornar o valor `TRUE`. -->

<!-- ```{r, eval = FALSE} -->
<!-- x <- 4 -->
<!-- if(x = 4) { -->
<!--   TRUE -->
<!-- } -->
<!-- ``` -->

<!-- **Resposta:** -->

<!-- A expressão `x = 4` está tentando atribuir o valor 4 ao objeto `x` dentro do if, o que não é permitido pois o controlador `if` só aceita valores lógicos. Para corrigir o código e fazê-lo retornar `TRUE`, basta trocar `=` por `==`. -->

<!-- ```{r} -->
<!-- x <- 4 -->
<!-- if(x == 4) { -->
<!--   TRUE -->
<!-- } -->
<!-- ``` -->

<!-- -------------------------------------------------------------------------------- -->

<!-- **6.** Usando `if` e `else`, escreva um código que retorne a string "número" caso o objeto `x` seja da classe `numeric` ou `integer`; a string "palavra" caso o objeto seja da classe `character`; e `NULL` caso contrário. -->

<!-- **Resposta:** -->

<!-- ```{r} -->
<!-- x <- 1 -->
<!-- # x <- 1L -->
<!-- # x <- "1" -->

<!-- if(is.numeric(x)) { -->
<!--   "número" -->
<!-- } else if(is.character(x)) { -->
<!--   "palavra" -->
<!-- } else {  -->
<!--   NULL -->
<!-- } -->

<!-- ``` -->

<!-- Note que a função `is.numeric()` retorna `TRUE` para as classes `integer` e `numeric`. -->

<!-- -------------------------------------------------------------------------------- -->

<!-- **7.** Use o `for` para retornar o valor mínimo do seguinte vetor: `vetor <- c(4, 2, 1, 5, 3)`. Modifique o seu código para receber vetores de qualquer tamanho. -->

<!-- **Resposta:** -->

<!-- ```{r} -->

<!-- vetor <- c(4, 2, 1, 5, 3) -->
<!-- minimo <- Inf -->

<!-- for(i in 1:5) { -->

<!--   if(minimo > vetor[i]) { -->
<!--     minimo <- vetor[i] -->
<!--   } -->

<!-- } -->

<!-- minimo -->

<!-- # Para qualquer vetor -->

<!-- for(i in 1:length(vetor)) { -->

<!--   if(minimo > vetor[i]) { -->
<!--     minimo <- vetor[i] -->
<!--   } -->

<!-- } -->

<!-- minimo -->

<!-- ``` -->

<!-- **Lembrete**: o R já possui a função `min()` para calcular o mínimo de um conjunto de valores. -->

<!-- -------------------------------------------------------------------------------- -->

<!-- **8.** Usando apenas `for` e a função `length()`, construa uma função que calcule a média de um vetor número qualquer. Construa uma condição para a função retornar `NULL` caso o vetor não seja numérico. -->

<!-- **Resposta:** -->

<!-- ```{r} -->
<!-- media <- function(x) { -->

<!--   i <- 1 -->
<!--   tamanho <- length(x) -->
<!--   soma <- 0 -->

<!--   for(i in 1:tamanho){ -->
<!--     soma <- soma + x[i] -->
<!--   } -->

<!--   return(soma/tamanho) -->
<!-- } -->

<!-- media(1:3) -->
<!-- ``` -->

<!-- -------------------------------------------------------------------------------- -->

<!-- **9.** Rode `help(runif)` para descobrir o que a função `runif()` faz. Em seguida, use-a para escrever uma função que retorne um número aleatório inteiro entre 0 e 10 (0 e 10 inclusive). -->

<!-- **Resposta:** -->

<!-- A função `runif()` gera números reais aleatórios entre um valor mínimo e um valor máximo. -->

<!-- ```{r} -->
<!-- alea <- function() { -->

<!--   x <- runif(n = 1, min = 0, max = 10) -->
<!--   x <- round(x) -->

<!--   return(x) -->
<!-- } -->

<!-- alea() -->
<!-- ``` -->

<!-- Veja que construímos uma função sem argumentos. Podemos generalizá-la incluindo os argumentos da função `runif()`. -->

<!-- ```{r} -->
<!-- alea <- function(n, min, max) { -->

<!--   x <- runif(n = n, min = min, max = max) -->
<!--   x <- round(x) -->

<!--   return(x) -->
<!-- } -->

<!-- alea(2, 2, 5) -->
<!-- alea(5, 100, 105) -->
<!-- ``` -->

<!-- Observe que não há problema em usar os mesmos nomes para os argumentos. Isso se deve aos *environments*.  -->

<!-- -------------------------------------------------------------------------------- -->

<!-- **10.** Rode `help(sample)` para descobrir o que a função `sample()` faz. Em seguida, use-a para escrever uma função que escolha uma linha aleatoriamente de uma matriz e devolva os seus valores. -->

<!-- **Resposta:** -->

<!-- ```{r} -->
<!-- matriz <- matrix(runif(20), nrow = 5, ncol = 4) -->

<!-- linha_alea <- function(matriz) { -->

<!--   x <- 1:nrow(matriz) -->

<!--   linha <- sample(x, size = 1) -->

<!--   return(matriz[linha,]) -->
<!-- } -->

<!-- matriz -->
<!-- linha_alea(matriz) -->
<!-- ``` -->

<!-- -------------------------------------------------------------------------------- -->

<!-- <!-- **11.** Rode `help(paste)` e `help(names)` para descobrir o que as funções `paste()` e `names()` fazem. Em seguida, use-as para escrever um código para gerar a fórmula `mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb` a partir do data frame `mtcars`. --> -->

<!-- <!-- **Resposta:** --> -->

<!-- <!-- ```{r} --> -->
<!-- <!-- variaveis <- names(mtcars) --> -->

<!-- <!-- esq <- "mpg ~ " --> -->
<!-- <!-- dir <- paste(variaveis[-1], collapse = " + ") --> -->

<!-- <!-- formula <- paste0(esq, dir) --> -->
<!-- <!-- as.formula(formula) --> -->
<!-- <!-- ``` --> -->

<!-- <!-- Observe que a função `paste0()` é equivalente à função `paste()` com o argumento `sep = ""`. --> -->
