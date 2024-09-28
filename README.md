# CRAN Doomsday Clock


At all times, a large amount of packages on CRAN are at risk to be
[archived](https://www.cranhaven.org/dashboard-at-risk.html). There are many
reasons why a package might need to be archived. Whatever it is, maintainers will receive an
email (if the reason is not that your maintainer emails bounce...) that they
have two weeks to fix the problem, otherwise the package is archived. So 

**What if noone would fix the issues and packages are archived?**

The interesting part of this thought experiment is, that archiving one package,
might trigger the "at risk" status of another, namely if it imports (or
suggests) the archived package. If these packages also do not fix this issue,
they also will be archived and yet again trigger a new wave of "at risk" packages.
Eventually, this chain reaction will lead to the situation where only a few
packages are left that do not import/suggest others. 

The CRAN Doomsday Clock calculates when the point in time is reached where CRAN
only contains dependency free packages, based on the current packages at risk
to be archived

The clock resets every day at noon, because - not surprisingly - most
maintainers DO actually fix the issues. However, also new issues may arise in
previously safe packages.
