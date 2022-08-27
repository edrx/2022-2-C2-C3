-- This file:
--   http://angg.twu.net/LUA/C2Formulas1.lua.html
--   http://angg.twu.net/LUA/C2Formulas1.lua
--           (find-angg "LUA/C2Formulas1.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- (defun s  () (interactive) (find-angg "LUA/C2Subst1.lua"))
-- (defun cf () (interactive) (find-angg "LUA/C2Formulas1.lua"))
--
-- (defun a  () (interactive) (find-angg "LUA/Pict2e1.lua"))
-- (defun b  () (interactive) (find-angg "LUA/Pict2e1-1.lua"))
-- (defun ab () (interactive) (find-2b '(a) '(b)))
-- (defun et () (interactive) (find-angg "LATEX/2022pict2e.tex"))
-- (defun eb () (interactive) (find-angg "LATEX/2022pict2e-body.tex"))
-- (defun ao () (interactive) (find-angg "LATEX/2022pict2e.lua"))
-- (defun v  () (interactive) (find-pdftools-page "~/LATEX/2022pict2e.pdf"))
-- (defun tb () (interactive) (find-ebuffer (eepitch-target-buffer)))
-- (defun etv () (interactive) (find-wset "13o2_o_o" '(tb) '(v)))
-- (setenv "PICT2ELUADIR" "~/LATEX/")
--
-- This is a translation to Lua of:
--   (c2m221prp 4 "C2Formulas1-test")
--   (c2m221pra   "C2Formulas1-test")
--   (c2m221pda   "C2Formulas1-test")
-- A test:
--   (c2m221dp1p 2 "C2Formulas1")
--   (c2m221dp1a   "C2Formulas1")

-- «.RC»		(to "RC")
-- «.RC-test-und»	(to "RC-test-und")
-- «.TFC2»		(to "TFC2")
-- «.DFI»		(to "DFI")
-- «.MVs»		(to "MVs")
--   «.MV2»		(to "MV2")
-- «.MT2-20192»		(to "MT2-20192")


require "Pict2e1"     -- (find-angg "LUA/Pict2e1.lua")
require "C2Subst1"    -- (find-angg "LUA/C2Subst1.lua")
define_MV1()          -- (find-angg "LUA/C2Subst1.lua" "define_MV1")

-- (find-angg "LUA/C2Subst1.lua" "GaExpr-DFIminus")

-- «RC»  (to ".RC")
RC = eq(ddvar(x,f(g(x))), Mul(fp(g(x)),gp(x)))

--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Formulas1.lua"
= RC
= RCu

substislazy = nil
S1 = Subst.from("S1", "[S1]", [[
      f(expr1) := sin(S1(expr1))
     fp(expr1) := cos(S1(expr1))
      g(expr1) := Mul(S1(42),S1(expr1))
     gp(expr1) := 42
  ]])
= RC
= S1(RC)

--]]


-- «RC-test-und»  (to ".RC-test-und")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Formulas1.lua"
und = function (over, under) return LExpr.from("\\und{<1>}{<2>}", over, under) end

substislazy = nil
S1 = Subst.from("S1", "[S1]", [[
      f(expr1) := sin(S1(expr1))
     fp(expr1) := cos(S1(expr1))
      g(expr1) := Mul(S1(42),S1(expr1))
     gp(expr1) := 42
  ]])

u = function (over, under)
    PP(over, under)
    print(und(over, under))
    return und(over, under)
  end
S      = function (a) return mul(2, a) end
S      = S1
_x     = u(x,      S(x))
_gx    = u(g(_x),  S(g(x)))
_fgx   = u(f(_gx), S(f(g(x))))
_gpx   = u(gp(_x),  S(gp(x)))
_fpgx  = u(fp(_gx), S(fp(g(x))))
_right = u(Mul(_fpgx,_gpx), S(mul(fp(g(x)),gp(x))))
_left  = u(ddvar(_x, _fgx), S(ddvar(x,f(g(x)))))
_RC    = u(eq(_left, _right), S(eq(ddvar(x,f(g(x))), mul(fp(g(x)),gp(x)))))

= _RC
o = _RC:topict():dd()
= Show.try(o:tostring())
= Show.log
 (etv)

--]==]



-- «TFC2»  (to ".TFC2")
-- (c2m221ftp 2 "TFC2")
-- (c2m221fta   "TFC2")
-- (c2m221fda   "TFC2")
-- (find-angg "LUA/C2Formulas1.lua" "TFC2")
--
TFC2 = GaExpr.from [[
  \D \Intvar{<x>}{<a>}{<b>}{<Fp(x)>} \; = \; \difvar{<x>}{<a>}{<b>}{<F(x)>}
]]


-- «DFI»  (to ".DFI")
-- (c2m221ftp 3 "DFI")
-- (c2m221fta   "DFI")
-- (c2m221fda   "DFI")
--
DFIminus = GaExpr.from [[
  \begin{array}{lrcl}
    \text{Se:}    & <f(g(x))> &\eqnp{1}& x \\
    \text{Então:} & <gp(x)>   &\eqnp{6}& \D \frac{1}{<fp(g(x))>} \\
  \end{array}}
]]

-- (find-LATEX "2022-1-C2-formulas-defs.tex" "MV-bases" "MV3")

-- «MVs»  (to ".MVs")
-- (c2m221ftp 5 "MVs")
-- (c2m221fta   "MVs")
-- (c2m221fda   "MVs")
-- (find-angg "LUA/C2Formulas1.lua" "MVs")

-- «MV2»  (to ".MV2")
MV2 = eq( Intvar(x, a, b, Mul(fp(g(x)), gp(x))),
          Intvar(u, g(a), g(b), fp(u))
        )

--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Formulas1.lua"
substislazy = true
= MV2
S1 = Subst.from("S1", "\\ga{[S1]}", [[
     fp(expr1) := tan(S1(expr1))
      g(expr1) := Mul(S1(2),S1(expr1))
     gp(expr1) := S1(2)
             a := 3
             b := 4
  ]])
= S1
= S1:bmat()
= S1:bmat():sa("S1")
= S1:bmatlazy()
= S1:bmatlazy():sa("S1 lazy")
substislazy = nil
= S1(MV2)

--]==]


MV3 = GaExpr.from [[
    \sa{MV hip} {<Fp(u)> = <f(u)>}
    \sa{MV ne}  {<Intvar(x, a, b, Mul(f(g(x)), gp(x)))>}
    \sa{MV nw}  {<difvar(x, a, b, F(g(x)))>}
    \sa{MV sw}  {<difvar(u, g(a), g(b), F(u))>}
    \sa{MV se}  {<Intvar(u, g(a), g(b), f(u))>}
    \ga{MV base}
]]

F  = function (a) return app("F",  a) end
Fp = function (a) return app("F'", a) end

--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Formulas1.lua"
substislazy = nil
S3 = Subst.from("S3", "[S3]", [[
      F(expr1) := sin(S3(expr1))
     Fp(expr1) := exp(S3(expr1))
      g(expr1) := ln (S3(expr1))
     gp(expr1) := lnp(S3(expr1))
  ]])
= MV3
= S3(MV3)

--]==]



-- «MT2-20192»  (to ".MT2-20192")
-- (c2m192p1p 4 "gabarito-maxima")
-- (c2m192p1a   "gabarito-maxima")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Formulas1.lua"
-- (2*x + 3) * sqrt(4*x + 5)
=           mul(paren(plus(Mul(2,x),3)), sqrt(plus(mul(4,x),5)))
= intvar(x, mul(paren(plus(Mul(2,x),3)), sqrt(plus(mul(4,x),5))))

MT2_1 = intvar(x, mul(paren(plus(Mul(2,x),3)), sqrt(plus(mul(4,x),5))))

o = MT2_1:topict():dd()
= Show.try(o:tostring())
= Show.log
 (etv)


--]]




-- Local Variables:
-- coding:  utf-8-unix
-- indent-tabs-mode: nil
-- End:
