library(readxl)
library(tidyverse)

df <- read_excel("df.xlsx")

names(df) <- df %>% slice(1) %>% unlist()
df <- df %>% slice(-1)

patients <- unique(df[c("Name")])
elasticity.curve <- matrix(ncol=2, nrow = 19)


for(i in 1:19) {
  
  df.modified <- df %>% filter(Name == patients$Name[i])
  seizures.detected <- sum(df.modified$`"Useful" Electrode`)
  electrodes.placed <- length(df.modified$MRN)
  
  elasticity.curve[i,1] = seizures.detected
  elasticity.curve[i,2] = electrodes.placed
  
}

elasticity.curve <- data.frame(elasticity.curve)

colnames(elasticity.curve) <- c('# of Electrodes Detecting Seizure','# of Implanted Electrodes')
# Plot the elasticity curve w/ each row number being an electrode. The columns
# should be seen as the x and y coordinates'

ggplot(elasticity.curve, aes(x=`# of Electrodes Detecting Seizure`, y=`# of Implanted Electrodes`)) +
  geom_point()  +
  geom_smooth(method=lm)




