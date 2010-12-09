default: aqe.pdf aqe.dvi

aqe.pdf: aqe.dvi
	dvipdfmx aqe.dvi

aqe.dvi: aqe.tex
	platex -kanji=euc aqe.tex

clean:
	rm aqe.dvi aqe.pdf
