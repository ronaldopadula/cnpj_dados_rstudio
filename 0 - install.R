#################################################################
## INSTALAÇÃO DAS BIBLIOTECAS NECESSÁRIAS PARA UTILIZAR O SISTEMA
#################################################################

# OBS: o SQLite deve estar instalado no seu computador
# consultar o site do projeto: https://www.sqlite.org/

install.packages("rvest", dependencies = TRUE)
install.packages("tidyverse", dependencies = TRUE)
install.packages("plyr", dependencies = TRUE) 
install.packages("RSQLite", dependencies = TRUE)
install.packages("DBI", dependencies = TRUE)
install.packages("progress", dependencies = TRUE)

#Obs: cara arquivo do programa terá a chamada das bibliotecas para executar.