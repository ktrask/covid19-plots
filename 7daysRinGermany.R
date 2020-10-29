library(ggplot2)
library(anytime)

csv <- read.table(file="https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Projekte_RKI/Nowcasting_Zahlen_csv.csv?__blob=publicationFile", sep = ";", dec=",",stringsAsFactors = FALSE,na.strings=c(".",""),header=TRUE)
gsub("(..)\\.(..)\\.(....)", "\\3-\\2-\\1", csv$Datum[1])
csv$Datum <- anytime(gsub("(..)\\.(..)\\.(....)", "\\3-\\2-\\1", csv$Datum)
)
ggplot(subset(csv, Datum > "2020-09-01")) + 
  geom_ribbon(aes(x=Datum,
                  ymin=UG_PI_7_Tage_R_Wert,
                  ymax=OG_PI_7_Tage_R_Wert),
              fill="#9DBCD4") +
  geom_line(aes(Datum,Schätzer_7_Tage_R_Wert),
            colour="#6D5ACF") +
  ylab("7 Tage R Wert")

  
ggsave(filename = "R-wert.svg")
