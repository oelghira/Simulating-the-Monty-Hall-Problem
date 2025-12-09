# Simulating-the-Monty-Hall-Problem :door::door::door:
#### Omar El-Ghirani | Month 00th, 202X
I've got a masters in statistics, so I'm embarrsed to admit that I did not initially understand or trust the experts who've proven the strategy to solving the Monty Hall Problem. The mathematical proofs are rock solid, but this was a case where I trusted my feelings more so than the math.  

The Monty Hall Problem comes from the 1970's game show "Let's Make a Deal" hosted by Monty Hall. In the game "Pick-A-Door" a lucky contestant would have the chance to win a fabulous prize if they could guess which door the prize was behind. The contestant would be given 3 doors to choose from. The contestant would pick a door, then Monty would remove one of the losing doors and ask the contestant "Do you want to switch your pick to the other door or stick with your first pick?" This question is where the Monty Hall Problem comes from. The probability theorists have proven that switching your pick gives you on average a two-thirds (2/3) chance at winning. I was skeptical that switching doors was any better than staying with the original pick as there are now 2 doors with 1 winner and 1 loser. The problem seemed more like a 50/50 chance to me.  

I am one of those who had to see it to believe it, so for this project I simulated the game 1,000 times and tested both strategies (switching doors vs not switching doors) to see if there is any difference in the outcome. 

**Spoiler Alert: The strategy that was already proven is the best method to win the game**  

**can i find an actual clip of the game from the show?? turns out it is really effing hard to find an actual clip of just this game**

## R Code Simulation 
The file **file name** contains the R code I created to simulate the "Pick-A-Door" game 1,000 times. The code uses a binomial distribution in each trial/play of the game to randomly select the winning door. The code also uses another binomial distribution in each trial/play of the game to randomly assign the contestants first pick. In the case where the winning door and the door selected for the first pick are not the same, the remaining losing door is removed. In the case where the winning door is picked first another binomial distribution is used to randomly remove one of the losing doors. After the removal of the losing door in each case, both strategies are implimented. One strategy where the final pick comes from switching from the first door picked and one strategy where the final pick is the original door picked. In each trial/play of the game, only one strategy can be the correct.  

After 1,000 trials the results seem to confirm what has already been proven. Switching your pick after one of the losing doors is removed, gives nearly a two-thirds or 67% chance of winning the game. 

## Simulation Results :gear::repeat::chart_with_upwards_trend:
<img width="1200" height="711" alt="Image" src="https://github.com/user-attachments/assets/57a7de96-69bb-4bac-a91c-9991d37b65bb" />  
## Hypothesis Testing

## Conclusion/How to think of the monty hall problem now  
now i think of the monty hall problem and instead of asking what is my probability of guessing right on the first guess I think what is my probability of guessing wrong? With that mindset, the probability of me guessing wrong on the first guess is 2/3rds or 0.67. After the host removes a door, the 2/3rds probability of guessing wrong is now condensed into my first guess. That means my probability of guessing right on my first try is now 1/3rd and the probability of the other door being correct is now 2/3rds (exactly what the simulation found). Thus switching is much better than sticking with my first guess. 
