library(devtools)
library(JABBA)
library(gplots)
library(coda)
library(rjags)
library(R2jags)
library("fitdistrplus")
library(reshape)

data(iccat)
iccat$bet
# Compile JABBA JAGS model and input object for bigeye tuna (bet)
jbinput = build_jabba(catch=iccat$bet$catch,cpue=iccat$bet$cpue,se=iccat$bet$se,assessment="BET",scenario = "TestRun",model.type = "Fox",sigma.est = FALSE,fixed.obsE = 0.01)

# Fit JABBA (here mostly default value - careful)
bet1 = fit_jabba(jbinput,quickmcmc=TRUE)

# Make individual plots
jbplot_catcherror(bet1)
jbplot_ppdist(bet1)
jbplot_cpuefits(bet1)
jbplot_logfits(bet1)

# Plot Status Summary
par(mfrow=c(3,2),mar = c(3.5, 3.5, 0.5, 0.1))
jbplot_trj(bet1,type="B",add=T)
jbplot_trj(bet1,type="F",add=T)
jbplot_trj(bet1,type="BBmsy",add=T)
jbplot_trj(bet1,type="FFmsy",add=T)
jbplot_spphase(bet1,add=T)
jbplot_kobe(bet1,add=T)
# Test run end