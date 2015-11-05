Contains standalone programs, each testing one power series implementation.
You'll need 
https://github.com/bigdatadev/benchpress
for all of them, and the respective libraries or binaries installed, which are

* flint, http://www.flintlib.org
* libpari, from http://pari.math.u-bordeaux.fr
* piranha (headers), see https://github.com/bluescarni/piranha

Please see the resp. web pages for the dependencies needed for these
libraries.

The tests are manipulations of univariate series with integer exponents
and rational coefficients which is one of the main usages. The purpose
at the moment is to see if piranha's generic implementation can
compete with traditional dedicated univariate implementations.

The main test at the moment is to multiply the expansions of sin(x)
and cos(x) to various precision.

Results
-------
System: 6x3GHz AMD Phenom with OpenSuSE Linux 13. Time is in milliseconds.
```
                                N=100   N=1000      

flint fmpq_poly_mul()            0.27       88
flint fmpq_poly_mullow()         0.29       91
piranha psin*pcos trunc.         0.69      690
piranha psin*pcos no trunc.      5.0      4670
pari sin(x)*cos(x)              11        1400
```
