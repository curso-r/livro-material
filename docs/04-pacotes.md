# Pacotes {#pacotes}

A primeira aparição da linguagem de progromação R foi em 1993 e, apesar de lá para cá muita coisa ter sido desenvolvida e atualizada, é muito difícil fazer mudanças na base da linguagem sem quebrar os códigos já existentes. Por essa razão, as maiores inovações são realizadas na forma de pacotes.

Um pacote é um conjunto de funções que têm como objetivo resolver um problema específico. São eles que deixam o R poderoso, capaz de enfrentar qualquer tarefa de análise de dados. Assim, fique bastante à vontade para instalar e atualizar muitos e muitos pacotes ao longo da sua experiência com o R.

O legal é que qualquer pessoa pode fazer um novo pacote e disponibilizar para a comunidade, o que acelera bastante o desenvolvemento da ferramenta. Dificilmente você vai fazer uma análise apenas com as funções básicas do R e dificilmente não vai existir um pacote com as funções que você precisa.

## Instalação de pacotes

Existem três principais maneiras de instalar pacotes. Em ordem de frequência, são:

- Via CRAN (Comprehensive R Archive Network): `install.packages("nome-do-pacote")`.
- Via Github: `devtools::install_github("nome-do-repo/nome-do-pacote")`.
- Via arquivo .zip/.tar.gz: `install.packages("C:/caminho/nome-do-pacote.zip", repos = NULL)`.

Para conseguir instalar alguns pacotes no Linux, você pode precisar instalar dependências do sistema manualmente. Por exemplo, se você quer instalar o pacote devtools no R, será necessário ter as bibliotecas `curl`, `openssl`, `httr` e `git2r`.

Essas dependências geralmente podem ser instaladas no terminal por meio do comando `apt-get install nome-da-biblioteca`. Caso você não consiga instalar um pacote devido a ausência de uma dependência, uma maneira de saber quais bibliotecas você precisa instalar é observar as mensagens que aparecem no console durante a tentativa da instalação do pacote.

### Via CRAN

Instale pacotes que não estão na sua biblioteca usando a função `install.packages("nome_do_pacote")`. Por exemplo:


```r
install.packages("tidyverse")
```

E, de agora em diante, não precisa mais instalar. Basta carregar o pacote com `library(magrittr)`.

> Escreva nome_do_pacote::nome_da_funcao() se quiser usar apenas uma função de um determinado pacote. O operador :: serve para isso. Essa forma também é útil quando se tem duas funções com o mesmo nome e precisamos garantir que o código vá usar a função do pacote correto.

### Via Github

Desenvolvedores costumam disponibilizar a última versão de seus pacotes no Github, e alguns deles sequer estão no CRAN. Mesmo assim ainda é possível utilizá-los instalando diretamente pelo github. O comando é igualmente simples:


```r
devtools::install_github("rstudio/shiny")
```

Apenas será necessário o username e o nome do repositório (que geralmente tem o mesmo nome do pacote). No exemplo, o username foi "rstudio" e o repositório foi "shiny". 

Se você não é familiar com o github, não se preocupe! Os pacotes disponibilizados na plataforma geralmente têm um `README` cuja primeira instrução é sobre a instalação. Se não tiver, provavelmente este pacote não te merece! =)

### Via arquivo .zip ou .tar.gz

Se você precisar instalar um pacote que está zipado no seu computador (ou em algum servidor), utilize o seguinte comando:


```r
install.packages("C:/caminho/para/o/arquivo/zipado/nome-do-pacote.zip", repos = NULL)
```

É semelhante a instalar pacotes via CRAN, com a diferença que agora o nome do pacote é o caminho inteiro até o arquivo. O parâmetro `repos = NULL` informa que estamos instalando a partir da máquina local.

A aba ***Packages*** do RStudio também ajuda a administrar os seus pacotes.

## Tidyverse

Muitas pessoas tentam definir *o que é* ciência de dados no mercado e na academia. O problema é que esse termo pode ser descrito de várias formas distintas, seja pela formação específica da pessoa que define ou do interlocutor ao qual ela se comunica. Por isso, a definição de ciência de dados é, de certa forma, vazia.

No entanto, é possível definir *como se faz* ciência de dados. Ou seja, independentemente da definição do termo, o que temos de fazer na prática em projetos reais é algo bastante conhecido.

O "como faz" é definido através do *Ciclo da Ciência de Dados*, descrito na Figura \@ref(fig:04-ciclo). Primeiro, os dados brutos são coletados de fontes públicas, como arquivos Excel, portais de dados abertos ou bases de dados internos da companhia. Em seguida, os dados são arrumados, para mitigar problemas de padronização de nomes, obtenção das variáveis de interesse e exclusão de casos que estão fora do escopo de análise, produzindo o que se define como base de dados analítica. A base analítica é então transformada para produzir as tabelas e gráficos e, quando necessário, são utilizadas como insumo para o ajuste de modelos estatísticos. Finalmente, os resultados obtidos são comunicados através de uma série de ferramentas, como relatórios, dashboards interativos, indicadores ou Application Programming Interfaces (API) para automação. 

<div class="figure" style="text-align: center">
<img src="https://raw.githubusercontent.com/curso-r/livro-material/master/assets/img/manipulacao/ciclo-ciencia-de-dados.png" alt="O Ciclo da Ciência de Dados."  />
<p class="caption">(\#fig:04-ciclo)O Ciclo da Ciência de Dados.</p>
</div>


O `{tidyverse}` é um pacote guarda-chuva que consolida uma série de ferramentas que fazem parte o ciclo da ciência de dados. Fazem parte do `{tidyverse}` os pacotes `{ggplot2}`, `{dplyr}`, `{tidyr}`, `{purrr}`, `{readr}`, entre muitos outros, como é possível observar na Figura \@ref(fig:04-ciclo-pacotes). Veremos as características principais desses pacotes nas próximas Seções.

<div class="figure" style="text-align: center">
<img src="https://raw.githubusercontent.com/curso-r/livro-material/master/assets/img/pacotes/ciclo-ciencia-de-dados-pacotes.png" alt="A implementação do Ciclo da Ciência de Dados, através do tidyverse. Pela definição estrita do tidyverse, na imagem não fazem parte do tidyverse os pacotes janitor, data.table e os pacotes descritos nas partes de modelagem, comunicação e automatização. No entanto, a maioria desses pacotes também seguem os princípios tidy e podem ser usados em conjunto com o tidyverse sem grandes dificuldades."  />
<p class="caption">(\#fig:04-ciclo-pacotes)A implementação do Ciclo da Ciência de Dados, através do tidyverse. Pela definição estrita do tidyverse, na imagem não fazem parte do tidyverse os pacotes janitor, data.table e os pacotes descritos nas partes de modelagem, comunicação e automatização. No entanto, a maioria desses pacotes também seguem os princípios tidy e podem ser usados em conjunto com o tidyverse sem grandes dificuldades.</p>
</div>

<br>

O `{tidyverse}` traz consigo o [*manifesto tidy*](https://cran.r-project.org/web/packages/tidyverse/vignettes/manifesto.html). Trata-se de um documento que formaliza uma série de princípios que norteiam o desenvolvimento do tidyverse. Como os pacotes do `{tidyverse}` compartilham os mesmos princípios, podem ser utilizados naturalmente em conjunto.

Pode-se dizer que existe uma linguagem R antes e outra depois do `{tidyverse}`. A linguagem mudou muito, a comunidade abraçou uso desses princípios e criou centenas de novos pacotes que conversam uns com os outros dessa forma.[^messy]

[^messy]: Usar a filosofia tidy não é a única forma de fazer pacotes do R. Existem muitos pacotes excelentes que não utilizam essa filosofia. O próprio manifesto diz "O contrário de tidyverse não é o messyverse, e sim muitos outros universos de pacotes interconectados."

Os princípios fundamentais do tidyverse são:

1. Reutilizar estruturas de dados existentes.
1. Organizar funções simples usando o *pipe* (Seção \@ref(pipe)).
1. Aderir à programação funcional (Seção \@ref(funcionais)).
1. Projetado para ser usado por seres humanos.

No texto do [manifesto tidy](https://cran.r-project.org/web/packages/tidyverse/vignettes/manifesto.html) cada um dos lemas é descrito de forma detalhada. No [nosso blog](https://www.curso-r.com/blog/2017-02-16-manifesto-tidy/), selecionamos os aspectos que achamos mais importante de cada um deles.

<img src="https://github.com/curso-r/livro-material/blob/master/assets/img/pacotes/tidyverse_celestial.png?raw=true" width="500" height="500" style="display: block; margin: auto;" />

Na prática, carregar o  (veja o código abaixo) é o mesmo que carregar os seguintes pacotes:

- `{tibble}` para *data frames* repaginados; 

- `{readr}` para importarmos bases para o R;

- `{tidyr}` e `{dplyr}` para arrumação e manipulação de dados;

- `{stringr}` para trabalharmos com textos;

- `{forcats}` para trabalharmos com fatores;

- `{ggplot2}` para gráficos;

- `{purrr}` para programação funcional.

Embora o `{tidyverse}` instale diversos outros pacotes, apenas esses são carrregados. Dificilmente fazemos uma análise de dados em que não precisamos usá-los. Falaremos com mais detalhes de todos eles neste livro.


```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
## ✓ tibble  3.1.0     ✓ dplyr   1.0.5
## ✓ tidyr   1.1.3     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

Mensagens de conflito quando carregamos o `{tidyverse}` ou qualquer outro pacote significam que funções anteriormente carregadas foram *mascaradas* por novas funções. No exemplo acima, as funções `filter()` e `lag()` do pacote `stats` foram substituídas na sessão pelas funções `filter()` e `lag()` do pacote `dplyr`. Nesse caso, se quiséssemos usar as funções do pacote `stats` após carregar o `{tidyverse}`, precisaríamos rodar `stats::filter()` e `stats::lag()`.

Se você quiser *descarregar* um pacote, reinicie a sua sessão em `Session > Restart R` ou use a função `detach()` como no exemplo abaixo.


```r
detach("package:tidyverse", unload = TRUE)
```

