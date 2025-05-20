# CRIAÇÃO DO BANCO DE DADOS

library(RSQLite) # Biblioteca do SQLite ( o SQLite tem que estar instalado no seu PC)
library(DBI) # Biblioteca para conectar e manipular o banco de dados
library(progress) # Biblioteca para criar a barra de progresso da tarefa

#Configuração dos diretórios para salvar os arquivos (pastas já criadas)
dir_download <- "./download"
dir_unzip <- "./unzip"

# cria automaticamente o banco "cnpj.db" se o mesmo não existir, e conecta
conn <- dbConnect(RSQLite::SQLite(), "cnpj.db")

##############################################################################################################
# cria e carrega a tabela empresas

# lista os arquivos que contém os dados
lista_empresas <- list.files(path = dir_unzip, pattern = toupper("EMPRE"), full.names = FALSE) 
# conta e verifica tamanho
count_empresas <- length(lista_empresas)

# inicia transação para garantir consistência
dbBegin(conn)

# nova barra de contagem:
pb <- progress_bar$new(
  format = "  Carregando empresas [:bar] :percent eta: :eta",
  total = count_empresas, clear = FALSE, width = 60)


# Código para criar a tabela
for (i in 1:count_empresas) {
  pb$tick()
  Sys.sleep(1 / count_empresas)
  empresas_arquivo <- file.path("unzip", lista_empresas[i])
  tryCatch({
    empresas <- read.csv(file = empresas_arquivo, header = FALSE, sep = ";", encoding = "ASCII")
    if (ncol(empresas) == 7) {
      colnames(empresas) <- c("cnpj_basico", 
                              "razao_social", 
                              "natureza_juridica", 
                              "qualificacao_responsavel", 
                              "capital_social", 
                              "porte_empresa", 
                              "ente_federativo_responsavel")
      if (i == 1) {
        dbWriteTable(conn, name = "empresas", value = empresas, overwrite = TRUE)
      } else {
        dbWriteTable(conn, name = "empresas", value = empresas, append = TRUE)
      }
      print(paste("Arquivo OK:", lista_empresas[i], "-", nrow(empresas), "linhas"))
    } else {
      print(paste("Erro de colunas no arquivo:", lista_empresas[i]))
    }
  }, error = function(e) {
    print(paste("Erro ao processar", lista_empresas[i], ":", e$message))
  })
}

# encerra transação para garantir consistência
dbCommit(conn)
#checa as linhas
cat("Total de linhas na tabela empresas:", dbGetQuery(conn, "SELECT COUNT(*) FROM empresas")[[1]], "\n")

##############################################################################################################
# Cria e carrega a tabela estabelecimentos

# lista os arquivos que contém os dados
lista_estabelecimentos <- list.files(path = dir_unzip, pattern = "ESTABELE", full.names = FALSE)
# conta e verifica tamanho
count_estabelecimentos <- length(lista_estabelecimentos)

# inicia transação para garantir consistência
dbBegin(conn)

# nova barra de contagem:
pb <- progress_bar$new(
  format = "  Carregando estabelecimentos [:bar] :percent eta: :eta",
  total = count_estabelecimentos, clear = FALSE, width = 60)

# processa a criação da tabela
for (i in 1:count_estabelecimentos) {
  pb$tick()
  Sys.sleep(1 / count_estabelecimentos)
  estabelecimentos_arquivo <- paste("unzip/", lista_estabelecimentos[i], sep = "")
  tryCatch({
    estabelecimentos <- read.csv(file = estabelecimentos_arquivo, header = FALSE, sep = ";", encoding = "ISO-8859")
    if (ncol(estabelecimentos) == 30) {
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
      if (i == 1) {
        dbWriteTable(conn, name = "estabelecimentos", value = estabelecimentos, overwrite = TRUE)
      } else {
        dbWriteTable(conn, name = "estabelecimentos", value = estabelecimentos, append = TRUE)
      }
      print(paste("Arquivo OK:", lista_estabelecimentos[i], "-", nrow(estabelecimentos), "linhas"))
    } else {
      print(paste("Erro de colunas no arquivo:", lista_estabelecimentos[i]))
    }
  }, error = function(e) {
    print(paste("Erro ao processar", lista_estabelecimentos[i], ":", e$message))
  })
}

# encerra transação para garantir consistência
dbCommit(conn)
# checa as linhas
cat("Total de linhas na tabela estabelecimentos:", dbGetQuery(conn, "SELECT COUNT(*) FROM estabelecimentos")[[1]], "\n")

##############################################################################################################
# Cria e carrega a tabela socios

# Carregando tabela socios
# lista os arquivos que contém os dados
lista_socios <- list.files(path = dir_unzip, pattern = "SOCIO", full.names = FALSE)
# conta e verifica tamanho
count_socios <- length(lista_socios)

# inicia transação para garantir consistência
dbBegin(conn)

# nova barra de contagem:
pb <- progress_bar$new(
  format = "  Carregando socios [:bar] :percent eta: :eta",
  total = count_socios, clear = FALSE, width = 60)

# processa a criação da tabela
for (i in 1:count_socios) {
  pb$tick()
  Sys.sleep(1 / count_socios)
  socios_arquivo <- paste("unzip/", lista_socios[i], sep = "")
  tryCatch({
    socios <- read.csv(file = socios_arquivo, header = FALSE, sep = ";", encoding = "ASCII")
    if (ncol(socios) == 11) {
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
      if (i == 1) {
        dbWriteTable(conn, name = "socios", value = socios, overwrite = TRUE)
      } else {
        dbWriteTable(conn, name = "socios", value = socios, append = TRUE)
      }
      print(paste("Arquivo OK:", lista_socios[i], "-", nrow(socios), "linhas"))
    } else {
      print(paste("Erro de colunas no arquivo:", lista_socios[i]))
    }
  }, error = function(e) {
    print(paste("Erro ao processar", lista_socios[i], ":", e$message))
  })
}

# inicia transação para garantir consistência
dbCommit(conn)
#checa as linhas
cat("Total de linhas na tabela socios:", dbGetQuery(conn, "SELECT COUNT(*) FROM socios")[[1]], "
")

##############################################################################################################
# Cria e carrega a tabela de informações sobre o Simples Nacional/MEI

# lista os arquivos que contém os dados
lista_simples <- list.files(path = dir_unzip, pattern = "SIMPLES", full.names = FALSE)
# conta e verifica tamanho
count_simples <- length(lista_simples)

# inicia transação para garantir consistência
dbBegin(conn)

# cria nova barra de contagem:
pb <- progress_bar$new(
  format = "  Carregando simples [:bar] :percent eta: :eta",
  total = count_simples, clear = FALSE, width = 60)

# processa a criação da tabela
for (i in 1:count_simples) {
  pb$tick()
  Sys.sleep(1 / count_simples)
  simples_arquivo <- paste("unzip/", lista_simples[i], sep = "")
  tryCatch({
    simples <- read.csv(file = simples_arquivo, header = FALSE, sep = ";", encoding = "ASCII")
    if (ncol(simples) == 7) {
      colnames(simples) <- c("cnpj_basico", 
                             "opcao_pelo_simples", 
                             "data_opcao_simples", 
                             "data_exclusao_simples", 
                             "opcao_mei", 
                             "data_opcao_mei", 
                             "data_exclusao_mei")
      if (i == 1) {
        dbWriteTable(conn, name = "simples", value = simples, overwrite = TRUE)
      } else {
        dbWriteTable(conn, name = "simples", value = simples, append = TRUE)
      }
      print(paste("Arquivo OK:", lista_simples[i], "-", nrow(simples), "linhas"))
    } else {
      print(paste("Erro de colunas no arquivo:", lista_simples[i]))
    }
  }, error = function(e) {
    print(paste("Erro ao processar", lista_simples[i], ":", e$message))
  })
}
# encerra transação para garantir consistência
dbCommit(conn)

#checa as linhas
cat("Total de linhas na tabela simples:", dbGetQuery(conn, "SELECT COUNT(*) FROM simples")[[1]], "
")

##############################################################################################################
# Cria e carrega a tabela de atributo CNAE

# Carregando tabela cnae
# lista os arquivos que contém os dados
lista_cnae <- list.files(path = dir_unzip, pattern = "CNAE", full.names = FALSE)
# conta e verifica tamanho
count_cnae <- length(lista_cnae)

# inicia transação para garantir consistência
dbBegin(conn)

#cria nova barra de contagem
pb <- progress_bar$new(
  format = "  Carregando cnae [:bar] :percent eta: :eta",
  total = count_cnae, clear = FALSE, width = 60)

# incia processamento da tabela
for (i in 1:count_cnae) {
  pb$tick()
  Sys.sleep(1 / count_cnae)
  cnae_arquivo <- paste("unzip/", lista_cnae[i], sep = "")
  tryCatch({
    cnae <- read.csv(file = cnae_arquivo, header = FALSE, sep = ";", encoding = "ISO-8859")
    if (ncol(cnae) == 2) {
      colnames(cnae) <- c("codigo", 
                          "descricao")
      if (i == 1) {
        dbWriteTable(conn, name = "cnae", value = cnae, overwrite = TRUE)
      } else {
        dbWriteTable(conn, name = "cnae", value = cnae, append = TRUE)
      }
      print(paste("Arquivo OK:", lista_cnae[i], "-", nrow(cnae), "linhas"))
    } else {
      print(paste("Erro de colunas no arquivo:", lista_cnae[i]))
    }
  }, error = function(e) {
    print(paste("Erro ao processar", lista_cnae[i], ":", e$message))
  })
}
# encerra transação para garantir consistência
dbCommit(conn)
#confere as linhas criadas
cat("Total de linhas na tabela cnae:", dbGetQuery(conn, "SELECT COUNT(*) FROM cnae")[[1]], "
    ")

##############################################################################################################
# Cria e carrega a tabela de motivo da situação cadastral

# Carregando tabela motivo
# Seleciona os arquivos
lista_motivo <- list.files(path = dir_unzip, pattern = "MOTI", full.names = FALSE)
#verifica e conta
count_motivo <- length(lista_motivo)

# inicia transação para garantir consistência
dbBegin(conn)

#cria nova barra de contagem
pb <- progress_bar$new(
  format = "  Carregando motivo [:bar] :percent eta: :eta",
  total = count_motivo, clear = FALSE, width = 60)

#processa a tabela
for (i in 1:count_motivo) {
  pb$tick()
  Sys.sleep(1 / count_motivo)
  motivo_arquivo <- paste("unzip/", lista_motivo[i], sep = "")
  tryCatch({
    motivo <- read.csv(file = motivo_arquivo, header = FALSE, sep = ";", encoding = "ASCII")
    if (ncol(motivo) == 2) {
      colnames(motivo) <- c("codigo", "descricao")
      if (i == 1) {
        dbWriteTable(conn, name = "motivo", value = motivo, overwrite = TRUE)
      } else {
        dbWriteTable(conn, name = "motivo", value = motivo, append = TRUE)
      }
      print(paste("Arquivo OK:", lista_motivo[i], "-", nrow(motivo), "linhas"))
    } else {
      print(paste("Erro de colunas no arquivo:", lista_motivo[i]))
    }
  }, error = function(e) {
    print(paste("Erro ao processar", lista_motivo[i], ":", e$message))
  })
}
# encerra transação para garantir consistência
dbCommit(conn)
# Verifica e conta as linhas criadas
cat("Total de linhas na tabela motivo:", dbGetQuery(conn, "SELECT COUNT(*) FROM motivo")[[1]], "
")

##############################################################################################################
# Cria e carrega a tabela de atributo Município

# Carregando tabela municipio
lista_municipio <- list.files(path = dir_unzip, pattern = "MUNIC", full.names = FALSE)
count_municipio <- length(lista_municipio)

# inicia transação para garantir consistência
dbBegin(conn)

#cria nova barra de contagem
pb <- progress_bar$new(
  format = "  Carregando municipio [:bar] :percent eta: :eta",
  total = count_municipio, clear = FALSE, width = 60)

#processa a tabela
for (i in 1:count_municipio) {
  pb$tick()
  Sys.sleep(1 / count_municipio)
  municipio_arquivo <- paste("unzip/", lista_municipio[i], sep = "")
  tryCatch({
    municipio <- read.csv(file = municipio_arquivo, header = FALSE, sep = ";", encoding = "ASCII")
    if (ncol(municipio) == 2) {
      colnames(municipio) <- c("codigo", "descricao")
      if (i == 1) {
        dbWriteTable(conn, name = "municipio", value = municipio, overwrite = TRUE)
      } else {
        dbWriteTable(conn, name = "municipio", value = municipio, append = TRUE)
      }
      print(paste("Arquivo OK:", lista_municipio[i], "-", nrow(municipio), "linhas"))
    } else {
      print(paste("Erro de colunas no arquivo:", lista_municipio[i]))
    }
  }, error = function(e) {
    print(paste("Erro ao processar", lista_municipio[i], ":", e$message))
  })
}
# encerra transação para garantir consistência
dbCommit(conn)
# Verifica e conta as linhas criadas
cat("Total de linhas na tabela municipio:", dbGetQuery(conn, "SELECT COUNT(*) FROM municipio")[[1]], "
")

##############################################################################################################
# Cria e carrega a tabela de atributo Natureza Jurídica
# Carregando tabela natju
lista_natju <- list.files(path = dir_unzip, pattern = "NATJU", full.names = FALSE)
count_natju <- length(lista_natju)

# inicia transação para garantir consistência
dbBegin(conn)

#cria nova barra de contagem
pb <- progress_bar$new(
  format = "  Carregando natju [:bar] :percent eta: :eta",
  total = count_natju, clear = FALSE, width = 60)

#processa a tabela
for (i in 1:count_natju) {
  pb$tick()
  Sys.sleep(1 / count_natju)
  natju_arquivo <- paste("unzip/", lista_natju[i], sep = "")
  tryCatch({
    natju <- read.csv(file = natju_arquivo, header = FALSE, sep = ";", encoding = "ISO-8859")
    if (ncol(natju) == 2) {
      colnames(natju) <- c("codigo", "descricao")
      if (i == 1) {
        dbWriteTable(conn, name = "natju", value = natju, overwrite = TRUE)
      } else {
        dbWriteTable(conn, name = "natju", value = natju, append = TRUE)
      }
      print(paste("Arquivo OK:", lista_natju[i], "-", nrow(natju), "linhas"))
    } else {
      print(paste("Erro de colunas no arquivo:", lista_natju[i]))
    }
  }, error = function(e) {
    print(paste("Erro ao processar", lista_natju[i], ":", e$message))
  })
}
# encerra transação para garantir consistência
dbCommit(conn)
# Verifica e conta as linhas criadas
cat("Total de linhas na tabela natju:", dbGetQuery(conn, "SELECT COUNT(*) FROM natju")[[1]], "
")

##############################################################################################################
# Cria e carrega a tabela de atributo País

# Carregando tabela pais
lista_pais <- list.files(path = dir_unzip, pattern = "PAIS", full.names = FALSE)
count_pais <- length(lista_pais)

# inicia transação para garantir consistência
dbBegin(conn)

#cria nova barra de contagem
pb <- progress_bar$new(
  format = "  Carregando pais [:bar] :percent eta: :eta",
  total = count_pais, clear = FALSE, width = 60)

#processa a tabela
for (i in 1:count_pais) {
  pb$tick()
  Sys.sleep(1 / count_pais)
  pais_arquivo <- paste("unzip/", lista_pais[i], sep = "")
  tryCatch({
    pais <- read.csv(file = pais_arquivo, header = FALSE, sep = ";", encoding = "ISO-8859")
    if (ncol(pais) == 2) {
      colnames(pais) <- c("codigo", "descricao")
      if (i == 1) {
        dbWriteTable(conn, name = "pais", value = pais, overwrite = TRUE)
      } else {
        dbWriteTable(conn, name = "pais", value = pais, append = TRUE)
      }
      print(paste("Arquivo OK:", lista_pais[i], "-", nrow(pais), "linhas"))
    } else {
      print(paste("Erro de colunas no arquivo:", lista_pais[i]))
    }
  }, error = function(e) {
    print(paste("Erro ao processar", lista_pais[i], ":", e$message))
  })
}
# encerra transação para garantir consistência
dbCommit(conn)
# Verifica e conta as linhas criadas
cat("Total de linhas na tabela pais:", dbGetQuery(conn, "SELECT COUNT(*) FROM pais")[[1]], "
")

##############################################################################################################
# Cria e carrega a tabela de atributo qualificação dos sócios

# Carregando tabela qualsocio
lista_qualsocio <- list.files(path = dir_unzip, pattern = "QUALS", full.names = FALSE)
count_qualsocio <- length(lista_qualsocio)

# inicia transação para garantir consistência
dbBegin(conn)

#cria nova barra de contagem
pb <- progress_bar$new(
  format = "  Carregando qualsocio [:bar] :percent eta: :eta",
  total = count_qualsocio, clear = FALSE, width = 60)

#processa a tabela
for (i in 1:count_qualsocio) {
  pb$tick()
  Sys.sleep(1 / count_qualsocio)
  qualsocio_arquivo <- paste("unzip/", lista_qualsocio[i], sep = "")
  tryCatch({
    qualsocio <- read.csv(file = qualsocio_arquivo, header = FALSE, sep = ";", encoding = "ISO-8859")
    if (ncol(qualsocio) == 2) {
      colnames(qualsocio) <- c("codigo", "descricao")
      if (i == 1) {
        dbWriteTable(conn, name = "qualsocio", value = qualsocio, overwrite = TRUE)
      } else {
        dbWriteTable(conn, name = "qualsocio", value = qualsocio, append = TRUE)
      }
      print(paste("Arquivo OK:", lista_qualsocio[i], "-", nrow(qualsocio), "linhas"))
    } else {
      print(paste("Erro de colunas no arquivo:", lista_qualsocio[i]))
    }
  }, error = function(e) {
    print(paste("Erro ao processar", lista_qualsocio[i], ":", e$message))
  })
}
# encerra transação para garantir consistência
dbCommit(conn)
# Verifica e conta as linhas criadas
cat("Total de linhas na tabela qualsocio:", dbGetQuery(conn, "SELECT COUNT(*) FROM qualsocio")[[1]], "
")
