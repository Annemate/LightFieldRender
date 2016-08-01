VC <- as.numeric(read.table("/Users/bybub/LightFieldRender/rData/VC.txt", header = FALSE))
IC <- as.numeric(read.table("/Users/bybub/LightFieldRender/rData/IC.txt", header = FALSE))

sd(VC, na.rm = FALSE)
sd(IC, na.rm = FALSE)
mean(VC)
mean(IC)
t.test(VC,IC, var.equal=TRUE, paired=FALSE)
