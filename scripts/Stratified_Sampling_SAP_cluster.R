# Read in phenotype file 'Y'

cvf <- data.frame(matrix("",nrow=nrow(Y), ncol=0))

for (k in 1:100){
    result <- c()

    c.list = vector("list", 5)

    for (i in 1:5) {
        ctemp = Y[Y$Cluster==i,]
        total = nrow(ctemp)/5
        if (!(is.integer(total))) { 
            total = as.integer(total) +1 
        }
        x2 = sample(ctemp$ID)
        g = rep(seq(1,5), total)
        g2 = g[1:length(x2)]
        x = split(x2, g2)
        c.list[[i]] = x
    }

    # to get 5 folds and assign individuals into folds
    cv.list = vector("list", 5)
    for (i in 1:5) {
        cv.list[[i]] = c(unname(unlist(c.list[[1]][i])),
                         unname(unlist(c.list[[2]][i])),
                         unname(unlist(c.list[[3]][i])),
                         unname(unlist(c.list[[4]][i])),
                         unname(unlist(c.list[[5]][i])))
    }
    result = c(0, nrow(Y))
    for (i in 1:nrow(Y)) {
        test = c(NA, 5)
        for (j in 1:5) {
            test[j] = Y$ID[i] %in% cv.list[[j]]
        }
        result[i] = which(test==1)
    }

    cvf <- cbind(cvf,result)
}

colnames(cvf) <- c(paste("CV_",1:100, sep=""))
rownames(cvf) <- Y$Taxa

write.csv(cvf, "cvf_CV1.csv")



