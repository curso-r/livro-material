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
(1 + 5^(1 / 2))/2
## [1] 1.618034
```

*Também poderia ser resolvido usando a função `sqrt()` para calcular a raiz quadrada.*


```r
(1 + sqrt(5))/2
## [1] 1.618034
```


---

**5.** Por que é preferível escrevermos sempre o nosso código no *script* e não no *Console*?

*Porque o código é a documentação da nossa análise. Se parte da análise for feita diretamente no Console, parte da documentação será perdida.*


### Objetos e funções {-}

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

### Classes {-}

**1.** Guarde em um objeto chamado `nome` uma *string* contendo o seu nome completo.


```r
nome <- "William Nilson de Amorim"
```

---

**2.** Guarde em um objeto chamado `cidade` o nome da cidade onde você mora. Em seguida, guarde em um objeto chamado `estado` o nome do estado onde você mora. Usando esses objetos, resolva os itens abaixo:

**a.** Utilize a função `nchar()` para contar o número de caracteres em cada cada string.


```r
cidade <- "São Paulo"
estado <- "SP"

nchar(cidade)
## [1] 9

nchar(estado)
## [1] 2
```


**b.** Interprete o resultado do seguinte código:


```r
paste(cidade, estado)
## [1] "São Paulo SP"
```

*A função `paste` juntou (colou) as duas strings, uma do lado da outra, separando-as por um espaço. O resultado gerado foi uma única string.*

**c.** Interprete o resultado do seguinte código:


```r
paste(cidade, estado, sep = " - ")
## [1] "São Paulo - SP"
```

*O argumento `sep` da função `paste()` nos permite escolher qual caracter será utilizado para separar as duas strings. Por padrão será utilizado um espaço em branco `" "`. No exemplo, foi utilizado um espaço, seguido de um traço, seguido de outro espaço. Sem os espaços o resultado seria:*


```r
paste(cidade, estado, sep = "-")
## [1] "São Paulo-SP"
```

*Veja que qualquer caracter ou string pode ser utilizada como separador:*


```r
paste(cidade, estado, sep = " #tricolor ")
## [1] "São Paulo #tricolor SP"
```

**d.** Desafio. Como você reproduziria o mesmo resultado do item (c) sem utilizar o argumento `sep`?


```r
paste(cidade, "-", estado)
## [1] "São Paulo - SP"
```

**e.** Qual a diferença entre as funções `paste()` e `paste0()`?

*A função `paste0()` é equivalente à função `paste()` com o argumento `sep = ""`.* 


```r
paste(cidade, "-", estado)
## [1] "São Paulo - SP"
paste(cidade, "-", estado, sep = "")
## [1] "São Paulo-SP"
paste0(cidade, "-", estado)
## [1] "São Paulo-SP"
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

**2.** Crie um vetor com o nome de tres frutas, guarde em um objeto chamado `frutas` e resolva os itens abaixo.

**a.** Utilize a a função `length()` para verificar o tamanho do vetor.


```r
frutas <- c("banana", "maçã", "mamão")

length(frutas)
## [1] 3
```


**b.** Inspecione a saída de `paste("eu gosto de", frutas)` e responda se o tamanho do vetor mudou.


```r
paste("eu gosto de", frutas)
## [1] "eu gosto de banana" "eu gosto de maçã"   "eu gosto de mamão"
```

*O tamanho do vetor não muda. O que aconteceu foi o acréscimo do prefixo "eu gosto de" a cada valor do vetor `frutas`. Podemos confirmar essa afirmação calculando o comprimento do novo vetor:*


```r
length(paste("eu gosto de", frutas))
## [1] 3
```

---

**3.** O que é reciclagem? Escreva um código em R que exemplifique esse comportamento.

*Reciclagem é a repetição de valores de um vetor para que uma operação com vetores de tamanhos diferentes possa ser realizada. Embora pareça um comportamento estranho, utilizamos a reciclagem o tempo todo dentro do R, muitas vezes sem perceber. No exemplo a seguir, os valores do `vetor_menor` serão repetidos (reciclados) até o dois vetores terem o mesmo tamanho. Então, o primeiro valor do vetor menor será somado com o promeiro valor do vetor maior, o segundo do menor somado com o segundo do maior e assim por diante.*


```r
# Exemplo
vetor_menor <- c(1, 3)
vetor_maior <- c(1, 2, 3, 4)

vetor_menor + vetor_maior
## [1] 2 5 4 7
```

---

**4.** O que é coerção? Escreva um código em R que exemplifique esse comportamento.

*Coerção é a homogenização da classe dos valores de um vetor. Se construirmos um vetor com valores de classes diferentes, todos os valores serão reprimidos para a classe mais dominante entre eles. No exemplo abaixo, todos os valores do vetor foram transformados em `character`, pois `character` é mais dominante do que as demais classes presentes (`numeric` e `logical`).*

*Considerando apenas as principais classes, temos a seguinte ordem de dominância: `character > numeric > integer > logical`*.


```r
c(1, -3, "a", TRUE)
## [1] "1"    "-3"   "a"    "TRUE"
```

---

**5.** Por que a coerção pode ser um problema na hora de importarmos bases de dados para o R?

*Porque as colunas podem acabar sendo importadas com uma classe diferente daquela que estamos esperando e nenhum erro ou warning será devolvido. Por exemplo, se uma coluna da base que deveria ser numérica tiver, por algum descuido, qualquer tipo de caracter não numérico (texto), toda a coluna será importada como texto.*

*O caso mais comum desse problema é gerado pelo separador de decimais. Se não especificarmos corretamente qual é o separador de decimais que estamos utilizando na nossa base de dados na hora da importação, qualquer coluna com valores decimais será importada como texto.*

---

**6.** Use a função `sum()` para somar os valores de 1 a 100.


```r
sum(1:100)
## [1] 5050
```

---

**7.** Considere o vetor booleano a seguir:


```r
dolar_subiu <- c(TRUE, TRUE, FALSE, FALSE, TRUE, FALSE, TRUE)
```

Este vetor tem informação de uma semana (7 dias, começando no domingo) indicando se o dólar subiu (TRUE) ou não subiu (FALSE) no respectivo dia. Interprete o resultado dos códigos abaixo:

**a.** `length(dolar_subiu)`


```r
length(dolar_subiu)
## [1] 7
```

*Devolve o comprimento do vetor `dolar_subiu`. Podemos interpretar como o número de dias analisados nesse estudo.*

**b.** `dolar_subiu[2]`


```r
dolar_subiu[2]
## [1] TRUE
```

*Verifica se o dólar subiu no segundo dia do estudo (segunda-feira).*

**c.** `sum(dolar_subiu)`


```r
sum(dolar_subiu)
## [1] 4
```
*Verifica o número de dias que o dólar subiu (já que na soma, os valores `TRUE` viram 1 e os valores `FALSE` viram 0), no caso, 4 dias com alta do dólar.*

**d.** `mean(dolar_subiu)`


```r
mean(dolar_subiu)
## [1] 0.5714286
```
*Verifica a proporção de dias em que o dólar subiu (a média de valores 0 e 1 é igual a proporção de valores 1), no caso, cerca de 57% dos dias.*

### Testes lógicos

**1** O código abaixo vai guardar no objeto `segredo` um número inteiro entre 0 e 10. Sem olhar qual número foi guardado no objeto, resolva os itens a seguir:


```r
segredo <- round(runif(1, min = 0, max = 10))
```

**a.** Teste se o segredo é maior ou igual a 0.


```r
segredo >= 0
## [1] TRUE
```


**b.** Teste se o segredo é menor ou igual a 10.


```r
segredo <= 10
## [1] TRUE
```


**c.** Teste se o segredo é maior que 5.


```r
segredo > 5
## [1] FALSE
```


**d.** Teste se o segredo é par.

*Precisamos verificar se o resto da divisão por 2 é igual a zero.*


```r
# Resto da divisão por 2
segredo %% 2
## [1] 1

# Guardando o resultado
resto <- segredo %% 2

# Teste
resto == 0
## [1] FALSE

# Equivalentemente poderíamos fazer
segredo %% 2 == 0
## [1] FALSE
```


**e.** Teste se `segredo * 5` é maior que a sua idade.


```r
segredo * 5 > 31
## [1] FALSE
```

**f.** Desafio. Escreva um teste para descobrir o valor do segredo.

*Vamos descobrir a posição do segredo no vetor `0:10`.*


```r
numeros_possiveis <- 0:10
numeros_possiveis
##  [1]  0  1  2  3  4  5  6  7  8  9 10

segredo == numeros_possiveis
##  [1] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
```

*No código acima, para cada valor de `numero_possiveis`, foi testado se esse valor é igual ao segredo. Em caso afirmativo, um TRUE é devolvido. Veja que há apenas um TRUE no vetor resultante. Essa é posição do nosso segredo dentro do vetor `numeros_possiveis`.*

*Podemos usar esse vetor de TRUE/FALSE para recuperar o valor do segredo fazendo subsetting.*


```r
# Eis o valor do segredo
numeros_possiveis[segredo == numeros_possiveis]
## [1] 1
```

*No código acima, foi retornado apenas o número associado ao valor TRUE dado pelo teste `segredo == numeros_possiveis`*.

---

**2.** Escreva um código em R que devolva apenas os valores maiores
ou iguais a 10 do vetor abaixo:


```r
vetor <- c(4, 8, 15, 16, 23, 42)

# Resposta
vetor[vetor >= 10]
## [1] 15 16 23 42
```

### Data frames

**1.** Quais códigos abaixo retornam **um vetor** com a coluna `mpg` do data frame `mtcars`?

**a.** `mtcars$mpg`


```r
mtcars$mpg
##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
## [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [31] 15.0 21.4
```

*Retorna!*


**b.** `mtcars[ , 3]`


```r
mtcars[ , 3]
##  [1] 160.0 160.0 108.0 258.0 360.0 225.0 360.0 146.7 140.8 167.6 167.6 275.8
## [13] 275.8 275.8 472.0 460.0 440.0  78.7  75.7  71.1 120.1 318.0 304.0 350.0
## [25] 400.0  79.0 120.3  95.1 351.0 145.0 301.0 121.0
```

*Não retorna. A coluna `mpg` é a primeira coluna do data frame. A coluna que esse código retornou foi a `disp`.* 

**c.** `mtcars("mpg")`


```r
mtcars("mpg")
## Error in mtcars("mpg"): could not find function "mtcars"
```
*A sintaxe desse código não é válida pois `()` não são utilizados para fazer subsetting, mas sim para definir os argumentos de uma função (e `mtcars` não é uma função).*

**d.** `mtcars[ , "mpg"]`


```r
mtcars[ , "mpg"]
##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
## [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [31] 15.0 21.4
```

"Retorna!"

**e.** `mtcars.mpg`


```r
mtcars.mpg
## Error in eval(expr, envir, enclos): object 'mtcars.mpg' not found
```

*Essa sintaxe não é válida no R. Ele está procurando por um objeto chamado `mtcars.mpg`, que não existe.*

**f.** `mtcars[ , 1]`


```r
mtcars[ , 1]
##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2 10.4
## [16] 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4 15.8 19.7
## [31] 15.0 21.4
```

*Retorna!*

**g.** `mtcars[1, 1]`


```r
mtcars[1, 1]
## [1] 21
```

*Esse código retorna apenas o primeiro valor da coluna `mpg`.*

h. `mpg$mtcars`


```r
mpg$mtcars
## Error in eval(expr, envir, enclos): object 'mpg' not found
```

*Não retorna. Essa sintaxe não é válida para selecionar colunas de um data frame. O correto seria `nome_do_data_frame$nome_da_coluna`.*

---

**2.** Para que serve a função `str()`. Dê um exemplo do seu uso.

*Serve para espiarmos a estrutura de um data frame, como número de linhas, colunas, classes das colunas e exemplo de valores em cada uma delas.*


```r
str(mtcars)
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```


**3.** Para que serve a função `nanes()`. Dê um exemplo do seu uso.

*Serve para observamos os nomes das colunas de um data frame. O valor retornado é um vetor de strings.*


```r
names(mtcars)
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb"
```


**4.** Use o data frame `airquality` para responder às questões abaixo:

**a.** Quantas colunas `airquality` tem?


```r
ncol(airquality)
## [1] 6
```


**b.** Quantas linhas `airquality` tem?


```r
nrow(airquality)
## [1] 153
```

**c.** O que a função `head()` retorna?

*Retorna as 6 primeiras linhas do data frame.*


```r
head(airquality)
##   Ozone Solar.R Wind Temp Month Day
## 1    41     190  7.4   67     5   1
## 2    36     118  8.0   72     5   2
## 3    12     149 12.6   74     5   3
## 4    18     313 11.5   62     5   4
## 5    NA      NA 14.3   56     5   5
## 6    28      NA 14.9   66     5   6
```


**d.** Quais são os nomes das colunas?


```r
names(airquality)
## [1] "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day"
```

**e.** Qual é a classe da coluna `Ozone`?


```r
str(airquality)
## 'data.frame':	153 obs. of  6 variables:
##  $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
##  $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
##  $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
##  $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
##  $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
##  $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...

# Também podemos ver apenas a coluna Ozone
class(airquality$Ozone)
## [1] "integer"
```


**5.** Desafio. Calculando desvio-padrão no R. Use o data frame `airquality` para responder às questões abaixo:

**a.** Tire a média da coluna Ozone e guarde em um objeto.


```r
media_ozone <- mean(airquality$Ozone, na.rm = TRUE)
```


**b.** Guarde em um objeto o vetor correspondente à coluna Ozone subtraída da sua própria média (calculada em no item a).


```r
ozone_centralizado <- airquality$Ozone - media_ozone
```


**c.** Eleve o vetor calculado em (b) ao quadrado. Salve o resultado em um novo objeto.


```r
ozone_centr_quadrado <- ozone_centralizado ^ 2
```


**d.** Tire a média do vetor calculado em (c) e salve o resultado em um objeto chamado `variancia`. Em seguida, calcule a raiz quadrada desse valor e salve em um objeto chamado `desvio_padrao`.


```r
variancia <- mean(ozone_centr_quadrado, na.rm = TRUE)
desvio_padrao <- sqrt(variancia)
```


**e.** Compare o valor de `desvio_padrao` com `sd(airquality$Ozone)` e pesquise por que os valores não são iguais. Dica: veja a documentação da função `sd()`.


```r
desvio_padrao
## [1] 32.84539
sd(airquality$Ozone, na.rm = TRUE)
## [1] 32.98788
```

*Os valores não são iguais, pois na nossa conta, ao calcularmos a média no item (d), dividimos a soma de quadrados por `n` (tamanho da amostra, no caso, 116), enquanto na função `sd()` a divisão é por `n - 1` (115). A divisão por `n - 1`, na Estatística, representa o estimador não viesado para a variância/desvio-padrão de uma quantidade. Na prática, ambas podem ser utilizadas como medidas de variabilidade, mas em contextos inferenciais o valor dividido por `n - 1` é preferível.*

*Para chegarmos no mesmo resultado, poderíamos fazer:*


```r
# Número de valores sem NA
n <- length(na.omit(airquality$Ozone))

variancia <- sum(ozone_centr_quadrado, na.rm = TRUE) / (n - 1)
desvio_padrao <- sqrt(variancia)
desvio_padrao
## [1] 32.98788
```


## Pipe

---

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
