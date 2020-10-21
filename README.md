Arknights 6-star Headhunting Rate Analysis
==========================================

[![](https://img.shields.io/badge/Analysis-RPubs-blue.svg)](https://rpubs.com/Frizu/arknightstheo)
[![License:
MIT](https://img.shields.io/badge/license-MIT-red.svg)](https://cran.r-project.org/web/licenses/MIT)
[![](https://img.shields.io/github/last-commit/KaidenFrizu/GachaPull.svg)](https://github.com/KaidenFrizu/GachaPull/commits/master)

Comparative analysis on theoretical and simulated data in Arknights
Headhunting.

Developed by [KaidenFrizu](https://github.com/KaidenFrizu),
[SurfChu85](https://twitter.com/SurfChu85), [Ayane
Satomi](https://github.com/sr229), and
[Eyenine](https://twitter.com/Eyenine_i9).

Abstract
--------

Theoretical probabilities are important to predict your chances in
getting 6★ Operators in Arknights. While the first 50 consecutive non-6★
pulls follow the conventional geometric pdf with fixed probability `p`,
but it’s impossible in the case where the pity system starts and the `p`
varies each pull.

A similar problem was found in
[StackExchange](https://math.stackexchange.com/questions/435746/geometric-distribution-with-unequal-probabilities-for-trials/436247#436247)
where it asks about the specific distribution similar to geometric pdf
but with varying but deterministic probabilities. It is found out that
the theoretical probabilities of pulling a 6★ Operator after consecutive
non-6★ Operators follows a more general version of geometric
distribution in which accounts for the varying probabilities.

The probability of getting a 6★ Operator is much sooner than you would
expect. Upon calculation from the general version of geometric pdf,
results show that there is a 76% chance that you will pull a 6★ Operator
on your **55th** pull or earlier in your streak, 95% on your **62nd**
pull or earlier, and 99% on your **67th** pull or earlier. The
probabilities shown accounts the near impossibility of making into pull
99 because the probability of ending the current streak (or getting a
non-6★ Operator) decreases exponentially as you approach the 99th pull.

To validate, we tested each simulated data and determine whether they
follow the theoretical probabilities. For this analysis, there are 6
sets of simulated data where their differences comes down to their RNGs
and seeding methods. Results indicate that the all six sets of simulated
data follow the calculated theoretical probabilities.

The computed theoretical probabilities can be used to accurately predict
your chances of getting a 6★ Operator. This would highly benefit users
to plan ahead on their rolls and their desired outcomes. Further
research on other gacha rating system with varying rates could be
possible using the general formula for geometric pdf.

Files
-----

`arkfunc.R`  
A file containing all the custom codes used for simulation and analysis.

`CODEBOOK.md`  
A markdown file that contains the function and variable details in
`arkfunc.R` and `Savedata.RData`.

`GachaPull.Rproj`  
File used to open this project in RStudio.

`LICENSE`  
Contains the details on MIT License.

`Savedata.RData`  
An `RData` that contains the saved global environment on its last
render.

Analysis
--------

Detailed analysis can be found in
[**RPubs**](https://rpubs.com/Frizu/arknightstheo).
