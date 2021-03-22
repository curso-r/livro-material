## Extensões do pacote ggplot2

O site [ggplot2 extensions](https://exts.ggplot2.tidyverse.org/) tem uma galeria com diversos pacotes que deixam o ggplot2 bem mais poderoso, indo de novos geoms até animações.



A seguir, listamos algumas das mais famosas.

### gghighlight

O [`gghighlight`](https://yutannihilation.github.io/gghighlight/) é uma  extensões do `{ggplot2}` que serve para realçar partes de um gráfico feito com `ggplot`. 

A seguir, mostramos como utilizar essa extensão pare realçar gráficos de pontos e linhas.

#### Realçando pontos {-}

Muitas vezes temos um gráfico de dispersão em que queremos realçar alguns pontos de acordo com alguma característica. Por exemplo, abaixo estamos realçando os pontos que possuem `carat > 4`, além disso colocamos uma label em cada um.


```r
diamonds %>% 
  ggplot(aes(x = carat, y = price)) +
  geom_point() +
  gghighlight::gghighlight(carat > 4, label_key = carat)
```

<img src="082-extensoes-ggplot2_files/figure-html/unnamed-chunk-2-1.png" width="672" />

Também é possível configurar a cor dos pontos que serão realçados e dos que não serão, bem como o estilo das labels.


```r
diamonds %>% 
  ggplot(aes(x = carat, y = price)) +
  geom_point(color = "red") +
  gghighlight::gghighlight(
    carat > 4, 
    label_key = carat,
    unhighlighted_params = list(colour = "black"),
    label_params = list(size = 10, fill = "grey")
  )
```

<img src="082-extensoes-ggplot2_files/figure-html/unnamed-chunk-3-1.png" width="672" />

#### Realçando linhas {-}

Com o `{gghighlight}` também é possível realçar linhas em um gráfico que possui varias linhas. Isso é interessante quando você quer ver como uma série temporal se compara com relação à um conjunto de outras séries.

No gráfico a seguir mostramos o número de downloads de cada um dos pacotes do tidyverse no ano de 2019. Uma das séries se destaca por mudar de padrão no meio do ano. Usamos o `{gghighlight}` para destacá-la no gráfico.


```r
tab <- cranlogs::cran_downloads(
  packages = tidyverse::tidyverse_deps()$package,
  from = "2019-01-01", to = "2019-12-31"
)

tab %>% 
  ggplot(aes(x = date, y = count, group = package)) +
  geom_line() +
  gghighlight::gghighlight(max(count) > 100000, label_key = package)
```

<img src="082-extensoes-ggplot2_files/figure-html/unnamed-chunk-4-1.png" width="672" />

Para mais informações sobre o `{gghighlight}`, recomendamos a leitura da [excelente documentação oficial](https://yutannihilation.github.io/gghighlight/index.html).


### ggridges

A extensão `{ggridges}` é uma ótima alternativa para histogramas e boxplots, quando queremos comparar a distribuição de uma variável A em vários níveis de uma variável B.

Primeiro, instale o pacote.


```r
install.packages("ggridges")
```

No gráfico abaixo, comparamos a distribuição da receita dos filmes em cada um dos anos de 2005 a 2016. Para isso, utilizamos o novo `geom_density_ridges()`, disponibilizado pelo pacote `{ggridges}`.


```r
library(ggridges)
imdb %>%
  filter(ano > 2005) %>% 
  mutate(ano = as.factor(ano)) %>% 
  ggplot(aes(y = ano, x = receita, fill = ano)) +
  geom_density_ridges(na.rm = TRUE, show.legend = FALSE)
```

```
## Picking joint bandwidth of 17300000
```

<img src="082-extensoes-ggplot2_files/figure-html/unnamed-chunk-6-1.png" width="672" />

Você pode baixar a base IMDB utilizada [clicando aqui](https://github.com/curso-r/livro-material/raw/master/assets/data/imdb.rds).
