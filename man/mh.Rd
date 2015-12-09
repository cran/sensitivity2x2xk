\name{mh}
\alias{mh}
\title{Exact Test for One 2x2xk Table in Observational Studies}
\usage{
mh(tab,Gamma=1)
}
\description{
Exact, one-sided sensitivity analysis for a 2x2xk table.
}
\arguments{
\item{tab}{
tab is a 2x2 or a 2x2xk contingency table, typically treatment x outcome x covariate.
}
\item{Gamma}{
Gamma>=1 is the sensitivity parameter, where Gamma=1 yields a randomization test.
}
}
\value{
\item{pval}{
Upper bound on the one-sided P-value.
}
\item{A}{
A is the total count in the [1,1,j] cells of the 2x2xk table tab, summing over j=1,...,k.  It is the test statistic in Birch's (1964) exact version of the Cochran-Mantel-Haenszel test. Birch's test is the uniformly most powerful unbiased test against a constant odds ratio alternative.
}
}
\note{
The mh function uses the exact distribution.  Use mhLS for a large
sample approximation based on exact moments.
}
\examples{
# The example is from Satagopan, et al. (2001), Table 2.
# It is a case-control study of breast cancer and
# BRCA1+ mutations for women aged <40 and women aged >=40.
ageLT40<-matrix(c(18,51,11,673),2,2)
ageGE40<-matrix(c(39,652,21,2699),2,2)
rownames(ageLT40)<-c("BRCA1+","Negative")
rownames(ageGE40)<-c("BRCA1+","Negative")
colnames(ageLT40)<-colnames(ageGE40)<-c("Case","Control")
names(dimnames(ageLT40))<-c("Mutation","Breast Cancer")
names(dimnames(ageGE40))<-c("Mutation","Breast Cancer")
both<-array(c(18,51,11,673,39,652,21,2699),c(2,2,2))
dimnames(both)<-list(c("BRCA1+","Negative"),
      c("Case","Control"),c("LT40","GE40"))
names(dimnames(both))<-c("Mutation","Breast Cancer","Age")

mh(ageLT40,Gamma=9.3)
mh(ageGE40,Gamma=9.3)
mh(both,Gamma=9.3)

#Compare with adaptmh(ageLT40,ageGE40,Gamma=10)
}
\references{

Birch, M. W. (1964). The detection of partial association, I: The 2 x 2 case. Journal of the Royal Statistical Society. Series B (Methodological), 313-324.

Cochran, W. G. (1954). Some methods for strengthening the common chi-squared tests. Biometrics, 10, 417-451.

Fu, Zhenming, Martha J. Shrubsole, Walter E. Smalley, Huiyun Wu, Zhi Chen, Yu Shyr, Reid M. Ness, and Wei Zheng (2012). Lifestyle factors and their combined impact on the risk of colorectal polyps. American Journal of Epidemiology 176, 766-776.

Mantel, N. and Haenszel, W. (1959). Statistical aspects of the analysis of data from retrospective studies. Journal of the National Cancer Institute 22, 719-748.

Rosenbaum, P. R. (1995). Quantiles in nonrandom samples and observational studies. Journal of the American Statistical Association, 90, 1424-1431.

Rosenbaum, P. R. (2002) Observational Studies (2nd edition).  New York: Springer.

Satagopan, J. M., Offit, K., Foulkes, W.,
Robson, M. E. Wacholder, S., Eng, C. M., Karp, S. E. and Begg, C. B. (2001).
The lifetime risks of breast cancer in Ashkenazi Jewish carriers of brca1 and brca2 mutations.  Cancer Epidemology, Biomarkers and Prevention, 10, 467-473.



}
