Group members - Hoshank Ailani(1310110148) Akash Idnani(1310110034) Prateek Gulati(1310110245)
Usage:
    $mapreduce.sh filename
Name
	mapreduce.sh

SYNOPSIS
	./mapreduce.sh 
	python mapreducedata.py [NAME of txt FILE] [Number of threads]
	Rscript mapReduceVisualization.R

DESCRIPTION
		Used as to generate wordcount of the unique words in a text file and generate the plots for the frequency of those words.

EXAMPLE: python mapReduceData.py Pagerank.txt 8
			generates wordfrequency.csv
		 Rscript mapReduceVisualization.R
		 
		 generates following plots
			# 	mostcommon.html
			#	leastcommon.html
			#	mostimportant.html
