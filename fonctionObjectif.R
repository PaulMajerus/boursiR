# Fonction objectif

# Fonction à minimiser (marge négative)
objectif <- function(P) {
  stock <- ifelse(stock0 - S <0,0,stock0-S)
  rarete <- ifelse(stock_fini, tau * log1p(stock0 / pmax(stock, 1)), 0)/100
  # Attractivité dynamique
  A <- alpha + gamma * sqrt(S) + rarete


  # Terme de substitution
  subst_term <- rowSums(W * (matrix(P, n, n, byrow = TRUE) - P))

  # Demande estimée
  D <- pmin(A - E * P + delta * subst_term, 2 * stock0)

  # Marge
  marge <- D * (P - Pc)

  # Calcul des pénalités pour les stocks non écoulés
  # Pénalité sur les stocks non écoulés pour les bières à stock limité
  # Calcul de la pénalité uniquement pour les bières à stock limité
  indice_fini <- which(stock_fini)
  stock_fini_vec <- stock[indice_fini]
  D_fini <- D[indice_fini]

  penalite_stock <- kappa * sum(
    (pmax(stock_fini_vec - D_fini, 0))
  )
  # Si stock limité, pénalité pour stock non écoulé
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
  #penalite <- lambda * mean(P)^2

  objectif_value <- -sum(marge /  log1p(S)) + penalite_stock

  return(objectif_value)
}
