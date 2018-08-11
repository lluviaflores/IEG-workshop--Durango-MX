#Contains functions for PopGen analysis
#author: Mitra Menon, menonm2@mymail.vcu.edu
#Date last modified: 8/2/2018


MinorToHierf<-function(df){
  
  #this script will use a dataframe where the first column is starting at SNP information as input
  # the snps need to be coded as counts of the minor allele
  
  formated<- apply(df, 2, function(df) gsub('1','het',df))
  formated <- apply(formated, 2, function(df) gsub('2','min',df))
  formated <- apply(formated, 2, function(df) gsub('0','maj',df))
  
  formated<- apply(formated, 2, function(df) gsub('het','12',df))
  formated <- apply(formated, 2, function(df) gsub('maj','22',df))
  formated <- apply(formated, 2, function(df) gsub('min','11',df))
  
  formated<-apply(formated,2,function(df) as.numeric(df))
  return(data.frame(formated))
}


MAFbyPop<-function(Gdata,Group,n){
  
  #This function takes three inputs, the genotype data matrix where genotype is represented as count of minor allele, the Grouping variable, the column number at which the genotype information begins.
  #We assume the loci information to to be stored from column n to the last column of the dataframe/matrix.

  pops<-split(Gdata,f=Group,drop=TRUE)
  cat ("The number of groups is", length(pops))
  
  loci<-lapply(pops,function(df) return(df[ ,n:ncol(df)]))
  
  x1 <- lapply(loci, function(X) return(apply(X, 2, function(df) length(which(df == 1)))))
  x1<-do.call(rbind,x1)
  rownames(x1)<-names(loci)
  x2 <- lapply(loci, function(X) return(apply(X, 2, function(df) length(which(df == 2)))))
  x2<-do.call(rbind,x2)
  rownames(x2)<-names(loci)
  
  Nadj<-lapply(loci, function(X) return(apply(X,MARGIN = 2,function(df) sum(!(is.na(df))))))
  Nadj<-do.call(rbind,Nadj)
  
  
  allelefreq<-(x2+(1/2)*x1)/Nadj
  allelefreq[is.na(allelefreq)]<-0
  allelefreq<-cbind(rownames(allelefreq),allelefreq)
  colnames(allelefreq)[1]<-"population"
  rownames(allelefreq)<-NULL
  return(allelefreq)
}
  

#Function for outlier detection borrowed from B. Forrester

outliers <- function(x,z){
  lims <- mean(x) + c(-1, 1) * z * sd(x)     # find loadings +/-z sd from mean loading     
  x[x < lims[1] | x > lims[2]]               # locus names in these tails
}



#Function to identify predictor axis of strongest effect
ClimAxis<-function(candidates,predictors,AF){
  
  #candidates is a dataframe that contains the name of the outlier SNP in the column "snp"
  #predictors is a dataframe/matrix that contains the value of each predictor variable.
  #AF is a matrix/dataframe that contains allelefrequency for each SNP at each population
  
  #NOTE: The order of populations should be the same between  predictors and the AF
  
  df<- matrix(nrow=nrow(candidates), ncol=ncol(predictors)+2)
  colnames(df)<-c(colnames(predictors),"predictor","correlation")
  
  #loop through the dataframe which contains the outliers and assess correlation 
  for (i in 1:nrow(candidates)) {
    nam <- candidates[i,"snp"]
    snp.gen <- AF[,nam]
    envCorr<- apply(predictors,2,function(x) cor(x,snp.gen))
    
    df[i,1:ncol(predictors)]<-envCorr
    MaxPred<-names(which.max(abs(envCorr)))
    df[i,"predictor"]<-MaxPred
    df[i,"correlation"]<-envCorr[names(envCorr)==MaxPred ]
  }
  
  
  cand <- cbind.data.frame(candidates,df)
  
  return(cand)
  
}

### AIC weight function, borrowed from A. Eckert

aic_weights <- function(aic_vals) {
  
  min_aic <- which(aic_vals == min(aic_vals))
  
  change_vec <- numeric(length(aic_vals))
  
  for(i in 1:length(aic_vals)) {
    
    change_vec[i] <- exp(-0.5*(aic_vals[i] - aic_vals[min_aic]))
    
  }
  
  fin_out <- change_vec/sum(change_vec)
  
  return(fin_out)
  
}

### Replication of pop effects for easy adding, borrowed from A. Eckert

pop_rep <- function(pop.eff, n.fam, fam.eff) {
  
  out <- numeric(n.fam)
  
  for(i in 1:nrow(pop.eff)) {
    
    out[grep(pattern = row.names(pop.eff)[i], x = row.names(fam.eff))] <- pop.eff[i,1]
    
  }
  
  return(out)
  
}

##Function for gwas
GWAS<-function(trait,snps){
  #assumes that genotype information is stored in snps and starts at column 1
 outputs<-matrix(nrow=ncol(snps),ncol=2)
 colnames(outputs)<-c("ES","pval")
 
  mod<-apply(snps,2,function(X) return(lm(trait ~ 1 + X)))
  
  for (i in 1:length(mod)){
    outputs[i,1]<-mod[[i]]$coefficients[2]
    outputs[i,2]<-anova(mod[[i]])[1,5]
  }
  
  return(cbind.data.frame(snp=colnames(snps),outputs))
}
