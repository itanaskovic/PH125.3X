## Monte Carlo simulations for famous Monty Hall problem
# the problem is named after famous game show host (for more info, see: https://en.wikipedia.org/wiki/Monty_Hall_problem ,
# and for the explanation of the counter-intuitive nature of this problem,
# see this video: https://www.khanacademy.org/math/precalculus/prob-comb/dependent-events-precalc/v/monty-hall-problem

## contestant has two choices "stick" or "switch"; which one she should choose to increse her odds of winning a prize?

# Monte Carlo simulation for the "stick strategy" case:
B <- 10000
stick <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("goat","prize","goat"))
  prize_door <- doors[prize == "prize"]
  my_pick <- sample(doors,1)
  show <- doors[!doors %in% c(my_pick,prize_door)]
  stick <- my_pick
  stick == prize_door
})
mean(stick)

# Monte Carlo simulation for the "switch strategy" case:
switch <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("goat","prize","goat"))
  prize_door <- doors[prize == "prize"]
  my_pick <- sample(doors,1)
  show <- sample(doors[!doors %in% c(my_pick,prize_door)], 1)
  switch <- doors[!doors%in%c(my_pick,show)]
  switch == prize_door
})
mean(switch)

