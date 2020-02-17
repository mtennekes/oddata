od_id_max_min = function (x, y) {
  d <- convert_to_numeric(x, y)
  a <- pmax(d$x, d$y)
  b <- pmin(d$x, d$y)
  a * (a + 1)/2 + b
}


convert_to_numeric = function (x, y) {
  if (length(x) != length(y)) 
    stop("x and y are not of equal length")
  if (class(x) == "factor") 
    x <- as.character(x)
  if (class(y) == "factor") 
    y <- as.character(y)
  lvls <- unique(c(x, y))
  x <- as.integer(factor(x, levels = lvls))
  y <- as.integer(factor(y, levels = lvls))
  list(x = x, y = y)
}

