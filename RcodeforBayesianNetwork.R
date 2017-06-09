install.packages("bnlearn")
install.packages("readr")
library(bnlearn)
library(readr)

#Inputs
#XBeach Result input
cwd <- getwd()
data <- read_delim(paste(cwd, "/results.txt", sep=""),"\t", escape_double = FALSE, trim_ws = TRUE)
#Conditions to predict
predict.data <- read_delim(paste(cwd, "/predict.txt", sep=""),"\t", escape_double = FALSE, trim_ws = TRUE)

#fitting the data into BN
net=model2network("[Dhin][Bwin][Dain|Dhin][deltacrest|Dhin:Bwin:Dain][Erosion|Dhin:Dain:Bwin]")

fitted=bn.fit(net,data)
prederosion=predict(fitted, "Erosion", predict.data)
predcrest=predict(fitted, "deltacrest", predict.data)

#Get Outputs
write.table(predcrest, paste(cwd, "/result_deltcrest.txt", sep=""), row.names = FALSE,quote = FALSE,sep=" ")
write.table(prederosion, paste(cwd, "/result_erosion.txt", sep=""), row.names = FALSE,quote = FALSE,sep=" ")
