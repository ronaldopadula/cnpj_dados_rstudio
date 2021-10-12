# fazer conexão com o banco de dados
conn <- dbConnect(RSQLite::SQLite(), "cnpj.db")

# Listar tabelas do banco de dados
dbListTables(conn)

# Lista campos da tabela empresas como exemplo
dbListFields(conn,"empresas")

# Lista campos da tabela estabelecimentos como exemplo
dbListFields(conn,"estabelecimentos")

# Lista campos da tabela sócios como exemplo
dbListFields(conn,"socios")

# Lista campos da tabela municípios 
dbListFields(conn,"municipio")

########################################################
#####################    ATENÇÃO   #####################

# Fazer consultas massivas nas tabelas estabelecimentos, sócios ou empresas requer muito processamento.
# Logo, pode-se consultar alvos específicos como uma cidade, um estado, um tipo de atividade econômica.
empresas_selec <- dbGetQuery(conn,"select cnpj_basico, cnae_fiscal_principal, nome_fantasia, situacao_cadastral from estabelecimentos where municipio = '5813'")
