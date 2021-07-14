## O pacote stringr



### Introdução

Variáveis de texto são muito comuns nos bancos de dados e, geralmente, dão bastante trabalho para serem manipuladas. É muito comum encontrarmos colunas com categorias não padronizadas, como, por exemplo, uma variável `Estado` com "SP", "sp", "Sao Paulo", "São Paulo" etc, todas indicando o mesmo estado.

O R possui várias funções para manipular textos (ou *strings*). No entanto, as funções do `base` não possuem uma interface consistente e cada uma tem a sua forma de passar os parâmetros, dificultando a programação durante a análise.

Pensando nisso, Hadley Wickham deu aquela força para a comunidade R e criou o pacote `stringr`, que possui uma sintaxe consistente, permitindo o usuário manipular textos com muito mais facilidade.

##### Vantagens do stringr em relação às funções do R base {-}

- Sintaxe unificada, o que auxilia na memorização das funções e leitura do código.

- Todas as funções são vetorizadas.

- Construído sobre a [biblioteca ICU](http://site.icu-project.org/), implementada em `C` e `C++`, uma garantia de resultados mais rápidos.

##### Regras básicas do pacote {-}

- As funções de manipulação de texto começam com `str_`. Caso esqueça o nome de uma função, basta digitar `stringr::str_` e apertar `TAB` para ver quais são as opções.

- O primeiro argumento da função é sempre uma *string* ou um vetor de *strings*.

##### Curiosidade {-}

Inicialmente, o `stringr` era um *wrapper* de funções do `base`. Depois disso, surgiu um novo pacote `stringi`, com sintaxe similar ao `stringr`, mas funcionando como *wrapper* da biblioteca ICU. Wickham gostou tanto do pacote `stringi` que decidiu reescrever o `stringr` como um *wrapper* do `stringi`. 

Veja [essa página](https://github.com/tidyverse/stringr/blob/master/NEWS.md) para detalhes.

##### Começando a usar {-}

Todas as funções do `stringr` começam com o prefixo `str_`. Isso ajuda na hora de encontrar a função que você está procurando. No RStudio, digite `str_` e aperte **TAB** para visualizar a lista de funções com esse prefixo. Você pode verificar o que cada função faz até encontrar a que atende às suas necessidades.

<img src="assets/img/manipulacao/str_tab.png" width="719" style="display: block; margin: auto;" />

Na próxima seção, vamos apresentar as funções mais simples do `{stringr}`. Em seguida, vamos falar um pouco de expressões regulares (regex) e então veremos funções mais avançadas do pacote, que utilizam regex para identificar padrões.

Antes de mais nada, instale e carregue o pacote `stringr`.


```r
install.packages("stringr")
```


```r
library(stringr)
```

### Funções básicas

A seguir, apresentamos as funções mais simples do `{stringr}`, que não utilizam o conceito de expressões regulares. 

##### str_length {-}

A função mais simples do `stringr()` é a função `str_length()`. Esta função recebe como argumento um vetor de *strings* e retorna o número de caracteres de cada *string*. Repare que o espaço `" "` é considerado um caracter.


```r
str_length("São Paulo")
## [1] 9
str_length(c("São Paulo", "Rio de Janeiro", 
             "Rio Grande do Norte", "Acre"))
## [1]  9 14 19  4
```

Note que `str_length()` é diferente de `length()`. O primeiro retorna o número de caracteres e o segundo retorna o comprimento do objeto. Isso fica mais claro no seguinte exemplo:


```r
s <- c("São Paulo", "Rio de Janeiro", 
       "Rio Grande do Norte", "Acre")

str_length(s)
## [1]  9 14 19  4
length(s)
## [1] 4
```

A função `str_length()` retornou um vetor com o número de caracteres de cada elemento do vetor `s`, enquanto `length()` retornou o comprimento do vetor `s`.

##### str_to_upper, str_to_lower, str_to_title {-}

Essas funções servem para modificar a caixa das letras. Veja alguns exemplos:


```r
s <- "Somos a curso-r"
str_to_lower(s)
## [1] "somos a curso-r"
str_to_upper(s)
## [1] "SOMOS A CURSO-R"
str_to_title(s)
## [1] "Somos A Curso-R"
```

##### str_trim {-}

É muito comum encontrar textos que vêm com espaços a mais, principalmente de dados
provenientes de formulários em que cada usuário escreve da forma que prefere. Isso é um problema pois cria categorias diferentes para valores que deveriam ser iguais. Espaços antes e após o texto são especialmente chatos, pois pode ser difícil detectá-los.


```r
s <- c("M", "F", "F", " M", " F ", "M")
as.factor(s)
## [1] M   F   F    M   F  M  
## Levels:  F   M F M
```

A função `str_trim()` ajuda removendo os espaços excedentes antes e depois da string.


```r
string_aparada <- str_trim(s)
as.factor(string_aparada)
## [1] M F F M F M
## Levels: F M
```

##### str_sub {-}

Não é raro você precisar obter uma parte fixa de uma *string*, como, por exemplo, manipular textos da forma:


```r
s <- c("01-Feminino", "02-Masculino", "03-Indefinido")
```

Você pode querer apenas a parte final da string. Neste caso, pode usar a função `str_sub()`.


```r
# pegar do quarto até o último caractere
str_sub(s, start = 4) 
## [1] "Feminino"   "Masculino"  "Indefinido"
```

Também é possível obter apenas os números.


```r
# pegar apenas os dois primeiros caracteres
str_sub(s, end = 2) 
## [1] "01" "02" "03"
```

Em outros casos você precisa obter os últimos 2 caracteres.


```r
s <- c("Feminino-01", "Masculino-02", "Indefinido-03")
str_sub(s, end = -4)
## [1] "Feminino"   "Masculino"  "Indefinido"
str_sub(s, start = -2)
## [1] "01" "02" "03"
```

É possível usar os argumentos `start` e `end` conjuntamente.


```r
s <- c("__SP__", "__MG__", "__RJ__")
str_sub(s, 3, 4)
## [1] "SP" "MG" "RJ"
```

##### str_c {-}

Análoga à função `paste0()` do R base, concatena *strings* em uma única string.


```r
string1 <- "O valor p é: "
string2 <- 0.03

str_c(string1, string2) 
## [1] "O valor p é: 0.03"
```

Pode misturar objetos com strings definidas diretamente na função.


```r
string1 <- "Brigadeiro"
string2 <- "bom"
string3 <- "melhor"

str_c(string1, " é a prova de que não existe nada tão ", string2,
      " que não pode ficar ", string3, ".")
## [1] "Brigadeiro é a prova de que não existe nada tão bom que não pode ficar melhor."
```

A função é vetorizada.


```r
string1 <- c("Brigadeiro", "A política brasileira")
string2 <- c("bom", "ruim")
string3 <- c("melhor", "pior")

str_c(string1, " é a prova de que não existe nada tão ", string2,
      " que não pode ficar ", string3, ".")
## [1] "Brigadeiro é a prova de que não existe nada tão bom que não pode ficar melhor."          
## [2] "A política brasileira é a prova de que não existe nada tão ruim que não pode ficar pior."
```

Essas são as funções mais simples do pacote `stringr` e não exigem nenhum conhecimento de **expressões regulares**. Note que nenhuma delas possui o parâmetro `pattern`. Você verá como especificar esse parâmetro nas próximas seções. 

### Expressões Regulares

Trabalhar com textos exige um certo conhecimento de [expressões regulares](https://pt.wikipedia.org/wiki/Express%C3%A3o_regular). As expressões regulares --- ou simplesmente **regex** --- permitem identificar conjuntos de caracteres, palavras e outros padrões por meio de uma sintaxe concisa. 

O `stringr` utiliza regex da forma descrita [neste documento](http://www.gagolewski.com/software/stringi/manual/?manpage=stringi-search-regex). A própria [definição](https://stat.ethz.ch/R-manual/R-devel/library/base/html/regex.html) de regex do R é um ótimo manual.

Vamos estudar expressões regulares por meio de exemplos e da função `str_detect()`. Ela retorna `TRUE` se uma *string* atende a uma expressão regular e `FALSE` caso contrário. Por exemplo:


```r
str_detect("sao paulo", pattern = "paulo$")
## [1] TRUE
str_detect("sao paulo sp", pattern = "paulo$")
## [1] FALSE
```

A regex/pattern "paulo\$" indica que o texto deve ser terminado em "paulo". Existem diversos caracteres auxiliares que vão auxiliar na manipulação dos textos, assim como o "\$". 

> **Importante**: o valor passado para o argumento `pattern` de qualquer função do pacote `stringr` será entendido como uma regex.

A tabela abaixo mostra a aplicação de cinco regex em seis *strings* distintas.

- '^ban' reconhece apenas o que começa exatamente com "ban".

- 'b ?an' reconhece tudo que tenha "ban", com ou sem espaço entre o "b" e o "a".

- 'ban' reconhece tudo que tenha "ban", apenas minúsculo.

- BAN' reconhece tudo que tenha "BAN", apenas maiúsculo.

- 'ban$' reconhece apenas o que termina exatamente em "ban"





|strings         |^ban  |b ?an |ban   |BAN   |ban$  |
|:---------------|:-----|:-----|:-----|:-----|:-----|
|abandonado      |FALSE |TRUE  |TRUE  |FALSE |FALSE |
|ban             |TRUE  |TRUE  |TRUE  |FALSE |TRUE  |
|banana          |TRUE  |TRUE  |TRUE  |FALSE |FALSE |
|BANANA          |FALSE |FALSE |FALSE |TRUE  |FALSE |
|ele levou ban   |FALSE |TRUE  |TRUE  |FALSE |TRUE  |
|pranab anderson |FALSE |TRUE  |FALSE |FALSE |FALSE |

##### Quantificadores {-}

Os caracteres `+`, `*` e `{x,y}` indicam quantas vezes um padrão se repete:

- `ey+` significa `e` e depois `y` "**uma vez** ou mais". Por exemplo, reconhece `hey`, `heyy`, `a eyyy`, mas não reconhece `e`, `y` nem `yy`.

- `ey*` significa "**nenhuma vez** ou mais". Por exemplo, reconhece `hey`, `heyy`, `a eyyy` e `e`, mas não reconhece `y` nem `yy`.

- `ey{3}` significa "exatamente três vezes". Por exemplo, reconhece `eyyy` e `eyyyy`, mas não reconhece `eyy`.
- `ey{1,3}` significa "entre uma e três vezes".

Para aplicar um quantificador a um conjunto de caracteres, use parênteses. Por exemplo, `(ey )+` reconhece `ey ey `.

##### Conjuntos {-}

Colocando caracteres dentro de `[]`, reconhecemos quaisquer caracteres desse conjunto. Alguns exemplos práticos:

- `[Cc]asa` para reconhecer "casa" em maiúsculo ou minúsculo.

- `[0-9]` para reconhecer somente números. O mesmo vale para letras `[a-z]`, `[A-Z]`, `[a-zA-Z]` etc.

- O símbolo `^` dentro do colchete significa negação. Por exemplo, `[^0-9]` significa pegar tudo o que não é número.

- O símbolo `.` fora do colchete indica "qualquer caractere", mas dentro do colchete é apenas ponto.

- Use `[[:space:]]+` para reconhecer espaços e `[[:punct:]]+` para reconhecer pontuações.

##### Miscelânea {-}

- Use `abjutils::rm_accent()` para retirar os acentos de um texto.

- Use `|` para opções. Por exemplo, `desfavor|desprov` reconhece tanto "desfavorável" quanto "desprovido".

- O código `\n` pula linha, `\f` é final da página, `\t` é tab. Use `\` para transformar caracteres especiais em literais.

A lista de possibilidades com expressões regulares é extensa. 
Um bom lugar para testar o funcionamento das regex é o [regex101](https://regex101.com/).

### Funções que utilizam regex

Agora que já vimos as funções básicas do `stringr` e aprendemos um pouco de regex, vamos às funções mais avançadas. Basicamente, essas funções buscarão `patterns` em um vetor de *strings* e farão alguma coisa quando encontrá-lo.

Como já vimos na sessão sobre regex, a função mais simples que possui o argumento `pattern=` é a `str_detect()`.

##### str_detect()  {-}

Retorna `TRUE` se a regex é compatível com a string e `FALSE` caso contrário.


```r
library(stringr)
str_detect("sao paulo", pattern = "paulo$")
## [1] TRUE
str_detect("sao paulo sp", pattern = "paulo$")
## [1] FALSE
```

##### str_replace() e str_replace_all() {-}

Substituem um padrão (ou todos) encontrado para um outro padrão.

Substituindo apenas a primeira ocorrência.


```r
cidades <- c("S. José do Rio Preto", "São Paulo", "S. José dos Campos", "São Roque", "S. S. da Grama")

str_replace(cidades, "S[.]", "São")
## [1] "São José do Rio Preto" "São Paulo"             "São José dos Campos"  
## [4] "São Roque"             "São S. da Grama"
```
Veja que no exemplo anterior precisamos colocar o `.` entre colchetes. Se não tivéssemos colocado, ele seria interpretado como uma regex e o padrão procurado seria *"S" seguido de qualquer caracter*:


```r
cidades <- c("S. José do Rio Preto", "São Paulo", "S. José dos Campos", "São Roque", "S. S. da Grama")

str_replace(cidades, "S.", "São")
## [1] "São José do Rio Preto" "Sãoo Paulo"            "São José dos Campos"  
## [4] "Sãoo Roque"            "São S. da Grama"
```

Nesses casos, podemos usar a função `fixed()` para indicar que o padrão procurado não é uma regex:


```r
cidades <- c("S. José do Rio Preto", "São Paulo", "S. José dos Campos", "São Roque", "S. S. da Grama")

str_replace(cidades, fixed("S."), "São")
## [1] "São José do Rio Preto" "São Paulo"             "São José dos Campos"  
## [4] "São Roque"             "São S. da Grama"
```

A função `str_replace()` substitui apenas a primeira ocorrência encontrada. No exemplo anterior, apenas o primeiro "S." era substituído por "São". Se quisermos substituir todas as ocorrências de um padrão dentro de uma string, utilizamos a função `str_replace_all()`.

No exemplo abaixo, substituímos todas as ocorrências de `.` e `-` por um espaço.


```r
cpf <- c("303.030.111-33", "102-177-011-20", "987.220.199.00")

str_replace_all(cpf, "[.-]", " ")
## [1] "303 030 111 33" "102 177 011 20" "987 220 199 00"
```

##### str_extract() e str_extract_all() {-}

As funções `str_extract()` e `str_extract_all()` extraem padrões de uma *string*. No exemplo abaixo, pegamos apenas os sobrenomes de cada integrante do grupo.


```r
r_core_group <- c(
  'Douglas Bates', 'John Chambers', 'Peter Dalgaard',
  'Robert Gentleman', 'Kurt Hornik', 'Ross Ihaka', 'Tomas Kalibera',
  'Michael Lawrence', 'Friedrich Leisch', 'Uwe Ligges', '...'
)

sobrenomes <- str_extract(r_core_group, '[:alpha:]+$')
sobrenomes
##  [1] "Bates"     "Chambers"  "Dalgaard"  "Gentleman" "Hornik"    "Ihaka"    
##  [7] "Kalibera"  "Lawrence"  "Leisch"    "Ligges"    NA
```

##### str_split() e str_split_fixed() {-}

Essas funções separam uma *string* em várias de acordo com um separador.


```r
texto <- 'Durante um longo período de tempo o "R" foi escrito "P" como no alfabeto cirílico. O seu nome no alfabeto fenício era "rech". Seu significado era o de uma cabeça, representada pela adaptação do hieróglifo egípcio de uma cabeça. Transformou-se no "rô" dos gregos. Os romanos modificaram o rô acrescentando um pequeno traço para diferenciá-lo do no nosso P.'

str_split(texto, fixed('.'))
## [[1]]
## [1] "Durante um longo período de tempo o \"R\" foi escrito \"P\" como no alfabeto cirílico"                
## [2] " O seu nome no alfabeto fenício era \"rech\""                                                         
## [3] " Seu significado era o de uma cabeça, representada pela adaptação do hieróglifo egípcio de uma cabeça"
## [4] " Transformou-se no \"rô\" dos gregos"                                                                 
## [5] " Os romanos modificaram o rô acrescentando um pequeno traço para diferenciá-lo do no nosso P"         
## [6] ""
```

O `str_split_fixed` faz o mesmo que `str_split()`, mas separa apenas `n` vezes.


```r
str_split_fixed(texto, fixed('.'), 3)
##      [,1]                                                                                   
## [1,] "Durante um longo período de tempo o \"R\" foi escrito \"P\" como no alfabeto cirílico"
##      [,2]                                          
## [1,] " O seu nome no alfabeto fenício era \"rech\""
##      [,3]                                                                                                                                                                                                                                      
## [1,] " Seu significado era o de uma cabeça, representada pela adaptação do hieróglifo egípcio de uma cabeça. Transformou-se no \"rô\" dos gregos. Os romanos modificaram o rô acrescentando um pequeno traço para diferenciá-lo do no nosso P."
```

##### str_subset() {-}

A função `str_subset()` retorna somente as strings compatíveis com a regex.


```r
frases <- c('a roupa do rei', 'de roma', 'o rato roeu')
str_subset(frases, 'd[eo]')
## [1] "a roupa do rei" "de roma"
```

É o mesmo que fazer subset usando a função `str_detect`.


```r
frases[str_detect(frases, "d[eo]")]
## [1] "a roupa do rei" "de roma"
```

### Exercícios

**1.** O CPF é um número de 11 dígitos, por exemplo: 54491651884. No entanto para facilitar a visualização costumamos mostrá-lo com separadores a cada 3 casas: 544.916.518-84. Crie uma função que transforma um número de 11 dígitos em uma string com as separações, como um CPF.

**2.** Transforme o vetor de *strings* abaixo em `"01 - Alto" "02 - Médio" "03 - Baixo"`.


```r
s <- c('Alto', 'Médio', 'Baixo')
```

**3.** Crie uma regex que capture múltiplas versões da palavra 'casa'. Ela deve funcionar com as palavras 'Casa', 'CASA', 'CaSa', 'CAsa'. Teste-a usando a função `str_detect()`.


```r
s <- c('Casa', 'CASA', 'CaSa', 'CAsa')
```

**4.** Imagine que a seguinte *string* é a parte final de uma URL.

* `/ac/rio-branco/xpto-xyz-1-0-1fds2396-5`

Transforme-a em "AC - Rio Branco" utilizando funções do pacote `{stringr}`.


```r
url <- c('/ac/rio-branco/xpto-xyz-1-0-1fds2396-5')
```

**5.** Crie uma função que retorna `TRUE` quando a string é um [palíndromo](https://pt.wikipedia.org/wiki/Pal%C3%ADndromo) e `FALSO` caso não seja.


**6.** De acordo com as regras da língua portuguesa, antes de “p” ou “b” devemos usar a letra “m”. Em outras palavras, com outras consoantes, usamos a letra “N”. Suponha que você tem o seguinte texto com erros gramaticais:


```r
texto <- 'Nós chamamos os bonbeiros quando começou o incêmdio.'
```

Crie uma função para corrigi-lo. 

**7.** Considere o seguinte texto


```r
txt <- "A função mais importante para leitura de dados no `lubridate` é a `ymd`. Essa função serve para ler qualquer data de uma `string` no formato `YYYY-MM-DD`. Essa função é útil pois funciona com qualquer separador entre os elementos da data e também porque temos uma função para cada formato (`mdy`, `dmy`, `dym`, `myd`, `ydm`)."
```

Extraia todas as combinações da função `ymd`, sem repetições.

**8.** Considere as frases abaixo


```r
s <- c(
  'O produto é muito bom.',
  'O produto não é bom.',
  'O produto não é muito bom.',
  'O produto não é ruim.',
  'O produto não é não bom.'
)
```

Crie uma regra para identificar se o texto refere-se a um feedback positivo ou negativo sobre o produto (considere "não bom = ruim" e "não ruim = bom"). Retorne um vetor lógico que vale `TRUE` se o feedback é positivo e `FALSE` caso contrário.

