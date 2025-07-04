# Copyright (C) 2002, 2003 John Goerzen
# <jgoerzen@complete.org>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; version 2 of the License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

clean:
	-python2.3 setup.py clean --all
	-rm -f `find . -name "*~"`
	-rm -f `find . -name "*.pyc"`
	-rm -f `find . -name "*.pygc"`
	-rm -f `find . -name "*.class"`
	-rm -f `find . -name "*.bak"`
	-rm -f `find . -name ".cache*"`
	-rm -f *.log *.aux *.dvi *.out *.jtex jadetex.cfg
	-find . -name auth -exec rm -vf {}/password {}/username \;
	-rm -rf build

changelog:
	git log -M -C --find-copies-harder --name-status > ChangeLog

docs: doc/pygopherd.8 doc/pygopherd.ps \
	doc/pygopherd.pdf doc/pygopherd.txt doc/pygopherd.html

#doc/pygopherd.8: doc/pygopherd.sgml doc/book.sgml
#	docbook2man doc/book.sgml
#	docbook2man doc/book.sgml
#	-rm manpage.links manpage.refs
#	mv pygopherd.8 doc

doc/pygopherd.8: doc/pygopherd.sgml doc/book.sgml
	mkdir -p doc
	cd doc && docbook2man book.sgml
	cd doc && rm -f manpage.links manpage.refs
	cd doc && if [ -f pygopherd.8 ]; then \
		: ; \
	elif [ -f book.8 ]; then \
		mv book.8 pygopherd.8; \
	else \
		echo "No manpage produced!"; exit 1; \
	fi

#doc/pygopherd.html: doc/pygopherd.sgml
#	docbook2html -u doc/pygopherd.sgml
#	mv pygopherd.html doc

#doc/pygopherd.html: doc/pygopherd.sgml doc/book.sgml
#	docbook2html -u doc/book.sgml
#	mv book.html doc/pygopherd.html

doc/pygopherd.html: doc/pygopherd.sgml doc/book.sgml
	mkdir -p doc
	cd doc && docbook2html -u book.sgml
	cd doc && if [ -f pygopherd.html ]; then \
		: ; \
	elif [ -f book.html ]; then \
		mv book.html pygopherd.html; \
	else \
		echo "No HTML doc produced!"; exit 1; \
	fi

#doc/pygopherd.ps: doc/pygopherd.8
#	man -t -l doc/pygopherd.8 > doc/pygopherd.ps

#doc/pygopherd.ps: doc/pygopherd.sgml doc/book.sgml doc/manpage.sgml
#	docbook2ps \
#		doc/book.sgml
#	mv book.ps doc/pygopherd.ps

doc/pygopherd.ps: doc/pygopherd.sgml doc/book.sgml doc/manpage.sgml
	mkdir -p doc
	cd doc && docbook2ps book.sgml
	cd doc && if [ -f book.ps ]; then \
		mv book.ps pygopherd.ps; \
	else \
		echo "No PS doc produced!"; exit 1; \
	fi

#doc/pygopherd.pdf: doc/pygopherd.ps
#	ps2pdf doc/pygopherd.ps
#	mv pygopherd.pdf doc

doc/pygopherd.pdf: doc/pygopherd.ps
	mkdir -p doc
	cd doc && ps2pdf pygopherd.ps
	cd doc && if [ -f pygopherd.pdf ]; then :; else echo "No PDF produced!"; exit 1; fi

#doc/pygopherd.txt:
#	groff -Tascii -man doc/pygopherd.8 | sed $$'s/.\b//g' > doc/pygopherd.txt

doc/pygopherd.txt: doc/pygopherd.8
	mkdir -p doc
	cd doc && groff -Tascii -man pygopherd.8 | sed $$'s/.\b//g' > pygopherd.txt
