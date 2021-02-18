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

### Testes lógicos {-}

**1.** O código abaixo vai guardar no objeto `segredo` um número inteiro entre 0 e 10. Sem olhar qual número foi guardado no objeto, resolva os itens a seguir:


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

---

**3.** Use o vetor numeross abaixo para responder as questoes seguintes.


```r
numeros <- -4:2
```

**a.** Escreva um código que devolva apenas valores positivos do vetor `numeros`.


```r
numeros[numeros > 0]
## [1] 1 2
```


**b.** Escreva um código que devolta apenas os valores pares do vetor `numeros`.


```r
# Resto da divisão por 2
numeros %% 2
## [1] 0 1 0 1 0 1 0

# Quais números são pares?
numeros %% 2 == 0
## [1]  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE

# Usando para filtrar o vetor
numeros[numeros %% 2 == 0]
## [1] -4 -2  0  2
```

**c.** Filtre o vetor para que retorne apenas aqueles valores que, quando elevados a 2, são menores do que 4.


```r
# Quadrado dos valores do vetor
numeros^2
## [1] 16  9  4  1  0  1  4

# Aqueles menores que 4
numeros^2 < 4
## [1] FALSE FALSE FALSE  TRUE  TRUE  TRUE FALSE

# Usando para filtrar
numeros[numeros^2 < 4]
## [1] -1  0  1
```

### Valores especiais {-}

**1.** Quais as diferenças entre `NaN`, `NULL`, `NA` e `Inf`? Digite expressões que retornem cada um desses valores.

- *O `NaN` representa uma indefinição matemática. Todo `NaN` é um `NA`, mas o contrário não é verdade.*


```r
0/0
## [1] NaN
```


- *O `NA` representa o nosso desconhecimento acerca de um valor. Esse valor existe, mas nós não o conhecemos. Na Estatística, ele é conhecido como valor omisso ou valor faltante.*


```r
sum(c(1, NA))
## [1] NA
```

- *O `NULL` é um valor especial para o R, isto é, ao contrário do NA, ele não tem um significado prático para a análise de dados, mas sim computacional. Ele representa a ausência de um vetor e é útil na construção da lógica de programação de alguns códigos.*


```r
mtcars$coluna_que_nao_existe
## NULL
```

- *O `Inf` representa um número muito grande (que o computador não consegue representar) ou um limite matemático.*


```r
2^2000
## [1] Inf
```

---

**2.** Escreva um código que conte o número de `NAs` do vetor `b`.


```r
b <- c(1, 0, NA, NA, NA, NA, 7, NA, NA, NA, NA, NA, 2, NA, NA, 10, 1, 1, NA)
```


```r
sum(is.na(b))
## [1] 12
```



### Data frames {-}

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

---

**6.** Use o *data frame* `airquality` para responder às questões abaixo.

**a.** Conte quantos `NAs` tem na coluna `Solar.R`.


```r
sum(is.na(airquality$Solar.R))
## [1] 7
```

**b.** Filtre a tabela `airquality `com apenas linhas em que `Solar.R` é `NA`.


```r
tab <- airquality[is.na(airquality$Solar.R),]

# Imprimindo apenas as primeiras linhas para facilitar a leitura
head(tab)
##    Ozone Solar.R Wind Temp Month Day
## 5     NA      NA 14.3   56     5   5
## 6     28      NA 14.9   66     5   6
## 11     7      NA  6.9   74     5  11
## 27    NA      NA  8.0   57     5  27
## 96    78      NA  6.9   86     8   4
## 97    35      NA  7.4   85     8   5
```

**c.** Filtre a tabela `airquality` com apenas linhas em que `Solar.R` **não** é `NA`.


```r
tab <- airquality[!is.na(airquality$Solar.R),]

# Imprimindo apenas as primeiras linhas para facilitar a leitura
head(tab)
##   Ozone Solar.R Wind Temp Month Day
## 1    41     190  7.4   67     5   1
## 2    36     118  8.0   72     5   2
## 3    12     149 12.6   74     5   3
## 4    18     313 11.5   62     5   4
## 7    23     299  8.6   65     5   7
## 8    19      99 13.8   59     5   8
```


**d.** Filtre a tabela `airquality` com apenas linhas em que `Solar.R` **não** é `NA` e `Month` é igual a 5.


```r
tab <- airquality[!is.na(airquality$Solar.R) & airquality$Month > 5,]

# Imprimindo apenas as primeiras linhas para facilitar a leitura
head(tab)
##    Ozone Solar.R Wind Temp Month Day
## 32    NA     286  8.6   78     6   1
## 33    NA     287  9.7   74     6   2
## 34    NA     242 16.1   67     6   3
## 35    NA     186  9.2   84     6   4
## 36    NA     220  8.6   85     6   5
## 37    NA     264 14.3   79     6   6
```

### Mais sobre funções {-}

**1.** Qual dos códigos abaixo devolverá um erro se for avaliado?

**a.** `3 * 5 + 10`


```r
3 * 5 + 10
## [1] 25
```

*Sem erro.*

**b.** `function <- 10`


```r
function <- 10
## Error: <text>:1:10: unexpected assignment
## 1: function <-
##              ^
```

*Retorna erro pois `function` é um nome reservado no R. Não podemos utilizá-lo para nomear outros objetos.*

**c.** `mean(1, 10)`


```r
mean(1, 10)
## [1] 1
```
*Não retorna erro, mas o 10 não é considerado na média. O código correto seria `mean(c(1, 10))`.*

**d.** `(soma <- sum(1, 1))`


```r
(soma <- sum(1, 1))
## [1] 2
```
*Não retorna erro. Cercar o código com parênteses força a saída a sempre ser apresentada no Console, além de ser gravada dentro do objeto.*

---

**2.** Crie uma função que receba um número e retorne o quadrado deste número.


```r
quadrado <- function(x) {
  x ^ 2
}

quadrado(2)
## [1] 4
quadrado(3)
## [1] 9
quadrado(0)
## [1] 0
```


---

**3.** Crie uma função que receba 2 números e devolva a raiz quadrada da soma desses números.


```r
raiz_da_soma <- function(a, b) {
  sqrt(a + b)
}

raiz_da_soma(2, 2)
## [1] 2
raiz_da_soma(1, 4)
## [1] 2.236068
```

---

**4.** Crie uma função que receba dois valores (numéricos) e devolva o maior deles.


```r
retornar_maior <- function(x, y) {
  vetor <- c(x, y)
  filtro <- c(x > y, x <= y)
  vetor[filtro]
}

retornar_maior(10, 20)
## [1] 20
retornar_maior(5, -5)
## [1] 5
```

*Também poderíamos resolver usando a função `max()`.


```r
retornar_maior <- function(x, y) {
  max(x, y)
}

retornar_maior(10, 20)
## [1] 20
retornar_maior(5, -5)
## [1] 5
```

---

**5.** Use a função `runif()` para criar uma função que retorne um número aleatório inteiro entre 0 e 10 (0 e 10 inclusive). Caso você não conheça a função `runif()`, rode `help(runif)` para ler a sua documentação.


```r
sortear_numero <- function() {
  numero <- runif(1, min = 0, max = 10)
  
  numero_inteiro <- round(numero)
  
  return(numero_inteiro)
}

sortear_numero()
## [1] 4
```


---

**6.** Rode `help(sample)` para descobrir o que a função `sample()` faz. Em seguida: 

**a.** Use a função `sample()` para escrever uma função que devolva uma linha aleatória de um *data frame*.


```r
sortear_linha <- function(data_frame) {
  num_linhas <- nrow(data_frame)
  linha_sorteada <- sample(1:num_linhas, 1)
  
  data_frame[linha_sorteada, ]
}

sortear_linha(mtcars)
##               mpg cyl  disp hp drat   wt qsec vs am gear carb
## Porsche 914-2  26   4 120.3 91 4.43 2.14 16.7  0  1    5    2
```

**b.** Generalize a função para retornar um número qualquer de linhas, escolhido pelo usuário.


```r
sortear_linha <- function(data_frame, n) {
  num_linhas <- nrow(data_frame)
  linha_sorteada <- sample(1:num_linhas, n)
  
  data_frame[linha_sorteada, ]
}

sortear_linha(mtcars, 10)
##                     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Dodge Challenger   15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
## Cadillac Fleetwood 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
## Datsun 710         22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Lotus Europa       30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Toyota Corona      21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Pontiac Firebird   19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## Hornet Sportabout  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
## Mazda RX4 Wag      21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Merc 280C          17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
## Chrysler Imperial  14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
```

### Controle de fluxo {-}

**1.** Por que o código abaixo retorna erro? Arrume o código para retornar o valor `TRUE`.


```r
x <- 4
if(x = 4) {
  TRUE
}
```

**Porque a expressão dentro do `if` deve retornar um valor lógico (TRUE ou FALSE) e o código `x = 4` é uma atribuição (equivalente a `x <- 4`). O correto seria utilizar `==` em vez de `=`.*


```r
x <- 4
if(x == 4) {
  TRUE
}
## [1] TRUE
```

---

**2.** Usando `if` e `else`, escreva um código que retorne a string `"número"` caso um valor `x` seja da classe `numeric` ou `integer`; a string `"palavra"` caso seja da classe `character`; e `NA` caso contrário.


```r
x <- 10

if (class(x) == "numeric" | class(x) == "integer") {
  "número"
} else if (class(x) == "character") {
  "palavra"
} else {
  NA
}
## [1] "número"
```
**Uma solução mais simples seria utilizar as funções `is.numeric()` e `is.character()`.**


```r
x <- "qualquer texto"

if (is.numeric(x)) {
  "número"
} else if (is.character(x)) {
  "palavra"
} else {
  NA
}
## [1] "palavra"
```

---

**3.** Usando apenas `for` e a função `length()`, construa uma função que calcule a média de um vetor numérico qualquer. Construa uma condição para a função retornar `NULL` caso o vetor não seja numérico.


```r
minha_media <- function(vetor) {

  soma <- 0
  
  for (i in 1:length(vetor)) {
    soma <- soma + vetor[i]
  }
  
  media <- soma / length(vetor)  
  
  return(media)
  
}

minha_media(c(1, 2))
## [1] 1.5
minha_media(0:10)
## [1] 5
minha_media(c(2, 2))
## [1] 2
```

---

**4.** Utilize o vetor `a` para resolver as questões a seguir:


```r
a <- c(10, 3, 5, -1, 3, -4, 8, 9, -10)
```

**a.** Utilize o `for` para imprimir as médias acumuladas do vetor `a`, isto é, primeiro vamos imprimir 10, depois a média entre 10 e 3, depois a média entre 10, 3 e 5 e assim por diante.


```r
soma <- 0

for(i in 1:length(a)) {
  soma <- soma + a[i]
  
  print(soma / i)
}
## [1] 10
## [1] 6.5
## [1] 6
## [1] 4.25
## [1] 4
## [1] 2.666667
## [1] 3.428571
## [1] 4.125
## [1] 2.555556
```


**b.** Adapte o laço que você fez no item anterior para ignorar os valores negativos, isto é, em caso de valor negativo, o laço não deve calcular a média e não imprimir nada.


```r
soma <- 0
divisor <- 0

for(i in 1:length(a)) {
  if (a[i] >= 0) {
    soma <- soma + a[i]
    divisor <- divisor + 1
    print(soma / divisor)
  }
}
## [1] 10
## [1] 6.5
## [1] 6
## [1] 5.25
## [1] 5.8
## [1] 6.333333
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

## O pacote dplyr




### Selecionando colunas

Utilize a base `imdb` nos exercícios a seguir.

**1.** Teste aplicar a função `glimpse()` do pacote `{dplyr}` à base `imdb`. O que ela faz?


```r
glimpse(imdb)
## Rows: 3,807
## Columns: 15
## $ titulo         <chr> "Avatar ", "Pirates of the Caribbean: At World's End "…
## $ ano            <dbl> 2009, 2007, 2012, 2012, 2007, 2010, 2015, 2016, 2006, …
## $ diretor        <chr> "James Cameron", "Gore Verbinski", "Christopher Nolan"…
## $ duracao        <dbl> 178, 169, 164, 132, 156, 100, 141, 183, 169, 151, 150,…
## $ cor            <chr> "Color", "Color", "Color", "Color", "Color", "Color", …
## $ generos        <chr> "Action|Adventure|Fantasy|Sci-Fi", "Action|Adventure|F…
## $ pais           <chr> "USA", "USA", "USA", "USA", "USA", "USA", "USA", "USA"…
## $ classificacao  <chr> "A partir de 13 anos", "A partir de 13 anos", "A parti…
## $ orcamento      <dbl> 237000000, 300000000, 250000000, 263700000, 258000000,…
## $ receita        <dbl> 760505847, 309404152, 448130642, 73058679, 336530303, …
## $ nota_imdb      <dbl> 7.9, 7.1, 8.5, 6.6, 6.2, 7.8, 7.5, 6.9, 6.1, 7.3, 6.5,…
## $ likes_facebook <dbl> 33000, 0, 164000, 24000, 0, 29000, 118000, 197000, 0, …
## $ ator_1         <chr> "CCH Pounder", "Johnny Depp", "Tom Hardy", "Daryl Saba…
## $ ator_2         <chr> "Joel David Moore", "Orlando Bloom", "Christian Bale",…
## $ ator_3         <chr> "Wes Studi", "Jack Davenport", "Joseph Gordon-Levitt",…
```

*A função `glimpse()` traz um resumo da base, contendo o número de linhas, colunas, o nome e tipo das colunas e as primeiras observações de cada coluna.*

**2.** Crie uma tabela com apenas as colunas `titulo`, `diretor`, e `orcamento.` Salve em um objeto chamado `imdb_simples`.


```r
imdb_simples <- select(imdb, titulo, diretor, orcamento)
imdb_simples
## # A tibble: 3,807 x 3
##    titulo                                      diretor           orcamento
##    <chr>                                       <chr>                 <dbl>
##  1 Avatar                                      James Cameron     237000000
##  2 Pirates of the Caribbean: At World's End    Gore Verbinski    300000000
##  3 The Dark Knight Rises                       Christopher Nolan 250000000
##  4 John Carter                                 Andrew Stanton    263700000
##  5 Spider-Man 3                                Sam Raimi         258000000
##  6 Tangled                                     Nathan Greno      260000000
##  7 Avengers: Age of Ultron                     Joss Whedon       250000000
##  8 Batman v Superman: Dawn of Justice          Zack Snyder       250000000
##  9 Superman Returns                            Bryan Singer      209000000
## 10 Pirates of the Caribbean: Dead Man's Chest  Gore Verbinski    225000000
## # … with 3,797 more rows
```


**3.** Selecione apenas as colunas `ator_1`, `ator_2` e `ator_3` usando o ajudante `contains()`.


```r
select(imdb, contains("ator"))
## # A tibble: 3,807 x 3
##    ator_1          ator_2            ator_3              
##    <chr>           <chr>             <chr>               
##  1 CCH Pounder     Joel David Moore  Wes Studi           
##  2 Johnny Depp     Orlando Bloom     Jack Davenport      
##  3 Tom Hardy       Christian Bale    Joseph Gordon-Levitt
##  4 Daryl Sabara    Samantha Morton   Polly Walker        
##  5 J.K. Simmons    James Franco      Kirsten Dunst       
##  6 Brad Garrett    Donna Murphy      M.C. Gainey         
##  7 Chris Hemsworth Robert Downey Jr. Scarlett Johansson  
##  8 Henry Cavill    Lauren Cohan      Alan D. Purwin      
##  9 Kevin Spacey    Marlon Brando     Frank Langella      
## 10 Johnny Depp     Orlando Bloom     Jack Davenport      
## # … with 3,797 more rows
```

**4.** Usando a função `select()` (e seus ajudantes), escreva códigos que retornem a base IMDB sem as colunas `ator_1`, `ator_2` e `ator_3.` Escreva todas as soluções diferentes que você conseguir pensar. 


```r
select(imdb, -starts_with("ator"))

select(imdb, -ator_1, -ator_2, -ator_3)

select(imdb, -(ator_1:ator_3))

select(imdb, titulo:likes_facebook)

select(imdb, -contains("ator"))
```

### Ordenando a base

**1.** Ordene os filmes em ordem crescente de `ano` e decrescente de `receita` e salve em um objeto chamado `filmes_ordenados`.


```r
filmes_ordenados <- arrange(imdb, ano, desc(receita))
```


**2.** Selecione apenas as colunas `titulo` e `orcamento` e então ordene de forma decrescente pelo `orcamento`.


```r
# Aninhando as funções
arrange(select(imdb, titulo, orcamento), desc(orcamento))

# Criando objeto intermediário
imdb_aux <- select(imdb, titulo, orcamento)
arrange(imdb_aux, desc(orcamento))

# Pipe s2
imdb %>% 
  select(titulo, orcamento) %>% 
  arrange(desc(orcamento))
```

### Filtrando linhas

Utilize a base `imdb` nos exercícios a seguir.

**1.** Crie um objeto chamado `filmes_pb` apenas com filmes preto e branco.


```r
# Vendo categorias da variável cor
unique(imdb$cor)
## [1] "Color"           "Black and White" NA

# Filtrando
imdb %>% filter(cor == "Black and White")
## # A tibble: 149 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <dbl> <chr>     <dbl> <chr> <chr>   <chr> <chr>             <dbl>
##  1 Pearl…  2001 Michae…     184 Blac… Action… USA   A partir de … 140000000
##  2 The A…  2004 Martin…     170 Blac… Biogra… USA   A partir de … 110000000
##  3 Ali     2001 Michae…     165 Blac… Biogra… USA   A partir de … 107000000
##  4 Erago…  2006 Stefen…     104 Blac… Action… USA   Livre         100000000
##  5 Seabi…  2003 Gary R…     140 Blac… Drama|… USA   A partir de …  87000000
##  6 Bewit…    NA <NA>         25 Blac… Comedy… USA   Outros               NA
##  7 Nine    2009 Rob Ma…     118 Blac… Drama|… USA   A partir de …  80000000
##  8 The L…  2003 Stephe…     110 Blac… Action… USA   A partir de …  78000000
##  9 War H…  2011 Steven…     146 Blac… Drama|… USA   A partir de …  66000000
## 10 Space…  2000 Clint …     130 Blac… Action… USA   A partir de …  65000000
## # … with 139 more rows, and 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

**2.** Crie um objeto chamado `curtos_legais` com filmes de 90 minutos ou menos de duração e nota no imdb maior do que 8.5.


```r
curtos_legais <- imdb %>% 
  filter(duracao <= 90, nota_imdb > 8.5)
```

**3.** Retorne tabelas (`tibbles`) apenas com:

**a.** filmes coloridos anteriores a 1950;


```r
imdb %>% 
  filter(cor == "Color", ano < 1950)
## # A tibble: 14 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <dbl> <chr>     <dbl> <chr> <chr>   <chr> <chr>             <dbl>
##  1 Pinoc…  1940 Norman…      88 Color Animat… USA   Outros          2600000
##  2 Duel …  1946 King V…     144 Color Drama|… USA   Outros          8000000
##  3 Tycoo…  1947 Richar…      95 Color Advent… USA   Outros          3209000
##  4 State…  1945 Walter…     100 Color Musica… USA   Outros               NA
##  5 Gone …  1939 Victor…     226 Color Drama|… USA   Outros          3977000
##  6 The P…  1948 Vincen…     102 Color Advent… USA   Outros          3700000
##  7 It's …  1946 Frank …     118 Color Drama|… USA   Livre           3180000
##  8 Bathi…  1944 George…     101 Color Comedy… USA   Outros          2361000
##  9 Fanta…  1940 James …     120 Color Animat… USA   Outros          2280000
## 10 She W…  1949 John F…     103 Color Western USA   Outros          1600000
## 11 Spell…  1945 Alfred…      95 Color Film-N… USA   Outros          1696377
## 12 Snow …  1937 Willia…      83 Color Animat… USA   Outros          2000000
## 13 Casab…  1942 Michae…      82 Color Drama|… USA   Livre            950000
## 14 Bambi   1942 James …      70 Color Animat… USA   Outros               NA
## # … with 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


**b.** filmes do "Woody Allen" ou do "Wes Anderson";


```r
imdb %>% 
  filter(diretor == "Woody Allen" | diretor == "Wes Anderson")
## # A tibble: 25 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <dbl> <chr>     <dbl> <chr> <chr>   <chr> <chr>             <dbl>
##  1 The L…  2004 Wes An…     119 Color Advent… USA   A partir de …  50000000
##  2 Fanta…  2009 Wes An…      87 Color Advent… USA   Livre          40000000
##  3 The G…  2014 Wes An…      99 Color Advent… USA   A partir de …  25000000
##  4 The R…  2001 Wes An…     110 Color Comedy… USA   A partir de …  21000000
##  5 The C…  2001 Woody …     103 Color Comedy… USA   A partir de …  26000000
##  6 To Ro…  2012 Woody …     112 Color Comedy… USA   A partir de …  17000000
##  7 Bulle…  1994 Woody …      98 Color Comedy… USA   A partir de …  20000000
##  8 Decon…  1997 Woody …      96 Color Comedy  USA   A partir de …  20000000
##  9 Every…  1996 Woody …     101 Color Comedy… USA   A partir de …  20000000
## 10 Blue …  2013 Woody …      98 Color Drama   USA   A partir de …  18000000
## # … with 15 more rows, and 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


**c.** filmes do "Steven Spielberg" ordenados de forma decrescente por ano, mostrando apenas as colunas `titulo` e `ano`;


```r
imdb %>% 
  filter(diretor == "Steven Spielberg") %>% 
  arrange(desc(ano)) %>% 
  select(titulo, ano)
## # A tibble: 24 x 2
##    titulo                                                ano
##    <chr>                                               <dbl>
##  1 Bridge of Spies                                      2015
##  2 Lincoln                                              2012
##  3 The Adventures of Tintin                             2011
##  4 War Horse                                            2011
##  5 Indiana Jones and the Kingdom of the Crystal Skull   2008
##  6 War of the Worlds                                    2005
##  7 The Terminal                                         2004
##  8 Minority Report                                      2002
##  9 Catch Me If You Can                                  2002
## 10 A.I. Artificial Intelligence                         2001
## # … with 14 more rows
```


**d.**  filmes que tenham "Action" **ou** "Comedy" entre os seus gêneros;


```r
library(stringr)

# Solução 1
imdb %>% 
  filter(str_detect(generos, "Action") | str_detect(generos, "Comedy"))
## # A tibble: 2,187 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <dbl> <chr>     <dbl> <chr> <chr>   <chr> <chr>             <dbl>
##  1 Avata…  2009 James …     178 Color Action… USA   A partir de … 237000000
##  2 Pirat…  2007 Gore V…     169 Color Action… USA   A partir de … 300000000
##  3 The D…  2012 Christ…     164 Color Action… USA   A partir de … 250000000
##  4 John …  2012 Andrew…     132 Color Action… USA   A partir de … 263700000
##  5 Spide…  2007 Sam Ra…     156 Color Action… USA   A partir de … 258000000
##  6 Tangl…  2010 Nathan…     100 Color Advent… USA   Livre         260000000
##  7 Aveng…  2015 Joss W…     141 Color Action… USA   A partir de … 250000000
##  8 Batma…  2016 Zack S…     183 Color Action… USA   A partir de … 250000000
##  9 Super…  2006 Bryan …     169 Color Action… USA   A partir de … 209000000
## 10 Pirat…  2006 Gore V…     151 Color Action… USA   A partir de … 225000000
## # … with 2,177 more rows, and 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

**e.** filmes que tenham "Action" **e** "Comedy" entre os seus gêneros e tenha `nota_imdb` maior que 8;


```r
imdb %>% 
  filter(str_detect(generos, "Action"), str_detect(generos, "Comedy"))
## # A tibble: 203 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <dbl> <chr>     <dbl> <chr> <chr>   <chr> <chr>             <dbl>
##  1 Men i…  2012 Barry …     106 Color Action… USA   A partir de … 225000000
##  2 Rush …  2007 Brett …      91 Color Action… USA   A partir de … 140000000
##  3 Monst…  2009 Rob Le…      94 Color Action… USA   Livre         175000000
##  4 Wild …  1999 Barry …     106 Color Action… USA   A partir de … 170000000
##  5 Suici…  2016 David …     123 Color Action… USA   A partir de … 175000000
##  6 Big H…  2014 Don Ha…     102 Color Action… USA   Livre         165000000
##  7 Madag…  2008 Eric D…      89 Color Action… USA   Livre         150000000
##  8 G-For…  2009 Hoyt Y…      88 Color Action… USA   Livre         150000000
##  9 Kung …  2011 Jennif…      90 Color Action… USA   Livre         150000000
## 10 Mars …  2011 Simon …      88 Color Action… USA   Livre         150000000
## # … with 193 more rows, and 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```


**f.** filmes que não possuem informação tanto de receita quanto de orçamento (isto é, possuem `NA` em ambas as colunas).


```r
imdb %>% 
  filter(is.na(orcamento), is.na(receita))
## # A tibble: 137 x 15
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <dbl> <chr>     <dbl> <chr> <chr>   <chr> <chr>             <dbl>
##  1 The A…    NA <NA>         60 Color Action… USA   Outros               NA
##  2 Ben-H…  2016 Timur …     141 Color Advent… USA   A partir de …        NA
##  3 Hanni…    NA <NA>         44 Color Crime|… USA   Outros               NA
##  4 All T…  1979 Bob Fo…     123 Color Comedy… USA   A partir de …        NA
##  5 Dared…    NA <NA>         54 <NA>  Action… USA   Outros               NA
##  6 Bewit…    NA <NA>         25 Blac… Comedy… USA   Outros               NA
##  7 Const…    NA <NA>         43 Color Drama|… USA   Outros               NA
##  8 Life      NA <NA>         45 Color Crime|… USA   Outros               NA
##  9 Sleep…    NA <NA>         45 Color Advent… USA   Outros               NA
## 10 Last …    NA <NA>         30 Color Comedy  USA   Outros               NA
## # … with 127 more rows, and 6 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

### Modificando e criando novas colunas

**1.** Crie uma coluna chamada `prejuizo` (`orcamento - receita`) e salve a nova tabela em um objeto chamado `imdb_prejuizo`. Em seguida, filtre apenas os filmes que deram prejuízo e ordene a tabela por ordem crescente de prejuízo.


```r
imdb_prejuizo <- imdb %>% 
  mutate(prejuizo = orcamento - receita)

imdb_prejuizo %>% 
  filter(prejuizo > 0) %>% 
  arrange(prejuizo)
## # A tibble: 1,312 x 16
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <dbl> <chr>     <dbl> <chr> <chr>   <chr> <chr>             <dbl>
##  1 The H…  2009 Michel…      93 Color Docume… USA   Outros           160000
##  2 Newly…  2011 Edward…      95 Color Comedy… USA   Outros             9000
##  3 Short…  2006 John C…     101 Color Comedy… USA   Outros          2000000
##  4 Slam    1998 Marc L…     100 Color Drama   USA   A partir de …   1000000
##  5 Pink …  1971 James …      65 Color Drama|… USA   Outros            27000
##  6 The F…  2011 Brando…      82 Color Comedy  USA   A partir de …     60000
##  7 Assau…  2005 Jean-F…     109 Color Action… USA   A partir de …  20000000
##  8 The B…  2002 Sherma…     103 Color Drama|… USA   Outros           200000
##  9 Latte…  2003 C. Jay…     107 Color Comedy… USA   A partir de …    850000
## 10 Happy…  2014 Joe Sw…      82 Color Comedy… USA   A partir de …     70000
## # … with 1,302 more rows, and 7 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>,
## #   prejuizo <dbl>
```


**2.** Fazendo apenas uma chamada da função mutate(), crie as seguintes colunas novas na base `imdb`:

**a.** `lucro = receita - orcamento`

**b.** `lucro_medio`

**c.** `lucro_relativo = (lucro - lucro_medio)/lucro_medio`

**d.** `houve_lucro = ifelse(lucro > 0, "sim", "não")`


```r
imdb %>% 
  mutate(
    lucro = receita - orcamento,
    lucro_medio = mean(lucro, na.rm = TRUE),
    lucro_relativo = (lucro - lucro_medio) / lucro_medio,
    houve_lucro = ifelse(lucro > 0, "sim", "não")
  )
## # A tibble: 3,807 x 19
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <dbl> <chr>     <dbl> <chr> <chr>   <chr> <chr>             <dbl>
##  1 Avata…  2009 James …     178 Color Action… USA   A partir de … 237000000
##  2 Pirat…  2007 Gore V…     169 Color Action… USA   A partir de … 300000000
##  3 The D…  2012 Christ…     164 Color Action… USA   A partir de … 250000000
##  4 John …  2012 Andrew…     132 Color Action… USA   A partir de … 263700000
##  5 Spide…  2007 Sam Ra…     156 Color Action… USA   A partir de … 258000000
##  6 Tangl…  2010 Nathan…     100 Color Advent… USA   Livre         260000000
##  7 Aveng…  2015 Joss W…     141 Color Action… USA   A partir de … 250000000
##  8 Batma…  2016 Zack S…     183 Color Action… USA   A partir de … 250000000
##  9 Super…  2006 Bryan …     169 Color Action… USA   A partir de … 209000000
## 10 Pirat…  2006 Gore V…     151 Color Action… USA   A partir de … 225000000
## # … with 3,797 more rows, and 10 more variables: receita <dbl>,
## #   nota_imdb <dbl>, likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>,
## #   ator_3 <chr>, lucro <dbl>, lucro_medio <dbl>, lucro_relativo <dbl>,
## #   houve_lucro <chr>
```


**3.** Crie uma nova coluna que classifique o filme em `"recente"` (posterior a 2000) e `"antigo"` (de 2000 para trás).


```r
imdb %>% 
  mutate(antigo_ou_recente = ifelse(ano > 2000, "recente", "antigo"))
## # A tibble: 3,807 x 16
##    titulo   ano diretor duracao cor   generos pais  classificacao orcamento
##    <chr>  <dbl> <chr>     <dbl> <chr> <chr>   <chr> <chr>             <dbl>
##  1 Avata…  2009 James …     178 Color Action… USA   A partir de … 237000000
##  2 Pirat…  2007 Gore V…     169 Color Action… USA   A partir de … 300000000
##  3 The D…  2012 Christ…     164 Color Action… USA   A partir de … 250000000
##  4 John …  2012 Andrew…     132 Color Action… USA   A partir de … 263700000
##  5 Spide…  2007 Sam Ra…     156 Color Action… USA   A partir de … 258000000
##  6 Tangl…  2010 Nathan…     100 Color Advent… USA   Livre         260000000
##  7 Aveng…  2015 Joss W…     141 Color Action… USA   A partir de … 250000000
##  8 Batma…  2016 Zack S…     183 Color Action… USA   A partir de … 250000000
##  9 Super…  2006 Bryan …     169 Color Action… USA   A partir de … 209000000
## 10 Pirat…  2006 Gore V…     151 Color Action… USA   A partir de … 225000000
## # … with 3,797 more rows, and 7 more variables: receita <dbl>, nota_imdb <dbl>,
## #   likes_facebook <dbl>, ator_1 <chr>, ator_2 <chr>, ator_3 <chr>,
## #   antigo_ou_recente <chr>
```

### Summarisando a base

Utilize a base `imdb` nos exercícios a seguir.

**1.** Calcule a duração média e mediana dos filmes
da base.


```r
imdb %>% 
  summarise(
    duracao_media = mean(duracao, na.rm = TRUE),
    duracao_mediana = median(duracao, na.rm = TRUE)
  )
## # A tibble: 1 x 2
##   duracao_media duracao_mediana
##           <dbl>           <dbl>
## 1          106.             103
```


**2.** Calcule o lucro médio dos filmes com duração
menor que 60 minutos.


```r
imdb %>% 
  filter(duracao < 60) %>% 
  mutate(lucro = receita - orcamento) %>% 
  summarise(lucro_medio = mean(lucro, na.rm = TRUE))
## # A tibble: 1 x 1
##   lucro_medio
##         <dbl>
## 1     632454.
```

**3.** Apresente na mesma tabela o lucro médio dos filmes com duracao menor que 60 minutos e o lucro médio dos filmes com duracao maior ou igual a 60 minutos.


```r
imdb %>% 
  mutate(
    lucro = receita - orcamento,
    duracao_cat = ifelse(duracao < 60, "menor 60 min", "60 ou mais min")
  ) %>% 
  filter(!is.na(lucro)) %>% 
  group_by(duracao_cat) %>% 
  summarise(
    lucro_medio = mean(lucro, na.rm = TRUE)
  )
## `summarise()` ungrouping output (override with `.groups` argument)
## # A tibble: 2 x 2
##   duracao_cat    lucro_medio
##   <chr>                <dbl>
## 1 60 ou mais min   17274472.
## 2 menor 60 min       632454.
```

**4.** Retorne tabelas (`tibbles`) apenas com:

**a.** a nota IMDB média dos filmes por tipo de classificacao;


```r
imdb %>% 
  group_by(classificacao) %>% 
  summarise(nota_media = mean(nota_imdb, na.rm = TRUE))
## `summarise()` ungrouping output (override with `.groups` argument)
## # A tibble: 4 x 2
##   classificacao       nota_media
##   <chr>                    <dbl>
## 1 A partir de 13 anos       6.18
## 2 A partir de 18 anos       6.47
## 3 Livre                     6.26
## 4 Outros                    6.65
```

**b.** a receita média e mediana dos filmes por ano;


```r
imdb %>% 
  group_by(ano) %>% 
  summarise(
    receita_media = mean(receita, na.rm = TRUE),
    receita_mediana = median(receita, na.rm = TRUE)
  )
## `summarise()` ungrouping output (override with `.groups` argument)
## # A tibble: 91 x 3
##      ano receita_media receita_mediana
##    <dbl>         <dbl>           <dbl>
##  1  1916           NaN              NA
##  2  1920       3000000         3000000
##  3  1925           NaN              NA
##  4  1929       2808000         2808000
##  5  1930           NaN              NA
##  6  1932           NaN              NA
##  7  1933       2300000         2300000
##  8  1934           NaN              NA
##  9  1935       3000000         3000000
## 10  1936        163245          163245
## # … with 81 more rows
```

**c.** apenas o nome dos diretores com mais de 10 filmes.


```r
imdb %>% 
  filter(!is.na(diretor)) %>% 
  group_by(diretor) %>% 
  summarise(num_filmes = n()) %>% 
  filter(num_filmes > 10) %>% 
  select(diretor)
## `summarise()` ungrouping output (override with `.groups` argument)
## # A tibble: 22 x 1
##    diretor             
##    <chr>               
##  1 Barry Levinson      
##  2 Clint Eastwood      
##  3 Francis Ford Coppola
##  4 John Carpenter      
##  5 Kevin Smith         
##  6 Martin Scorsese     
##  7 Michael Bay         
##  8 Renny Harlin        
##  9 Ridley Scott        
## 10 Rob Cohen           
## # … with 12 more rows
```

*Também podemos usar a função `count()`.*


```r
imdb %>% 
  filter(!is.na(diretor)) %>% 
  count(diretor, name = "num_filmes") %>% 
  filter(num_filmes > 10) %>% 
  select(diretor)
## # A tibble: 22 x 1
##    diretor             
##    <chr>               
##  1 Barry Levinson      
##  2 Clint Eastwood      
##  3 Francis Ford Coppola
##  4 John Carpenter      
##  5 Kevin Smith         
##  6 Martin Scorsese     
##  7 Michael Bay         
##  8 Renny Harlin        
##  9 Ridley Scott        
## 10 Rob Cohen           
## # … with 12 more rows
```


### Juntando duas bases

**1.** Utilize a base `imdb` para resolver os itens a seguir.

**a.** Salve em um novo objeto uma tabela com a
nota média dos filmes de cada diretor. Essa tabela
deve conter duas colunas (`diretor` e `nota_imdb_media`)
e cada linha deve ser um diretor diferente.


```r
nota_diretores <- imdb %>% 
  group_by(diretor) %>% 
  summarise(nota_imdb_media = mean(nota_imdb))
## `summarise()` ungrouping output (override with `.groups` argument)

nota_diretores
## # A tibble: 1,813 x 2
##    diretor          nota_imdb_media
##    <chr>                      <dbl>
##  1 A. Raven Cruz                1.9
##  2 Aaron Hann                   6  
##  3 Aaron Schneider              7.1
##  4 Aaron Seltzer                2.7
##  5 Abel Ferrara                 6.6
##  6 Adam Carolla                 6.1
##  7 Adam Goldberg                5.4
##  8 Adam Green                   5.7
##  9 Adam Jay Epstein             3.8
## 10 Adam Marcus                  4.3
## # … with 1,803 more rows
```


**b.** Use o `left_join()` para trazer a coluna
`nota_imdb_media` da tabela do item anterior
para a tabela `imdb` original.


```r
imdb %>% 
  left_join(nota_diretores, by = "diretor") %>% 
  select(nota_imdb_media, everything())
## # A tibble: 3,807 x 16
##    nota_imdb_media titulo   ano diretor duracao cor   generos pais 
##              <dbl> <chr>  <dbl> <chr>     <dbl> <chr> <chr>   <chr>
##  1            7.88 Avata…  2009 James …     178 Color Action… USA  
##  2            6.99 Pirat…  2007 Gore V…     169 Color Action… USA  
##  3            8.43 The D…  2012 Christ…     164 Color Action… USA  
##  4            7.73 John …  2012 Andrew…     132 Color Action… USA  
##  5            6.9  Spide…  2007 Sam Ra…     156 Color Action… USA  
##  6            7.8  Tangl…  2010 Nathan…     100 Color Advent… USA  
##  7            7.92 Aveng…  2015 Joss W…     141 Color Action… USA  
##  8            7.18 Batma…  2016 Zack S…     183 Color Action… USA  
##  9            7.26 Super…  2006 Bryan …     169 Color Action… USA  
## 10            6.99 Pirat…  2006 Gore V…     151 Color Action… USA  
## # … with 3,797 more rows, and 8 more variables: classificacao <chr>,
## #   orcamento <dbl>, receita <dbl>, nota_imdb <dbl>, likes_facebook <dbl>,
## #   ator_1 <chr>, ator_2 <chr>, ator_3 <chr>
```

