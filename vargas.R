library(readxl)
library(tidyverse)

varg_event <- read_excel(file.choose())

unique(varg_event$`Comunidad de precedencia`)

cuants<-data.frame(table(varg_event$`Comunidad de precedencia`))

my_color <- palette("polychrome 36")

p <- with(cuants, barplot(height = Freq, names = Var1, col = my_color))

ggplot(cuants, mapping = aes(x=Freq, color=Var1)) + geom_bar()


pie(cuants$Freq, labels = cuants$Var1, col = my_color)

cuants <- mutate(cuants, porcentaje = (Freq/178)*100)


nuevo <- cuants %>% filter(Freq>=9)

with(nuevo, pie(Freq, labels =paste(Var1, porcentaje), col = my_color))
text("mayor concurrencia")
