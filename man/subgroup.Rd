\name{subgroup}
\alias{subgroup}
\title{Compute measures for assessing treatment effect heterogeneity across subgroups in clinical trials and produce graphical presentations}
\description{This function produces various measures of expected treatment effect heterogeneity 
	and allows graphical comparisons with the observed counterparts. The resulting measures can also be saved for creation of 
	user-specified graphics. 
	}
\usage{
	subgroup(data, overall.diff = NA, force.theoretical = FALSE, 
		force.simulation = FALSE, design = FALSE, plots = TRUE)
	}
\arguments{
  \item{data}{A matrix of 2 columns containing the subgroup treatment effects and their associated standard errors.
		The treatment effects must be measured on a scale where 0 means no effect. For example, a mean difference, a log relative 
		risk, log odds ratio, or log hazard ratio. Column 2 must contain the standard errors associated with the subgroup 
		treatment effects in Column 1. Furthermore, a treatment effect that is > 0 is considered to favour the control.}
  \item{overall.diff}{The overall treatment effect, provided optionally by the user. If not specified this 
		is calculated within the \code{subgroup} routine as a reciprocal variance weighted mean.}
  \item{force.theoretical}{The default value for this argument is \code{FALSE}. If \code{TRUE}, theoretical computations 
	are conducted regardless of the number of subgroups, \code{R}. If the standard errors of the subgroup treatment effects 
	is heterogeneous and \code{R > 20}, a warning is given to advise the user that the processing time may be significant. 
	An error message is given if both \code{force.theoretical} and 
	\code{force.simulation} are set to \code{TRUE}, and the routine will stop execution. }
  \item{force.simulation}{The default value for this argument is \code{FALSE}. If \code{TRUE}, simulation based computations 
	are conducted regardless of the number of subgroups, \code{R}. An error message is given if both \code{force.theoretical} and 
	\code{force.simulation} are set to \code{TRUE}, and the routine will stop execution. }
  \item{design}{The default value for this argument is \code{FALSE}. If \code{TRUE}, the plots will not include any observed measures.}
  \item{plots}{The default value for this argument is \code{TRUE}. If \code{FALSE}, no plots will be displayed.}
	}
\details{Subgroup analysis principles require a significant test of interaction in order to claim 
	heterogeneity of treatment effect. As clinical trials are typically underpowered for tests of 
	interaction, overly optimistic expectations of treatment effect homogeneity can make interpretation 
	difficult when treatment effects seemingly differ between subgroups. In addition to extending 
	the ideas proposed by Marschner (2010), the package \pkg{subgroup} 
	also implements some new measures, and provides a suite of graphical tools that 
	allow visual comparison of the magnitude and nature of the observed and expected 
	subgroup differences that can arise as an artefact of chance. These tools are intended to 
	supplement a formal test of interaction in subgroup analyses, and are described in the manuscript 
	Schou and Marschner (2014). 

	Three outputs are computed by the package. These include the following: the expectations of the 
	ordered treatment effects, the probability density of the range, and the probability distribution 
	of the number of subgroups favouring the control treatment. The user has the option to have the in-built 
	plot suppressed. The content of the default plot produced will depend on the user choice of an analysis stage 
	evaluation or a design stage evaluation; if it is the former, the observed counterparts of the measures 
	produced will be included in the plots. 
	}

\value{
	The following list of components is returned by the routine \code{subgroup}:
	\item{expectations}{A matrix of dimension \code{R x 4}, where \code{R} is the number of subgroups. The first two columns present the treatment differences
				and the standard errors contained in the dataset \code{data} as submitted by the user. The third column
				contains the expected ordered treatment differences, and the fourth column the order number.}
	\item{favourcontrol}{A matrix of dimension \code{(R+1) x 2}, where \code{R} is the number of subgroups. The first column contains the 
				number of subgroups favouring control. The second contains the probability of that event. 
				Here, a treatment effect that is > 0 is considered to favour the control.}
	\item{rangedensity}{A matrix with 2 columns. The first column contains the sample space for the range which takes 
				on values > 0. The second column contains the probability density.}
	\item{overalldiff}{A numeric variable which returns the input argument \code{overall.diff} if specified by the user or 
				the reciprocal variance weighted mean treatment difference as calculated 
				within the routine \code{subgroup}.}
	}
\references{
	Marschner IC.
	Regional differences in multinational clinical trials: anticipating change variation.
	Clinical Trials 2010; 7:147-156.

	Schou IM and Marschner IC. Methods for exploring treatment effect heterogeneity in 
	subgroup analysis: an application to global clinical trials. COBRA Preprint Series. 
	Working Paper 108. http://biostats.bepress.com/cobra/art108/.
	}
\author{I. Manjula Schou}
\examples{
	\donttest{ 
		# Create dataset containing treatment differences and standard errors. ------------
		difference<-c(-0.163, -0.083, -0.030, 0.095)
		se<-c(0.48, 0.27, 0.19, 0.39) 
		mydata<-cbind(difference, se)

		# Example code to produce the expected measures together with the plot created ----
		# by the subgroup routine for comparison against the observed differences. --------
		# NOTE: The execution time increases as the number of subgroups increases. --------
		test1<-subgroup(data=mydata)

		# Expected measures produced by the subgroup routine that the user ----------------
		# can manipulate to produce own graphics. -----------------------------------------
		test1$overalldiff         # Overall difference between treatment groups.
		test1$expectations        # Expectations of the ordered treatment differences.
		test1$rangedensity[1:15,] # Sample of the probability density of the range.
		test1$favourcontrol	  # Prob dist of subgroups favouring the control treatment.

		# Example code for evaluation of chance heterogeneity at the design stage. --------
		test2<-subgroup(data=mydata, design=TRUE)

		# Example code for simulation based evaluation of chance heterogeneity. -----------
		test3<-subgroup(data=mydata, force.simulation=TRUE)
		}

	}


 
