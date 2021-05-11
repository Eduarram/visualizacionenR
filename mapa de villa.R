#mapa de villa victoria prueba uno
library(tidyverse)
library(readxl)

rut <- "C:\\Users\\bodega\\Desktop\\Tesis anexos del codigo\\tesis\\porqueria.xlsx"

mpavilla <- read_excel(rut)

ggplot(mpavilla, aes(x=longitude, y=latitude))+ geom_point() 

library(jsonlite)

#mapa <- read_json("GeoJSON - Censo 2010 (Municipal).json")

remove(mapa)