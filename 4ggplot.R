#### Data visualization with ggplot2 ####

# loading library
library(tidyverse)
?ggplot

# read in data and assign to object
birth_reduced <- read.csv("data/birth_reduced.csv")
smoke_complete <- read.csv("data/smoke_complete.csv")

# create directory for figures
dir.create("figures")

# plotting with base R
plot(x=smoke_complete$age_at_diagnosis, y=smoke_complete$cigarettes_per_day)

#### intro to ggplot2 and scatterplots ####

# create a simple ggplot
ggplot(data = smoke_complete, # binds data to plot
       aes(x = age_at_diagnosis, y = cigarettes_per_day)) + #aesthetic, mapping data to plot
  geom_point() # geometry, shapes to represent data

# assign basic plot to an object
smoke_plot <- ggplot(data = smoke_complete, 
                     aes(x=age_at_diagnosis, y=cigarettes_per_day)) 

# plot using object
smoke_plot + geom_point()

# building plots iteratively
smoke_plot +
  geom_point(alpha=0.1) # changes transparency
smoke_plot +
  geom_point(alpha=0.1, color="blue") # change color
# color points by disease/cancer type
smoke_plot +
  geom_point(alpha=0.3, aes(color=disease))
# change background theme
smoke_plot +
  geom_point(alpha=0.3, aes(color=disease)) +
  theme_bw()
# add title and custom axis labels
smoke_plot +
  geom_point(alpha=0.3, aes(color=disease)) +
  labs(title="Age at diag vs cigs per day",
       x="age (days)",
       y="cigarettes per day") +
  theme_bw()
# save plot to file
ggsave("figures/awesomePlot.jpg")
?ggsave

## Challenge: create a scatterplot showing age at diagnosis vs years smoked with points colored by gender (centered title)
ggplot(data=smoke_complete,
       aes(x=age_at_diagnosis, 
           y=years_smoked, color=gender)) +
  geom_point()
ggplot(data=smoke_complete,
       aes(x=age_at_diagnosis, 
           y=years_smoked)) +
  labs(title="title") +
  geom_point(aes(color=gender)) +
  theme(plot.title = element_text(hjust = 0.5)) + # centers the title
  theme_bw()

#### Boxplots ####

# creating a box and whisker plot
ggplot(data=smoke_complete,
       aes(x=vital_status, y=cigarettes_per_day)) +
  geom_boxplot()
# adding colored points to a black box plot
ggplot(data=smoke_complete,
       aes(x=vital_status, y=cigarettes_per_day)) +
  geom_boxplot() +
  geom_jitter(alpha=0.3, color="tomato")

## Challenge:
# what happens if you specify the color with geom_boxplot? Why?
ggplot(data=smoke_complete,
       aes(x=vital_status, y=cigarettes_per_day)) +
  geom_boxplot(color="tomato")
# Does the order of geom layers matter?
ggplot(data=smoke_complete,
       aes(x=vital_status, y=cigarettes_per_day)) +
  geom_jitter(alpha=0.3, color="tomato") +
  geom_boxplot()
# plot the same data as violin plot
ggplot(data=smoke_complete,
       aes(x=vital_status, y=cigarettes_per_day)) +
  geom_violin(color="tomato")

#### plotting time series data (line plots) ####

# count number of observations for each disease by year of birth
yearly_counts <- birth_reduced %>%
  count(year_of_birth, disease)

# plot all counts by year
ggplot(data=yearly_counts,
       aes(x=year_of_birth, y=n)) +
  geom_line()

# plot one line per cancer type
ggplot(data=yearly_counts,
       aes(x=year_of_birth, y=n, group=disease)) +
  geom_line()

# plot one colored line per cancer type
ggplot(data=yearly_counts,
       aes(x=year_of_birth, y=n, color=disease)) +
  geom_line()

## Challenge: create a plot of birth year and number of patients with two lines representing each gender (hint: create a new count object!)
yearly_counts2 <- birth_reduced %>%
  count(year_of_birth, gender)
ggplot(data=yearly_counts2, 
       aes(x=year_of_birth, y=n, color=gender)) +
  geom_line(aes(linetype=gender))
# how could you change the line appearance besides changing color? dashes, dots, etc

#### Faceting ####

# count observations by disease, year of birth, and vital status
yearly_vital_counts <- birth_reduced %>%
  count(year_of_birth, disease, vital_status)

# plot each cancer type in separate panels with lines colored by vital status
ggplot(data=yearly_vital_counts, 
       aes(x=year_of_birth, y=n, 
           color=vital_status)) +
  geom_line() +
  facet_wrap(~disease)

# plot each vital status in separate panels with lines colored by disease
ggplot(yearly_vital_counts,
       aes(x=year_of_birth, y=n,
           color=disease)) +
  geom_line() +
  facet_grid(vital_status ~ .)

# change arrangement of panels
ggplot(yearly_vital_counts,
       aes(x=year_of_birth, y=n,
           color=disease)) +
  geom_line() +
  facet_grid(. ~ vital_status)

# plot diseases and vital status in different panels
ggplot(yearly_vital_counts,
       aes(x=year_of_birth, y=n,
           color=disease)) +
  geom_line() +
  facet_grid(vital_status ~ disease)
