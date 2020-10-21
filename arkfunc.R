srand <- function(seed = NULL) { #Derived from Rosetta Code website; made by SurfChu85
    
    if(is.null(seed)) {
        if(!exists("TEMP55")) srand(as.integer(Sys.time()) %% (10^9))
        TEMP55 <- tail(TEMP55, n = 55)
        TEMP55 <- append(TEMP55, (TEMP55[56-55] - TEMP55[56-24]) %% (10^9))
        TEMP55 <<- TEMP55
        return(TEMP55[56])
    }
    
    if((seed <= 10^9-1 & seed >= 1) == FALSE) stop("Seed must be between 1 and 10^9-1")
    
    temp <- c()
    reorder_temp <- c()
    result <- c()
    
    temp[1] <- seed
    temp[2] <- 1
    
    for(i in 3:55) temp[i] <- (temp[i-2] - temp[i-1]) %% (10^9)
    for(i in 1:55) reorder_temp[i] <- temp[((34*(i)) %% 55)+1]
    for(i in 56:220) (reorder_temp[i] <- (reorder_temp[i-55] - reorder_temp[i-24]) %% (10^9))
    
    TEMP55 <<- append(reorder_temp, (reorder_temp[56-55] - reorder_temp[56-24]) %% (10^9))
    
    return(invisible(NULL))
}

mtrng_sim <- function(reps, iteration
                      ,master.seed = NULL
                      ,seedtype = c("default","rng","time")) {
    
    if(!is.null(master.seed)) set.seed(master.seed)
    suppressWarnings(if(!(seedtype %in% c("default","rng","time")))
        stop("Invalid seedtype"))
    
    dist_matrix <- matrix(nrow = reps, ncol = iteration)
    seedtype <- seedtype[1]
    tallydata <- c()
    seed_list <- c()
    returnlist <- list()
    
    for (j in 1:iteration) {
        
        if(seedtype == "time") {
            Sys.sleep(2*10^(-3))
            seed <- (as.numeric(Sys.time()) * (10^9)) %% (10^9)
            seed_list <- c(seed_list, seed)
            set.seed(seed)
        }
        else if(seedtype == "rng") {
            seed <- (runif(1)*10^9) %% (10^9)
            seed_list <- c(seed_list, seed)
            set.seed(seed)
        }
        
        for(i in 1:reps) {
            attempt <- 0
            result <- 1
            rateformula <- 0.02
            while(result > rateformula) {
                attempt = attempt + 1
                rateformula <- 0.02 * max(1, attempt-49)
                result <- runif(1)
            }
            dist_matrix[i,j] <- attempt
        }
    }
    
    returnlist[["results"]] <- dist_matrix
    
    for(k in 1:99) tallydata <- c(tallydata, sum(dist_matrix == k))
    tallydata <- data.frame(c(1:99), tallydata, cumsum(tallydata)
                            ,(tallydata / sum(tallydata)), cumsum(tallydata / sum(tallydata))
                            ,"mtrng", seedtype)
    names(tallydata) <- c("pulls","freq","c.freq","prob","c.prob","rng","seedtype")
    returnlist[["tally"]] <- tallydata
    
    if(seedtype == "rng" | seedtype == "time") {
        seed_list <- data.frame(c(1:length(seed_list)), seed_list)
        names(seed_list) <- c("iteration","seed")
        returnlist[["seed_list"]] <- seed_list
    }
    else if(!is.null(master.seed)) returnlist[["seed_list"]] <- master.seed
    else returnlist[["seed_list"]] <- NULL
    
    return(returnlist)
}

sprng_sim <- function(reps, iteration
                      ,master.seed = NULL
                      ,seedtype = c("default","rng","time")) {
    
    if(!is.null(master.seed)) srand(master.seed)
    suppressWarnings(if(!(seedtype %in% c("default","rng","time")))
        stop("Invalid seedtype"))
    
    dist_matrix <- matrix(nrow = reps, ncol = iteration)
    seedtype <- seedtype[1]
    seed_list <- c()
    tallydata <- c()
    returnlist <- list()
    
    for (j in 1:iteration) {
        
        if(seedtype == "time") {
            Sys.sleep(10^(-3))
            seed <- (as.numeric(Sys.time()) * (10^9)) %% (10^9-1)
            seed_list <- c(seed_list, seed)
            srand(seed)
        }
        else if(seedtype == "rng") {
            seed <- srand()
            seed_list <- c(seed_list, seed)
            srand(seed)
        }
        
        for(i in 1:reps) {
            attempt <- 0
            result <- 1
            rateformula <- 0.02
            while(result > rateformula) {
                attempt = attempt + 1
                rateformula <- 0.02 * max(1, attempt-49)
                result <- srand() / (10^9)
            }
            dist_matrix[i,j] <- attempt
        }
    }
    
    returnlist[["results"]] <- dist_matrix
    
    for(k in 1:99) tallydata <- c(tallydata, sum(dist_matrix == k))
    tallydata <- data.frame(c(1:99), tallydata, cumsum(tallydata)
                            ,(tallydata / sum(tallydata)), cumsum(tallydata / sum(tallydata))
                            ,"sprng", seedtype)
    names(tallydata) <- c("pulls","freq","c.freq","prob","c.prob","rng","seedtype")
    returnlist[["tally"]] <- tallydata
    
    if(seedtype == "rng" | seedtype == "time") {
        seed_list <- data.frame(c(1:length(seed_list)), seed_list)
        names(seed_list) <- c("iteration","seed")
        returnlist[["seed_list"]] <- seed_list
    }
    else if(!is.null(master.seed)) returnlist[["seed_list"]] <- master.seed
    else returnlist[["seed_list"]] <- NULL
    
    return(returnlist)
}

arknights_dist <- function(n) {
    
    if(n <= 0) stop("n must be positive")
    
    n <- as.integer(n)
    pulls <- as.numeric(1:99)
    pr <- as.numeric(1)
    prob <- rate <- as.numeric()
    type <- as.character()
    
    for(i in pulls) {
        rateformula <- 0.02*max(1,i-49)
        rate <- c(rate,rateformula)
        
        prob <- c(prob, prod(pr)*rateformula)
        if(length(prob) != 0) pr <- c(pr, 1-rateformula)
        
        if(i <= 50) type <- c(type, "nonpity")
        else type <- c(type, "pity")
    }
    
    freq <- round(n * prob)
    c.prob <- cumsum(prob)
    c.freq <- cumsum(freq)
    odds <- prob / (1 - prob)
    fail.odds <- (1 - prob) / prob
    
    return(data.frame(pulls, type, rate
                      ,freq, c.freq, prob, c.prob
                      ,odds, fail.odds))
}
