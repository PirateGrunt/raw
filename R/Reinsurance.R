LayeredLoss <- function(Losses, Attachment, Limit){
  
  Losses <- pmax(Losses - Attachment, 0)
  Losses <- pmin(Losses, Limit)
  Losses
}
