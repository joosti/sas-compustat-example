

%let wrds = wrds.wharton.upenn.edu 4016;options comamid = TCP remote=WRDS; 
signon username=_prompt_; 


rsubmit; 

libname comp '/wrds/comp/sasdata/naa'; 
/*
-gvkey
-datadate 
-fyear
-ib(net income before extraordinary items)
-epspx(EPS before extraordinary items)   
-prcc_f (price at fiscal year end)
-cshpri (basic weighted average shares for fiscal year, in millions) -- I prefer csho (common shares outstanding end of year)
-indfmt (Industry Format)
-datafmt(data format)
-popsrc(Population Source)
-consol(Level of Consolidation - Company Annual Descriptor)
*/

/*compustat data 1961-1990*/
proc sql;
	create table myCompustat as
	select a.gvkey, a.datadate, a.fyear, a.ib, a.epspx, a.prcc_f, a.csho
	from
		comp.funda a
	where
		1962<= fyear <= 1990
	and indfmt='INDL' and datafmt='STD' and popsrc='D' and consol='C'; 
quit;

proc download data = myCompustat out=work.a_comp;run;

endrsubmit;