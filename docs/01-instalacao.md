# Instalação {#instalacao}

Nesta seção, abordaremos como instalar o R e o RStudio no Linux e no Windows. Também discutiremos sobre a instalação de pacotes no R.

## Instalação do R

A instalação padrão do R é feita a partir do CRAN, uma rede de servidores espalhada pelo mundo que armazena versões idênticas e atualizadas de códigos e documentações para o R. 

> Sempre que for instalar algo do CRAN, utilize o servidor (*mirror*) mais próximo de você.

### No Windows

Para instalar o R no Windows, siga os seguintes passos:

1. Acesse o CRAN: https://www.r-project.org/

2. No menu à esquerda, encontre a opção **Download** e clique em **CRAN**.

3. Escolha a opção de servidor (*mirror*) mais próxima de você. 

4. Clique na opção **base**.

5. Na nova página, clique em **Download R x.x.x for Windows*, sendo x.x.x o número da versão que será baixada. Se você teve algum problema com o download, tente escolher outro servidor no passo 3.

6. Feito o download, clique duas vezes no arquivo baixado e siga as instruções para instalação.

> Na etapa de escolher a pasta de destino da instalação, se você escolher um local que não esteja dentro da sua pasta de usuário, você precisará de acesso de administrador. Se escolher uma pasta dentro da sua paste de usuário, não precisará.

### No Linux

Como a instalação no Linux depende da distribuição utilizada e, em geral, pessoas que utilizam Linux são mais experientes, vamos informar apenas as coordenadas até as instruções/arquivos. Se você tiver alguma dificuldade durante o processo, por favor envie a sua dúvida para a nossa [comunidade](https://discourse.curso-r.com/). Faremos o possível para ajudar.

1. Acesse o CRAN: https://cran.r-project.org/

2. No menu à esquerda, encontre a opção **Download** e clique em **CRAN**.

3. Escolha a opção de servidor (*mirror*) mais próxima de você.

4. Clique em *Download R for Linux*.

5. Clique no link referente à distribuição que você utiliza.

6. Siga as instruções contidas na página para instalar o R. Se você teve algum problema com o download, tente escolher outro servidor no passo 3.

### No Mac

Para instalar o R no Mac, siga os seguintes passos:

1. Acesse o CRAN: https://www.r-project.org/

2. No menu à esquerda, encontre a opção **Download** e clique em **CRAN**.

3. Escolha a opção de servidor (*mirror*) mais próxima de você.

4. Na nova página, clique em **Download R for (Mac) OS X*.

5. Clique na versão do R que você quer baixar (geralmente queremos baixar a mais recente). O objetivo aqui é baixar um arquivo do tipo "R-x.x.x.pkg", sendo x.x.x o número da versão que vamos instalar. Se você teve algum problema com o download, tente escolher outro servidor no passo 3.

6. Feito o download, clique duas vezes no arquivo baixado e siga as instruções para instalação.



## Instalação do RStudio

Agora vamos instalar a versão *open source* do RStudio, a IDE que utilizaremos para escrever e executar códigos em R. 

Para instalar o RStudio no Windows, siga os seguintes passos:

1. Acesse a página de downloads da RStudio: https://rstudio.com/products/rstudio/download/#download

- Se você tiver acesso administrador, baixe a versão referente ao seu sistema operacional que está na lista de *All Installers*.

- Se você não tiver acesso de administrador, baixe a versão referente ao seu sistema operacional que está na lista de *Zip/Tarballs*.

#### Instalando se você for administrador {-}

2. Clique duas vezes no arquivo que você baixou da página do RStudio e siga as instruções de instalação.

#### Instalação se você não for administrador {-}

2. Descompacte o arquivo baixado no passo anterior. Geralmente isso pode ser feito clicando no arquivo compactado com o botão direito do mouse e clicando na opção *descompactar* ou *extrair*.

3. Após a descompactação ter sido finalizada, você terá uma pasta chamada: `RStudio-x.x.x`, em que x.x.x é o número da versão baixada. Abra essa pasta e entre na subpasta com nome `bin`. 

4. Procure pelo arquivo chamado `rstudio` e clique duas vezes. Isso abrirá o RStudio. Recomendamos fixar o programa na barra de tarefas para não precisar repetir essa etapa sempre que for abrir o programa.

**Observação**: se você excluir a pasta que extraímos, o RStudio irá parar de funcionar.


## Instalação de softwares adicionais

### LaTeX

O $\LaTeX$ é um software para renderização de documentos PDF e também uma linguagem de programação. É bastante usada na academia para produção de artigos científicos. 

No R, o LaTeX aparece quando queremos gerar relatórios e apresentações em PDF, a partir de um documento RMarkdown. Na prática, o RMarkdown é transformado para LaTeX através do software [*Pandoc*](https://pandoc.org)[^pandoc], que por sua vez é processado para gerar o PDF. Portanto, para gerar um relatório em PDF através do RMarkdown, precisamos ter alguma ferramenta de LaTeX instalada.

[^pandoc]: O Pandoc já vem dentro do próprio RStudio, então não é necessário instalar este *software*.

#### No Windows

(em construção)

#### No Linux

No linux, a forma mais direta de garantir que temos o LaTeX na máquina com todas as dependências é instalando o `texlive-full`. No Ubuntu, basta rodar

    sudo apt install texlive-full

> **Importante**: o texlive-full é uma fora "bruta" de instalar tudo do LaTeX, e pode ocupar mais do que 5GB do seu disco! Então tome cuidado e procure alternativas, como as descritas [neste site](https://linuxconfig.org/how-to-install-latex-on-ubuntu-18-04-bionic-beaver-linux).

#### No Mac

(em construção)

### Office

No R, os arquivos do pacote office também são gerados a partir do Pandoc. Por isso, não é necessário instalar nenhum software adicional para gerar os documentos.

No entanto, para abrir documentos do Office, como `.pptx` e `.docx`, é necessário ter o Office ou alguma alternativa aberta instalados.

Além disso, por conta das particularidades desses tipos de documentos, muitas vezes é necessário instalar pacotes adicionais, que não vêm com o `{rmarkdown}`. Abaixo, segue uma lista de pacotes usualmente utilizados nesse contexto:

- `{officedown}`.
- `{officer}`, que é uma dependência do `{officedown}`.
- `{flextable}`, para geração de tabelas.
- `{svglite}`, para renderizar gráficos em SVG.

> Uma dica adicional: É possível gerar gráficos *editáveis* nos documentos Office! Dessa forma, você pode gerar o relatório bruto e depois editar manualmente. Para isso, siga o tutorial deste [vídeo do YouTube](https://www.youtube.com/watch?v=Yprmq8AUf8g). Referência: [link](http://www.sthda.com/english/wiki/saving-high-resolution-ggplots-how-to-preserve-semi-transparency) (Thanks to @AugustoCL_)

#### No Windows

(em construção)

#### No Linux

No linux, a forma mais fácil de abrir documentos provenientes do Office é utilizando o LibreOffice:

    sudo apt install libreoffice

> O LibreOffice possui algumas limitações quando comparado ao software da Microsoft. Por exemplo, as tabelas que saem bonitas no Office podem ficar desformatadas no LibreOffice.

> o LibreOffice 7.1 nao está ainda no aptitude. Se quiser instalar essa versão, é possível baixar o arquivo `.deb` no [site da ferramenta](https://www.libreoffice.org). (Thanks to @pouchewar)

#### No Mac

(em construção)

### Pagedown e Chrome

O `{pagedown}` é uma alternativa recente para produzir arquivos em HTML utilizando o [`paged.js`](), uma biblioteca em JavaScript que torna um arquivo HTML muito parecido com um PDF. Com a ajuda do Chrome, é possível, inclusive, exportar o arquivo para PDF.

O `{pagedown}`, portanto, apresenta o melhor de dois mundos: a praticidade da extensão HTML e a portabilidade de arquivos PDF. Dessa forma, é possível gerar documentos PDF com formatos agradáveis sem depender do LaTeX.

No entanto, para gerar documentos PDF, é preciso utilizar um navegador. O navegador recomendado pelo `{pagedown}` é o Chrome, tanto que o pacote já vem com a função `pagedown::chrome_print()`, que pode ser utilizada para transformar um arquivo HTML ou RMarkdown em PDF.

> Se você já tiver o Chrome instalado na sua máquina, provavelmente tudo funcionará sem problemas. Se não tiver e não quiser instalar, é possível instalar somente o [headless Chrome](https://developers.google.com/web/updates/2017/04/headless-chrome).

> No linux, uma alternativa é instalar o projeto Chromium, que é quase que totalmente open source.

### Renderizando HTML widgets

Os HTML widgets são formas de ligar bibliotecas do JavaScript com pacotes do R. Isso permite gerar relatórios dinâmicos em HTML diretamente do R. O pacote `{htmlwidgets}` possui um conjunto de melhores práticas para criação dessas soluções.

No entanto, é comum utilizar HTML widgets em relatórios estáticos. Para isso, o R precisa de uma estratégia para tirar fotos estáticas dos widgets. Isso é realizado através do pacote `{webshot}`.

Você pode instalar o `{webshot}` rodando

    install.packages("webshot")

Para que o `{webshot}` funcione, no entanto, também é necessário ter o PhantomJS instalado na máquina. O PhantomJS é basicamente um navegador que roda totalmente no plano de fundo, possibilitando a captura de tela.

Para instalar o PhantomJS, rode

```r
webshot::install_phantomjs()
```

### Blogdown

Para criar blogs utilizando o pacote `{blogdown}`, também é necessário instalar o Hugo, programa que renderiza sites estáticos.

Felizmente, essa tarefa é bem tranquila pois o `{blogdown}` já vem com um helper para isso. Basta rodar

```r
blogdown::install_hugo()
```

e reiniciar sua sessão que está tudo certo!
