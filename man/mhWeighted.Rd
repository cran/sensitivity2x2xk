\name{mhWeighted}
\alias{mhWeighted}
\title{Weighted Exact Test for Two 2x2xk Tables}
\usage{
mhWeighted(tab1,tab2,Gamma=1)
}
\description{
Exact, one-sided sensitivity analysis for two 2x2xk tables, where the first table receives twice the weight.
}
\arguments{
\item{tab1}{
tab1 is a 2x2 or a 2x2xk contingency table, typically treatment x outcome x covariate.  Table tab1 receives twice the weight of tab2.
}
\item{tab2}{
tab2 is a 2x2 or a 2x2xk contingency table, typically treatment x outcome x covariate.  Table tab1 receives twice the weight of tab2.
}
\item{Gamma}{
Gamma>=1 is the sensitivity parameter, where Gamma=1 yields a randomization test.
}
}
\value{
\item{pval}{
Upper bound on the one-sided P-value.
}
\item{WeightedMH}{
WeightedMH is the twice total count in the [1,1,j] cells of tab1 plus the total count of the [1,1,j] cells of tab2.
}
}
\note{
The mhWeighted function uses the exact distribution of the WeightedMH statistic under the null hypothesis.  In function adaptmh,
this test statistic may be used as one of the two component tests by setting double=TRUE.  The mhWeighted function makes the same test statistic available in a nonadaptive form.
}
\examples{
# The first example is from Satagopan, et al. (2001),
# Table 2. It is a case-control study of breast
# cancer and BRCA1+ mutations for women aged <40
# and women aged >=40.
ageLT40<-matrix(c(18,51,11,673),2,2)
ageGE40<-matrix(c(39,652,21,2699),2,2)
rownames(ageLT40)<-c("BRCA1+","Negative")
rownames(ageGE40)<-c("BRCA1+","Negative")
colnames(ageLT40)<-c("Case","Control")
colnames(ageGE40)<-c("Case","Control")
names(dimnames(ageLT40))<-c("Mutation","Breast Cancer")
names(dimnames(ageGE40))<-c("Mutation","Breast Cancer")
both<-array(c(18,51,11,673,39,652,21,2699),c(2,2,2))
dimnames(both)<-list(c("BRCA1+","Negative"),
      c("Case","Control"),c("LT40","GE40"))
names(dimnames(both))<-c("Mutation","Breast Cancer","Age")

#This is an unweighted Cochran-Mantel-Haenszel-Birch
#test for the 2x2x2 table:
mh(both,Gamma=7.2)

#This is the weighted test giving double
#weight to the first table.
mhWeighted(ageLT40,ageGE40,Gamma=7.2)
mhWeighted(ageLT40,ageGE40,Gamma=8.3)

#Compare: adaptmh(ageLT40,ageGE40,Gamma=10,double=TRUE)

#The second example is from Table II of
#Abbas, S. et al. (2008).  The table started as a 5x2
# crossclassification of doses of vitamin D
#in blood serum (25(OH)D in nM), and became
#two 2x2 tables, an outer table of extreme doses
#and an inner table of moderate doses.
#Compare with the discussion of the crosscut
#test in Rosenbaum (2015) and the corresponding example
#in the documentation for adaptmh.

tab1<-matrix(c(345,209,218,294),2,2)
tab2<-matrix(c(354,186,327,218),2,2)
colnames(tab2)<-c("cases","controls")
colnames(tab1)<-c("cases","controls")
rownames(tab1)<-c("<30",">=70")
rownames(tab2)<-c("30-45","60-75")
names(dimnames(tab1))<-c("Vitamin D","Breast Cancer")
names(dimnames(tab2))<-c("Vitamin D","Breast Cancer")

mhWeighted(tab1,tab2,Gamma=1.58)

# Compare with an unweighted test
mh(array(c(tab1,tab2),c(2,2,2)),Gamma=1.58)
mh(array(c(tab1,tab2),c(2,2,2)),Gamma=1.46)

# Compare: adaptmh(tab1,tab2,Gamma=2,inc=0.25,double=TRUE)

# Both examples are discussed in Rosenbaum and Small (2015).
}
\references{

Abbas, S. et al. (2008) Serum 25-hydroxyvitamin D and risk of post-menopausal breast cancer -- results in a large case-control study.
Carcinogenesis 29, 93-99.

Birch, M. W. (1964). The detection of partial association, I: The 2 x 2 case. Journal of the Royal Statistical Society. Series B (Methodological), 313-324.

Cochran, W. G. (1954). Some methods for strengthening the common chi-squared tests. Biometrics, 10, 417-451.

Fu, Zhenming, Martha J. Shrubsole, Walter E. Smalley, Huiyun Wu, Zhi Chen, Yu Shyr, Reid M. Ness, and Wei Zheng (2012). Lifestyle factors and their combined impact on the risk of colorectal polyps. American Journal of Epidemiology 176, 766-776.

Mantel, N. and Haenszel, W. (1959). Statistical aspects of the analysis of data from retrospective studies. Journal of the National Cancer Institute 22, 719-748.

Rosenbaum, P. R. (1995). Quantiles in nonrandom samples and observational studies. Journal of the American Statistical Association, 90, 1424-1431.

Rosenbaum, P. R. (2002) Observational Studies (2nd edition).  New York: Springer.

Rosenbaum, P. R. and Small, D. S. (2015)  An adaptive Mantel-Haenszel test for sensitivity analysis in observational studies.  Manuscript.

Satagopan, J. M., Offit, K., Foulkes, W.,
Robson, M. E. Wacholder, S., Eng, C. M., Karp, S. E. and Begg, C. B. (2001).
The lifetime risks of breast cancer in Ashkenazi Jewish carriers of brca1 and brca2 mutations.  Cancer Epidemology, Biomarkers and Prevention, 10, 467-473.
}
