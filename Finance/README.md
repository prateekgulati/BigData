Group 3A - Prateek, Hoshank , Akash
Name
	finance.sh

SYNOPSIS
	python balance.py  #optional
	./finance.sh


DESCRIPTION
		Provides balance sheet in .csv by parsing and cleaning data through balance.py using company API by last10K (optional part)
		
		Used as a blackbox function to plot the data from balancesheet datapoints stored in the csv generated file whose rows have 
		annual data of the company's balance sheet. Data file should be stored in the same directory as script or the filename should
		be provided with directory address.

		Output is various plots in .html format for inference

Advisabe to use it in Windows only. Final plots can be found in the company's ticker directory.

EXAMPLE: python balance.py #optional
		 generates balancesheet.csv in company's directory
		 
		 ./finance.sh
		 generates following plots and store them in the company's directory
			# 	QuickPlot.html
			#	CurrentPlot.html
			#	DebtEquityRatio.html
			#	PercentageChange.html
