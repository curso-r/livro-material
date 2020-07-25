# Instalação {#instalacao}

Nesta seção, abordaremos como instalar o R e o RStudio no Linux e no Windows. Também discutiremos sobre a instalação de pacotes no R.

## Instalação do R

A instalação padrão do R é feita a partir do CRAN, uma rede servidores espalhada pelo mundo que armazena versões idênticas e atualizadas de códigos e documentações para o R. 

> Sempre que for instalar algo do CRAN, utilize o servidor (*mirror*) mais próximo de você.

### No Windows

Para instalar o R no Windows, siga os seguintes passos:

1. Acesse o CRAN: https://cran.r-project.org/bin/windows/base/

2. Clique em "Download R x.x.x for Windows", sendo x.x.x o número da versão mais recente disponível.
  
3. Salve o arquivo em qualquer pasta do seu computador.

4. Clique no arquivo duas vezes com o botão esquerdo e siga as instruções para instalação.

> Na etapa de escolher a pasta de destino da instalação, se você escolher um local que não esteja dentro da sua pasta de usuário, você precisará de acesso de administrador. Se escolher uma pasta dentro da sua paste de usuário, não precisará.

Pronto! O R está instalado no seu computador!

### No Linux

Como a instalação no Linux depende da distribuição utilizada e, em geral, usuário de Linux são mais experientes, vamos informar apenas as coordenadas até as instruções/arquivos de instalação para cada distribuição. Se você tiver alguma dificuldade durante o processo, por favor envie a sua dúvida para a nossa [comunidade](https://discourse.curso-r.com/) ou para o e-mail duvidas@curso-r.com. Faremos o possível para ajudar.

1. Acesse o CRAN: https://cran.r-project.org/

2. Clique em *Download R for Linux*.

3. Clique no link referente à distribuição que você utiliza.

4. Siga as instruções contidas na página para instalar o R.

### No Mac

## Instalação do RStudio

Agora vamos instalar a versão *open source* do RStudio, a IDE que utilizaremos para escrever e executar códigos em R. 

### No Windows

Para instalar o RStudio no Windows, siga os seguintes passos:

1. Entre no site da Rstudio: https://rstudio.com

2. No topo da página, clique em [download](https://rstudio.com/products/rstudio/download/).

2a. Se você tiver acesso administrador, baixe a versão que está na lista de *All Installers*.

2b. Se você não tiver acesso de administrador, faça o download da versão
que está na lista *Zip/Tarballs*.

#### Instalando se você for administrador {-}

3. Clique duas vezes no arquivo que você baixou da página do RStudioe siga as instruções de instalação.

Pronto! O RStudio está pronto para ser utilizado.

#### Instalação se você não for administrador {-}

3. Clique com o botão direito no arquivo baixado e depois em *Extrair Tudo* conforme a imagem.

4. Após a descompactação do arquivo ter sido finalizada, você terá uma pasta chamada: `RStudio-x.x.x`, em que x.x.x é o número da versão baixada. Abra essa pasta e entre na subpasta com nome `bin`. 

5. Procure pelo arquivo chamado `rstudio` e clique duas vezes. Isso abrirá o RStudio. Recomendo fixar o programa na barra de tarefas para não precisar repetir essa etapa sempre que for abrir o programa.

**Observação**: se você excluir a pasta que extraímos, o RStudio irá parar de funcionar.

### No Linux

1. Entre no site da Rstudio: https://rstudio.com

2. No topo da página, clique em [download](https://rstudio.com/products/rstudio/download/).

2. Clique no link referente à distribuição que você utiliza para fazer o download do arquivo de instalação.

3. A depender da sua distribuição do Linux, instale o arquivo baixado.


### No Mac

