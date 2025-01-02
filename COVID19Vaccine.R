################################################################################
### Relative risk
### Refactored code
get_rr <- function(data, alpha, digits) {
  # computes MLE for a binary response
  get_mle <- function(w, n) {
    (w / n)
  }
  # computes confidence interval for RR
  # RR_hat is estimated(pi_1)/estimated(pi_2)
  # w1: success count for group 1
  # n1: total count for group 1
  # w2 and n2 are the quantities above, but for group 2
  get_confidence <- function(rr_hat, w1, n1, w2, n2) {
    z_values <- qnorm(c(alpha/2, 1 - alpha/2))
    var_hat_log_rr_hat <-  1 / w1 - 1 / n1 + 1 / w2 - 1 / n2
    (exp(log(rr_hat) + z_values * sqrt(var_hat_log_rr_hat)))
  }
  n1 <- rowSums(data)[1]
  n2 <- rowSums(data)[2]
  w1 <- data[1, 1]
  w2 <- data[2, 1]
  pi_hat1 <- get_mle(w1, n1)
  pi_hat2 <- get_mle(w2, n2)
  rr_hat <- pi_hat1 / pi_hat2
  ci_rr <- get_confidence(rr_hat, w1, n1, w2, n2)
  (round(
    data.frame(Estimate = rr_hat, Lower = ci_rr[1], Upper = ci_rr[2]),
    digits))
}
get_rr(data = c.table, alpha = 0.05, digits = 4)

################################################################################
### Odds ratio
### Refactored Code
get_estimated_odds_ratio <- function(contingency_table) {
  diagonal <- diag(contingency_table)
  off_diagonal <- contingency_table[ row(contingency_table) != col(contingency_table) ]
  (prod(diagonal)/prod(off_diagonal))
}
get_wald_for_odds_ratio <- function(alpha, contingency_table){
  crit_values <- qnorm(p = c(alpha/2, 1-alpha/2))
  log_or <- log(get_estimated_odds_ratio(contingency_table))
  v_log_or <- sum(1/contingency_table)
  (exp(log_or + crit_values * sqrt(v_log_or)))
}
print(round(get_estimated_odds_ratio(c.table),4))
print(round(get_wald_for_odds_ratio(0.05, c.table), 4))
