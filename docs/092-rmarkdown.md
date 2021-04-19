## R Markdown

O R Markdown é a junção da linguagem Markdown com o poder de códigos em R. A mágica aconte em arquivos do tipo `.Rmd`, onde é possível adicionar textos, códigos, resultados de códigos e muito mais!

Nesta seção, utilizaremos como exemplos alguns códigos envolvendo a base de dados de pinguins. A versão original deste dataset (em Inglês) está disponível no pacote [palmerpenguins](https://github.com/allisonhorst/palmerpenguins), e a versão traduzida para Português está disponível no pacote [dados](https://cienciadedatos.github.io/dados/).

<div class="figure" style="text-align: center">
<img src="https://github.com/allisonhorst/palmerpenguins/blob/master/man/figures/lter_penguins.png?raw=true" alt="Conheça os Pinguins do dataset PalmerPenguins! Ilustração por &lt;a href='https://github.com/allisonhorst/stats-illustrations'&gt;Allison Horst&lt;/a&gt;." width="80%" />
<p class="caption">(\#fig:unnamed-chunk-1)Conheça os Pinguins do dataset PalmerPenguins! Ilustração por <a href='https://github.com/allisonhorst/stats-illustrations'>Allison Horst</a>.</p>
</div>

Caso não tenha o pacote [dados](https://cienciadedatos.github.io/dados/) instalado, é possível instalar com o seguinte código:


```r
install.packages("remotes")
remotes::install_github("cienciadedatos/dados")
```


Agora carregue os pacotes necessários:


```r
library(dados)  # Pacote com bases de dados em Português
library(magrittr)  # Pacote para utilizar o Pipe %>%
```

### Códigos em R

Ao analisar dados, escrevemos códigos que calculam estatísticas descritivas, geram gráficos e tabelas, entre outros.
Para adicionar esses resultados nos relatórios, não é muito prático adicionar manualmente o resultado final (copiando e colando, por exemplo), pois em caso de alguma mudança na base de dados, será necessário gerar novamente estes resultados e adicioná-los novamente!

<!--# Acho que esse trecho abaixo pode ser aprimorado. tem algumas palavras que repetem bastante! -->

Com RMarkdown, podemos adicionar códigos nos nossos relatórios que geram os resultados, assim a cada vez que compilarmos o relatório os códigos que geram estes resultados serão executados, e o relatório terá sempre os resultados atualizados.

Caso você queira que o código seja executado como código R, existem duas possibilidades:


-   **chunks de código** ou **campos de código** ( _chunks_ em Inglês), quando o código é executado em um campo de código em R.


-   **código em linha** (ou '*inline code*' em Inglês), quando o resultado aparece junto ao texto;

#### Campos de código (chunks) {-}

É possível adicionar campos de código utilizando a seguinte sintaxe:

````md
```{r}
codigo em R aqui
```
````

Um exemplo de campo de código é o campo abaixo, onde é possível executar o código e visualizar o resultado.

**Exemplo:**

````md
```{r}
# calcula a média
media_massa_g <-
  mean(pinguins$massa_corporal, na.rm = TRUE) 

# converte de gramas para kilogramas
media_massa_kg_completo <-
  media_massa_g / 1000 

# arredonda o valor para ter uma casa decimal
media_massa_kg <- round(media_massa_kg_completo, 1)

# exibe o resultado
media_massa_kg 
```
````

**Resultado:**


```r
# calcula a média
media_massa_g <-
  mean(pinguins$massa_corporal, na.rm = TRUE) 

# converte de gramas para kilogramas
media_massa_kg_completo <-
  media_massa_g / 1000 

# arredonda o valor para ter uma casa decimal
media_massa_kg <- round(media_massa_kg_completo, 1)

# exibe o resultado
media_massa_kg 
```

```
## [1] 4.2
```

Veja que no resultado obtivemos o código em R e também o resultado deste código. Dependendo do público alvo do relatório, não queremos mostrar códigos. É possível escondê-los (e fazer muito mais!) alterando as opções de chunks (ou _chunk options_ em Inglês). Veremos mais sobre isso posteriormente!

#### Inline code  {-}

Para que um resultado de código apareça ao longo do texto, é possivel usar a seguinte estrutura: `` `r ` `` .

**Exemplo:**

````md
A média da massa corporal dos pinguins é `r media_massa_kg` kg.

````



**Resultado:**

> A média da massa corporal dos pinguins é 4.2 kg.



### Imagens

Na seção anterior (sobre [Markdown](#markdown)), mostramos como é possóvel adicionar uma imagem em um relatório utilizando Markdown.

Porém, quando utilizamos arquivos RMarkdown também podemos adicionar imagens usando código em R, com a função `include_graphics` do pacote `knitr`.

Usando o  `knitr` é possível personalizar de forma mais intuitiva como a imagem aparecerá no arquivo final: você pode adicionar uma imagem utilizando como primeiro argumento a url da imagem ou o caminho onde ela está no projeto. Além disso, com as opções de chunks (ou _chunk options_ em Inglês), poderemos personalizar diversos atributos da imagem, como: legenda, tamanho, alinhamento, entre outros.

Veja o exemplo abaixo:


```r
knitr::include_graphics("https://cienciadedatos.github.io/dados/reference/figures/dados-hex.png")
```

<img src="https://cienciadedatos.github.io/dados/reference/figures/dados-hex.png" width="30%" style="display: block; margin: auto;" />

### Tabelas

Na seção anterior (sobre [Markdown](#markdown)), foi apresentado como adicionar uma tabela utilizando Markdown.

Porém quando utilizamos arquivos R Markdown também é possível adicionar tabelas que resultam de códigos em R. 

Existem algumas funções diferentes para fazer isso. Para apresentar alguns exemplos, primeiramente vamos salvar uma versão  da base pinguins:


```r
media_massa <- pinguins %>% # usamos a base de pinguins
  # agrupamos por especies e ilhas
  dplyr::group_by(especies, ilha) %>%  
  # calculamos a média da massa corporal 
  dplyr::summarise(media_massa = mean(massa_corporal, na.rm = TRUE)) %>% 
  # criamos uma nova coluna, com a massa em kg, e arredondada com 2 casas decimais
  dplyr::mutate(media_massa_kg = round(media_massa / 1000, 2)) %>%  
  # removemos a coluna da massa em gramas
  dplyr::select(-media_massa)

# Apresentamos o resultado da tabela:
media_massa
```

```
## # A tibble: 5 x 3
## # Groups:   especies [3]
##   especies            ilha      media_massa_kg
##   <fct>               <fct>              <dbl>
## 1 Pinguim-de-adélia   Biscoe              3.71
## 2 Pinguim-de-adélia   Dream               3.69
## 3 Pinguim-de-adélia   Torgersen           3.71
## 4 Pinguim-de-barbicha Dream               3.73
## 5 Pinguim-gentoo      Biscoe              5.08
```


Acima, a tabela é apresentada como ela é escrita no console do R. Porém essa forma não é elegante de ser apresentada em um relatório! Podemos utilizar funções de diferentes pacotes para que as tabelas fiquem formatadas de uma forma mais atraente:

- Utilizando o pacote `knitr`: função `kable()`


```r
media_massa %>%
  knitr::kable()
```



|especies            |ilha      | media_massa_kg|
|:-------------------|:---------|--------------:|
|Pinguim-de-adélia   |Biscoe    |           3.71|
|Pinguim-de-adélia   |Dream     |           3.69|
|Pinguim-de-adélia   |Torgersen |           3.71|
|Pinguim-de-barbicha |Dream     |           3.73|
|Pinguim-gentoo      |Biscoe    |           5.08|



-  Utilizando o pacote `DT`: função `datatable()`


```r
media_massa %>%
  DT::datatable()
```

<!--html_preserve--><div id="htmlwidget-27c256049e67ff8e5a45" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-27c256049e67ff8e5a45">{"x":{"filter":"none","data":[["1","2","3","4","5"],["Pinguim-de-adélia","Pinguim-de-adélia","Pinguim-de-adélia","Pinguim-de-barbicha","Pinguim-gentoo"],["Biscoe","Dream","Torgersen","Dream","Biscoe"],[3.71,3.69,3.71,3.73,5.08]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>especies<\/th>\n      <th>ilha<\/th>\n      <th>media_massa_kg<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":3},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

Os exemplos anteriores são as formas mais simples de apresentar as tabelas, porém cada pacote possibilita diferentes personalizações (por exemplo, alterar o nome das colunas, etc). Existem outros pacotes que permitem adicionar tabela nos relatórios em RMarkdown, como por exemplo:

  - [reactable](https://glin.github.io/reactable/index.html) 
  
  - [flextable](https://davidgohel.github.io/flextable/articles/overview.html)
  
  - [kableExtra](https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html) 
  
  <!-- Quais mais? -->

### Dicas para o RStudio

A versão mais recente do RStudio possui uma ferramenta de edição de Markdown visual, que disponibiliza botões para editar o texto com Markdown.

Veja mais [neste post no blog da RStudio](https://blog.rstudio.com/2020/09/30/rstudio-v1-4-preview-visual-markdown-editing/), e também a animação disponível neste post:

<div class="figure" style="text-align: center">
<img src="https://blog.rstudio.com/2020/09/30/rstudio-v1-4-preview-visual-markdown-editing/images/visualmode-demo.gif" alt="Demonstração do RStudio versão 1.4" width="80%" />
<p class="caption">(\#fig:unnamed-chunk-6)Demonstração do RStudio versão 1.4</p>
</div>

### Exercícios {- #exercicios-rmd}

**1.** Leia o [guia de referência do RMarkdown](https://rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf) até o final.

**2.** Qual o propósito do YAML do documento?

**3.** Quais são as opções e resultados do parâmetro `results=`?

````md
```{r results='markup'}
knitr::kable(head(cars))
```
````


