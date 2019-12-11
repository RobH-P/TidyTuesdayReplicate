library(tidyverse)
library(dslabs)
library(janitor)
library(ggplot2)
library(hrbrthemes)
library(magick)
library(cowplot)



??dslabs
#Superbowl champions by team
#source: https://www.businessinsider.com/most-super-bowl-wins-by-team-2017-12?r=US&IR=T

# read in the data

superb_owls <- read_csv("/Users/robhal1/Downloads/NFL Championship - Sheet1.csv")
names(superb_owls)
superb_owls <- clean_names(superb_owls)

#remove New England Patriots and Philadephia Eagles last wins

owls1 <- superb_owls[-c(52,53),]

# amend wins - to include moved/renamed franchises 
owls1$winning_team <- gsub("Baltimore Colts","Indianapolis Colts", owls1$winning_team, ignore.case = T) 
owls1$winning_team <- gsub("Los Angeles Raiders", "Oakland Raiders",  owls1$winning_team, ignore.case = T)
#sort data

owls2 <- owls1 %>% 
  count(winning_team) %>% 
  arrange(desc(n))


ggplot(owls2, aes(x=reorder(winning_team, n), y=n)) +
  geom_bar(stat="identity", colour="#003333", width = 0.45) +
  labs(title = "SUPER BOWL CHAMPIONSHIPS", x = "", y = "") +
  coord_flip()
 
# add values to the end of the bar chart

owls3 <- ggplot(owls2, aes(x=reorder(winning_team, n), y=n)) +
  geom_bar(stat="identity", colour="aquamarine", width = 0.45) +
  labs(title = "SUPER BOWL CHAMPIONSHIPS", x = "", y = "") +
  theme(legend.position = "none", axis.title=element_text(face="bold",size="10",color="black"),axis.text=element_text(size=10,face="bold")) +
  coord_flip() +
  geom_text(data = owls2, nudge_y = 0.5, angle = 0,
                          aes(x = winning_team, y = n, label = n)) 


# add caption to bar plot
owls3 <- owls3 + labs(caption = "The Arizona Cardinals, Atlanta Falcons, Buffalo Bills, Carolina Panthers, Cincinnati Bengals, Cleveland Browns, Detroit Lions, Houston Texans, Jackonsville Jaguars,\n Minnesota Vikings, Philadelphia Eagles, San Diego Chargers and Tennessee Titans all have 0 Super Bowl wins\n Source: Pro-Football Reference") 
owls3


#hex value not seem to work #003333
#text(x,y+2,labels=as.character(y))
#cmyk(0,50,85,0)
#rgb(41,93,124, max=255)
 

