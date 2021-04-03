## Caminhos

Um passo importante na tarefa de importação de dados para o R é saber onde está o arquivo que queremos importar. Toda função de importação vai exigir um **caminho**, uma string que representa o endereço do arquivo no computador.

Há duas formas de passarmos o caminho de arquivo: usar o **caminho absoluto** ou usar o **caminho relativo**.

Antes de falarmos sobre a diferença dos dois, precisamos definir o que é o **diretório de trabalho**.

O diretório de trabalho (*working directory*) nada mais é do que a pasta em que o R vai procurar arquivos na hora de ler informações ou gravar arquivos na hora de salvar objetos.

Se você está usando um projeto, o diretório de trabalho da sua sessão será, por padrão, a pasta raiz do seu projeto (é a pasta que contém o arquivo com extensão `.Rproj`). Se você não estiver usando um projeto ou simplesmente não souber qual é o seu diretório de trabalho, você pode descobri-lo usando a seguinte função `getwd()`. Ela vai devolver uma string com o caminho do seu diretório de trabalho.

A função `setwd()` pode ser utilizada para mudar o diretório de trabalho. Como argumento, ela recebe o caminho para o novo diretório.

Caminhos absolutos são aqueles que tem início na pasta raiz do seu computador/usuário. Por exemplo:


```r
getwd()
```

```
## [1] "/Users/william/Documents/curso-r/livro-material"
```

Esse é o caminho absoluto para a pasta onde esse livro foi produzido.

Na grande maioria dos casos, caminhos absolutos são uma **má prática**, pois deixam o código irreprodutível. Se você trocar de computador ou passar o script para outra pessoa rodar, o código não vai funcionar, pois o caminho absoluto para o arquivo muito provavelmente será diferente.

Caminhos relativos são aqueles que tem início no diretório de trabalho da sua sessão. Assim, se você quiser acessar um arquivo `minha_base.csv` dentro de uma pasta "dados" existente no seu diretório de trabalho, você poderia passar para o R o caminho `"dados/minha_base.csv"`. 

**Trabalhar com projetos no RStudio ajuda bastante o uso de caminhos relativos**, pois nos incentiva a colocar todos os arquivos da análise dentro da pasta do projeto. Assim, se você usar apenas caminhos relativos e compartilhar a pasta do projeto com alguém, todos os caminhos existentes nos códigos continuarão a funcionar em qualquer computador!
