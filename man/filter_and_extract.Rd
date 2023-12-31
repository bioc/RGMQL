% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filter-extract-function.R
\name{filter_and_extract}
\alias{filter_and_extract}
\title{Filter and extract function}
\usage{
filter_and_extract(
  data,
  metadata = NULL,
  metadata_prefix = NULL,
  region_attributes = NULL,
  suffix = "antibody_target"
)
}
\arguments{
\item{data}{string GMQL dataset folder path or GRangesList
object}

\item{metadata}{vector of strings containing names of metadata attributes
to be searched for in metadata files.
Data will be extracted if at least one condition is satisfied:
this condition is logically "ANDed" with prefix filtering (see below)
if NULL no filtering action occures
(i.e every sample is taken for region filtering)}

\item{metadata_prefix}{vector of strings that will support the metadata
filtering. If defined, each 'metadata' is concatenated with the
corresponding prefix.}

\item{region_attributes}{vector of strings that extracts only region
attributes  specified; if NULL no regions attribute is taken and the output
is only GRanges made up by the region coordinate attributes
(seqnames, start, end, strand);
It is also possible to assign the \code{\link{FULL}} with or without 
its input parameter; in case was without the `except` parameter, 
all the region attributes are taken, otherwise all the region attributes 
are taken except the input attribute defined by except.}

\item{suffix}{name for each metadata column of GRanges. By default it is the
value of the metadata attribute named "antibody_target". This string is
taken from sample metadata file or from metadata() associated.
If not present, the column name is the name of selected regions specified
by 'region_attributes' input parameter}
}
\value{
GRanges with selected regions
}
\description{
This function lets user to create a new GRangesList with fixed information:
seqnames, ranges and strand, and a variable part made up by the regions
defined as input. The metadata and metadata_prefix are used to filter
the data and choose only the samples that match at least one metdatata
with its prefix. The input regions are shown for each sample obtained
from filtering.
}
\details{
This function works only with dataset or GRangesList all whose samples or
Granges have the same region coordinates (chr, ranges, strand) ordered in
the same way for each sample

In case of GRangesList data input, the function searches for metadata
into metadata() function associated to GRangesList.
}
\examples{

## This statement defines the path to the folder "DATASET" in the
## subdirectory "example" of the package "RGMQL" and filters such folder
## dataset including at output only "pvalue" and "peak" region attributes

test_path <- system.file("example", "DATASET", package = "RGMQL")
filter_and_extract(test_path, region_attributes = c("pvalue", "peak"))

## This statement imports a GMQL dataset as GRangesList and filters it
## including at output only "pvalue" and "peak" region attributes, the sort
## function makes sure that the region coordinates (chr, ranges, strand)
## of all samples are ordered correctly

grl <- import_gmql(test_path, TRUE)
sorted_grl <- sort(grl)
filter_and_extract(sorted_grl, region_attributes = c("pvalue", "peak"))

## This statement imports a GMQL dataset as GRangesList and filters it
## including all the region attributes

sorted_grl_full <- sort(grl)
filter_and_extract(sorted_grl_full, region_attributes = FULL())

## This statement imports a GMQL dataset as GRangesList and filters it
## including all the region attributes except "jaccard"

sorted_grl_full_except <- sort(grl)
filter_and_extract(
 sorted_grl_full_except, 
 region_attributes = FULL("jaccard")
)

}
