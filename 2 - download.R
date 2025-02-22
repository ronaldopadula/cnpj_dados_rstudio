library(tidyverse) # trabalhar com strings
library(rvest) # pacote para web scraping
library(progress) # Biblioteca para criar a barra de progresso da tarefa

# criação da barra de progresso
pb <- progress_bar$new(
  format = "  downloading [:bar] :percent eta: :eta",
  total = 100, clear = FALSE, width= 60)

# ACESSO AO LINK E CARREGAMENTO DOS ELEMENTOS DA PÁGINA
cnpj_page <- read_html(url_cnpj)
print(cnpj_page)
length(cnpj_page)

# INSPEÇÃO DOS ELEMENTOS E CRIAÇÃO DO DATAFRAME COM OS LINKS
inspecao <- cnpj_page %>% 
  html_nodes("a") %>% # nodes são as classes, neste caso foi verificada a classe "a".
  html_attr("href") %>% # attr são os atributos, neste casso é "href" que são urls.
  unique()
count <- length(inspecao)
count

class(inspecao)
inspecao

# DOWNLOAD DOS ARQUIVOS

for(i in 1:count){
  pb$tick()
  Sys.sleep(1 / count)
  arquivo <- inspecao[i]
  url_ativa <- str_c(url_cnpj, arquivo)
  salvar <- paste(dir_download,"/",arquivo, sep = "")
  download.file(url_ativa, salvar, mode="wb")
  options(timeout = 10000)
}

