# Fonction objectif

# Fonction à minimiser (marge négative)
objectif <- function(P) {
  # Attractivité dynamique
  A <- alpha + gamma * log1p(S)

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

  # Régularisation : pénalise la moyenne des prix élevés
  penalite <- lambda * mean(P)^2

  -sum(marge /  log1p(S)) + penalite
}
