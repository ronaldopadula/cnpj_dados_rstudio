library(progress) # Biblioteca para criar a barra de progresso da tarefa

# CONFIGURAÇÕES INICIAIS

#Configuração dos diretórios para salvar os arquivos (pastas já criadas)
dir_download <- "./download"
dir_unzip <- "./unzip"

# link da página da receita federal
url_cnpj <- "http://200.152.38.155/CNPJ/"

# criação da barra de progresso
pb <- progress_bar$new(
  format = "  downloading [:bar] :percent eta: :eta",
  total = 100, clear = FALSE, width= 60)

