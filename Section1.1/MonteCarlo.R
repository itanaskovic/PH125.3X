## Monte Carlo simulations

# let's sample one bead from the jar
beads <- rep(c("red","blue"), times = c(2,3))
sample(beads, 1)
beads

# let's do Monte Carlo simulation
# of doing sampling from the jar 
# 10000 times
B <- 10000
events <- replicate(B, sample(beads,1))
events

#let's print table of events in the more read
tab <- table(events)
tab
prop.table(tab)

## also we could sample without replace
events <- sample(beads,B,replace = TRUE)
prop.table(table(events))

## Assesment 1

beads <- rep(c("cyan","magenta","yellow"), times = c(3,5,7))
events <- sample(beads,B,replace = TRUE)
prop.table(table(events))

beads <- rep(c("cyan","magenta","yellow"), times = c(2,5,7))
events <- sample(beads,B,replace = TRUE)
prop.table(table(events))
