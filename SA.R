simulated_annealing <- function(pSample, objectiveFunction, tempIni = 1, tempEnd = .1, niter = 10, coolingFactor = .9) {
  bestSolution <- currentSolution <- neighSolution <- s0 <- pSample()
  bestOutput <- currentOutput <- neighOutput <- objectiveFunction(s0)
  message("It\tBest\tCurrent\tNeigh\tTemp")
  message(sprintf("%i\t%.4f\t%.4f\t%.4f\t%.4f", 0L, bestOutput, currentOutput, neighOutput, tempIni))
  
  for (k in 1:niter) {
    temp = tempIni
    while (temp > tempEnd) {     
      temp <- (temp * coolingFactor)
      # consider a random neighbor
      neighSolution <- pSample(currentSolution)
      neighOutput <- objectiveFunction(neighSolution)
      # update current state
      if (neighOutput < currentOutput || runif(1, 0, 1) < exp(-(neighOutput - currentOutput) / temp)) {
        currentOutput <- neighOutput
        currentSolution <- currentSolution
        # update best state
        if (neighOutput < bestOutput) {
          bestSolution <- neighSolution
          bestOutput <- neighOutput         
        }
      }
      message(sprintf("%i\t%.4f\t%.4f\t%.4f\t%.4f", k, bestOutput, currentOutput, neighOutput, temp))
    }
  }
  
  return(list(iterations = niter, best_value = bestOutput, best_state = bestSolution))
}

