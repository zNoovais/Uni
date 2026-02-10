
tibble

r = 0.2

outMatrix <- matrix(data = c(1,r,r,1), nrow = 2, ncol = 2, byrow = TRUE)

eigen(outMatrix)


outMatrix2 <- matrix(data = c(1,r,0,r,1,0,0,0,1), nrow = 3, ncol = 3, byrow = TRUE)


eigen(outMatrix2)

pc = prcomp(c(1,r,0,r,1,0,0,0,1))

pc
summary(pc)
