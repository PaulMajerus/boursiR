library(nloptr)

source("parametres.R")
source("fonctionObjectif.R")

# Sécurité 1 : Vérifier que Pmin < Pmax pour chaque bière
if (any(Pmin >= Pmax)) {
  stop("Erreur : au moins une bière a Pmin >= Pmax. Corrige les bornes.")
}

# Sécurité 2 : x0 bien inclus entre Pmin et Pmax
x0 <- (Pmin + Pmax) / 2
if (any(x0 < Pmin | x0 > Pmax)) {
  stop("Erreur : x0 calculé en dehors des bornes.")
}

# Lancer optimisation
res <- nloptr(
  x0 <- (Pmin + Pmax) / 2,
  eval_f = objectif,
  lb = Pmin,
  ub = Pmax,
  opts = list(algorithm = "NLOPT_LN_COBYLA",
              xtol_rel = 1e-6)
)

# Résultat : prix optimaux
P_optim <- res$solution

