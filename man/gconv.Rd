\name{gconv}
\alias{gconv}
\title{Convolution of Two Probability Generating Functions}
\usage{
gconv(g1,g2)
}
\description{
Computes the convolution of two probability generating functions using the convolve function in the stats package.  The convolve function uses the fast fourier transform.
}
\arguments{
\item{g1}{
A probability generating function.  A vector g1 for a random variable X taking values 0, 1, 2, ..., length(g1)-1, where g1[i] = Pr(X=i-1)For example, g1 = c(2/3, 1/3) is the generating function of a binary random variable X with Pr(X=0)=2/3, Pr(X=1)=1/3.  The random variable that is 0 with probability 1 has g1=1.
}
\item{g2}{
Another probability generating function for a random variable Y.  For a fair die, g2 = c(0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6).
}
}

\value{
The probability generating function of X+Y when X and Y are independent.
}
\examples{

gconv(c(2/3,1/3),c(2/3,1/3))

gconv(1,c(2/3,1/3))

gconv(c(0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6),
     c(0, 1/6, 1/6, 1/6, 1/6, 1/6, 1/6))


}

\references{

Pagano, M. and Tritchler, D. (1983). On obtaining permutation distributions in polynomial time. Journal of the American Statistical Association, 78, 435-440.

Rosenbaum, P. R. (2010).  Design of Observational Studies.  New York: Springer.  Section 3.9: Appendix Exact Computations for Sensitivity Analysis.

}
