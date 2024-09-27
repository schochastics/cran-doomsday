# CRAN Doomsday Clock


At all times, a large amount of packages on CRAN are at risked to be [archived](https://www.cranhaven.org/dashboard-at-risk.html). There are many reasons why a package might be at risk to be archived. Whatever it is, maintainers will receive an email (if the reason is not that your maintainer emails bounce...) that they have two weeks to fix the problem, otherwise the package is archived. In many cases, fixes are trivial, but 

**What if noone fixes the issues and packages are archived?**

The interesting part of this thought experiment is, that the archival of one package, might trigger the "at risk" status of another, namely if it imports (or suggests) the archived package. If these packages also do not fix this issue, they also will get archived and trigger a new wave of "at risk" packages. Eventually, there will be only a few packages left that do not import/suggest other packages. 

The CRAN Doomsday Clock calculates when the point in time is reached where CRAN
only contains dependency free packages.
