


## O pacote lubridate

Trabalhar com datas no R era uma chateação. As funções do R base são, em grande parte, contraintuitivas e podem mudar de acordo com o tipo do objeto que você está usando (data, hora, data/hora). Além disso, características como fusos horários, anos bissextos, horários de verão, entre outras, podem não estar bem especificadas ou nem mesmo sendo levadas em conta.

O pacote `{lubridate}`, criado por [Garrett Grolemund](https://github.com/garrettgman) e [Hadley Wickham](https://github.com/hadley), surgiu para lidar com esses problemas, fazendo o trabalho com datas ser muito mais fácil.

Antes de começar a usar, você precisa instalar e carregar o pacote.


```r
install.packages("lubridate")
library(lubridate)
```



Neste seção, falaremos sobre:

- transformar e extrair datas;
- algumas funções úteis para trabalhar com datas;
- trabalhar com fusos horários; e
- operações aritméticas com datas.

### A classe "date"

Datas no R são tratadas como um tipo especial de objeto, com classe `date`. Há várias formas de criar objetos dessa classe com o pacote `{lubridate}`:


```r
data_string <- "21-10-2015"
class(data_string)
```

```
## [1] "character"
```

```r
data_date <- date(data_string)
class(data_date)
```

```
## [1] "Date"
```

```r
data_date
```

```
## [1] "0021-10-20"
```

```r
data_as_date <- as_date(data_string)
```

```
## Warning: All formats failed to parse. No formats found.
```

```r
class(data_as_date)
```

```
## [1] "Date"
```

```r
data_as_date
```

```
## [1] NA
```

```r
data_mdy <- dmy(data_string)
class(data_mdy)
```

```
## [1] "Date"
```

```r
data_mdy
```

```
## [1] "2015-10-21"
```

Veja que as funções `date()` e `as_date()` converteram a *string* para data, mas não devolveram o valor esperado. A função `dmy()` resolve esse problema estabelecendo explicitamente a ordem dia-mês-ano. Existem funções para todas as ordens possíveis: `dmy()`, `mdy()`, `myd()`, `ymd()`, `ydm()` etc.

As funções `date()` e `as_date()` assumem que a ordem segue o padrão da língua inglesa: ano-mês-dia (ymd).


```r
date("2015-10-21")
```

```
## [1] "2015-10-21"
```

```r
as_date("2015-10-21")
```

```
## [1] "2015-10-21"
```

Uma grande facilidade que essas funções trazem é poder criar objetos com classe `date` a partir de números e *strings* em diversos formatos.


```r
dmy(21102015)
```

```
## [1] "2015-10-21"
```

```r
dmy("21102015")
```

```
## [1] "2015-10-21"
```

```r
dmy("21/10/2015")
```

```
## [1] "2015-10-21"
```

```r
dmy("21.10.2015")
```

```
## [1] "2015-10-21"
```

Se além da data você precisar especificar o horário, basta usar as funções do tipo `ymd_h()`, `ymd_hm()`, `ymd_hms()`, sendo que também há uma função para cada formato de dia-mês-ano.


```r
ymd_hms(20151021165411)
```

```
## [1] "2015-10-21 16:54:11 UTC"
```

No R base, utilizamos a função `as.Date()` para transformar uma string em data:


```r
data_base <- as.Date("2015-10-21")
class(data_base)
```

```
## [1] "Date"
```

```r
data_base
```

```
## [1] "2015-10-21"
```

Repare que a função `date()` do R base retorna a data e horário no momento da execução:


```r
base::date()
```

```
## [1] "Mon Mar 22 10:06:06 2021"
```

### Funções úteis

O `lubridate` traz diversas funções para extrair os componentes de um objeto da classe `date`. 

- `second()` - extrai os segundos.
- `minute()` - extrai os minutos.
- `hour()` - extrai a hora.
- `wday()` - extrai o dia da semana.
- `mday()` - extrai o dia do mês.
- `month()` - extrai o mês.
- `year()` - extrai o ano.

Os nomes são tão óbvios que a explicação do que cada função faz é praticamente desnecessária.


```r
bday <- ymd_hms("1989-07-29 030142")
bday
```

```
## [1] "1989-07-29 03:01:42 UTC"
```

```r
second(bday)
```

```
## [1] 42
```

```r
day(bday)
```

```
## [1] 29
```

```r
month(bday)
```

```
## [1] 7
```

```r
year(bday)
```

```
## [1] 1989
```

```r
wday(bday)
```

```
## [1] 7
```

```r
wday(bday, label = TRUE)
```

```
## [1] Sat
## Levels: Sun < Mon < Tue < Wed < Thu < Fri < Sat
```

Você também pode usar essas funções para atribuir esses componentes a uma data:


```r
data <- dmy("01/04/1991")
data
```

```
## [1] "1991-04-01"
```

```r
hour(data) <- 20
data
```

```
## [1] "1991-04-01 20:00:00 UTC"
```

Também existem funções para extrair a data no instante da execução.


```r
# Data e horário do dia em que essa página foi editada pela última vez.
today() 
```

```
## [1] "2021-03-22"
```

```r
now()
```

```
## [1] "2021-03-22 10:06:06 -03"
```

### Fusos horários

Uma característica inerente das datas é o fuso horário. Se você estiver trabalhando com datas de eventos no Brasil e na Escócia, por exemplo, é preciso verificar se os valores seguem o mesmo fuso horário. Além disso, quando a data exata de um evento for relevante, você pode precisar converter horários para outros fusos para comunicar seus resultados em outros países.

Para fazer essas coisas, o `lubridate` fornece as funções `with_tz()` e `force_tz()`. Veja um exemplo de como usá-las.


```r
estreia_GoT <- ymd_hms("2017-07-16 22:00:00", tz = "America/Sao_Paulo")
estreia_GoT
```

```
## [1] "2017-07-16 22:00:00 -03"
```

```r
# Devolve qual seria a data em outro fuso

with_tz(estreia_GoT, tzone = "GMT")
```

```
## [1] "2017-07-17 01:00:00 GMT"
```

```r
with_tz(estreia_GoT, tzone = "US/Alaska")  
```

```
## [1] "2017-07-16 17:00:00 AKDT"
```

```r
# Altera o fuso sem mudar a hora

force_tz(estreia_GoT, tzone = "GMT")
```

```
## [1] "2017-07-16 22:00:00 GMT"
```

### Operações com datas

O pacote `lubridate` possui ainda funções para calcular intervalos e fazer operações aritméticas com datas.

#### Intervalos {-}

Intervalos podem ser salvos em objetos com classe `interval`.


```r
inicio <- dmy("01-04-1991")
evento <- dmy("31-10-1993")

sobrev <- interval(inicio, evento)
sobrev
```

```
## [1] 1991-04-01 UTC--1993-10-31 UTC
```

```r
class(sobrev)
```

```
## [1] "Interval"
## attr(,"package")
## [1] "lubridate"
```

Você pode verificar se dois intervalos tem intersecção com a função `int_overlaps()`.


```r
# Outra forma de definir um intervalo: o operador %--%
intervalo_1 <- dmy("01-02-2003") %--% dmy("02-03-2005")  

intervalo_2 <- dmy("04-05-2004") %--% dmy("12-03-2012")  

int_overlaps(intervalo_1, intervalo_2)
```

```
## [1] TRUE
```

#### Aritmética com datas

Veja alguns exemplos de operações aritméticas que você pode fazer utilizando funções do `lubridate`:


```r
# Somando datas

data <- dmy("31/01/2000")

data + ddays(1)
```

```
## [1] "2000-02-01"
```

```r
data + dyears(1)
```

```
## [1] "2001-01-30 06:00:00 UTC"
```

```r
# A operação abaixo retornaria uma data inválida
# por isso obtemos NA
data + months(1)  
```

```
## [1] NA
```

```r
# Criando datas recorrentes

reuniao <- dmy("18-03-2017")
reunioes <- reuniao + weeks(0:10)
reunioes
```

```
##  [1] "2017-03-18" "2017-03-25" "2017-04-01" "2017-04-08" "2017-04-15"
##  [6] "2017-04-22" "2017-04-29" "2017-05-06" "2017-05-13" "2017-05-20"
## [11] "2017-05-27"
```

```r
# Duração de um intervalo 

intervalo <-dmy("01-03-2003") %--% dmy("31-03-2003") 

intervalo / ddays(1)               # Número de dias
```

```
## [1] 30
```

```r
intervalo / dminutes(1)            # Número de minutos
```

```
## [1] 43200
```

```r
as.period(intervalo)
```

```
## [1] "30d 0H 0M 0S"
```

Para mais informações sobre o`lubridate`, visite o [vignette do pacote](https://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html).

### Exercícios

Nos exercícios a seguir, vamos utilizar a base `lakers`, que contém estatísticas jogo a jogo do [Los Angeles Lakers](http://www.nba.com/lakers/) na temporada 2008-2009.


```r
lakers %>% as_tibble()
```

```
## # A tibble: 34,624 x 13
##      date opponent game_type time  period etype team  player result points type 
##     <int> <chr>    <chr>     <chr>  <int> <chr> <chr> <chr>  <chr>   <int> <chr>
##  1 2.01e7 POR      home      12:00      1 jump… OFF   ""     ""          0 ""   
##  2 2.01e7 POR      home      11:39      1 shot  LAL   "Pau … "miss…      0 "hoo…
##  3 2.01e7 POR      home      11:37      1 rebo… LAL   "Vlad… ""          0 "off"
##  4 2.01e7 POR      home      11:25      1 shot  LAL   "Dere… "miss…      0 "lay…
##  5 2.01e7 POR      home      11:23      1 rebo… LAL   "Pau … ""          0 "off"
##  6 2.01e7 POR      home      11:22      1 shot  LAL   "Pau … "made"      2 "hoo…
##  7 2.01e7 POR      home      11:22      1 foul  POR   "Greg… ""          0 "sho…
##  8 2.01e7 POR      home      11:22      1 free… LAL   "Pau … "made"      1 ""   
##  9 2.01e7 POR      home      11:00      1 foul  LAL   "Vlad… ""          0 "per…
## 10 2.01e7 POR      home      10:53      1 shot  POR   "LaMa… "made"      2 "jum…
## # … with 34,614 more rows, and 2 more variables: x <int>, y <int>
```


**1.** Repare que a coluna `date` no data.frame é um vetor de inteiros. Transforme essa coluna em um vetor de valores com classe `date`.


**2.** Crie uma coluna que junte as informações de data e tempo de jogo (colunas `date` e `time`) em objetos da classe `date`.


**3.** Crie as colunas `dia`, `mês` e `ano` com as respectivas informações sobre a data do jogo.


**4.** Em média, quanto tempo o Lakers demora para arremessar a primeira bola no primeiro período?

**Dica**: arremessos são representados pela categoria `shot` da coluna `etype`.


**5.** Em média, quanto tempo demora para sair a primeira cesta de três pontos? Considere toda a base, e cestas de ambos os times.


**6.** Construa boxplots do tempo entre pontos consecultivos para cada períodos. Considere toda a base de dados e apenas pontos do Lakers.


**7.** Qual foi o dia e mês do jogo que o Lakers demorou mais tempo para fazer uma cesta? Quanto tempo foi?

--------------------------------------------------------------------------------

# Respostas


--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
