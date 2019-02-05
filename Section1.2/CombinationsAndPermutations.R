## Combinations and Permutations

# let's construct deck of cards by using R's functions:
# expand.grid()
# we use paste for joining smaller strings 
# paste()

number <- "Three"
suit <- "Hearts"
paste(number,suit)

## it also works on pair of vectors
paste(letters[1:5],as.character(1:5))

# the function expand.grid() gives us all the combinations of two lists
expand.grid(pants=c("blue","black"), shirt=c("white","gray","plaid"))

# here is how we can generate a dec of cards
suits <- c("Diamonds", "Hearts", "Clubs", "Spades")
numbers <- c("Ace","Deuce","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Jack","Queen","King")
deck <- expand.grid(number=numbers,suit=suits)
deck <- paste(deck$number,deck$suit)

# let's see what is probability of drawing King from a deck (is it 1/13?)
kings <- paste("King", suits)
kings
mean(deck %in% kings) == 1/13

# now, what about probability that second card would be a King?
# let's use library gtools and it's functions permutations() and combinations() for this purpose
library(gtools)
permutations(5,2)

# another example; generate all permutations of possible phone numbers and pick 5 from it
all_phone_numbers <- permutations(10,7, v=0:9)
n <- nrow(all_phone_numbers)
index <- sample(n,5)
all_phone_numbers[index,]

# to compute all possible ways that we can choose two cards when the order matters,
# we can use this code: 
hands <- permutations(52,2, v=deck) # 52 cards, we're going to chose two, and we are going to select them from vector that contains their names
# let's grab a cards by grabbin first and second column
first_card <- hands[,1]
second_card <- hands[,2]
# and check how many cases have a first card that is a king
sum(first_card %in% kings)
# ant then to find conditional probability we ask what fraction of this 204 have also King in the second card
sum(first_card %in% kings &second_card %in% kings) / sum(first_card %in% kings)
# and that is 3 out of 51, as what we already deduced:
(sum(first_card %in% kings &second_card %in% kings) / sum(first_card %in% kings)) == 3/51

## now what if order doesn't matter? then we enumerate combinations not the permutations
# example: in blackjack, if you get Ace and a face card or a ten, it's called natural 21, and you win automatically
# if we want to compute probability of this happening, we wan't to enumerate combinations not permutations, since order doesn't matter:
# if you get an A and a King, or King and an A, it's still 21 (WE DON'T WANT TO COUNT THAT TWICE)
## N.B. permutations() list all permutations and combinations() where order does not matter!
permutations(3,2)
combinations(3,2)
# so, to compute probability of a natural 21 in blackjack we can do this:
# first we can define a vector that includes all the Aces
aces <- paste("Ace",suits)
# a vector that includes all the face cards:
facecard <- c("King", "Queen", "Jack", "Ten")
facecard <- expand.grid(number=facecard, suit=suits)
facecard <- paste(facecard$number,facecard$suit)
# and then we generate all the combinations of picking 2 cards out of 52
hands <- combinations(52,2,v=deck)
# and then we simply count how often do we get Aces and a face card:
mean(hands[,1] %in% aces & hands[,2] %in% facecard)
# in the previous peace of code we assumed that Aces come first. 
# This is only because we know the way that combination generates and enumerates possibilities
# But if we wan't to be safe, we can type this code which considers both possibilities:
mean((hands[,1] %in% aces & hands[,2] %in% facecard) | (hands[,2] %in% aces & hands[,1] %in% facecard))

## instead of using combinations to deduce the exact probability of a natural 21, we can also use Monte Carlo to estimate this probability
# In this case we draw 2 cards over and over and keep track of how many 21's we get
# We can use function sample() to draw a card with replacement like this:
hand <- sample(deck, 2)
hand
# we simply run this over and over again, and we get a very good approximation:
B <- 10000
results <- replicate(B, {
  hand <- sample(deck, 2)
  (hand[1] %in% aces & hand[2] %in% facecard) |
    (hand[2] %in% aces & hand[1] %in% facecard)
})
mean(results)