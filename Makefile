# This file:
#   http://angg.twu.net/2022-2-C2-C3/Makefile.html
#   http://angg.twu.net/2022-2-C2-C3/Makefile
#           (find-angg "2022-2-C2-C3/Makefile")
#      See: (find-angg "2022-1-C2-C3/Makefile")
# Author: Eduardo Ochs <eduardoochs@gmail.com>
#
# Created by hand from:
#   (find-angg "2022-2-C2-C3/README.org")
#   (find-fline "/tmp/.filest0.tex")
#   (setq last-kbd-macro (kbd "C-a C-q TAB lualatex SPC C-a <down>"))

all: compile_all_texs

compile_basic_texs:
	lualatex 2022-2-C2-buraco.tex
	lualatex 2022-2-C2-mathologermovel.tex
	lualatex 2022-2-C3-intro.tex

compile_all_texs:
	lualatex 2022-2-C2-buraco.tex
	lualatex 2022-2-C2-mathologermovel.tex
	lualatex 2022-2-C3-intro.tex
	lualatex 2022-2-C2-tudo.tex
	lualatex 2022-2-C3-tudo.tex
