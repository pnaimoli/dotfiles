#########################################
# Options
#########################################

options(scipen=250)
options(width=250)
options(digits=10)
options(repos="http://cran.stat.ucla.edu")

#########################################
# Defaults
#########################################

try({
require(Defaults)
require(utils)
require(stats)
setDefaults(approx, method="constant", ties="ordered", rule=2)
setDefaults(page, method="print")
})

#########################################
# Random
#########################################

bell <- function() { cat("\a") }

read.emptytable <- function(filename, ...) {
    df = try(read.table(filename, ...))
    if (inherits(df, 'try-error') &&
        attr(df, "condition")$message == "no lines available in input")
    {
        return(NULL)
    }
    return(df)
}

nonEmptyGlob <- function(g) {
    files = Sys.glob(g)
    return(files[file.info(files)$size>0])
}

read.tables <- function(file.names, ...) {
    do.call("rbind", lapply(nonEmptyGlob(file.names), function(fn) read.table(fn, ...)))
}

read.csvs <- function(file.names, header=F, ...) {
    do.call("rbind", lapply(nonEmptyGlob(file.names), function(fn) read.csv(fn, header=header, ...)))
}

read.ntables <- function(file.names, ...) {
    read.tables(file.names, colClasses=c("numeric"), ...)
}

read.ncsvs <- function(file.names, ...) {
    read.csvs(file.names, colClasses=c("numeric"), ...)
}

evenBucketAgg = function(data, n, FUN = mean)
{
    data = data[sort(data[,1], index.return=T)$ix,]
    newdata = list()
    thisGroupPoints = c()
    i = 1
    while(i <= NROW(data)) {
        newMinI = min((i+n-1),NROW(data))
        thisGroupPoints = data[i:newMinI,2]
        lastInd = bsearch(data[1:NROW(data), 1], data[newMinI,1])
        if(lastInd == 0) {
            newdata[[NROW(newdata)+1]] = c(data[i,1], FUN(data[i:newMinI,2]))
            break
        }
#        cat("i=", i, " lastInd=", lastInd, " newMinI=", newMinI, " tail=", data[newMinI,1], "\n");
        newdata[[NROW(newdata)+1]] = c(data[i,1], FUN(data[i:lastInd,2]))
        i = lastInd + 1
    }
    return(data.frame(do.call("rbind", newdata)))
}

plot.cor = function(corr) {
    red   = c( seq( from = 1.0,  to = 0.0, by = -0.1 ),
              seq( from = 0.05, to = 0.5, length = 10 ) )
    blue  = c( rep( x = 0.0, times = 10 ),
              seq( from = 0.0, to = 1.0, by = 0.1 ) )
    green = red
    colors = rgb( red = red, green = green, blue = blue )

    ##  Reverse the columns of the matrix so it will be drawn correctly.

    n = ncol( corr )
    corr2 <- corr[ , n:1 ]

    ##  Create the image.

    image(
        z    = corr2,
        axes = FALSE,
        col  = colors,
        zlim = c( -1.0, 1.0 ) )

    axis(
        side     = 2,
        labels   = colnames( corr2 ),
        at       = seq( 0, 1, length = length( rownames( corr2 ) ) ),
        cex.axis = 0.8,
        las      = 2)

    ##  Add labels for the x axis, but along the top.

    axis(
        side     = 3,
        labels   = rownames( corr2 ),
        at       = seq( 0, 1, length = length( colnames( corr2 ) ) ),
        cex.axis = 0.8,
        las      = 2 )
}

int2date = function(d) { ISOdatetime(floor(d/10000), floor((d %% 10000)/100), d %% 100, 0, 0, 0) }

#########################################
# Data cleaning functions
#########################################
cleanDataFrame <- function(data, quant)
{
    if(nrow(data) == 0 || ncol(data) == 0)
        return(data);
    clean <- function(x)
    {
        cleanList(x, quant);
    }
    myInc <- apply(apply(data, 2, clean), 1, all)
    return(data[myInc,]);
}

cleanList <- function(data, quant)
{
    myRange <- quantile(data,seq(0,1,1/quant),na.rm=TRUE)[c(2,quant)];
    return(data >= myRange[1] & data <= myRange[2]);
}

removeZeros <- function(data, form)
{
    ivs <- attr(terms(form), "term.labels");
    dv <-  as.character(attr(terms(form), "variables"))[2];
    myInc <- apply(apply(data[,ivs], 2, function(x) { x!=0 }), 1, all);
    return(data[myInc,]);
}

