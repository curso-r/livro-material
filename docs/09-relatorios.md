# Relatórios {#relatorios}

Depois de fazer toda a nossa análise dentro do R, não é justamente na hora de mostrá-la ao mundo que vamos abandonar as vantagens de estarmos dentro de uma linguagem de programação.

Com a ajuda do R Markdown, uma interface de anotações que combina texto livre com códigos em R, podemos construir relatórios não só reprodutíveis, mas elegantemente bem formatados, sem sair do R!

<div class="figure" style="text-align: center">
<img src="https://raw.githubusercontent.com/allisonhorst/stats-illustrations/master/rstats-artwork/rmarkdown_wizards.png" alt="Ilustração por &lt;a href='https://github.com/allisonhorst/stats-illustrations'&gt;Allison Horst&lt;/a&gt;." width="80%" />
<p class="caption">(\#fig:unnamed-chunk-1)Ilustração por <a href='https://github.com/allisonhorst/stats-illustrations'>Allison Horst</a>.</p>
</div>

<!-- - Falar  sobre os pacotes que usamos com Rmarkdown   -->

Além do próprio `{rmarkdown}`, existem diversos pacotes que podem ser utilizados para ampliar os produtos que elaboramos com R Markdown. Podemos criar/escrever:

- blogs e sites —  [blogdown](https://bookdown.org/yihui/blogdown/) e [distill](https://rstudio.github.io/distill/); 

- livros (como este!) — [bookdown](https://bookdown.org/);

- apresentações — [xaringan](https://github.com/yihui/xaringan);

-  currículos, cartas e trabalhos acadêmicos —  [pagedown](https://github.com/rstudio/pagedown);

- tutoriais interativos —  [learnr](https://rstudio.github.io/learnr/);

- artigos científicos —  [rticles](https://github.com/rstudio/rticles).

Antes de mais nada, vamos instalar os pacotes `{rmarkdown}` e `{knitr}`. O primeiro reune todas as funcionalidades para juntar nossos textos narrativos e códigos de R. O segundo vai fazer a *magia* de transformar nossos simples arquivos de texto em arquivos HTML, PDF e Word (`.doc`) bonitões.


```r
install.packages(c("rmarkdown", "knitr"))
```

Nas seções a seguir, vamos mostrar como começar a utilizar o R Markdown para criar esses documentos. Não se esqueça de conferir (e deixar por perto) as folhas de cola sobre R Markdown:

  - [`rmarkdown` cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
  
  - [`rmarkdown` cheatsheet 2.0](http://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf)
  

  
