\name{adaptmhLS}
\alias{adaptmhLS}
\title{Large Sample Adaptive Test for Two 2x2xk Tables}
\usage{
adaptmhLS(tab1,tab2,Gamma=1,double=FALSE)
}
\description{
Given two statistically independent contingency tables, a focal 2x2xk table and an additional 2x2xm table, adaptmh performs an approximate, adaptive test and sensitivity analysis.  The test is adaptive in that is considers one test using the focal table alone, another test that combines the focal and additional tables, correcting for multiple testing using a Normal approximation to the exact joint distribution.  Uses the BiasedUrn and mvtnorm packages.
}
\arguments{
\item{tab1}{
tab1 is a 2x2 or a 2x2xk table that will be emphasized in the test.
}
\item{tab2}{
tab2 is a 2x2 or a 2x2xm table that will be given less emphasis in the test.  tab1 and tab2 must be statistically independent describing different individuals.
}
\item{Gamma}{
Gamma>=1 is the sensitivity parameter, where Gamma=1 yields a randomization test.
}
\item{double}{
If double = FALSE, then one test uses tab1 and the other uses both tab1 and tab2 as essentially a 2x2x(k+m) table; that is, the test statistic is the total count in the [1,1,j] cells of this 2x2x(k+m) table, as in the Cochran-Mantel-Haenszel-Birch test.

If double = TRUE, then one test uses tab1 as a 2x2xk table, and the other doubles the test statistic from this table and adds the test statistic for tab2, the 2x2xm table.  In other words, the counts in the [1,1,j] cell of tab1 are given twice the weigth of the counts
in the [1,1,j] cell of tab2.

In either case, the exact expectations, variances and covariances of the two test statistics are used in a Normal approximation to the bivariate distribution.
}
}
\value{
\item{pval}{
The pval from the adaptive test.
}
\item{maxdeviate}{
The larger of the two standardized deviates for the two component tests.
}
\item{correlation}{
The correlation of the two component test statistics under the null hypothesis.
}
\item{detail}{
The component test statistics, their null expectations, variances, standardized deviates, and p-values.  Only the overall pval above provides a valid test that corrects for testing the hypothesis twice.
}
}
\note{
adaptmhLS is the large sample approximation to the exact adaptive test in adaptmh.  The Normal approximation is similar to that in Rosenbaum (2012b).
}
\examples{
# The first example is from Satagopan, et al. (2001),
# Table 2.  It is a case-control study of
# breast cancer and BRCA1+ mutations
# for women aged <40 and women aged >=40.
ageLT40<-matrix(c(18,51,11,673),2,2)
ageGE40<-matrix(c(39,652,21,2699),2,2)
rownames(ageLT40)<-c("BRCA1+","Negative")
rownames(ageGE40)<-c("BRCA1+","Negative")
colnames(ageLT40)<-c("Case","Control")
colnames(ageGE40)<-c("Case","Control")
names(dimnames(ageLT40))<-c("Mutation","Breast Cancer")
names(dimnames(ageGE40))<-c("Mutation","Breast Cancer")
adaptmhLS(ageLT40,ageGE40,Gamma=9.6)

#This example is from Fu et al (2012) as discussed
#in Rosenbaum (2015, Table 1). In effect, the test
#adapts between two possible definitions of a high
#life-style risk of large adenomas
#discovered by colonoscopy.

tab1<-matrix(c(42,45,136,913),2,2)
tab2<-matrix(c(77,78,482,885),2,2)
colnames(tab1)<-c(">1cm","None")
colnames(tab2)<-c(">1cm","None")
rownames(tab1)<-c("5-6","0-1")
rownames(tab2)<-c("4","2")
names(dimnames(tab1))<-c("Risk Score","Adenoma Size")
names(dimnames(tab2))<-c("Risk Score","Adenoma Size")

#An adaptive randomization test,
#where both component tests reject.
adaptmhLS(tab1,tab2,Gamma=1)

#An adaptive randomization test,
#giving double weight to the extreme table.
adaptmhLS(tab1,tab2,Gamma=1,double=TRUE)

#A sensitivity analysis at Gamma=4.
#Only the high risk table leads to rejection.
adaptmhLS(tab1,tab2,Gamma=4,double=TRUE)

}
\references{

Birch, M. W. (1964). The detection of partial association, I: The 2 x 2 case. Journal of the Royal Statistical Society. Series B (Methodological), 313-324.

Cochran, W. G. (1954). Some methods for strengthening the common chi-squared tests. Biometrics, 10, 417-451.

Fu, Zhenming, Martha J. Shrubsole, Walter E. Smalley, Huiyun Wu, Zhi Chen, Yu Shyr, Reid M. Ness, and Wei Zheng (2012). Lifestyle factors and their combined impact on the risk of colorectal polyps. American Journal of Epidemiology 176, 766-776.

Mantel, N. and Haenszel, W. (1959). Statistical aspects of the analysis of data from retrospective studies. Journal of the National Cancer Institute 22, 719-748.

Rosenbaum, P. R. (1995). Quantiles in nonrandom samples and observational studies. Journal of the American Statistical Association, 90, 1424-1431.

Rosenbaum, P. R. (2002) Observational Studies (2nd edition).  New York: Springer.

Rosenbaum, P. R. (2012a). An exact adaptive test with superior design sensitivity in an observational study of treatments for ovarian cancer. The Annals of Applied Statistics, 6(1), 83-105.

Rosenbaum, P. R. (2012b). Testing one hypothesis twice in observational studies. Biometrika, 99, 763-774.

Rosenbaum, P. R. (2015).  The cross-cut statistic and its sensitivity to bias in observational studies with ordered doses of treatment.  Biometrics, to appear.  DOI: 10:1111/biom.12373

Rosenbaum, P. R. and Small, D. S. (2015)  An adaptive Mantel-Haenszel test for sensitivity analysis in observational studies.  Manuscript.

Small, D. S., Cheng, J., Halloran, M. E. and Rosenbaum, P. R. (2013). Case definition and design sensitivity. Journal of the American Statistical Association, 108, 1457-1468.

}
