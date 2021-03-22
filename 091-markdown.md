## Markdown {#markdown}
 
Se você é uma pessoa que utiliza R, sabe das possibilidades de utilizar R Markdown (e os pacotes que expandem mais ainda as possibilidades) e gostaria de começar a utilizá-lo, é importante conhecer o Markdown. Por quê? O R Markdown tem como base a linguagem de marcação [Markdown](https://www.markdownguide.org/). 

Os arquivos markdown podem ser abertos por qualquer software que suporte este formato aberto. Além disso, independente da plataforma de trabalho, pode-se migrar para um arquivo de texto sem perder a formatação. O Markdown também é usado em outros lugares, como no [GitHub](https://github.com/) e no [Fórum da Curso-R](https://discourse.curso-r.com).

Uma referência interessante para ter sempre em mãos é a Folha de cola (*Cheatsheet*) do [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

Nas seções seguintes, descreveremos como podemos marcar os nossos textos e códigos usando `markdown`, e você poderá usar isso tanto em arquivos `.Rmd`, quanto em outros lugares que também utilizam essa marcação (como no [Fórum da Curso-R](https://discourse.curso-r.com)!).


### Ênfase

#### Negrito {-}

Para destacar um texto em negrito, coloque `**` ou `__` ao redor do texto.

Por exemplo:

|  Como é escrito no código |  Como aparece no relatório |
|--:|--:|
|`Esse é um texto com uma palavra destacada em **negrito**.`|  Esse é um texto com uma palavra destacada em **negrito**.| 
|`Esse é um texto com uma palavra destacada em __negrito__.`|  Esse é um texto com uma palavra destacada em **negrito**.| 




#### Itálico {-}

Para destacar um texto em itálico, coloque `*` ou `_` ao redor do texto.

Por exemplo:

|  Como é escrito no código |  Como aparece no relatório |
|--:|--:|
|`Esse é um texto com uma palavra destacada em *itálico*.`|  Esse é um texto com uma palavra destacada em *itálico*.| 
|`Esse é um texto com uma palavra destacada em _itálico_.`|  Esse é um texto com uma palavra destacada em *itálico*.| 

#### Riscado (ou tachado) {-}

Para riscar/tachar um texto, coloque `~~` ao redor do texto.

Por exemplo:

Esse é um texto com uma palavra ~~riscada/tachada~~.

|  Como é escrito no código |  Como aparece no relatório |
|--:|--:|
|`Esse é um texto com uma palavra ~~riscada/tachada~~.`| Esse é um texto com uma palavra ~~riscada/tachada~~.| 


### Títulos

Os títulos funcionam como uma hierarquia, e para criar um título é necessário colocar um `#` no início da linha. Então um `#` marca um título, `##` marca um sub-título, e assim sucessivamente. Veja os exemplos:


|  Como é escrito no código |  Como aparece no relatório |
|--:|--:|
| `# Título 1` <br> `## Título 2` <br> `### Título 3` |  ![](https://beatrizmilz.github.io/slidesR/markdown/images/titulos.png)<!-- -->| 


### Listas

#### Listas ordenadas {-}

Você pode fazer uma lista ordenada usando somente números. Você pode repetir o número quantas vezes quiser:




Como é escrito no código: 

> `1. Maçã`
> 
> `1. Banana`
> 
> `1. Uva`

Como aparece no relatório:


> 1. Maçã
> 1. Banana
> 1. Uva





#### Listas não ordenadas {-}

Você pode fazer uma lista não ordenada escrevendo com hífens ou asteriscos, como a seguir:


>
>
> `* Maçã`
>
> `* Banana`
>
> `* Uva`

>
>
> `- Maçã`
>
> `- Banana`
>
> `- Uva`

O resultado será:

>
> - Maçã
> - Banana
> - Uva

Você também pode adicionar sub-itens na lista indicando a hierarquia através da identação no Markdown (dica: utilize a tecla `tab` do teclado):

>
> - Frutas
>   - Maçã
>   - Banana
>   - Uva





### Equações

Você pode adicionar equações utilizando [LaTeX](https://pt.wikipedia.org/wiki/LaTeX).
Você pode saber mais na [página do Overleaf sobre expressões matemáticas](https://www.overleaf.com/learn/latex/mathematical_expressions).
Além disso, existem [geradores de equações online](https://www.codecogs.com/latex/eqneditor.php?latex=D) que ajudam a escrevâ-las em  LaTeX, HTML, entre outras linguagens de marcação.

É possível centralizar a equação envolvendo o código com `$$`. Veja o exemplo abaixo:


|  Como é escrito no código |  Como aparece no relatório |
|--:|--:|
|`$$y = \mu + \sum_{i=1}^p \beta_i x_i + \epsilon$$`| $$y = \mu + \sum_{i=1}^p \beta_i x_i + \epsilon$$ | 


Também é possível adicionar a equação na mesma linha que o texto, envolvendo o código com `$`. Veja o exemplo abaixo:


|  Como é escrito no código |  Como aparece no relatório |
|--:|--:|
|`Ou também na linha $y = \mu + \sum_{i=1}^p \beta_i x_i + \epsilon$ , junto ao texto!`| Ou também na linha $y = \mu + \sum_{i=1}^p \beta_i x_i + \epsilon$ , junto ao texto! | 

### Código

É possível __marcar textos para que fiquem formatados como códigos__, usando a crase: `

Mas atenção: o texto será __formatado como código__, porém não será executado!


|  Como é escrito no código |  Como aparece no relatório |
|--:|--:|
|`` `mean(pinguins$massa_corporal, na.rm = TRUE)` `` | `mean(pinguins$massa_corporal, na.rm = TRUE)` | 


Também é possível delimitar um trecho maior de código, utilizando três crases.

__Exemplo:__

__Como é escrito no código:__

````md
```
library(dados)
mean(pinguins$massa_corporal, na.rm = TRUE)
```
````


__Como aparece no relatório:__


```
library(dados)
mean(pinguins$massa_corporal, na.rm = TRUE)
```

### Links

- Você pode criar um link utilizando esta estrutura:

`[texto](http://url-da-pagina.com)`.

Por exemplo:

|  Como é escrito no código |  Como aparece no relatório |
|--:|--:|
|`Você pode consultar mais [materiais sobre R nesta página](https://curso-r.com/material/).`| Você pode consultar mais [materiais sobre R nesta página](https://curso-r.com/material/).| 



### Imagens

Você pode incluir uma imagem utilizando esta estrutura: 

`![descricao da imagem](http://url-da-imagem.com)`.

Não se esqueça: a descrição da imagem é importante para
acessibilidade do conteúdo através de leitores de tela!


|  Como é escrito no código |  Como aparece no relatório |
|--:|--:|
|`![Logo da Curso-R](https://raw.githubusercontent.com/curso-r/site-v2/master/static/img/logo_cursor_full.png)`| ![Logo da Curso-R](https://raw.githubusercontent.com/curso-r/site-v2/master/static/img/logo_cursor_full.png)| 


### Tabelas

As tabelas em Markdown têm uma estrutura definida, como mostra o exemplo abaixo.

É possível usar ferramentas online para gerar tabelas em Markdown, como por exemplo o [Tables Generator](https://www.tablesgenerator.com/markdown_tables).

__Em Markdown:__
```{}
|  a|  b|  c|
|--:|--:|--:|
|  1|  2|  3|
|  2|  3|  4|
```


__Resultado:__

>
>
> |  a|  b|  c|
> |--:|--:|--:|
> |  1|  2|  3|
> |  2|  3|  4|

### Recapitulando

Nesta seção, aprendemos que o Markdown é uma linguagem de marcação, usada para marcar textos. Podemos usar o Markdown para formatar textos e adicionar elementos no nossos relatórios.

Porém existem elementos (como código, imagens, tabelas, entre outros) que podemos também adiconar nos relatórios utilizando R. É isso que veremos na seção seguinte!
