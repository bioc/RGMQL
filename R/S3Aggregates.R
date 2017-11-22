#############################
#       AGGREGATES         #
############################


AGGREGATES <- function(value)
{
    op_list <- list(value = value)
    ## Set the name for the class
    class(op_list) <- "AGGREGATES"
    return(op_list)
}

check.META_AGGREGATES <- function(value)
{
    if(is.character(value) && length(value)>1)
        stop("value: no multiple string")
    
    if(!is.character(value))
        stop("value: is not a string")
}

META_AGGREGATES <- function(value)
{
    op_list <- list(value = value)
    ## Set the name for the class
    class(op_list) <- "META_AGGREGATES"
    return(op_list)
}

print.META_AGGREGATES <- function(obj) {
    res <- as.character(obj)
    cat(res)
}

as.character.META_AGGREGATES <- function(obj) {
    class <- class(obj)[1]
    val <- obj$value
    c(class,val)
}

take_value.META_AGGREGATES <- function(obj){
    class <- class(obj)[1]
    val <- obj$value
    text <- switch(class,
                "SUM" = paste0("sum_",val),
                "MIN" = paste0("min_",val),
                "MAX" = paste0("max_",val),
                "COUNT" = paste0("count"),
                "BAG" = paste0("bag_",val),
                "BAGD" = paste0("bagd_",val),
                "AVG" = paste0("avg_",val),
                "STD" = paste0("std_"),
                "MEDIAN" = paste0("median_",val),
                "Q1" = paste0("q1_",val),
                "Q2" = paste0("q2_"),
                "Q3" = paste0("q3_",val)
    )
    text
}



#' AGGREGATES object class constructor
#' 
#' 
#' This class constructor is used to create instances of AGGREGATES object,
#' to be used in GMQL functions that require aggregate on value.
#' 
#' \itemize{
#' \item{SUM: It prepares input parameter to be passed to the library 
#' function sum, performing all the type conversions needed  }
#' \item{COUNT: It prepares input parameter to be passed to the library 
#' function count, performing all the type conversions needed }
#' \item{MIN:It prepares input parameter to be passed to the library 
#' function minimum, performing all the type conversions needed  }
#' \item{MAX: It prepares input parameter to be passed to the library 
#' function maximum, performing all the type conversions needed }
#' \item{BAG: It prepares input parameter to be passed to the library 
#' function bag, this function creates comma-separated strings of 
#' attribute values, performing all the types conversions needed}
#' \item{BAGD: It prepares input parameter to be passed to the library 
#' function bag, this function creates comma-separated strings of distinct 
#' attribute values, performing all the types conversions needed}
#' \item{AVG: It prepares input parameter to be passed to the library 
#' function mean, performing all the type conversions needed }
#' \item{MEDIAN: It prepares input parameter to be passed to the library 
#' function median, performing all the type conversions needed }
#' \item{STD: It prepares input parameter to be passed to the library 
#' function standard deviation, performing all the type conversions needed}
#' \item{Q1: It prepares input parameter to be passed to the library 
#' function fist quartile, performing all the type conversions needed}
#' \item{Q2: It prepares input parameter to be passed to the library 
#' function second quartile, performing all the type conversions needed }
#' \item{Q3: It prepares input parameter to be passed to the library 
#' function third quartile, performing all the type conversions needed }
#' }
#' 
#' @param value string identifying name of metadata or region attribute
#'
#' @return aggregate object
#' 
#' @examples
#' 
#' ## local with CustomParser
#' init_gmql()
#' test_path <- system.file("example", "DATASET", package = "RGMQL")
#' exp = read_dataset(test_path)
#' 
#' ## This statement copies all samples of exp into res dataset, and 
#' ## then calculates new metadata attributes for each of them: 
#' ## sum_score is the sum of score of the sample regions.
#' 
#' res = extend(exp, sum_score = SUM("score"))
#' 
#' ## This statement copies all samples of exp into res dataset, 
#' ## and then calculates new metadata attributes for each of them: 
#' ## MinP is the minimum pvalue of the sample regions.
#' 
#' res = extend(exp, minP = MIN("pvalue"))
#' 
#' ## This statement copies all samples of exp into res dataset, 
#' ## and then calculates new metadata attributes for each of them: 
#' ## max_score is the maximum score of the sample regions.
#' 
#' res = extend(exp, max_score = MAX("score"))
#' 
#' ## The following cover operation produces output regions where at least 2 
#' ## and at most 3 regions ofexp overlap, having as resulting region 
#' ## attributes the average signal of the overlapping regions; 
#' ## the result has one sample for each input cell.
#' 
#' res = cover(exp, 2, 3, groupBy = list(DF("cell")), 
#' avg_signal = AVG("signal") )
#' 
#' ## It copies all samples of DATA into OUT dataset, and then for each of 
#' ## them it adds another metadata attribute, allScores, 
#' ## which is the aggregation comma-separated list of all the values 
#' ## that the region attribute score takes in the sample.
#' 
#' out = extend(exp, allScore = BAG("score"))
#' 
#' ## counts the regions in each sample and stores their number as value 
#' ## of the new metadata RegionCount attribute of the sample.
#' 
#' out = extend(exp, RegionCount = COUNT())
#' 
#' ## This statement copies all samples of exp into res dataset, 
#' ## and then calculates new metadata attributes for each of them: 
#' ## std_score is the standard deviation score of the sample regions.
#' 
#' res = extend(exp, std_score = STD("score"))
#' 
#' ## This statement copies all samples of exp into res dataset, 
#' ## and then calculates new metadata attributes for each of them: 
#' ## m_score is the median score of the sample regions.
#' 
#' res = extend(exp, m_score = MEDIAN("score"))
#' 
#' 
#' @name SUM
#' @aliases SUM
#' @rdname aggr-class
#' @export
#'
SUM <- function(value)
{
    check.META_AGGREGATES(value)
    
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("SUM","AGGREGATES","META_AGGREGATES")
    return(list)
}

#' @name MIN
#' @aliases MIN
#' @rdname aggr-class
#' @export
#'
MIN <- function(value)
{
    check.META_AGGREGATES(value)
    
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("MIN","AGGREGATES","META_AGGREGATES")
    return(list)
}


#' @name MAX
#' @aliases MAX
#' @rdname aggr-class 
#' @export
#'
MAX <- function(value)
{
    check.META_AGGREGATES(value)
    
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("MAX","AGGREGATES","META_AGGREGATES")
    return(list)
}

#' @name AVG
#' @aliases AVG
#' @rdname aggr-class
#' @export
#'
AVG <- function(value)
{
    check.META_AGGREGATES(value)
    
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("AVG","AGGREGATES","META_AGGREGATES")
    return(list)
}

#' @name BAG
#' @aliases BAG
#' @rdname aggr-class
#' @export
#'
BAG <- function(value)
{
    check.META_AGGREGATES(value)
    
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("BAG","AGGREGATES","META_AGGREGATES")
    return(list)
}

#' @name COUNT
#' @aliases COUNT
#' @rdname aggr-class
#' @export
#'
COUNT <- function()
{
    list <- list()
    ## Set the name for the class
    class(list) <- c("COUNT","AGGREGATES","META_AGGREGATES")
    return(list)
}
as.character.COUNT <- function(obj) {
    class <- class(obj)[1]
    c(class,"")
}
check.COUNT <- function(obj){}

#' @name STD
#' @aliases STD
#' @rdname aggr-class
#' @export
#'
STD <- function(value)
{
    check.META_AGGREGATES(value)
    
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("STD","META_AGGREGATES")
    return(list)
}


#' @name MEDIAN
#' @aliases MEDIAN
#' @rdname aggr-class
#' @export
#'
MEDIAN <- function(value)
{
    check.META_AGGREGATES(value)
    
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("MEDIAN","AGGREGATES","META_AGGREGATES")
    return(list)
}

#' @name Q1
#' @aliases Q1
#' @rdname aggr-class
#' @export
#'
Q1 <- function(value)
{
    check.META_AGGREGATES(value)
    
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("Q1","META_AGGREGATES")
    return(list)
}

#' @name Q2
#' @aliases Q2
#' @rdname aggr-class
#' @export
#'
Q2 <- function(value)
{
    check.META_AGGREGATES(value)
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("Q2","META_AGGREGATES")
    return(list)
}

#' @name Q3
#' @aliases Q3
#' @rdname aggr-class
#' @export
#'
Q3 <- function(value)
{
    check.META_AGGREGATES(value)
    
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("Q3","META_AGGREGATES")
    return(list)
}

#' @name BAGD
#' @aliases BAGD
#' @rdname aggr-class
#' @export
#'
BAGD <- function(value)
{
    check.META_AGGREGATES(value)
    
    list <- list(value = value)
    ## Set the name for the class
    class(list) <- c("BAGD","AGGREGATES","META_AGGREGATES")
    return(list)
}
