#################################################################
## INSTALAÇÃO DAS BIBLIOTECAS NECESSÁRIAS PARA UTILIZAR O SISTEMA
#################################################################

# OBS: o SQLite deve estar instalado no seu computador
# consultar o site do projeto: https://www.sqlite.org/
# No Ubuntu:
# sudo apt install libcurl4-openssl-dev

# Verificar bibliotecas e instalar se precisar:

list.of.packages <- c("rvest","tidyverse","plyr","RSQLite","DBI","progress")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, dependencies = TRUE)

# Ou instalar uma a uma

#install.packages("rvest", dependencies = TRUE)
#install.packages("tidyverse", dependencies = TRUE)
#install.packages("plyr", dependencies = TRUE) 
#install.packages("RSQLite", dependencies = TRUE)
#install.packages("DBI", dependencies = TRUE)
#install.packages("progress", dependencies = TRUE)

#Obs: cara arquivo do programa terá a chamada das bibliotecas para executar.
