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
Pmax <- c( 4.40 ,
           4.60 ,
           5.40 ,
           3.70 ,
           5.40 ,
           5.90 ,
           7.70 ,
           8.00 ,
           8.40 ,
           5.80 ,
           6.50 ,
           5.70 ,
           5.40 ,
           7.40 ,
           7.90 ,
           9.20 ,
           7.60 ,
           9.20
)

# S - Consommation cumulée ----
S <- c(35,24,12,28,12,2,14,18,13,4,3,8,10,20,10,4,18,15)

# E <- Élasticité propre à chaque bière (positif = plus sensible) ----
E <- c(1.25,2,1.75,2,
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
gamma <- c(0,0,1,2,
           1,1,3,3,
           3,2,2,3,
           1,3,3,
           3,2,3)  # peut être positif (rareté valorisée) ou négatif (saturation)

# W - Matrice de similarité ----
library(readxl)
W <- read_excel("matriceSimilarite.xlsx")[,-1] |>
  as.matrix()
diag(W) <- 0
rs <- rowSums(W)
rs[rs == 0] <- 1  # éviter division par 0
W <- W / rs

# delta - Sensibilité de la substitution ----
delta <- c(0,.8,0,.8,.5,
           1,0,1,1,1,
           1,1,1,.5,.5,
           .8,1,.8)
# lambda - coefficient à ajuster ----
lambda = 5

# Summary dataframe ----
library(dplyr)
table <- data.frame(biere=biere,
                    Elasticite=E,
                    attractiviteBase = alpha,
                    rarete = gamma,
                    sensibilite = delta) |>
  as.tibble()

print(table)
