library(plyr) # utilizado para configurar a descompactação dos arquivos

# listar todos os arquivos zipados
zip_list <- list.files(path = dir_download, pattern = "*.zip", full.names = TRUE)
zip_list

# unzip todos os arquivos
ldply(.data = zip_list, .fun = unzip, exdir = dir_unzip, .progress = 'text')

