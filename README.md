# Informações básicas
Criação de banco de dados em SQLite com os dados do CNPJ da Receita Federal do Brasil, feito em R Programming

A execução é feita de forma separada nos arquivos nomeados em sequência de execução. Foi feito desta maneira pois interpreto que um arquivão para rodar tudo atrapalha.

Os arquivos são:

 * 0 - install.R -> aqui estão os comandos para instalação das bibliotecas necessárias;
 * 1 - config.R -> aqui já estão configurados os diretórios padronizados tanto para download quanto para a desconpactação dos arquivos. Também separei em pastas distintas para que o usuário possa deletar ou não os arquivos zipados após a descompactação. Há também a criação da barra de progresso das tarefas;
 * 2 - download.R -> neste arquivo estão os comando exclusivamente utilizados para a leitura do link onde estão os arquivos da Receita Federal, propositalmente no html para exemplificar um básico de webscraping;
 * 3 - unzip.R -> neste arquivo há apenas o script usado para descompactar os arquivos já baixados;
 * 4 - database.R -> aqui há a criação do banco de dados em SQLite, a leitura dos arquivos descompactados para formação de data.frames, a criação das tabelas no banco de dados com características de cada conjunto de arquivos e o abastecimento de cada tabela com os dados dos referidos arquivos;
 * 5 - consultas.R há neste arquivo alguns exemplos de consultas no banco;

# Instruções

Instale o SQLite no seu computador antes de tudo. Para informações de dowload e instalação conte o site do projeto: https://www.sqlite.org/

Execute os arquivos na ordem estabelecida acima.

Tanto o download quanto a descompactação dos arquivos podem demorar a depende da sua conexão e sua máquina. A criação do banco de dados também é demorada, por isso para cada tabela do banco de dados há uma separação no script e é aconselhável rodar as tabelas uma de cada vez.

Ao fazer as consultas no banco, pense nos critérios a serem estabelecidos pois a massa de dados completa ao ser executada vai demorar bastante.

# Melhorias

Serão implementadas melhorias como as barras de progresso das tarefas de forma mais adequada, além de mais exemplo nos tipos de consulta a serem feitos bem como a adição de um arquivo chamado analitic.R onde pretendo colocar exemplos de análises dos dados disponíveis.
