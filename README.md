# cnpj_dados_rstudio
Criação de banco de dados em SQLite com os dados do CNPJ da Receita Federal do Brasil, feito em R Programming

A execução é feita de forma separada nos arquivos nomeados em sequência de execução. Foi feito desta maneira pois interpreto que um arquivão para rodar tudo atrapalha.

Os arquivos são:

 * 0 - install.R -> aqui estão os comandos para instalação das bibliotecas necessárias;
 * 1 - config.R -> aqui já estão configurados os diretórios padronizados tanto para download quanto para a desconpactação dos arquivos. Também separei em pastas distintas para que o usuário possa deletar ou não os arquivos zipados após a descompactação. Há também a criação da barra de progresso das tarefas.
 * 2 - download.R -> neste arquivo estão os comando exclusivamente utilizados para a leitura do link onde estão os arquivos da Receita Federal, propositalmente no html para exemplificar um básico de webscraping.
 * 3 - unzip.R -> neste arquivo há apenas o script usado para descompactar os arquivos já baixados.
 * 4 - database.R -> aqui há a criação do banco de dados em SQLite, a leitura dos arquivos descompactados para formação de data.frames, a criação das tabelas no banco de dados com características de cada conjunto de arquivos e o abastecimento de cada tabela com os dados dos referidos arquivos.
 * 5 - consultas.R há neste arquivo alguns exemplos de consultas no banco.
