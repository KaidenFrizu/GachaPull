CODEBOOK
========

These is the documentation for `arkfunc.R`. It contains all the details,
arguments, and their expected outputs from all variables which are also
saved in `Savedata.RData`.

Functions
---------

### Theoretical Frequency Table

**Syntax**

`arknights_dist(n)`

**Description**

Returns a table of probabilities, frequencies, and odds of Arknights 6★
Headhunting. Inputs the total number of frequencies to be compared to
simulated data. Outputs a data frame.

**Arguments**

-   `n` - An integer of pull streaks to be calculated.

**Column Descriptions**

-   `pulls` - Refers to the *n*<sup>*t**h*</sup> pull when you obtained
    a 6★ Operator

-   `type` - Classifies if the pull is under the pity system or not

-   `rate` - The 6★ Headhunting rate described in the game

-   `e.freq` - The expected frequency from the total records collected

-   `prob` - The probability that you will obtain a 6★ Operator at that
    particular *n*<sup>*t**h*</sup> pull

-   `c.prob` - The probability that you will obtain a 6★ Operator at the
    *n*<sup>*t**h*</sup> pull or earlier

-   `odds` - The ratio of probability of getting a 6★ Operator to not
    getting one

-   `fail.odds` - The reciprocal of `odds`

### Simulation Functions

**Syntax**

`mtrng_sim(reps, iteration, master.seed = NULL, seedtype = c("default","rng","time")`

`sprng_sim(reps, iteration, master.seed = NULL, seedtype = c("default","rng","time")`

**Description**

Both of these functions are similar in nature, but differ in the type of
RNG used. `mtrng_sim()` uses *Mersenne-Twister RNG* which is the default
RNG in R, while `sprng_sim()` uses *Subtractive PRNG* which is a custom
RNG through the function `srand()`. Returns a list of three elements.

-   `[["results"]]` - A matrix with a size depending on `reps` (as rows)
    and `iteration` (as columns). It contains records of pull streaks
    when it got a 6-star operator.

-   `[["tally"]]` - A data frame of frequency, probabilities, and their
    corresponding RNG and seeding type that would be used for plotting.

-   `[[seed_list]]` - A data frame which contains the seed for each
    iteration. The values might be reproducible when there is a value
    passed in `master.seed` (except when `seedtype = "time"`). If
    `seedtype` is “default”, it returns a single element which is the
    `master.seed`. If no values were passed in `master.seed`, it returns
    `NULL`.

**Arguments**

-   `reps` - The number of repetitions (pull streaks) after pulling a
    6-star Operator for each iteration (account).

-   `iteration` - The number of accounts to be simulated.

-   `master.seed` - An argument similar to `set.seed()`, but gets an RNG
    state for reproducibility. This would result to a determined seed
    for each iteration, except when `seedtype = "time"`. The default is
    `NULL` where its corresponding RNG will use the last RNG state.

-   `seedtype` - Choose on either “default”, “rng”, or “time”. This
    would determine on the procedure on seeding each iteration. In case
    of no values passed on this argument, the default (fixed seed) shall
    be done.

### Custom RNG

-   `srand()` - A function created by
    [SurfChu85](https://twitter.com/SurfChu85) that is based from
    [Rosetta Code](https://rosettacode.org/wiki/Subtractive_generator)
    website. When a seed number is passed into this function, it returns
    nothing but creates an RNG state which is `TEMP55` as a side effect.
    When the `seed` is `NULL`, it returns the next generated number from
    `TEMP55`. If there’s no `TEMP55`, a new one would be created with a
    seed based from `Sys.time()`.

------------------------------------------------------------------------

Data
----

### Simulated Data Results

A list of 3 elements: “results”, “tally”, and “seed\_list”. The first
two are data frames while “seed\_list” is a data frame if `seedtype` is
“rng” or “time”. If `seedtype` is “default”, it returns a number passed
on `master.seed`, otherwise, it returns `NULL`.

-   `exp1` - Results from Mersenne-Twister RNG with fixed seed.

-   `exp2` - Results from Mersenne-Twister RNG with RNG seeding.

-   `exp3` - Results from Mersenne-Twister RNG with time seeding.

-   `exp4` - Results from Subtractive PRNG with fixed seed.

-   `exp5` - Results from Subtractive PRNG with RNG seeding.

-   `exp6` - Results from Subtractive PRNG with time seeding.

### Plot Data

These variables are made by `ggplot2` library. Import the given library
before running.

-   `c.freq.plot` - A plot of cumulative frequencies with theoretical
    values as points.

-   `c.prob.plot` - A plot of cumulative probabilities with theoretical
    values as points.

-   `freq.plot` - The distribution of frequencies with theoretical
    values as points.

-   `prob.plot` - The distribution of probabilities with theoretical
    values as points.

### Others

-   `theo_df` - The output variable from `arknights_dist()`

-   `df_tally` - A large data frame that contains all simulated tallies
    that are row bind (`rbind()`)

------------------------------------------------------------------------

Values
------

`TEMP55` - The RNG state for the function `srand()`. Behaves similar to
`.Random.seed` where it uses this vector to generate a random number for
`srand()`. When deleted, it would generate automatically with the seed
based from `Sys.time()`. Unless you know what you’re doing, avoid
changing this variable at all costs.
