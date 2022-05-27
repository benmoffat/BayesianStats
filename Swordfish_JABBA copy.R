#Load Libraries/Packages
library(devtools)
library(JABBA)
library(gplots)
library(coda)
library(rjags)
library(R2jags)
library("fitdistrplus")
library(reshape)

#read in data
catch<-read.csv("swordfishcatch.csv")
cpue<-read.csv("swordfishCPUE.csv")
se<-read.csv("swordfishse.csv")

# MCMC settings
ni <- 30000 # Number of iterations
nt <- 5 # Steps saved
nb <- 5000 # Burn-in
nc <- 2 # number of chains

# Compile JABBA JAGS model and input object
jbinput = build_jabba(catch=catch,cpue=cpue,se=se,
                      model.type = "Pella", #Pella, Fox, or Schafer 
                      r.prior=c(0.578,0.217), #Informative
                      K.prior = c(125000,3), #Uninformative Lognormal 
                      add.catch.CV = TRUE,
                      )
# fit JABBA (in JAGS) ... Initialization took 1 min 3 sec
swordfish = fit_jabba(jbinput)

#Posteriors Summary Table with credible intervals
print(swordfish$estimates)

# Prior/Posterior Density Distribution PLot
jbplot_ppdist(swordfish)

#Output Plots
jbplot_catcherror(swordfish)
jbplot_cpuefits(swordfish)
jbplot_logfits(swordfish)
jbplot_trj(swordfish,type="B",add=T)
jbplot_trj(swordfish,type="F",add=T)
jbplot_trj(swordfish,type="BBmsy",add=T)
jbplot_trj(swordfish,type="FFmsy",add=T)
jbplot_spphase(swordfish,add=T)
jbplot_kobe(swordfish)
jbplot_summary(swordfish)

#Export all plots 
jabba_plots(jabba=swordfish)

#Convergence Diagnostics (Trace)
jbplot_mcmc(swordfish)





