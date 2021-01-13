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



