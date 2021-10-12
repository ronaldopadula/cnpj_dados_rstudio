library(RSQLite) # Biblioteca do SQLite ( o SQLite tem que estar instalado no seu PC)
library(DBI) # Biblioteca para conectar e manipular o banco de dados

# fazer conexão com o banco de dados
conn <- dbConnect(RSQLite::SQLite(), "cnpj.db")

# Listar tabelas do banco de dados
dbListTables(conn)

# selecionar tabela do banco de dados
dbGetQuery(conn, "SELECT * FROM empresas")
view(empresas) # visualizar data.frame