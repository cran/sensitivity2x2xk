\name{adaptmh}
\alias{adaptmh}
\title{Adaptive Exact Test for Two 2x2xk Tables}
\usage{
adaptmh(tab1,tab2,Gamma=1,alpha=0.05,double=FALSE,inc=0.25)
}
\description{
Given two statistically independent contingency tables, a focal 2x2xk table and an additional 2x2xm table, adaptmh performs an exact, adaptive test and sensitivity analysis.  The test is adaptive in that is considers one test using the focal table alone, another test that combines the focal and additional tables, correcting for multiple testing using the exact joint distribution.  Use
adaptmhLS for a large sample approximation to this exact test.
}
\arguments{
\item{tab1}{
tab1 is a 2x2 or a 2x2xk focal table that will be emphasized in the test.
}
\item{tab2}{
tab2 is a 2x2 or a 2x2xm additional table that will be given less emphasis in the test.  tab1 and tab2 must be statistically independent describing different individuals.
}
\item{Gamma}{
Gamma>=1 is the sensitivity parameter, where Gamma=1 yields a randomization test.
}
\item{alpha}{
alpha is a number, 0<alpha<1, where the test is performed with level alpha.  The test is one sided, testing no effect against
an increasted risk in the first row, the treated row.  To do a two-sided test,
report rejection at level alpha as rejection at level 2*alpha.  By
default, alpha=0.05, so rejection at one-sided alpha=0.025 can be described
as rejection at two-sided 0.05.
}
\item{double}{
If double = FALSE, then one test uses tab1 and the other uses both tab1 and tab2 as essentially a 2x2x(k+m) table; that is, the test statistic is the total count in the [1,1,j] cells of this 2x2x(k+m) table, as in the Cochran-Mantel-Haenszel-Birch test.

If double = TRUE, then one test uses tab1 as a 2x2xk table, and the other doubles the test statistic from this table and adds the test statistic for tab2, the 2x2xm table.  In other words, the counts in the [1,1,j] cell of tab1 are given twice the weigth of the counts
in the [1,1,j] cell of tab2.
}
\item{inc}{
The sensitivity analysis is performed at values of Gamma between 1 and
the number Gamma set when calling the function, in increments of inc.
For instance, setting Gamma=1.5 with inc=0.1 does the sensitivity analysis
for 1, 1.1, 1.2, 1.3, 1.4, 1.5.  The results end with the first Gamma
at which the null hypothesis is accepted at level alpha.
}
}
\value{
\item{A}{
A is the total count in the [1,1,j] cells of the 2x2xk table tab1, summing over j=1,...,k.  It is the test statistic in Birch's (1964) exact version of the Cochran-Mantel-Haenszel test.  A is the test statistic for the first test.
}
\item{B}{
Define A* to be the total count in the [1,1,j] cells of the 2x2xm table tab2, summing over j=1,...,m.  If double=FALSE, then B = A+A*.  If double=TRUE, then B = 2A+A*.  B is the test statistic for the second test.
}
\item{result}{
In row i of result, the test is performed so that, under H0, Pr(A>=a or B>=b) = peither <= alpha for the given Gamma.  The table also reports
Pr(A>=a) = pa, Pr(B>=b) = pb, and adif = |Pr(A>=a)-Pr(B>=b)| = |pa-pb|.  The values a, b are selected so that Pr(A>=a or B>=b) <= alpha, neither a nor b
can be reduced without increasing the other, and
|Pr(A>=a)-Pr(B>=b)| is minimized.  If either A>=a or B>=b then the test rejects at level alpha.
}
}
\note{
The test is Birch's (1964) one-sided exact test for no partial association in a 2x2xk table, reducing to Fisher's exact test if k=1.  The large sample version of Birch's test is the one-sided version of the Cochran (1954) - Mantel-Haenszel (1959) test.

Because this is an exact test with a discrete
distribution, it may have size strictly less than its level.  Discreteness
also implies that the optimal a and b may take small steps up and down as
Gamma increases.

The adaptmh
function performs the exact test using the fast fourier transform to convolve probability generating functions for the extended hypergeometric distribution.  The function makes use of the BiasedUrn package.  The sensitivity analysis for one 2x2xk (treatment x outcome x covariate) table in an observational study is developed in Rosenbaum (1995; 2002, Chapter 4).  Exact adaptive tests combining two groups of matched pairs or sets are described in Rosenbaum (2012a), Small et al. (2013) and Rosenbaum and Small (2015).  Another function, adaptmhLS, performs a parallel test using a Normal approximation to the exact null distribution.

The adaptive test shares alpha between two tests.  Some tables have such small
counts or marginal totals that rejection at level alpha is not possible no
matter how the results come out.  The program has to do a certain amount of
computation to discover this situation.  When the situation occurs, a warning
message is returned and the program executes a stop() with an error.  In this
case, you did not reject the null hypothesis at the given alpha and Gamma,
but no result with these data could do that.
}
\examples{
# The first example is from Satagopan, et al. (2001), Table 2.
# It is a case-control study of breast cancer and BRCA1+ mutations
# for women aged <40 and women aged >=40.
ageLT40<-matrix(c(18,51,11,673),2,2)
ageGE40<-matrix(c(39,652,21,2699),2,2)
rownames(ageLT40)<-rownames(ageGE40)<-c("BRCA1+","Negative")
colnames(ageLT40)<-colnames(ageGE40)<-c("Case","Control")
names(dimnames(ageLT40))<-c("Mutation","Breast Cancer")
names(dimnames(ageGE40))<-c("Mutation","Breast Cancer")
adaptmh(ageLT40,ageGE40,Gamma=10)

#The second example is from Fu et al (2012) as discussed
#in Rosenbaum (2015, Table 1). In effect, the test
#adapts between two possible definitions of a high
#life-style risk of large adenomas discovered by colonoscopy.

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
adaptmh(tab1,tab2,Gamma=1)

#An adaptive randomization test,
#giving double weight to the extreme table.

adaptmh(tab1,tab2,Gamma=1,double=TRUE)

#A sensitivity analysis at Gamma=5.
#Only the high risk table leads to rejection.

adaptmh(tab1,tab2,Gamma=5,double=TRUE)

#The third example is from Table II of
#Abbas, S. et al. (2008).  The table started as a 5x2
# crossclassification of doses of vitamin D
#in blood serum (25(OH)D in nM), and became
#two 2x2 tables, an outer table of extreme doses
#and an inner table of moderate doses.

tab1<-matrix(c(345,209,218,294),2,2)
tab2<-matrix(c(354,186,327,218),2,2)

colnames(tab2)<-colnames(tab1)<-c("cases","controls")
rownames(tab1)<-c("<30",">=70")
rownames(tab2)<-c("30-45","60-75")
names(dimnames(tab1))<-c("Vitamin D","Breast Cancer")
names(dimnames(tab2))<-c("Vitamin D","Breast Cancer")

#This performs the adaptive test with increments
#of .25 to limit computation
#in the example, but increments of 0.05
#would provide more detail.

adaptmh(tab1,tab2,Gamma=2, inc=0.25)

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

Rosenbaum, P. R. (2012a). An exact adaptive test with superior design sensitivity in an observational study of treatments for ovarian cancer. The Annals of Applied Statistics, 6(1), 83-105.

Rosenbaum, P. R. (2012b). Testing one hypothesis twice in observational studies. Biometrika, 99, 763-774.

Rosenbaum, P. R. (2015).  The cross-cut statistic and its sensitivity to bias in observational studies with ordered doses of treatment.  Biometrics, to appear.  DOI: 10:1111/biom.12373

Rosenbaum, P. R. and Small, D. S. (2015)  An adaptive Mantel-Haenszel test for sensitivity analysis in observational studies.  Manuscript.

Satagopan, J. M., Offit, K., Foulkes, W.,
Robson, M. E. Wacholder, S., Eng, C. M., Karp, S. E. and Begg, C. B. (2001).
The lifetime risks of breast cancer in Ashkenazi Jewish carriers of brca1 and brca2
mutations.  Cancer Epidemology, Biomarkers and Prevention, 10, 467-473.

Small, D. S., Cheng, J., Halloran, M. E. and Rosenbaum, P. R. (2013). Case definition and design sensitivity. Journal of the American Statistical Association, 108, 1457-1468.

}
