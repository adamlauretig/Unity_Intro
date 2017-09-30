library(foreach)
library(parallel)
library(doParallel)
cores<-detectCores(all.tests=TRUE)
message(paste("There are ",cores," cores on this machine."),sep="")
print(paste(Sys.timezone(),Sys.time(),sep=" ") )
registerDoParallel(cores)
#Above set up the environment that requires to proceed the bootstrapping.
bootstrap_size<-599;
#Wilcox, R. R. (2010). Fundamentals of modern statistical methods: Substantially improving power and accuracy. Springer. 
# suggests this surprisingly small number of bootstrapping sample size.
#When you increases this bootstrap_size to a larger number, you will see significant difference between the processor time between the run on Unity and your own machine.
x<-seq(1,999,1)
#Let us take 999 observations.
y<-sin(x)+rnorm(length(x),0,1)
#The true model is Y=sin(X)+error, error~N(0,1) being a Gaussian noise.
#This is not a linear regression so we need bootstrapping to estimate the variance of the coefficient estimator.
data<-data.frame(x,y)
##########
#From `foreach` package documentation
#foreach Specify the variables to iterate over
#%do%    Execute the R expression sequentially
#%dopar% Execute the R expression using the currently registered backend
##########
##########
#Usual bootstrapping using for...loop
bootstrap_C1<-c()
system.time(
  for(i in 1:bootstrap_size){
    
    bootstrap_data<-data[sample(nrow(data),nrow(data),replace=T),]
    bootstrap_C1<-c(bootstrap_C1,lm(y~x,bootstrap_data)$coef[2])
  }
)
var(bootstrap_C1)
#We use the bootstrap sample of C1 coefficient to calculate its bootstrap estimate variance.
##########
##########
#Parallel version bootstrapping foreach...
bootstrap_C1<-c()
system.time(
  bootstrap_C1<-
  foreach(i=1:bootstrap_size,.combine=c) %dopar% {
    #.combine is used to specify a function that is used to process the tasks results as they generated.
    #It is suggested that you try to use %do% instead of %dopar%to see which fits your scheme.
    size<-dim(data)[1];
    bootstrap_data<-data[sample(1:size,size,replace=T),]
    #This step resample from existing data.
    lm(y~x,bootstrap_data)$coef[2];
    #This output will be saved in bootstrap_C1 vector sequentially.
  }
)
var(bootstrap_C1)
#We use the bootstrap sample of C1 coefficient to calculate its bootstrap estimate variance.
##########
stopImplicitCluster()
#On a 8-core personal machine:
#Usual bootstrapping yields
#   user  system elapsed 
#    2.7     0.0     2.7 
#Parallel bootstrapping yields
#   user  system elapsed 
#   0.57    0.20    1.96 
#On a 24-core personal machine:
#Usual bootstrapping yields
#   user  system elapsed
#  1.199   0.042   1.242
#Parallel bootstrapping yields
#   user  system elapsed
#  2.348   0.822   0.417
#Reference: https://stackoverflow.com/questions/15978361/using-r-parallel-to-speed-up-bootstrap