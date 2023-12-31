% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gmql_read.R
\name{read_gmql}
\alias{read_gmql}
\alias{read_GRangesList}
\title{Function read}
\usage{
read_gmql(dataset, parser = "CustomParser", is_local = TRUE)

read_GRangesList(samples)
}
\arguments{
\item{dataset}{folder path for GMQL dataset or dataset name on repository}

\item{parser}{string used to parsing dataset files.
The Parsers available are:
\itemize{
\item{BedParser}
\item{BroadPeakParser}
\item{NarrowPeakParser}
\item{CustomParser}
}
Default is CustomParser.}

\item{is_local}{logical value indicating local or remote dataset}

\item{samples}{GRangesList}
}
\value{
GMQLDataset object. It contains the value to use as input 
for the subsequent GMQLDataset method
}
\description{
It reads a GMQL dataset, as a folder containing some homogenus samples on 
disk or as a GRangesList, saving it in Scala memory in a way that can be 
referenced in R. It is also used to read a repository dataset in case of
remote processing.
}
\details{
Normally, a GMQL dataset contains an XML schema file that contains
name of region attributes. (e.g chr, start, stop, strand)
The CustomParser reads this XML schema; 
if you already know what kind of schema your files have, use one of the 
parsers defined, without reading any XML schema.

If GRangesList has no metadata: i.e. metadata() is empty, two metadata are
generated:
\itemize{
\item{"provider" = "PoliMi"}
\item{"application" = "RGMQL"}
}

NOTE: 
The folder layout must obey the following rules and adopt 
the following layout:
The dataset folder can have any name, but must contains the 
sub-folders named: "files".
The sub-folder "files" contains the dataset files and 
the schema xml file.
The schema files adopt the following the naming conventions:

- "schema.xml"
- "test.schema"

The names must be in LOWERCASE. Any other schema file 
will not be conisdered, if both are present, "test.schema" will be used.
}
\examples{

## This statement initializes and runs the GMQL server for local execution 
## and creation of results on disk. Then, with system.file() it defines 
## the path to the folder "DATASET" in the subdirectory "example" 
## of the package "RGMQL" and opens such folder as a GMQL dataset 
## named "data" using CustomParser

init_gmql()
test_path <- system.file("example", "DATASET", package = "RGMQL")
data = read_gmql(test_path)

## This statement opens such folder as a GMQL dataset named "data" using 
## "NarrowPeakParser" 
dataPeak = read_gmql(test_path,"NarrowPeakParser")

## This statement reads a remote public dataset stored into GMQL system 
## repository. For a public dataset in a (remote) GMQL repository the 
## prefix "public." is needed before dataset name

remote_url = "http://www.gmql.eu/gmql-rest/"
login_gmql(remote_url)
data1 = read_gmql("public.Example_Dataset_1", is_local = FALSE)


}
