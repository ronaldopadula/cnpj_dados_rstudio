library(tidyverse) # trabalhar com strings
library(rvest) # pacote para web scraping
library(progress) # Biblioteca para criar a barra de progresso da tarefa

# ACESSO AO LINK E CARREGAMENTO DOS ELEMENTOS DA PÁGINA
cnpj_page <- read_html(url_cnpj)
print(cnpj_page)
length(cnpj_page)

# INSPEÇÃO DOS ELEMENTOS E CRIAÇÃO DO DATAFRAME COM OS LINKS
inspecao <- cnpj_page %>% 
  html_nodes(".external-link") %>% # nodes são as classes, neste caso foi verificada a classe "external-link".
  html_attr("href") %>% # attr são os atributos, neste casso é "href" que são urls.
  unique()
counts <- length(inspecao)
count

class(inspecao)
inspecao

# DOWNLOAD DOS ARQUIVOS

for(i in 1:count){
  pb$tick()
  Sys.sleep(1 / count)
  url_ativa <- inspecao[i]
  arquivo <- str_remove(url_ativa, "http://200.152.38.155/CNPJ/")
  salvar <- paste(dir_download,"/",arquivo, sep = "")
  download.file(url_ativa, salvar, mode="wb")
}

