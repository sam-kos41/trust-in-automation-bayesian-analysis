# Custom Bayesian Functions for Trust in AI Analysis
# Author: Sam Koscelny

#' Compute HPD Interval for Beta Distribution
#' @param y Number of successes
#' @param n Total number of trials
#' @param h Height parameter for HPD (0-1)
#' @param a Beta prior parameter alpha
#' @param b Beta prior parameter beta
#' @param plot Whether to create plot
#' @return Vector with lower bound, upper bound, coverage, and h
HPD.beta.h <- function(y, n, h = 0.1, a = 1, b = 1, plot = TRUE, ...) {
  apost <- y + a
  bpost <- n - y + b
  
  if (apost > 1 & bpost > 1) {
    mode <- (apost - 1) / (apost + bpost - 2)
    dmode <- dbeta(mode, apost, bpost)
  } else {
    return("Mode at 0 or 1: HPD not implemented")
  }
  
  lt <- uniroot(f = function(x) {
    dbeta(x, apost, bpost) / dmode - h
  }, lower = 0, upper = mode)$root
  
  ut <- uniroot(f = function(x) {
    dbeta(x, apost, bpost) / dmode - h
  }, lower = mode, upper = 1)$root
  
  coverage <- pbeta(ut, apost, bpost) - pbeta(lt, apost, bpost)
  
  if (plot) {
    theta <- seq(0, 1, length = 1000)
    plot(theta, dbeta(theta, apost, bpost),
         type = "l", lty = 1, xlab = expression(theta),
         ylab = "Posterior Density", 
         main = paste("Posterior Distribution (n =", n, ")"), ...)
    abline(h = h * dmode, lty = 2, col = "red")
    segments(ut, 0, ut, dbeta(ut, apost, bpost), col = "blue", lwd = 2)
    segments(lt, 0, lt, dbeta(lt, apost, bpost), col = "blue", lwd = 2)
    legend("topright", 
           legend = c("Posterior", 
                      paste0("HPD (", round(coverage * 100, 1), "%)")),
           lty = c(1, NA), pch = c(NA, 15), col = c("black", "blue"))
  }
  
  return(c(lower = lt, upper = ut, coverage = coverage, h = h))
}

#' Optimize HPD Coverage
#' @param h Height parameter
#' @param y Number of successes
#' @param n Total trials
#' @param alpha Significance level
#' @return Squared deviation from target coverage
Dev.HPD.beta.h <- function(h, y, n, alpha) {
  cov <- HPD.beta.h(y, n, h, plot = FALSE)[3]
  res <- (cov - (1 - alpha))^2
  return(res)
}

#' Get Exact HPD Interval
#' @param y Number of successes
#' @param n Total trials
#' @param alpha Significance level (default 0.05)
#' @param a Beta prior alpha
#' @param b Beta prior beta
#' @return HPD interval bounds and coverage
get_hpd_interval <- function(y, n, alpha = 0.05, a = 1, b = 1) {
  h.final <- optimize(Dev.HPD.beta.h, c(0, 1), 
                      y = y, n = n, alpha = alpha)$minimum
  result <- HPD.beta.h(y, n, h.final, a = a, b = b, plot = FALSE)
  return(list(
    lower = result[1],
    upper = result[2], 
    coverage = result[3],
    mean_post = (y + a) / (y + a + n - y + b),
    mode_post = (y + a - 1) / (y + a + n - y + b - 2)
  ))
}

#' MCMC for Logistic Regression with Bayesian Approach
#' @param X Design matrix
#' @param y Response vector
#' @param n_iter Number of MCMC iterations
#' @param prior_var Prior variance for coefficients
#' @return List with posterior samples and summary statistics
bayesian_logistic_mcmc <- function(X, y, n_iter = 5000, prior_var = 10) {
  
  # Initialize
  n <- length(y)
  p <- ncol(X)
  beta <- rep(0, p)
  beta_samples <- matrix(0, n_iter, p)
  
  # Metropolis-Hastings
  for (i in 1:n_iter) {
    for (j in 1:p) {
      # Propose new value
      beta_prop <- beta
      beta_prop[j] <- rnorm(1, beta[j], 0.1)
      
      # Calculate acceptance ratio
      loglik_curr <- sum(dbinom(y, 1, plogis(X %*% beta), log = TRUE))
      loglik_prop <- sum(dbinom(y, 1, plogis(X %*% beta_prop), log = TRUE))
      
      prior_curr <- dnorm(beta[j], 0, sqrt(prior_var), log = TRUE)
      prior_prop <- dnorm(beta_prop[j], 0, sqrt(prior_var), log = TRUE)
      
      log_ratio <- (loglik_prop + prior_prop) - (loglik_curr + prior_curr)
      
      # Accept or reject
      if (log(runif(1)) < log_ratio) {
        beta[j] <- beta_prop[j]
      }
    }
    beta_samples[i, ] <- beta
  }
  
  # Summary statistics
  summary_stats <- data.frame(
    parameter = paste0("beta_", 0:(p-1)),
    mean = apply(beta_samples, 2, mean),
    median = apply(beta_samples, 2, median),
    sd = apply(beta_samples, 2, sd),
    q025 = apply(beta_samples, 2, quantile, 0.025),
    q975 = apply(beta_samples, 2, quantile, 0.975)
  )
  
  return(list(
    samples = beta_samples,
    summary = summary_stats,
    acceptance_rate = NULL # Could be calculated with more tracking
  ))
}

#' Calculate Model Comparison Metrics
#' @param model1 First model object
#' @param model2 Second model object
#' @param y Response variable
#' @return List with comparison metrics
compare_models <- function(model1, model2, y) {
  
  # AIC and BIC
  aic1 <- AIC(model1)
  aic2 <- AIC(model2)
  bic1 <- BIC(model1)
  bic2 <- BIC(model2)
  
  # Predictions and accuracy
  pred1 <- predict(model1, type = "response")
  pred2 <- predict(model2, type = "response")
  
  pred1_class <- ifelse(pred1 > 0.5, 1, 0)
  pred2_class <- ifelse(pred2 > 0.5, 1, 0)
  
  acc1 <- mean(pred1_class == as.numeric(as.character(y)))
  acc2 <- mean(pred2_class == as.numeric(as.character(y)))
  
  return(list(
    model1 = list(AIC = aic1, BIC = bic1, accuracy = acc1),
    model2 = list(AIC = aic2, BIC = bic2, accuracy = acc2),
    best_aic = ifelse(aic1 < aic2, "Model 1", "Model 2"),
    best_bic = ifelse(bic1 < bic2, "Model 1", "Model 2"),
    best_accuracy = ifelse(acc1 > acc2, "Model 1", "Model 2")
  ))
}