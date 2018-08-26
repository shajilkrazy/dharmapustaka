run:
	rm -f *.aux *.log *.out *.toc
	xelatex main.tex
	xelatex main.tex
	mv main.pdf "Sanskrit Bible.pdf"
