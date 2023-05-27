# CRIAÇÃO DO BANCO DE DADOS

library(RSQLite) # Biblioteca do SQLite ( o SQLite tem que estar instalado no seu PC)
library(DBI) # Biblioteca para conectar e manipular o banco de dados
library(progress) # Biblioteca para criar a barra de progresso da tarefa

# cria automaticamente o banco "cnpj.db" se o mesmo não existir, e conecta
conn <- dbConnect(RSQLite::SQLite(), "cnpj.db")

##############################################################################################################
# cria e carrega a tabela empresas
lista_empresas <- list.files(path = dir_unzip, pattern = "EMPRE", full.names = FALSE)
count_empresas <- length(lista_empresas)


for (i in 1:count_empresas) {
  pb$tick() # para a barra de progresso da tarefa
  Sys.sleep(1 / count_empresas) # para a barra de progresso da tarefa
  empr_arquivo <- paste("unzip/", lista_empresas[i], sep = "")
  empresas <- read.csv(file = empr_arquivo, header = FALSE, sep = ";", encoding = "ASCII")
  colnames(empresas) <- c("cnpj_basico", 
                          "razao_social", 
                          "natureza_juridica", 
                          "qualificacao_responsavel", 
                          "capital_social", 
                          "porte_empresa", 
                          "ente_federativo_responsavel")
  dbWriteTable(conn, name="empresas", value=empresas, append=TRUE)
}

##############################################################################################################
# Cria e carrega a tabela estabelecimentos
lista_estabelecimentos <- list.files(path = dir_unzip, pattern = "ESTABELE", full.names = FALSE)
count_estabelecimentos <- length(lista_estabelecimentos)

for (i in 1:count_estabelecimentos) {
  pb$tick() # para a barra de progresso da tarefa
  Sys.sleep(1 / count_estabelecimentos) # para a barra de progresso da tarefa
  estab_arquivo <- paste("unzip/", lista_estabelecimentos[i], sep = "")
  estabelecimentos <- read.csv(file = estab_arquivo, header = FALSE, sep = ";", encoding = "ISO-8859")
  colnames(estabelecimentos) <- c("cnpj_basico",
                                  "cnpj_ordem",
                                  "cnpj_dv",
                                  "identificador_matriz_filial",
                                  "nome_fantasia",
                                  "situacao_cadastral",
                                  "data_situacao_cadastral",
                                  "motivo_situacao_cadastral",
                                  "nome_cidade_exterior",
                                  "pais",
                                  "data_inicio_atividade",
                                  "cnae_fiscal_principal",
                                  "cnae_fiscal_secundaria",
                                  "tipo_logradouro",
                                  "logradouro",
                                  "numero",
                                  "complemento",
                                  "bairro",
                                  "cep",
                                  "uf",
                                  "municipio",
                                  "ddd_1",
                                  "telefone_1",
                                  "ddd_2",
                                  "telefone_2",
                                  "ddd_fax",
                                  "fax",
                                  "correio_eletronico",
                                  "situacao_especial",
                                  "data_situacao_especial")
  dbWriteTable(conn, name="estabelecimentos", value=estabelecimentos, append=TRUE)
}

##############################################################################################################
# Cria e carrega a tabela socios
lista_socios <- list.files(path = dir_unzip, pattern = "SOCIO", full.names = FALSE)
count_socios <- length(lista_socios)

for (i in 1:count_socios) {
  pb$tick() # para a barra de progresso da tarefa
  Sys.sleep(1 / count_socios) # para a barra de progresso da tarefa
  socios_arquivo <- paste("unzip/", lista_socios[i], sep = "")
  socios <- read.csv(file = socios_arquivo, header = FALSE, sep = ";", encoding = "ASCII")
  colnames(socios) <- c("cnpj_basico",
                        "identificador_socio",
                        "nome_socio_razao_social",
                        "cpf_cnpj_socio",
                        "qualificacao_socio",
                        "data_entrada_sociedade",
                        "pais",
                        "representante_legal",
                        "nome_do_representante",
                        "qualificacao_representante_legal",
                        "faixa_etaria")
  dbWriteTable(conn, name="socios", value=socios, append=TRUE)
}

##############################################################################################################
# Cria e carrega a tabela de informações sobre o Simples Nacional/MEI
lista_simples <- list.files(path = dir_unzip, pattern = "SIMPLES", full.names = FALSE)
count_simples <- length(lista_simples)

for (i in 1:count_simples) {
  pb$tick() # para a barra de progresso da tarefa
  Sys.sleep(1 / count_simples) # para a barra de progresso da tarefa
  simples_arquivo <- paste("unzip/", lista_simples[i], sep = "")
  simples <- read.csv(file = simples_arquivo, header = FALSE, sep = ";", encoding = "ASCII")
  colnames(simples) <- c("cnpj_basico",
                         "opcao_pelo_simples",
                         "data_opcao_simples",
                         "data_exclusao_simples",
                         "opcao_mei",
                         "data_opcao_mei",
                         "data_exclusao_mei")
  dbWriteTable(conn, name="simples", value=simples, append=TRUE)
}

##############################################################################################################
# Cria e carrega a tabela de atributo CNAE
lista_cnae <- list.files(path = dir_unzip, pattern = "CNAE", full.names = FALSE)
count_cnae <- length(lista_cnae)
for (i in 1:count_cnae) {
  pb$tick() # para a barra de progresso da tarefa
  Sys.sleep(1 / count_cnae) # para a barra de progresso da tarefa
  cnae_arquivo <- paste("unzip/", lista_cnae[i], sep = "")
  cnae <- read.csv(file = cnae_arquivo, header = FALSE, sep = ";", encoding = "ISO-8859")
  colnames(cnae) <- c("codigo", 
                      "descricao")
  dbWriteTable(conn, name="cnae", value=cnae, append=TRUE)
}

##############################################################################################################
# Cria e carrega a tabela de motivo da situação cadastral
lista_motivo <- list.files(path = dir_unzip, pattern = "MOTI", full.names = FALSE)
count_motivo <- length(lista_motivo)
for (i in 1:count_motivo) {
  pb$tick() # para a barra de progresso da tarefa
  Sys.sleep(1 / count_motivo) # para a barra de progresso da tarefa
  motivo_arquivo <- paste("unzip/", lista_motivo[i], sep = "")
  motivo <- read.csv(file = motivo_arquivo, header = FALSE, sep = ";", encoding = "ASCII")
  colnames(motivo) <- c("codigo", 
                        "descricao")
  dbWriteTable(conn, name="motivo", value=motivo, append=TRUE)
}

##############################################################################################################
# Cria e carrega a tabela de atributo Município
lista_municipio <- list.files(path = dir_unzip, pattern = "MUNIC", full.names = FALSE)
count_municipio <- length(lista_municipio)
for (i in 1:count_municipio) {
  pb$tick() # para a barra de progresso da tarefa
  Sys.sleep(1 / count_municipio) # para a barra de progresso da tarefa
  municipio_arquivo <- paste("unzip/", lista_municipio[i], sep = "")
  municipio <- read.csv(file = municipio_arquivo, header = FALSE, sep = ";", encoding = "ASCII")
  colnames(municipio) <- c("codigo", 
                           "descricao")
  dbWriteTable(conn, name="municipio", value=municipio, append=TRUE)
}

##############################################################################################################
# Cria e carrega a tabela de atributo Natureza Jurídica
lista_natju <- list.files(path = dir_unzip, pattern = "NATJU", full.names = FALSE)
count_natju <- length(lista_natju)
for (i in 1:count_natju) {
  pb$tick() # para a barra de progresso da tarefa
  Sys.sleep(1 / count_natju) # para a barra de progresso da tarefa
  natju_arquivo <- paste("unzip/", lista_natju[i], sep = "")
  natju <- read.csv(file = natju_arquivo, header = FALSE, sep = ";", encoding = "ISO-8859")
  colnames(natju) <- c("codigo", 
                       "descricao")
  dbWriteTable(conn, name="natju", value=natju, append=TRUE)
}

##############################################################################################################
# Cria e carrega a tabela de atributo País
lista_pais <- list.files(path = dir_unzip, pattern = "PAIS", full.names = FALSE)
count_pais <- length(lista_pais)
for (i in 1:count_pais) {
  pb$tick() # para a barra de progresso da tarefa
  Sys.sleep(1 / count_pais) # para a barra de progresso da tarefa
  pais_arquivo <- paste("unzip/", lista_pais[i], sep = "")
  pais <- read.csv(file = pais_arquivo, header = FALSE, sep = ";", encoding = "ISO-8859")
  colnames(pais) <- c("codigo", 
                      "descricao")
  dbWriteTable(conn, name="pais", value=pais, append=TRUE)
}

##############################################################################################################
# Cria e carrega a tabela de atributo qualificação dos sócios
lista_qualsocio <- list.files(path = dir_unzip, pattern = "QUALS", full.names = FALSE)
count_qualsocio <- length(lista_qualsocio)
for (i in 1:count_qualsocio) {
  pb$tick() # para a barra de progresso da tarefa
  Sys.sleep(1 / count_qualsocio) # para a barra de progresso da tarefa
  qualsocio_arquivo <- paste("unzip/", lista_qualsocio[i], sep = "")
  qualsocio <- read.csv(file = qualsocio_arquivo, header = FALSE, sep = ";", encoding = "ISO-8859")
  colnames(qualsocio) <- c("codigo", 
                           "descricao")
  dbWriteTable(conn, name="qualsocio", value=qualsocio, append=TRUE)
}
