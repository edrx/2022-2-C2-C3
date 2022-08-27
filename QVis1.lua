-- This file:
--   http://angg.twu.net/LUA/QVis1.lua.html
--   http://angg.twu.net/LUA/QVis1.lua
--           (find-angg "LUA/QVis1.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- Visualize quantifications, like this,
--   ∀x∈[2,4). x^2≤10
-- and some set comprehensions.
-- See: (c2m221isp 2 "uma-figura")
--      (c2m221isa   "uma-figura")
--      (c2m221isp 5 "exercicio-1")
--      (c2m221isa   "exercicio-1")

-- (defun a  () (interactive) (find-angg "LUA/Pict2e1.lua"))
-- (defun b  () (interactive) (find-angg "LUA/Piecewise1.lua"))
-- (defun q  () (interactive) (find-angg "LUA/QVis1.lua"))
-- (defun ab () (interactive) (find-2b '(a) '(b)))
-- (defun aq () (interactive) (find-2b '(a) '(q)))
-- (defun et () (interactive) (find-angg "LATEX/2022pict2e.tex"))
-- (defun eb () (interactive) (find-angg "LATEX/2022pict2e-body.tex"))
-- (defun ao () (interactive) (find-angg "LATEX/2022pict2e.lua"))
-- (defun v  () (interactive) (find-pdftools-page "~/LATEX/2022pict2e.pdf"))
-- (defun tb () (interactive) (find-ebuffer (eepitch-target-buffer)))
-- (defun etv () (interactive) (find-wset "13o2_o_o" '(tb) '(v)))
-- (setenv "PICT2ELUADIR" "~/LATEX/")

require "Pict2e1"      -- (find-angg "LUA/Pict2e1.lua")
require "Piecewise1"   -- (find-angg "LUA/Piecewise1.lua")

PlotDots = Class {
  type    = "PlotDots",
  new     = function (p) return PlotDots { p=(p or PictList {})} end,
  __index = {
    topict = function (pd) return PictList(copy(pd)) end,
    plot  = function (pd, xy, color, open)
        local str = open and "\\opendot" or "\\closeddot"
        if color then str = "\\Color"..color.."{"..str.."}" end
        str = pformat("\\put%s{%s}", xy, str)
        table.insert(pd, str)
        return pd
      end,
    dims = function (pd, cl, op)
        local fmt1 = [[\def\closeddot{\circle*{%s}}]]
        local fmt2 = [[\def\opendot  {\circle*{%s}\color{white}\circle*{%s}}]]
        local str1 = pformat(fmt1, cl)
        local str2 = pformat(fmt2, cl, op)
        table.insert(pd, 1, str2)
        table.insert(pd, 1, str1)
        return pd
      end,
  },
}


-- (find-angg "LUA/Pict2e1.lua" "Pict2e-methods")
-- (find-angg "LUA/Pict2e1.lua" "Pict2e-methods" ".Color =")
-- PradClass.__index.addcloseddotat = function (pis, xy)
--     return pis:addputstrat(xy, "\\closeddot")
--   end





--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "QVis1.lua"

Pict2e.bounds = PictBounds.new(v(0,0), v(11,7))
ex1spec   = "(0,3)--(3,6)--(8,1)--(11,4)"
ex1pws    = PwSpec.from(ex1spec)
ex1f      = ex1pws:fun()
ex1curve  = ex1pws:topict()
pd        = PlotDots.new():dims(0.7, 0.4)
pd:plot(v(7, 0),   "Red")
pd:plot(v(8, 0),   "Red")
pd:plot(v(9, 0),   "Red")
pd:plot(v(7, 2),   "Orange", "open")
pd:plot(v(8, 1),   "Orange")
pd:plot(v(9, 2),   "Orange", "open")
pd:plot(v(0, 1.5), "Violet", "open")
ex1p      = PictList { ex1curve:prethickness("2pt"), pd:topict() }
ex1pdef0  = ex1p:pgat("pgatc"):preunitlength("10pt"):sa("P(1.5)")
all = PictList {
  ex1pdef0,
  [[ $$\ga{P(1.5)}$$ ]]
}
= all

= Show.try(all:tostringp())
 (etv)


--]==]





-- Local Variables:
-- coding:  utf-8-unix
-- End:

