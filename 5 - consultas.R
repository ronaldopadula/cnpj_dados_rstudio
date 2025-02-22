# Seguem exemplos de consultas direto na base de dados com um modelo de exportação em .csv no final.

# fazer conexão com o banco de dados
conn <- dbConnect(RSQLite::SQLite(), "cnpj.db")

# Listar tabelas do banco de dados
dbListTables(conn)

# Lista campos da tabela CNAE como exemplo
dbListFields(conn,"CNAE")
# Listar 10 linhas da tabela
CNAE_10 <- dbGetQuery(conn, "SELECT * FROM CNAE LIMIT 10")

# Lista campos da tabela empresas como exemplo
dbListFields(conn,"empresas")
# Listar 10 linhas da tabela
empresas_10 <- dbGetQuery(conn, "SELECT * FROM empresas LIMIT 10")

# Lista campos da tabela estabelecimentos como exemplo
dbListFields(conn,"estabelecimentos")
# Listar 10 linhas da tabela
estabelecimentos_10 <- dbGetQuery(conn, "SELECT * FROM estabelecimentos LIMIT 10")

# Lista campos da tabela motivo como exemplo
dbListFields(conn,"motivo")
# Listar 10 linhas da tabela
motivo_10 <- dbGetQuery(conn, "SELECT * FROM motivo LIMIT 10")

# Lista campos da tabela municipio como exemplo
dbListFields(conn,"municipio")
# Listar 10 linhas da tabela
municipio_10 <- dbGetQuery(conn, "SELECT * FROM municipio LIMIT 10")

# Lista campos da tabela natju como exemplo
dbListFields(conn,"natju")
# Listar 10 linhas da tabela
natju_10 <- dbGetQuery(conn, "SELECT * FROM natju LIMIT 10")
natju <- dbGetQuery(conn, "SELECT * FROM natju")

# Lista campos da tabela pais como exemplo
dbListFields(conn,"pais")
# Listar 10 linhas da tabela
pais_10 <- dbGetQuery(conn, "SELECT * FROM pais LIMIT 10")

# Lista campos da tabela qualsocio como exemplo
dbListFields(conn,"qualsocio")
# Listar 10 linhas da tabela
qualsocio_10 <- dbGetQuery(conn, "SELECT * FROM qualsocio LIMIT 10")

# Lista campos da tabela simples 
dbListFields(conn,"simples")
# Listar 10 linhas da tabela
simples_10 <- dbGetQuery(conn, "SELECT * FROM simples LIMIT 10")

# Lista campos da tabela sócios como exemplo
dbListFields(conn,"socios")
# Listar 10 linhas da tabela
socio_10 <- dbGetQuery(conn, "SELECT * FROM socio LIMIT 10")



########################################################
#####################    ATENÇÃO   #####################

# Fazer consultas massivas nas tabelas estabelecimentos, sócios ou empresas requer muito processamento.
# Logo, pode-se consultar alvos específicos como uma cidade, um estado, um tipo de atividade econômica.
empresas_selec <- dbGetQuery(conn,"SELECT cnpj_basico, cnae_fiscal_principal, nome_fantasia, situacao_cadastral 
                             FROM estabelecimentos WHERE municipio = '5813'")

empresas_selec10 <- dbGetQuery(conn, "SELECT * FROM estabelecimentos LIMIT 10")

estatais_RJ <- dbGetQuery(conn, "SELECT e.*,em.* 
                       FROM estabelecimentos e
                       INNER JOIN empresas em ON e.cnpj_basico = em.cnpj_basico
                       INNER JOIN natju n ON em.natureza_juridica = n.codigo
                       WHERE e.uf = 'RJ'
                       AND em.natureza_juridica IN (2011, 2038)
")

# Exportar o resultado para um arquivo CSV
write.csv(estatais_RJ, file = "estatais_RJ.csv", row.names = FALSE, fileEncoding = "UTF-8")


# Fechar a conexão com o banco de dados
dbDisconnect(conn)
