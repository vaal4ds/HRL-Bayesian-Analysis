# 1. LOADING DATASET and EDA ----------------------------------------------

##create datalist with data from 2015 Gershman paper

#First part: create datalist for joint D1 + D2
#load D1 (contains 4 studies, 166 participants in all)
GershmanData_d1 <- read.csv("C:/Users/Val/Desktop/DATASCIENCE/2semnew/SDS2/Avino_sds2_project/behavioral_data/GershmanData_d1.csv", stringsAsFactors = FALSE)

#remove random column that gets created
GershmanData_d1$X.1 <- NULL

# Check that all subject have done 100 trials
all(GershmanData_d1$N == 100) # FALSE
GershmanData_d1$N[which( GershmanData_d1$N != "" )]

# there is one subject with N = 75 --> remove it
removeSubj <- GershmanData_d1$name[which(GershmanData_d1$N == 75)]
index <- which(GershmanData_d1$name == removeSubj)
GershmanData_d1_cleaned <- GershmanData_d1[-c(index:(index+75)),]

#remove extra headers
index2 <- which(GershmanData_d1_cleaned$name == "name")
GershmanData_d1_cleaned <- GershmanData_d1_cleaned[-c(index2),]

#turn name column into something sensible(ish)
subj <- c(1:165)
k <- 1
for (i in subj){
  GershmanData_d1_cleaned$name[k:(k+(100-1))] <- i
  k <- 100 + k
}

#add trial number column 
i <- 1
GershmanData_d1_cleaned$trial_number[which(GershmanData_d1_cleaned$name == i)] <- c(1:100)
head(GershmanData_d1_cleaned)

##load D2 (1 study with 4 blocks = stimulus , 40 participants)

#load test block to get trial number up to 100
GershmanData_d2_b1 <- read.csv("C:/Users/Val/Desktop/DATASCIENCE/2semnew/SDS2/Avino_sds2_project/behavioral_data/GershmanData_d2_block1_test.csv", stringsAsFactors = FALSE)
GershmanData_d2_b2 <- read.csv("C:/Users/Val/Desktop/DATASCIENCE/2semnew/SDS2/Avino_sds2_project/behavioral_data/GershmanData_d2_block2_test.csv", stringsAsFactors = FALSE)
GershmanData_d2_b3 <- read.csv("C:/Users/Val/Desktop/DATASCIENCE/2semnew/SDS2/Avino_sds2_project/behavioral_data/GershmanData_d2_block3_test.csv", stringsAsFactors = FALSE)
GershmanData_d2_b4 <- read.csv("C:/Users/Val/Desktop/DATASCIENCE/2semnew/SDS2/Avino_sds2_project/behavioral_data/GershmanData_d2_block4_test.csv", stringsAsFactors = FALSE)

#remove random column that gets created
GershmanData_d2_b1$X.1 <- NULL
GershmanData_d2_b2$X.1 <- NULL
GershmanData_d2_b3$X.1 <- NULL
GershmanData_d2_b4$X.1 <- NULL

#remove extra headers
index <- which(GershmanData_d2_b1$N == "N")
GershmanData_d2_b1 <- GershmanData_d2_b1[-c(index),]

index <- which(GershmanData_d2_b2$N == "N")
GershmanData_d2_b2 <- GershmanData_d2_b2[-c(index),]

index <- which(GershmanData_d2_b3$N == "N")
GershmanData_d2_b3 <- GershmanData_d2_b3[-c(index),]

index <- which(GershmanData_d2_b4$N == "N")
GershmanData_d2_b4 <- GershmanData_d2_b4[-c(index),]

#create a name column for subject ID
#block 1
GershmanData_d2_b1$name <- 0
subj <- c(1:40)
k <- 1
for (i in subj){
  GershmanData_d2_b1$name[k:(k+(25-1))] <- i
  k <- 25 + k
}

#block 2
GershmanData_d2_b2$name <- 0
k <- 1
for (i in subj){
  GershmanData_d2_b2$name[k:(k+(25-1))] <- i
  k <- 25 + k
}

#block 3
GershmanData_d2_b3$name <- 0
k <- 1
for (i in subj){
  GershmanData_d2_b3$name[k:(k+(25-1))] <- i
  k <- 25 + k
}

#block 4
GershmanData_d2_b4$name <- 0
k <- 1
for (i in subj){
  GershmanData_d2_b4$name[k:(k+(25-1))] <- i
  k <- 25 + k
}

#add trial number column in to each dataframe
i <- 1
GershmanData_d2_b1$trial_number[which(GershmanData_d2_b1$name == i)] <- c(1:25)
i <- 1
GershmanData_d2_b2$trial_number[which(GershmanData_d2_b2$name == i)] <- c(26:50)
i <- 1
GershmanData_d2_b3$trial_number[which(GershmanData_d2_b3$name == i)] <- c(51:75)
i <- 1
GershmanData_d2_b4$trial_number[which(GershmanData_d2_b4$name == i)] <- c(76:100)

#combine 4 blocks into one
GershmanData_d2 <- rbind(GershmanData_d2_b1, GershmanData_d2_b2, GershmanData_d2_b3, GershmanData_d2_b4)
GershmanData_d2 <- GershmanData_d2[order(GershmanData_d2$name, GershmanData_d2$trial_number),]

#prepare data to be merged with D1
#add number of subjects from D1 to name column so that there is no overlap
GershmanData_d2$name <- GershmanData_d2$name+165

#make all columns match
GershmanData_d2$game <- GershmanData_d2$block
GershmanData_d2$block <- NULL
GershmanData_d2$C <- NULL

#merge D1 and D2
GershmanData_all <- rbind(GershmanData_d2, GershmanData_d1_cleaned)
GershmanData_all$name <- as.numeric(GershmanData_all$name)

#order by subject number
#1-165 come from D1, 166 - 205 come from D2
GershmanData_all <- GershmanData_all[order(GershmanData_all$name),]

#CREATING STICKINESS old wrong!!!
# GershmanData_all$stick <- lag(GershmanData_all$c, n = 1L, default = NA, order_by = NULL) == 1
# GershmanData_all$stick[which(GershmanData_all$stick == "TRUE")] <- 0.5
# GershmanData_all$stick[which(GershmanData_all$stick == "0")] <- -0.5

# CREATING new stickiness
rl_data$stick <- 0  # initialize stick column

# Apply Gershman-style coding
rl_data$stick[2:nrow(rl_data)] <- ifelse(rl_data$choice_two[1:(nrow(rl_data)-1)] == 1, 0.5, -0.5)
head(rl_data)
save(rl_data, file = "rl_data.RData")


# Datalist Creation -------------------------------------------------------

#get variables
subj_Gershman <- c(unique(GershmanData_all$name))
subj_Gershman <- as.numeric(subj_Gershman)
trials_Gershman <- c(unique(GershmanData_all$trial_number))

#TRIALS FOR SUBJ MATRIX
trialNum_Gershman <- array(length(trials_Gershman),dim=c(length(subj_Gershman)))

#REWARD MATRIX
reward_Gershman <- matrix(0,nrow = max(trials_Gershman),length(subj_Gershman))
GershmanData_all$name <- as.numeric(GershmanData_all$name)
GershmanData_all$r <- as.numeric(GershmanData_all$r)
k <- 1
for (i in subj_Gershman) {
  reward_Gershman[,k] <- GershmanData_all$r[GershmanData_all$name==i]
  k <- k+1
}
reward_Gershman <- t(reward_Gershman)

#STATE MATRIX
state_Gershman <- matrix(0,nrow = max(trials_Gershman),length(subj_Gershman))
GershmanData_all$game <- as.numeric(GershmanData_all$game)
k <- 1
for (i in subj_Gershman) {
  state_Gershman[,k] <- GershmanData_all$game[GershmanData_all$name==i]
  k <- k+1
}
state_Gershman <- t(state_Gershman)

#CHOICE MATRIX
#(1 is left, 2 is right)
choice_Gershman <- matrix(0,nrow = max(trials_Gershman),ncol = length(subj_Gershman))
k <- 1
GershmanData_all$c <- as.numeric(GershmanData_all$c )
for (i in subj_Gershman) {
  choice_Gershman[,k] <- GershmanData_all$c[GershmanData_all$name==i]
  k <- k + 1
}
choice_Gershman <- t(choice_Gershman)

#CHOICE_2 MATRIX (1 is left, right is 0)
choice_two_Gershman <- choice_Gershman
choice_two_Gershman[choice_two_Gershman == 2] <- 0
save(choice_two_Gershman, file= "choice_two_Gershman.RData")

#STICKINESS MATRIX
stickiness_Gershman <- matrix(0,nrow = max(trials_Gershman),ncol = length(subj_Gershman))
k <- 1
rl_data$stick <- as.numeric(rl_data$stick)
for (i in subj_Gershman) {
  stickiness_Gershman[,k] <- rl_data$stick[rl_data$name==i]
  k <- k + 1
}
stickiness_Gershman <- t(stickiness_Gershman)
dim(stickiness_Gershman)
stickiness


# Ensure first trial for each subject has stickiness = 0
stickiness_Gershman
stickiness_Gershman[, 1] <- 0

head(GershmanData_all)
rl_data <- GershmanData_all
rl_data$choice_two = rl_data$c
rl_data$choice_two[rl_data$choice_two == 2] <- 0

save(rl_data, file = "rl_data.RData")


# Running Models ------------------------------------------------------




# M1 ---------------------------------------------------------------

library(R2jags)
library(coda)


params <- c("alpha", "b0", "b1", "choice_pred")
data12 <- list("NS" = 205,
             "MT" = 100,
             "NStim" = 4,
             "NC" = 2,
             "NT" = trialNum_Gershman,
             "stim_id" = state_Gershman,
             "rew" = reward_Gershman,
             "choice" = choice_Gershman, 
             "choice_two" = choice_two_Gershman)


model_M1 <- jags(data = data12,
                   parameters.to.save = params,
                   model.file = "Non_hierarchicalM1.jags",
                   n.chains = 3,
                   n.iter = 5000,
                   n.burnin = 1000,
                   n.thin = 3)

save(model_M1, file = "model_M1.RData")
load("model_M1.RData")

### M2 -----------------------------------------

params <- c("alpha", "beta", "betaG", "lambda", "rho", "choice_pred")
model_M2 <- jags(data = data12,
                 parameters.to.save = params,
                 model.file = "Hierarchical_M2.jags",
                 n.chains = 3,
                 n.iter = 5000,
                 n.burnin = 1000,
                 n.thin = 3)

model_M2
save(model_M2, file = "model_M2.RData")

load("model_M2.RData")


# M3  ----------------------------------------------------------------

#datalist
data3 <- list(
  "NS" = 205,
  "NStim" = 4,
  "NC" = 2,
  "NT" = trialNum_Gershman,
  "K" = 3,
  "stim_id" = state_Gershman,
  "rew" = reward_Gershman,
  "choice" = choice_Gershman,
  "choice_two" = choice_two_Gershman,
  "stickiness" = stickiness_Gershman
)


#  parameters to save
params3 <- c(
  "alpha",
  "b0",
  "b1",
  "kappa",
  "choice_pred",
  "betaG",
  "tau_beta",
  "SigmaG"
)
library(R2jags)
model_M3 <- jags(data = data3,
               parameters.to.save = params3,
               model.file = "justanotherM3.jags",
               n.chains = 3,
               n.iter = 5000,
               n.burnin = 1000,
               n.thin = 5)

model_M3
save(model_M3, file = "model_M3.RData")

