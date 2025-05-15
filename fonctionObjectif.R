# Fonction objectif

# Fonction à minimiser (marge négative)
objectif <- function(P) {
  S <- if_else(S==0,S+1,S)

 # stock_eff <- ifelse(stock_fini, stock, Inf)
  # Attractivité dynamique
  A <- alpha + gamma * log1p(S) #+ tau / (1 + stock_eff)

  # Terme de substitution
  subst_term <- rowSums(W * (matrix(P, n, n, byrow = TRUE) - P))

  # subst_term <- numeric(n)
  # for (i in 1:n) {
  #   subst_term[i] <- sum(W[i, ] * (P - P[i]))
  # }

  # Demande estimée
  D <- A - E * P + delta * subst_term

  # Marge unitaire * demande
  marge <- D * (P - Pc)  # on minimise

  # Calcul des pénalités pour les stocks non écoulés
  # Pénalité sur les stocks non écoulés pour les bières à stock limité
  # penalite_stock <- kappa * sum(pmax(S - D, 0)^2)  # Si stock limité, pénalité pour stock non écoulé
  #
  # # Pénalité sur les prix : éviter des prix trop élevés (ou trop bas)
  # penalite_prix <- sum(pmax(P - Pmax, 0)^2 + pmax(Pmin - P, 0)^2)  # Penalité pour prix en dehors des limites
  #
  # # Pénalité pour la moyenne des prix (pour éviter des prix trop élevés)
  # penalite_prix_moyen <- lambda * mean(P)^2
  #
  # # Pénalité totale sur les prix
  # penalite_totale <- penalite_prix + penalite_prix_moyen + penalite_stock
  #
  # objectif_value <- -sum(marge / log1p(S)) + penalite_totale

  # Régularisation : pénalise la moyenne des prix élevés
  penalite <- lambda * mean(P)^2

  objectif_value <- -sum(marge /  log1p(S)) + penalite

  return(objectif_value)
}
