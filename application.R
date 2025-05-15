# Import des consommations cumulés
cumConso <- readxl::read_excel("Calculatrice.xlsx",
                           sheet = "ConsoTotal") |>
  dplyr::select(Bière,
         Cumul) |>
  dplyr::slice_head(n=18)


prixCourant <- readxl::read_excel("Calculatrice.xlsx",
                               sheet = "CalculPrix") |>
  dplyr::pull(`Prix actuel`)
# S - Consommation cumulée ----
S <- cumConso$Cumul
S <- if_else(S==0,S+1,S)
# Faire tourner le programme
source("programme.R")
# Sortir une liste de prix dans un excel
nouveauxPrix <- data.frame(NouveauPrix = round(P_optim,1))

# Transférer les nouveaux prix à tous

library(openxlsx)

# Charger le fichier Excel existant
wb <- loadWorkbook("Calculatrice.xlsx")

# Données à écrire (29 lignes, 1 colonne)
vecteur <- nouveauxPrix
data.frame(V0=prixCourant,V1=vecteur)
# Écrire en C2 (colonne 3, ligne 2)
writeData(wb,
          sheet = "CalculPrix",
          x = vecteur,
          startCol = 12,
          startRow = 2,
          colNames = FALSE,
          rowNames = FALSE)

# Sauvegarder
saveWorkbook(wb, "Calculatrice.xlsx", overwrite = TRUE)
