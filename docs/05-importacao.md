# Importação {#importacao}

Nesta seção, vamos introduzir os principais pacotes para importar dados para o R. Mostraremos como importar dados de arquivos de texto,  planilhas do excel e extensões de outros programas estatísticos (SAS e SPSS, por exemplo).

Antes de começarmos, vale a pena destacarmos um ponto importante. As funções de importação do `tidyverse` importam dados em objetos da classe `tibble`, que difere da classe `data.frame` usual em dois pontos importantes:

- imprime os dados na tela (Console) de maneira muito mais organizada, resumida e legível;

- permite a utilização de *list-columns*.

Se você não estiver familiarizado com o conceito de *list-columns*, não se preocupe. Trataremos melhor do assunto no Capítulo \@ref(funcionais).
