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
	lualatex 2022-2-C2-P1.tex
	lualatex 2022-2-C2-P2.tex
	lualatex 2022-2-C2-TFC1-e-TFC2.tex
	lualatex 2022-2-C2-VR.tex
	lualatex 2022-2-C2-VS.tex
	lualatex 2022-2-C2-areas-e-volumes.tex
	lualatex 2022-2-C2-buraco.tex
	lualatex 2022-2-C2-dicas-pra-P1.tex
	lualatex 2022-2-C2-dicas-pra-P2.tex
	lualatex 2022-2-C2-dicas-pra-VS.tex
	lualatex 2022-2-C2-edos-exatas.tex
	lualatex 2022-2-C2-edos-lineares.tex
	lualatex 2022-2-C2-edovs.tex
	lualatex 2022-2-C2-fracoes-parciais.tex
	lualatex 2022-2-C2-int-por-partes.tex
	lualatex 2022-2-C2-mathologermovel.tex
	lualatex 2022-2-C2-mudanca-de-variaveis.tex
	lualatex 2022-2-C2-somas-de-riemann.tex
	lualatex 2022-2-C2-subst-trig.tex
	lualatex 2022-2-C3-P1.tex
	lualatex 2022-2-C3-P2.tex
	lualatex 2022-2-C3-VR.tex
	lualatex 2022-2-C3-derivadas-parciais.tex
	lualatex 2022-2-C3-dicas-pra-P1.tex
	lualatex 2022-2-C3-dicas-pra-P2.tex
	lualatex 2022-2-C3-funcoes-homogeneas.tex
	lualatex 2022-2-C3-intro.tex
	lualatex 2022-2-C3-maximos-e-minimos.tex
	lualatex 2022-2-C3-plano-tangente.tex
	lualatex 2022-2-C3-regra-da-cadeia.tex
	lualatex 2022-2-C3-superficies.tex
	lualatex 2022-2-C3-taylor.tex
	lualatex 2022-2-C3-tipos.tex
	lualatex 2022-2-C3-topologia.tex

compile_all_texs:
	lualatex 2022-2-C2-P1.tex
	lualatex 2022-2-C2-P2.tex
	lualatex 2022-2-C2-TFC1-e-TFC2.tex
	lualatex 2022-2-C2-VR.tex
	lualatex 2022-2-C2-VS.tex
	lualatex 2022-2-C2-areas-e-volumes.tex
	lualatex 2022-2-C2-buraco.tex
	lualatex 2022-2-C2-dicas-pra-P1.tex
	lualatex 2022-2-C2-dicas-pra-P2.tex
	lualatex 2022-2-C2-dicas-pra-VS.tex
	lualatex 2022-2-C2-edos-exatas.tex
	lualatex 2022-2-C2-edos-lineares.tex
	lualatex 2022-2-C2-edovs.tex
	lualatex 2022-2-C2-fracoes-parciais.tex
	lualatex 2022-2-C2-int-por-partes.tex
	lualatex 2022-2-C2-mathologermovel.tex
	lualatex 2022-2-C2-mudanca-de-variaveis.tex
	lualatex 2022-2-C2-somas-de-riemann.tex
	lualatex 2022-2-C2-subst-trig.tex
	lualatex 2022-2-C3-P1.tex
	lualatex 2022-2-C3-P2.tex
	lualatex 2022-2-C3-VR.tex
	lualatex 2022-2-C3-derivadas-parciais.tex
	lualatex 2022-2-C3-dicas-pra-P1.tex
	lualatex 2022-2-C3-dicas-pra-P2.tex
	lualatex 2022-2-C3-funcoes-homogeneas.tex
	lualatex 2022-2-C3-intro.tex
	lualatex 2022-2-C3-maximos-e-minimos.tex
	lualatex 2022-2-C3-plano-tangente.tex
	lualatex 2022-2-C3-regra-da-cadeia.tex
	lualatex 2022-2-C3-superficies.tex
	lualatex 2022-2-C3-taylor.tex
	lualatex 2022-2-C3-tipos.tex
	lualatex 2022-2-C3-topologia.tex
	lualatex 2022-2-C2-tudo.tex
	lualatex 2022-2-C3-tudo.tex
