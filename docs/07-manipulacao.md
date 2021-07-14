# Manipulação {#manipulacao}

Esta seção trata do tema *manipulação de dados*. Trata-se de uma tarefa dolorosa e demorada, tomando muitas vezes a maior parte do tempo de uma análise de dados. Apesar de negligenciada pela Estatística, essa etapa é essencial para o sucesso da análise.

> *The fact that data science exists as a field is a colossal failure of statistics. To me, what I do is what statistics is all about. It is gaining insight from data using modelling and visualization. Data munging and manipulation is hard and statistics has just said that’s not our domain.* --- Hadley Wickham

Usualmente, o cientista de dados parte de uma base "crua" e a transforma até obter uma base de dados analítica, que, a menos de transformações simples, está preparada para gerar tabelas e gráficos e alimentar modelos.

<div class="figure" style="text-align: center">
<img src="assets/img/manipulacao/ciclo-ciencia-de-dados.png" alt="Estamos na etapa de arrumação do ciclo da Ciência de Dados." width="958" />
<p class="caption">(\#fig:transform)Estamos na etapa de arrumação do ciclo da Ciência de Dados.</p>
</div>

Um conceito importante para obtenção de uma base analítica é o *data tidying*, ou arrumação de dados. Uma base é considerada *tidy* se

- 1. Cada linha da base representa uma observação.
- 2. Cada coluna da base representa uma variável.

A base de dados analítica é estruturada de tal forma que pode ser colocada diretamente em ambientes de modelagem estatística ou de visualização. Nem sempre uma base de dados analítica está no formato *tidy*, mas usualmente são necessários poucos passos para migrar de uma para outra. A filosofia *tidy* é a base do [tidyverse](https://www.tidyverse.org/).

Os principais pacotes encarregados da tarefa de estruturar os dados são o `dplyr` e o `tidyr`. Eles serão o tema desse capítulo. Instale e carregue os pacotes utilizando:


```r
install.packages(c("dplyr", "tidyr"))

library(dplyr)
library(tidyr)
```

Mas antes de apresentar as principais funções do `dplyr` e do `tidyr`, precisamos falar sobre o conceito de `tibbles`.
