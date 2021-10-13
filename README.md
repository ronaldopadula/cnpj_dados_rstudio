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

# Tabelas geradas:

Verificar a estrutura dos dados no arquivo: NOVOLAYOUTDOSDADOSABERTOSDOCNPJ.pdf

As tabelas são:

* empresas: dados cadastrais da empresa em nível de matriz;
* estabelecimentos: dados analíticos da empresa por unidade / estabelecimento (telefones, endereço, filial, etc);
* socios: dados cadastrais dos sócios das empresas;
* simples: dados de MEI e Simples Nacional;
* cnae: código e descrição dos CNAEs;
* qualsocios: tabela de qualificação das pessoas físicas - sócios, responsável e representante legal;
* natju: tabela de naturezas jurídicas - código e descrição;
* motivos: tabela de motivos da situação cadastral - código e descrição;
* pais: tabela de países - código e descrição;
* municipios: tabela de municípios - código e descrição.

Não há relacionamento estre as tabelas no banco de dados. Isso porque não se trata de ítem relevante no momento. No entanto, será implementado mais a diante. No entanto a imagem abaixo demonstra qual deve ser a relação dos dados nas consultas:

![estrutura_relacional](https://user-images.githubusercontent.com/10247763/137045347-7dd40b99-37f6-4422-b6a8-979b58ddfaeb.png)




