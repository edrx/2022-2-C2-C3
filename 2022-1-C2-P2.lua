-- This file:
--   http://angg.twu.net/LATEX/2022-1-C2-P2.lua.html
--   http://angg.twu.net/LATEX/2022-1-C2-P2.lua
--           (find-angg "LATEX/2022-1-C2-P2.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- (defun e () (interactive) (find-angg "LATEX/2022-1-C2-P2.tex"))
-- (defun l () (interactive) (find-angg "LATEX/2022-1-C2-P2.lua"))
-- (defun l2 () (interactive) (find-angg "LUA/Lazy2.lua"))
-- (defun l3 () (interactive) (find-angg "LUA/Lazy3.lua"))
-- (defun l4 () (interactive) (find-angg "LUA/Lazy4.lua"))
-- (defun l5 () (interactive) (find-angg "LUA/Lazy5.lua"))
--
-- (defun a  () (interactive) (find-angg "LUA/Pict2e1.lua"))
-- (defun b  () (interactive) (find-angg "LUA/Pict2e1-1.lua"))
-- (defun ab () (interactive) (find-2b '(a) '(b)))
-- (defun et () (interactive) (find-angg "LATEX/2022pict2e.tex"))
-- (defun eb () (interactive) (find-angg "LATEX/2022pict2e-body.tex"))
-- (defun ao () (interactive) (find-angg "LATEX/2022pict2e.lua"))
-- (defun pv () (interactive) (find-pdftools-page "~/LATEX/2022pict2e.pdf"))
-- (defun tb () (interactive) (find-ebuffer (eepitch-target-buffer)))
-- (defun etv () (interactive) (find-wset "13o2_o_o" '(tb) '(pv)))
-- (setenv "PICT2ELUADIR" "~/LATEX/")
--
-- (find-sh0 "cd ~/LUA/; cp -v Lazy5.lua Pict2e1.lua Verbatim1.lua ~/LATEX/")

-- «.output»		(to "output")
-- «.basic-ops»		(to "basic-ops")
-- «.subst-trig»	(to "subst-trig")
-- «.edovs»		(to "edovs")
-- «.edo-2a-ordem»	(to "edo-2a-ordem")

require "Lazy5"     -- (find-anggfile "LUA/Lazy5.lua")
var = Lazy.var
fun = Lazy.fun
ang = Lazy.ang
funs = function (bigstr) map(fun, split(bigstr)) end
vars = function (bigstr) map(var, split(bigstr)) end
namedformula = Lazy.namedformula
namedang     = Lazy.namedang
namedsubst   = Subst.named

-- «output»  (to ".output")
out = ""
if not output then
  output = function (str, verbose)
      if verbose then print(); print(str) end
      out = out.."\n"..str
      Show.preamble = out
    end
  verbose = false
end

-- «basic-ops»  (to ".basic-ops")
-- (find-angg "LUA/Lazy3.lua" "basic-ops")

funs " ddx eq mul f g fp gp und "
vars " x y t "
fun("mul",   "<1> <2>")
fun("Mul",   "<1> · <2>")
fun("und",   "\\und{<1>}{<2>}")
fun("uu",    "\\und{<1>}{}")
fun("ddx",   "\\frac{d}{dx} <1>")
fun("ddvar", "\\frac{d}{d<1>} <2>")

fun("plus",  "<1> + <2>")
fun("minus", "<1> - <2>")
fun("eq",    "<1> = <2>")
fun("exp",   "e^{<1>}")
fun("pot",   "{<1>}^{<2>}")
fun("frac",  "\\frac{<1>}{<2>}")
fun("sqrt",  "\\sqrt{<1>}")
fun("paren", "(<1>)")
fun("Paren", "\\left(<1>\\right)")

fun("sen",   "\\sen <1>")
fun("sin",   "\\sin <1>")
fun("cos",   "\\cos <1>")
fun("tan",   "\\tan <1>")
fun("ln",    "\\ln <1>")
fun("lnp",   "\\ln' <1>")
fun("mod",   "|<1>|")
fun("uminus", "-<1>")

fun("sen",   "\\sen(<1>)")
fun("sin",   "\\sin(<1>)")
fun("cos",   "\\cos(<1>)")
fun("tan",   "\\tan(<1>)")

funs"f g h F G H"
vars"a b c t u x y z w s"

fun("fp",    "f'(<1>)")
fun("gp",    "g'(<1>)")
var("th",    "\\theta ")

fun("Intx",  "\\D \\Intx{<1>}{<2>}{<3>}")
fun("Intu",  "\\D \\Intu{<1>}{<2>}{<3>}")
fun("Ints",  "\\D \\Ints{<1>}{<2>}{<3>}")
fun("Intth", "\\D \\Intth{<1>}{<2>}{<3>}")
fun("difx",      "\\difx{<1>}{<2>}{<3>}")
fun("difu",      "\\difu{<1>}{<2>}{<3>}")
fun("ddvar", "\\frac{d}{d<1>}<2>")
fun("intvar", "\\intvar{<1>}{<2>}")
fun("Intvar", "\\D \\Intvar{<1>}{<2>}{<3>}{<4>}")
fun("difvar", "\\difvar{<1>}{<2>}{<3>}{<4>}")

fun("intx",  "\\D \\intx{<1>}")
fun("intu",  "\\D \\intu{<1>}")
fun("inty",  "\\D \\inty{<1>}")
fun("ints",  "\\D \\ints{<1>}")
fun("intth", "\\D \\intth{<1>}")



--  ____        _         _     _        _       
-- / ___| _   _| |__  ___| |_  | |_ _ __(_) __ _ 
-- \___ \| | | | '_ \/ __| __| | __| '__| |/ _` |
--  ___) | |_| | |_) \__ \ |_  | |_| |  | | (_| |
-- |____/ \__,_|_.__/|___/\__|  \__|_|  |_|\__, |
--                                         |___/ 
-- «subst-trig»  (to ".subst-trig")
-- (c2m221p2p 2 "subst-trig")
-- (c2m221p2a   "subst-trig")
-- (find-pdftoolsr-page "~/LATEX/2022-1-C2-P2.pdf" 2)

namedformula("RC",  "RC",    Paren(eq( ddx(f(g(x))), Mul(fp(g(x)), gp(x)))))
namedformula("MV2", "MV _2", Paren(eq( Intvar(x, a, b, Mul(fp(g(x)), gp(x))),
                                       Intvar(u, g(a), g(b), fp(u)))))

TRIG1L = ints(mul(pot(s,4), pot(sqrt(minus(1,pot(s,2))),10)))
TRIG1R = ints(mul(mul(pot(sen(th),4),
                      pot(sqrt(minus(1,pot(paren(sen(th)),2))),10)),
                  cos(th)))
namedformula("TRIG1", "TRIG _1", Paren(eq(TRIG1L, TRIG1R)))

namedsubst("STrig0", "STrig _0", [[
  g(x)  := sen(x)
  gp(x) := cos(x)
]])
namedsubst("STrig1", "STrig _1", [[
  g(x)  := sen(x)
  gp(x) := cos(x)
  x     := th
  u     := s
]])
namedsubst("STrig2", "STrig _2", [[
  g(x)  := sen(x)
  gp(x) := cos(x)
  x     := th
  u     := s
  fp(x) := pot(sqrt(x),10)
]])
namedsubst("STrig3", "STrig _3", [[
  g(x)  := sen(x)
  gp(x) := cos(x)
  x     := th
  u     := s
  fp(x) := pot(minus(1,sqrt(x)),10)
]])
namedsubst("STrig4", "STrig _4", [[
  g(x)  := sen(x)
  gp(x) := cos(x)
  x     := th
  u     := s
  fp(s) := mul(pot(s,4),pot(sqrt(minus(1,pot(s,2))),10))
]])

namedang("TRIGSOLUTION", nil, [[
  \begin{array}{rcl}
  <TRIG1_>             &=& <TRIG1> \\
  <MV2_>               &=& <MV2> \\
  <MV2_><STrig0:bsm()> &=& <STrig0(MV2)> \\
  <MV2_><STrig1:bsm()> &=& <STrig1(MV2)> \\
  <MV2_><STrig2:bsm()> &=& <STrig2(MV2)> \\
  <MV2_><STrig3:bsm()> &=& <STrig3(MV2)> \\
  <MV2_><STrig4:bsm()> &=& <STrig4(MV2)> \\
  \end{array}
]])

--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "2022-1-C2-P2.lua"
= TRIGSOLUTION:show("0.6 d")
 (etv)

= TRIG1L:tree()
= TRIG1R:tree()
= TRIG1:tree()
= STrig4(MV2):tree()

= TRIG1:totex()
= TRIG1:show("dd")
 (etv)

--]==]


--  _____ ____   _____     ______  
-- | ____|  _ \ / _ \ \   / / ___| 
-- |  _| | | | | | | \ \ / /\___ \ 
-- | |___| |_| | |_| |\ V /  ___) |
-- |_____|____/ \___/  \_/  |____/ 
--                                 
-- «edovs»  (to ".edovs")
-- (c2m221p2p 3 "edovs")
-- (c2m221p2a   "edovs")
-- (find-angg "LUA/Lazy4.lua" "EDOVSG")
-- (find-pdftoolsr-page "~/LATEX/2022-1-C2-P2.pdf" 3)

var("C1", "C_1")
var("C2", "C_2")
var("C3", "C_3")
fun("Hinv", "H^{-1}(<1>)")

namedang("EDOVSG", "EDOVSG", [[
  \left(\begin{array}{rcl}
             \D \dydx &=& \D <frac(g(x),h(y))> \\
           <h(y)>\,dy &=& <g(x)>\,dx \\
         <inty(h(y))> &=& <intx(g(x))> \\
           \mcc{\veq} & & \mcc{\veq} \\
\mcc{<plus(H(y),C1)>} & & \mcc{<plus(G(x),C2)>} \\
          <H(y)>      &=& <plus(G(x),minus(C2,C1))> \\
                      &=& <plus(G(x),C3)> \\
         <Hinv(H(y))> &=& <Hinv(plus(G(x),C3))> \\
           \mcc{\veq} & & \\
              \mcc{y} & & \\
   \end{array}
   \right)
]])

namedang("EDOVSP", "EDOVSP", [[
  \left(\begin{array}{rcl}
             \D \dydx &=& \D <frac(g(x),h(y))> \\
         <Hinv(H(y))> &=& <Hinv(plus(G(x),C3))> \\
           \mcc{\veq} & & \\
              \mcc{y} & & \\
   \end{array}
   \right)
]])

namedsubst("SE1", "SE _1", [[
    g(x)    :=    uminus(mul(2,x))
    G(x)    :=    uminus(pot(x,2))
    h(x)    :=    mul(2,x)
    H(x)    :=    pot(x,2)
    Hinv(x) :=    uminus(sqrt(x))
    C1      :=    4
    C2      :=    29
    C3      :=    25
  ]])

namedang("EDOVSa", "EDOVSa", [[
  \begin{array}{rcl}
    <EDOVSG_>      &=& <EDOVSG>      \\ \\[-5pt]
    <EDOVSG_><SE1> &=& <SE1(EDOVSG)> \\
  \end{array}
]])

--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "2022-1-C2-P2.lua"

= EDOVSa:show("0.5 d")
 (etv)

-- <SE1_> &=& <SE1:bsm()> \\


= EDOVSG
= EDOVSG:tree()
= EDOVSG:totex()
= SE1
= SE1:bmat()
= SE1:totex()
= SE1(EDOVSP):totex()
= ang("_", "<EDOVSG_> = <EDOVSG>"):totex()
= ang("_", "<EDOVSG_> = <EDOVSG>"):show("0.8 d")
= ang("_", "<EDOVSP_> = <EDOVSP>"):show("0.8 d")
= ang("_", "<SE1_> = <SE1>"):show("0.8 d")
= ang("_", "<SE1_> = <SE1:bsm()>"):show("0.8 d")
 (etv)

--]==]



--  _____ ____   ___    ____                       _                
-- | ____|  _ \ / _ \  |___ \ __ _    ___  _ __ __| | ___ _ __ ___  
-- |  _| | | | | | | |   __) / _` |  / _ \| '__/ _` |/ _ \ '_ ` _ \ 
-- | |___| |_| | |_| |  / __/ (_| | | (_) | | | (_| |  __/ | | | | |
-- |_____|____/ \___/  |_____\__,_|  \___/|_|  \__,_|\___|_| |_| |_|
--                                                                  
-- «edo-2a-ordem»  (to ".edo-2a-ordem")
-- (c2m221p2p 3 "edo-2a-ordem")
-- (c2m221p2a   "edo-2a-ordem")
-- (c2m221p2p 10 "edo-2a-ordem-gab")
-- (c2m221p2a    "edo-2a-ordem-gab")

vars("j k")
var("a2",  "a_2")
var("a5",  "a_5")
var("a7",  "a_7")
var("a10", "a_{10}")
var("aa",  "α")
var("bb",  "β")
var("gg",  "γ")
var("dd",  "δ")
var("ii",  "i")

namedang("EDOLP0", "EDOLP _0", [[
  \left(
  \begin{array}{rcl}
     f''(x) +   <a7> f'(x) + <a10> f(x)    &=& 0 \\
    (D^2 +       <a7> D +      <a10>) f &=& 0 \\
    (D^2 + (<a2>+<a5>)D + (<a2>·<a5>))f &=& 0 \\
    (D^2 + <a7>D + <a10>)(<gg>e^{-<a2>x} + <dd>e^{-<a5>x}) &=& 0 \\
  \end{array}
  \right)
]])

namedang("EDOLP1", "EDOLP _1", [[
  \left(
  \begin{array}{rcl}
     f''(x) +    <a7> f'(x) +  <a10> f(x) &=& 0 \\
    (D^2 +       <a7> D +      <a10>) f &=& 0 \\
    (D^2 +       <a7> D +      <a10>) f &=& 0 \\
    (D^2 + <a7>D + <a10>)(<gg>e^{-<a2>x} + <dd>e^{-<a5>x}) &=& 0 \\
  \end{array}
  \right)
]])

namedsubst("SL0", "S _0", [[
    a2      :=    2
    a5      :=    5
    a7      :=    7
    a10     :=    10
  ]])
namedformula("EDOLP",  "EDOLP",    SL0(EDOLP0))

namedsubst("SL1", "SL _1", [[
    a2      :=    aa
    a5      :=    bb
    a7      :=    7
    a10     :=    10
  ]])
namedsubst("S1", "S _1", [[
    aa      :=    2
    bb      :=    5
  ]])
namedformula("EDOLG1", "EDOLG _1", SL1(EDOLP0))

namedsubst("SL2", "SL _2", [[
    a2      :=    aa
    a5      :=    bb
    a7      :=    j
    a10     :=    k
  ]])
namedsubst("S2", "S _2", [[
    aa      :=    2
    bb      :=    5
    j       :=    7
    k       :=   10
  ]])
namedformula("EDOLG2", "EDOLG _2", SL2(EDOLP0))

namedsubst("S3", "S _3", [[
    j       :=  paren(plus(aa,bb))
    k       :=  paren(Mul(aa,bb))
  ]])

namedformula("EDOLG3", "EDOLG _3", S3(EDOLG2))
namedformula("EDOLG", "EDOLG", S3(EDOLG2))

namedang("EDO2aordem_EDOLG", nil, [[
  \begin{array}{rcll}
    <EDOLP_>       &=& <EDOLP>                                  \\ \\[-5pt]
    <EDOLG1_>      &=& <EDOLG1> & <S1_>=<S1>                    \\ \\[-5pt]
    <EDOLG2_>      &=& <EDOLG2> & <S2_>=<S2> \qquad <S3_>=<S3>  \\ \\[-5pt]
    <EDOLG2_><S3_> &=& <S3(EDOLG2)> & <EDOLG_> = <EDOLG2_><S3_> \\ \\[-5pt]
    <EDOLG_>       &=& <EDOLG>                                  \\ \\[-5pt]
    <EDOLG_><S1>   &=& <S1(EDOLG)>, & \text{que é ``muito parecido'' com o } <EDOLP_>... \\
  \end{array}
]])

namedsubst("SVSA1", "SE _1", [[
    aa := paren( plus(-2,mul(10,ii)))
    bb := paren(minus(-2,mul(10,ii)))
  ]])
namedformula("EVSA1", "E _1", SVSA1(EDOLG))

namedang("EDOLPVSA1", "EDOLP _1", [[
  \left(
  \begin{array}{rcl}
     f''(x) +    <a7> f'(x) +  <a10> f(x) &=& 0 \\
    (D^2 +       <a7> D +      <a10>) f &=& 0 \\
    (D^2 +       <a7> D +      <a10>) f &=& 0 \\
    (D^2 + <a7>D + <a10>)(<gg>e^{-<a2>x} + <dd>e^{-<a5>x}) &=& 0 \\
  \end{array}
  \right)
]])
namedsubst("SVSA2", "SE _2", [[
    a2 := paren( plus(-2,mul(10,ii)))
    a5 := paren(minus(-2,mul(10,ii)))
    a7 := paren(-4)
   a10 :=      104
  ]])
namedformula("EVSA2", "E _2", SVSA2(EDOLPVSA1))



--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "2022-1-C2-P2.lua"

= ang("_", [[
  \begin{array}{rcll}
    <EDOLP_>       &=& <EDOLP> \\
    <EDOLG1_>      &=& <EDOLG1> & <S1_>=<S1> \\
    <EDOLG2_>      &=& <EDOLG2> & <S2_>=<S2> \qquad <S3_>=<S3> \\
    <EDOLG2_><S3_> &=& <S3(EDOLG2)> & <EDOLG_> = <EDOLG2_><S3_> \\
    <EDOLG_>       &=& <EDOLG> \\
    <EDOLG_><S1>   &=& <S1(EDOLG)>, & \text{que é ``muito parecido'' com o } <EDOLP_>... \\
  \end{array}
]]):show("0.5 d")
 (etv)

= ang("_", [[
  \begin{array}{rcll}
    <EDOLG_> &=& <EDOLG> \\
  \end{array}
]]):show("0.5 d")
 (etv)

= ang("_", [[
  \begin{array}{rcll}
    <SVSA1_> &=& <SVSA1> \\
    <EDOLG_><SVSA1_> &=& <SVSA1(EDOLG)> \\
    <EDOLG_><SVSA1>  &=& <EVSA1> \\
    <EVSA1_>
  \end{array}
]]):show("0.6 d")
 (etv)

 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "2022-1-C2-P2.lua"

= ang("_", [[
  \begin{array}{l}
    <EDOLG_> = <EDOLG> \\ \\[-5pt]
    <EVSA1_> = <EDOLG_><SVSA1> = \\ \\[-5pt]
    = <EVSA1> \\ \\[-5pt]
    = <EVSA2> \\
  \end{array}
]]):show("0.6 d")
 (etv)




--]==]






-- Local Variables:
-- coding:  utf-8-unix
-- End:
