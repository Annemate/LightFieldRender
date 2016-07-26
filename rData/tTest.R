VC <- as.numeric(read.table("C:/Users/jakupklein/Desktop/VC.txt", header = FALSE))
IC <- as.numeric(read.table("C:/Users/jakupklein/Desktop/IC.txt", header = FALSE))

sd(VC, na.rm = FALSE)
sd(VC, na.rm = FALSE)
mean(VC)
mean(IC)
t.test(VC,IC, var.equal=TRUE, paired=FALSE)
