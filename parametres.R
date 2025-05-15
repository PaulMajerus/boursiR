# Nom des bières ----
biere <- c("Battin pils","Lupulus pils",
           "Blanche","Rulles",
           "Fructus","Corne",
           "Desperados","Smash","Delta",
           "Chouffe",
           "Vedette","Trolls",
           "Rochefort","Orval",
           "TK","Urine","Waw",
           "Windy")

# n - Nombre de bière ----
n <- length(biere)


# Pc - Prix coutant ----
Pc <- c( 1.10 ,
         0.92 ,
         1.16 ,
         1.35 ,
         1.36 ,
         1.47 ,
         1.92 ,
         1.99 ,
         2.10 ,
         1.44 ,
         1.63 ,
         1.42 ,
         1.35 ,
         1.84 ,
         1.97 ,
         2.30 ,
         1.90 ,
         2.30
)

# Pmin - Prix minimum ----
Pmin <- c( 1.60 ,
           1.40 ,
           1.70 ,
           1.90 ,
           1.90 ,
           2.00 ,
           2.40 ,
           2.50 ,
           2.60 ,
           1.90 ,
           2.10 ,
           1.90 ,
           1.80 ,
           2.30 ,
           2.50 ,
           2.80 ,
           2.40 ,
           2.80
)

# Pmax - Prix Maximum ----
Pmax <- c(6,4,5,6,6,6,8,8,8,6,6,6,6,8,8,9,8,9)

# E <- Élasticité propre à chaque bière (positif = plus sensible) ----
E <- c(1,1.5,1.5,2,
       1.75,2.5,1.25,2,
       2.5,2.5,2.5,2.5,
       3,1.25,1.75,2,
       2.5,2)


# alpha - Attractivité de base (alpha) ----
alpha <- c(15,15,10,18,
           10,8,18,15,
           10,8,12,10,
           6,15,15,15,10,15)

# Effet de rareté (gamma) ----
gamma <- c(.75,.75,.75,1,
           1,1,2,2,
           2,1.5,1.5,2,
           1,2,2,
           2,1.5,2)  # peut être positif (rareté valorisée) ou négatif (saturation)

# W - Matrice de similarité ----
library(readxl)
W <- read_excel("matriceSimilarite.xlsx")[,-1] |>
  as.matrix()
diag(W) <- 0
rs <- rowSums(W)
rs[rs == 0] <- 1  # éviter division par 0
W <- W / rs

# delta - Sensibilité de la substitution ----
delta <- c(.5,.8,0,.8,.5,
           1,0,1,1,1,
           1,1,1,.5,.5,
           .8,1,.8)
# lambda - coefficient à ajuster ----
lambda = 10

# kappa - Pénalité si on ne vide pas les stocks limités
kappa = 0.5

# tau - controle de l'effet de rarete
tau <- c(1,1,1,1,1,1,
         2,3,2,2,2,1,
         1,0.5,3,3,2,3)
tau_adj <- ifelse(stock_fini, tau, 0)

# stock - stock restant de bière
stock0 <- c(200,200,24*5,200,
            200,24*4,24*12,24*4,
           24*4,24*6,24*5,24*3,
           24*2,200,24*5,24*3,
           24*2,24*2)
stock0 <- ifelse(stock_fini, stock0, Inf)
# epsilon - correction petits nombres ----
epsilon <- 1

# stock_fini - vrai ou faux ----
stock_fini <- c(F,F,T,F,
                F,T,T,T,
                T,T,T,T,
                T,F,T,T,
                T,T)

# Summary dataframe ----
library(dplyr);library(tibble)
table <- data.frame(biere=biere,
                    Elasticite=E,
                    attractiviteBase = alpha,
                    rarete = gamma,
                    sensibilite = delta,
                    tau = tau,
                    stock0=stock0,
                    Conso = S) |>
  as.tibble()

print(table)
