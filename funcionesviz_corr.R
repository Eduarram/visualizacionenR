
##function para colorear el scartter del correlograma
##cargar primero GGally y ggplot si no los haz cargado previamente en el 
#markdown

my_scatter <- function(data, mapping){
  ggplot(data=data, mapping = mapping)+
    geom_jitter(color="yellow")
}

##funcion de densidad 

my_density <- function(data, mapping){
  ggplot(data=data, mapping=mapping) +
    geom_density(alpha = 0.5, 
                 fill="blue")
}