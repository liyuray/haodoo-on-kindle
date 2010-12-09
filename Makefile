default: bbe.txt aqe.pdf aqe.dvi

aqe.pdf: aqe.dvi
	dvipdfmx aqe.dvi > aqe.log1 2>&1
	perl misschar.pl < aqe.log1

aqe.dvi: aqe.tex
	platex -kanji=euc aqe.tex

bbe.txt: 1.txt
	perl tt.pl > bbe.txt

clean:
	rm aqe.dvi aqe.pdf
