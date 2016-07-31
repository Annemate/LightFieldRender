VC <- as.numeric(read.table("VC.txt", header = FALSE))
IC <- as.numeric(read.table("IC.txt", header = FALSE))
ICNAA <- as.numeric(read.table("ICNAA.txt", header = FALSE))


sd(VC, na.rm = FALSE)
sd(IC, na.rm = FALSE)
sd(ICNAA, na.rm = FALSE)
mean(VC)
mean(IC)
mean(ICNAA)
t.test(VC,IC, var.equal=TRUE, paired=FALSE)
t.test(VC,ICNAA, var.equal=TRUE, paired=FALSE)
