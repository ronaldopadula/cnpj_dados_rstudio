library(progress) # Biblioteca para criar a barra de progresso da tarefa

# CONFIGURAÇÕES INICIAIS

#Configuração dos diretórios para salvar os arquivos (pastas já criadas)
dir_download <- "./download"
dir_unzip <- "./unzip"

# link da página da receita federal
url_cnpj <- "https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/cadastros/consultas/dados-publicos-cnpj"

# criação da barra de progresso
pb <- progress_bar$new(
  format = "  downloading [:bar] :percent eta: :eta",
  total = 100, clear = FALSE, width= 60)