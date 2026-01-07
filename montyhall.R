library(dplyr)
library(ggplot2)
`%nin%` = Negate(`%in%`)

# this section shows the method used to select the winning door is uniformly distributed between Doors 1, 2, & 3 in 1,000 trials (game plays)
set.seed(123)
trials = 1000
i = 1
winners = c()
while(i<=trials){
winner = runif(1,min=1,max=4)
doors = c("Door 1","Door 2","Door 3")
winners = append(winners, doors[floor(winner)])
i = i + 1
}
table(winners)/trials

# The code below simulates playing the "Pick-A-Door" game in a set number of trials (game plays)
# In the example below the number of trials is set to 1,000 by the "trials" variable
# In each trial both strategies (switching and not-switching) are both implemented
# The outcome of each trial is stored in the data frames below

set.seed(1)
# switch_door_correct is a dataframe to store the outcome of each trial (play of the game)
# where the strategy is to switch the final door picked from the original to the door remaining after a losing door was removed post the initial pick
# a 1 in the "correct" column represents winning the game and getting the big prize
switch_door_correct = as.data.frame(matrix(NA,ncol = 2))
colnames(switch_door_correct) = c("trial","correct")

# dont_switch_door_correct is a dataframe to store the outcome of each trial (play of the game)
# where the strategy is not switch the final door picked and stay with the original selection after a losing door was removed post the initial pick
# a 1 in the "correct" column represents winning the game and getting the big prize
dont_switch_door_correct = as.data.frame(matrix(NA,ncol = 2))
colnames(dont_switch_door_correct) = c("trial","correct")

# the number of trials (game plays) used to simulate the game
trials = 1000

i = 1
while(i <= trials){
  
# randomly assigning which door is the winner each trial
winner = runif(1,min=1,max=4)
doors = c("Door 1","Door 2","Door 3")
doors[floor(winner)]

# randomly picking a door as a first guess/pick
guess1 = runif(1,min=1,max=4)
doors[floor(guess1)]

# this makes sure that doors2 always has 2 doors left
# creating a vector called "doors2" which represents 2 doors left after the first pick is made 
# doors2 contains the winning door and the original door picked
# there are 2 scenarios that can take place, the fist pick is the winning door or the first pick is not the winning door. 
# the if/else statement handles these 2 scenarios
if(doors[floor(winner)] == doors[floor(guess1)]){
  doors2 = doors[ c( floor(guess1), which(doors != doors[floor(guess1)])[floor(runif(1,1,3))] ) ]
  # this ensures that if the initial guess is correct 2 doors are left
  # the door to keep is randomly selected because which(doors != doors[floor(guess1)]) will always have 2 entries
  # which(doors != doors[floor(guess1)])[floor(runif(1,1,3))] randomly selects the first or second entry in the remaining 2 wrong answers to keep
}else{doors2 = doors[-which(doors %nin% c(doors[floor(guess1)],doors[floor(winner)]))]}
# if the initial guess is not the winner this removes the other incorrect door

# switch_door represents the final pick by switching from the initial pick to the remaining door
switch_door = doors2[which(doors2 %nin% doors[floor(guess1)])]

# dont_switch_door represents the final pick by sticking with the original pick
dont_switch_door = doors2[which(doors2 %in% doors[floor(guess1)])]

# adds the results of the final pick to the dataframes to store the results
if(switch_door == doors[floor(winner)]){switch_door_correct = rbind(switch_door_correct,c(i,1))}else{switch_door_correct = rbind(switch_door_correct,c(i,0))}
if(dont_switch_door == doors[floor(winner)]){dont_switch_door_correct = rbind(dont_switch_door_correct,c(i,1))}else{dont_switch_door_correct = rbind(dont_switch_door_correct,c(i,0))}

i = i + 1 
}
# removing the first empty row from each dataframe of results
switch_door_correct = na.omit(switch_door_correct)
dont_switch_door_correct = na.omit(dont_switch_door_correct)
# the total tally of correct guesses by each strategy 
sum(switch_door_correct$correct)
sum(dont_switch_door_correct$correct)

# aggregating data for plotting
plotdata = rbind(
  switch_door_correct %>%
    summarise(
      strategy = "Switch Doors",
      trial = trial, 
      correct = cumsum(correct))
  ,
  dont_switch_door_correct %>%
    summarise(
      strategy = "Don't Switch Doors",
      trial = trial, 
      correct = cumsum(correct))
)

ggplot(plotdata, aes(x = trial, y = correct, color = as.factor(strategy)))+geom_line(size = 1.05)+
  geom_label(data = plotdata %>% filter(trial == max(trial)), aes(label = correct, x = trials, y = correct), inherit.aes = FALSE)+
  scale_color_manual(values = c("Switch Doors" = "blue", "Don't Switch Doors" = "red"))+
  labs(color = "Strategy")+
  xlab("Number of Trials")+
  ylab("Number Correct")+
  ggtitle("Correct Picks in 1,000 Trials")+
  guides(color = guide_legend(reverse = TRUE))+
  theme(axis.text.x = element_text(face = "bold")
        ,axis.text.y = element_text(face = "bold"))

# #hypothesis testing
# The Probability of Winning by Switching Doors:
# h_0: p(success) = 0.5 vs h_1: p(success) > 0.5
# observed_value <- sum(switch_door_correct$correct)
# expected_value <- 0.5*trials
# p_value <- pbinom(q = sum(switch_door_correct$correct), prob = 0.5, size = trials, lower.tail = FALSE)
# since the number of doors correctly picked by the switching doors strategy is greater than the expected value given by prob* trials, 
# the hypothesis test will check if the observed value is in the upper tail of the distribution. Hence the option lower.tail = FALSE is selected
# interpretation <- paste("Our p-value,",p_value, ",is much smaller than 0.05 or 0.01, and thus we have evidence to reject h_0 in favor of the alternative that the probability of winning by switching doors is greater than 0.5.")

# h_0: p(success) = 0.67 vs h_1: p(success) != 0.67
# using the normal appoximation to the binomial
# observed_value <- sum(switch_door_correct$correct)
# expected_value <- 0.67*trials
# npq <- 0.67*trials*(1-0.67)
# z = (observed_value-expected_value)/sqrt(npq)
# p_value <- 2*pnorm(z)
# multiplied by 2 for 2 tailed test
# interpretation <-paste("Our p-value,",p_value," is much larger than 0.05, and thus we have evidence in support of h_0.")

# The Probability of Winning by Not Switching Doors
# h_0: p(success) = 0.5 vs h_1: p(success) < 0.5
# observed_value <- sum(dont_switch_door_correct$correct)
# expected_value <- 0.5*trials
# p_value <- pbinom(q = sum(dont_switch_door_correct$correct), prob = 0.5, size = trials, lower.tail = TRUE)
# since the number of doors correctly picked by the NOT switching doors strategy is less than the expected value given by prob* trials, the hypothesis test will check if the observed value is in the lower tail of the distribution. Hence the option lower.tail = TRUE is selected
# interpretation <- paste("Our p-value,",p_value, "is much smaller than 0.05 or 0.01 and thus we have evidence to reject h_0 in favor of the alternative that the probability of winning by switching doors is less than 0.5.")

# h_0: p(success) = 0.67 vs h_1: p(success) != 0.67
# observed_value <- sum(dont_switch_door_correct$correct)
# expected_value <- 0.67*trials
# npq <- 0.67*trials*(1-0.67)
# z = (observed_value-expected_value)/sqrt(npq)
# p_value <- 2*pnorm(z)
# multiplied by 2 for 2 tailed test
# interpretation <- paste("Our p-value,",p_value, "suggests that we have evidence in favor of the alternative hypothesis that the probability of success is not 0.67.")

# h_0: p(success) = 0.33 vs h_1: p(success) != 0.33
# observed_value <- sum(dont_switch_door_correct$correct)
# expected_value <- 0.33*trials
# npq <- 0.33*trials*(1-0.33)
# z = (observed_value-expected_value)/sqrt(npq)
# p_value <- 2*pnorm(z)
# multiplied by 2 for 2 tailed test
# interpretation <- paste("our p-value is approximately",p_value, "this suggests that we do not have evidence in favor of the alternative hypothesis and thus can conclude the best approximation for the probability of success by not switching doors is 0.33.")