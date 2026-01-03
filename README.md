# Simulating-the-Monty-Hall-Problem :door::door::door:  
*Using Simulation & Statistical Testing to Prove an Unintuitive Solution*     
#### Omar El-Ghirani | Month 00th, 202X
I've got a masters in statistics, so I'm embarrassed to admit that I did not initially understand or trust the experts who've proven the strategy to solving the Monty Hall Problem. The mathematical proofs are rock solid, but this was a case where I trusted my gut more than the math.  

The Monty Hall Problem comes from the 1970's game show *Let's Make a Deal* hosted by Monty Hall. In the game "Pick-A-Door" a lucky contestant would have the chance to win a fabulous prize if they could guess which door the prize was behind. The contestant would be given 3 doors to choose from. The contestant would pick a door, then Monty would remove one of the losing doors and ask the contestant "Do you want to switch your pick to the other door or stick with your first pick?" This question is where the Monty Hall Problem comes from. The probability theorists have proven that switching your pick gives you on average a two-thirds (2/3) chance at winning. I was skeptical that switching doors was any better than staying with the original pick as there are now 2 doors with 1 winner and 1 loser. The problem seemed more like a 50/50 chance to me.  

I am one of those who had to see it to believe it, so for this project I simulated the game 1,000 times and tested both strategies (switching doors vs not switching doors) to see if there is any difference in the outcome. 

**Spoiler Alert: There is a clearly best strategy to win the game and your chances at the end are better than 50/50 with the right strategy.**

## R Code Simulation 
The file **file name** contains the R code I created to simulate the "Pick-A-Door" game 1,000 times. The code uses a binomial distribution in each trial/play of the game to randomly select the winning door. The code also uses another binomial distribution in each trial/play of the game to randomly assign the contestants first pick. In the case where the winning door and the door selected for the first pick are not the same, the remaining losing door is removed. In the case where the winning door is picked first another binomial distribution is used to randomly remove one of the losing doors. After the removal of the losing door in each case, both strategies are implemented. One strategy where the final pick comes from switching from the first door picked and one strategy where the final pick is the original door picked. In each trial/play of the game, only one strategy can be the correct.  

After 1,000 trials the results seem to confirm what has already been proven. Switching your pick after one of the losing doors is removed, gives nearly a two-thirds or 67% chance of winning the game. 

## Simulation Results 
<img width="1200" height="711" alt="Image" src="https://github.com/user-attachments/assets/57a7de96-69bb-4bac-a91c-9991d37b65bb" />  

## Hypothesis Testing  
The results displayed above support the proven theory that switching doors after a losing door has been removed is the best strategy to win the game. While a picture is worth a thousand words a hypothesis test will be worth so much more to the credibility of each strategy.  

In each trial/play of the game there are only 2 possible outcomes, selecting the right or wrong door. We also have a fixed number of trials in this case (1,000 trials/plays of the game). This is the perfect setup to use the properties of the binomial distribution for hypothesis testing. The aim of the hypothesis test is to approximate the true probability of winning the game for each strategy.  

### The Probability of Winning by Switching Doors:
- **1st Test: $H_0$: P(success = 0.50) vs $H_1$: P(success > 0.50)** In English the first hypothesis we are testing is that the probability of picking the correct door is equal to 0.50 (a 50/50 chance) compared to the alternative hypothesis that our probability of picking the correct door is greater than 0.50. 
  - **Result:** The observed number of successes was 667. The probability of getting 667 success in 1,000 trials is nearly 0. Under $H_0$ our expected number of successes is 500 (n x p i.e. 1,000 x 0.50 due to the binomial distribution). Our p-value is much smaller than 0.05 or 0.01 (see code for details) and thus we have evidence to reject $H_0$ in favor of the alternative that the probability of winning by switching doors is greater than 0.5.
- **2nd Test: $H_0$: P(success = 0.67) vs $H_1$: P(success != 0.67)** In the second hypothesis we are testing if the probability of picking the correct door is equal to 0.67 (a two-thirds chance) compared to the alternative hypothesis that our probability of picking the correct door does not equal 0.67. 
  - **Result:** The observed number of successes was 667. The probability of getting 667 success in 1,000 trials is approximately 42%. Under $H_0$ our expected number of successes is 670 (n x p i.e. 1,000 x 0.50 due to the binomial distribution). Our observed number of successes almost the same as our expected number. With just this result we don't have to use any statistical tests to know that our p-value is much larger than 0.05 and thus we have evidence in support of $H_0$. (Using the normal approximation to the binomial distribution our p-value is approximately 0.84. See code for details)

### The Probability of Winning by Not Switching Doors:
- **1st Test: $H_0$: P(success = 0.50) vs $H_1$: P(success < 0.50)** 
  - **Result:** The observed number of successes was 333. The probability of getting 333 success in 1,000 trials is nearly 0. Under $H_0$ our expected number of successes is 500 (n x p i.e. 1,000 x 0.50 due to the binomial distribution). Our observed value of 333 is less than our expected value of 500 which is the reason why this the alternative is less than 0.5 and different than the alternative used in the first test for the other strategy. Our p-value here is much smaller than 0.05 or 0.01 (see code for details) and thus we have evidence to reject $H_0$ in favor of the alternative. 
- **2nd Test: $H_0$: P(success = 0.67) vs $H_1$: P(success != 0.67)** 
  - **Result:** The observed number of successes was 333. Under $H_0$ our expected number of successes is 670 (n x p i.e. 1,000 x 0.50 due to the binomial distribution). Our observed number of successes is far fewer than the expected number of successes. Using the normal approximation to the binomial distribution, under $H_0$ our p-value is approximately 0 (see code for details). This suggests that we have evidence in favor of the alternative hypothesis that the probability of success is not 0.67. However, we already knew this from our previous test, but in fairness to both strategies testing is kept as similar as possible to avoid any potential biasing.  
- **3rd Test: $H_0$: P(success = 0.33) vs $H_1$: P(success != 0.33)** 
  - **Result:** The observed number of successes was 333. Under $H_0$ our expected number of successes is 330 (n x p i.e. 1,000 x 0.33 due to the binomial distribution). Our observed number of successes is greater than the expected number of successes. Using the normal approximation to the binomial distribution, under $H_0$ our p-value is approximately 1 (see code for details). This suggests that we do not have evidence in favor of the alternative hypothesis and thus can conclude the best approximation for the probability of success by not switching doors is 0.33.

## Conclusion & How I Think of the Monty Hall Problem Now  
I can now conclude that switching doors after the first door is picked and a losing door is removed gives on average 67% chance of picking the correct door and winning the game. Sticking with your first gut feeling and not switching your door after a losing door is removed doesn't leave you with a 50/50 chance at winning the game. Not switching leaves you with an average of 33% chance of winning. 

Now when I think of the monty hall problem, instead of asking what is my probability of guessing right on the first guess I think what is my probability of guessing wrong? With that mindset, the probability of guessing wrong on the first guess is 2/3rds or 67%. After the host removes a door, we gain more information and know that 1 losing door has been removed. My first guess still has that initial 67% probability of being the incorrect door which leaves 1 other door with a much higher probability of being correct.  

In hindsight, I can say I'm no longer embarrassed about my initial skepticism to the mathematical proofs that already told me what my simulation has shown. The Monty Hall Problem is famously counterintuitive. Running this simulation transformed an abstract proof into something real and made the correct strategy impossible to ignore.

**Mathematical Proof for Reference:** https://www.montyhallproblem.com/as.html 
