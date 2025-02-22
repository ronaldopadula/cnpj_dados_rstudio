library(progress) # Biblioteca para criar a barra de progresso da tarefa

# CONFIGURAÇÕES INICIAIS

#Configuração dos diretórios para salvar os arquivos (pastas já criadas)
dir_download <- "./download"
dir_unzip <- "./unzip"

######### CRIAR O LINK MAIS ATUAL PARA CAPTAR A BASE DE DADOS  ###################################
# Carregar as bibliotecas necessárias
library(rvest)
library(dplyr)
library(stringr)

# URL da página principal
url_base <- "https://arquivos.receitafederal.gov.br/dados/cnpj/dados_abertos_cnpj/"

# Ler o conteúdo da página
pagina <- read_html(url_base)

# Extrair os diretórios disponíveis
diretorios <- pagina %>%
  html_nodes("a") %>%
  html_text() %>%
  str_trim() %>%
  .[str_detect(., "^\\d{4}-\\d{2}/$")]  # Filtrar apenas os diretórios no formato YYYY-MM/

# Garantir que há diretórios encontrados
if (length(diretorios) > 0) {
  # Ordenar os diretórios em ordem decrescente para pegar o mais atual
  diretorio_atual <- sort(diretorios, decreasing = TRUE)[1]
  
  # Construir o link mais atual
  url_cnpj <- paste0(url_base, diretorio_atual)
  
  # Exibir o link
  cat("Link mais atual encontrado:\n", url_cnpj, "\n")
} else {
  cat("Nenhum diretório encontrado.\n")
}
###################################################################################################

# criação da barra de progresso
pb <- progress_bar$new(
  format = "  downloading [:bar] :percent eta: :eta",
  total = 100, clear = FALSE, width= 60)
