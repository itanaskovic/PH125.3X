## The Birthday Problem
# Suppose you're in a classroom with 50 people. If we assume that this is a randomly selected group, what is a chance that
# at least two people have the same birthday?

# Deducing it mathematicaly is a bit advanced (see notebook for the notes on how to do it), but we can do Monte Carlo simulations to get answer
# (for simplicity we assumed that nobody was born on February 29th; this actually doesn't change result very much)
# first, note that birthdays can be represented as numbers between 1 and 365. So a smple of 50 random birthdays can be obtained simply by:
n <- 50
bdays <- sample(1:365, n, replace = TRUE)
# to check if, in this particular set of 50 people we have at least two with same birthday, we can use function duplicated() which returns TRUE 
# whenever an element of a vector has already appeared in that vector.
# example:
duplicated(c(1,2,3,2,1,4,5))
any(duplicated(c(1,2,3,2,1,4,5)))
# so to check for duplicated birthdays we simply do:
any(duplicated(bdays))
# to estimate probability, we're going to run a Monte Carlo simulation over and over again:
B <- 10000
results <- replicate(B, {
  bdays <- sample(1:365, n, replace = TRUE)
  any(duplicated(bdays))
})
mean(results)

## For which given number n of the people in the group, when are the chances larger then 75% or 50%? 
# Let's create lookup table. We can quickly create a function to compute this for any group:
compute_prob <- function(n, B=10000) {
  same_days <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_days)
}
# we want to apply this function to several values of n, let's say from 1 to 60. We can use for loop to apply this function to each value in n,
# but it turns out that for loops are rarely the preffered approach in R. In general, we try to perform operations on entire vectors. Arithmetic
# operations, for example, operate on vectors in an element wise fashion:
x <- 1:10
sqrt(x)
# function we defined expects scalar (single value). To make it work on vectors, we use function sapply()
n <- 1:60
prob <- sapply(n,compute_prob)

## Let's calculate exact probability instead of this Monte Carlo simulation 
# (actually, we are calculatin opposite presumption because it's easier, see notebook for the notes and explanation)
exact_prob <- function(n){
  prob_unique <- seq(365,365-n+1)/365
  1 - prod(prob_unique)
}
# we can compute each probability for each n by using sapply() like this:
eprob <- sapply(n,exact_prob)
plot(n,prob)
lines(n,eprob, col = "red")

## How many Monte Carlo experiments are enough?
# We know that larger the number of experiments (B) is the better is approximation. But how big does B need to be?
# Here is an practical approach that checks for the stability of the estimate in the case of the birthday problem:
B <- 10^seq(1,5,len=100)
compute_prob <- function(B, n=22) {
  same_days <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_days)
}
prob <- sapply(B, compute_prob)
plot(log10(B),prob,type = 'l')
