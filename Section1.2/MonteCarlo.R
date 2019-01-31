## Monte Carlo simulations

# let's sample one bead from the jar
beads <- rep(c("red","blue"), times = c(2,3))
sample(beads, 1)

# let's do Monte Carlo simulation
# of doing sampling from the jar 
# 10000 times
B <- 10000
events <- replicate(B, sample(beads,1))
events



