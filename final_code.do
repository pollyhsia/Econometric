use "D:\計量經濟\term_paper_Data\96_00_07_11\0602_final_data\0602_FinalTotalTable.dta" , replace
cap log close           
log using term_paper.log ,replace 
cd "D:\計量經濟\term_paper & Data\96_00_07_11\0602_final_data\" 

foreach v of var *{
	drop if missing(`v')
}


forval i = 1997/2000{
    gen D`i' = 0
 replace D`i' = 1 if year == `i'
}


forval i = 2007/2011{
    gen D`i' = 0
 replace D`i' = 1 if year == `i'
}


forval i = 1997/2000{
    gen isgov`i' = isgov*D`i'
}


forval i = 2007/2011{
    gen isgov`i' = isgov*D`i'
}

gen educol = 1 if edud > 12
replace educol = 0 if educol==.
gen  yeardXisgov = yeard*isgov

tabulate year
tabulate countyd
tabulate edud
sum edud
tabulate isgov
tabulate kids
tabulate educol
sum age
sum incomed if incomed > 1 & incomed < 999999
sum totalinc 



global ylist kids
global xlist1  yeard isgov yeardXisgov 
global xlist2 yeard isgov yeardXisgov age 
global xlist3 yeard isgov yeardXisgov age educol 
global xlist4 yeard isgov yeardXisgov age educol totalinc
global xlist5 yeard isgov yeardXisgov age educol totalinc nd ed cd 

global xlist6  D1997 D1998 D1999 D2000 D2007 D2008 D2009 D2010 D2011 isgov isgov1997 isgov1998 isgov1999 isgov2000 isgov2007 isgov2008 isgov2009 isgov2010 isgov2011 
global xlist7  D1997 D1998 D1999 D2000 D2007 D2008 D2009 D2010 D2011 isgov isgov1997 isgov1998 isgov1999 isgov2000 isgov2007 isgov2008 isgov2009 isgov2010 isgov2011 age 
global xlist8  D1997 D1998 D1999 D2000 D2007 D2008 D2009 D2010 D2011 isgov isgov1997 isgov1998 isgov1999 isgov2000 isgov2007 isgov2008 isgov2009 isgov2010 isgov2011 age educol
global xlist9  D1997 D1998 D1999 D2000 D2007 D2008 D2009 D2010 D2011 isgov isgov1997 isgov1998 isgov1999 isgov2000 isgov2007 isgov2008 isgov2009 isgov2010 isgov2011 age educol totalinc
global xlist10 D1997 D1998 D1999 D2000 D2007 D2008 D2009 D2010 D2011 isgov isgov1997 isgov1998 isgov1999 isgov2000 isgov2007 isgov2008 isgov2009 isgov2010 isgov2011 age educol totalinc nd ed cd

reg $ylist  $xlist1
est store OLS1_1
reg $ylist  $xlist2
est store OLS1_2
reg $ylist  $xlist3
est store OLS1_3
reg $ylist  $xlist4
est store OLS1_4
reg $ylist  $xlist5
est store OLS1_5
outreg2 [OLS1_1 OLS1_2 OLS1_3 OLS1_4 OLS1_5] using OLSOutput1_0602.doc, replace



reg $ylist  $xlist6
est store OLS2_1
reg $ylist  $xlist7
est store OLS2_2
reg $ylist  $xlist8
est store OLS2_3
reg $ylist  $xlist9
est store OLS2_4
reg $ylist  $xlist10
est store OLS2_5
outreg2 [OLS2_1 OLS2_2 OLS2_3 OLS2_4 OLS2_5] using OLSOutput2_0602.doc, replace


poisson $ylist  $xlist1
est store Poisson1_1
poisson  $ylist  $xlist2
est store Poisson1_2
poisson  $ylist  $xlist3
est store Poisson1_3
poisson  $ylist  $xlist4
est store Poisson1_4
poisson  $ylist  $xlist5
est store Poisson1_5
outreg2 [Poisson1_1 Poisson1_2 Poisson1_3 Poisson1_4 Poisson1_5] using PoissonOutput1_0602.doc, replace


poisson $ylist  $xlist6
est store Poisson2_1
poisson  $ylist  $xlist7
est store Poisson2_2
poisson  $ylist  $xlist8
est store Poisson2_3
poisson  $ylist  $xlist9
est store Poisson2_4
poisson  $ylist  $xlist10
est store Poisson2_5
outreg2 [Poisson2_1 Poisson2_2 Poisson2_3 Poisson2_4 Poisson2_5] using PoissonOutput2_0602.doc, replace





quietly poisson $ylist  $xlist1
margins, dydx(*) post
est store Poisson_ME_1_1
quietly poisson  $ylist  $xlist2
margins, dydx(*) post
est store Poisson_ME_1_2
quietly poisson  $ylist  $xlist3
margins, dydx(*) post
est store Poisson_ME_1_3
quietly poisson  $ylist  $xlist4
margins, dydx(*) post
est store Poisson_ME_1_4
quietly poisson  $ylist  $xlist5
margins, dydx(*) post
est store Poisson_ME_1_5
outreg2 [Poisson_ME_1_1 Poisson_ME_1_2 Poisson_ME_1_3 Poisson_ME_1_4 Poisson_ME_1_5] using PoissonOutput1_ME_0602.doc, replace


quietly poisson $ylist  $xlist6
margins, dydx(*) post
est store Poisson_ME_2_1
quietly poisson  $ylist  $xlist7
margins, dydx(*) post
est store Poisson_ME_2_2
quietly poisson  $ylist  $xlist8
margins, dydx(*) post
est store Poisson_ME_2_3
quietly poisson  $ylist  $xlist9
margins, dydx(*) post
est store Poisson_ME_2_4
quietly poisson  $ylist  $xlist10
margins, dydx(*) post
est store Poisson_ME_2_5
outreg2 [Poisson_ME_2_1 Poisson_ME_2_2 Poisson_ME_2_3 Poisson_ME_2_4 Poisson_ME_2_5] using PoissonOutput2_ME_0602.doc, replace







estpost sum dwhite dblack dother dmale age income if !mi(age) & !mi(income)
esttab using sum2.rtf, cells("mean(fmt(2)) sd(fmt(2)) min(fmt(1)) max(fmt(0))") nomtitle nonumber replace


//predict mu
//gen mu2 = exp(mu)
