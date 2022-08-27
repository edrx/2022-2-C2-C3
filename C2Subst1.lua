-- This file:
--   http://angg.twu.net/LUA/C2Subst1.lua.html
--   http://angg.twu.net/LUA/C2Subst1.lua
--           (find-angg "LUA/C2Subst1.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- My substition operator [:=] of Calculus 2.
--
-- (defun o  () (interactive) (find-angg "LUA/UbExpr1.lua"))
-- (defun l  () (interactive) (find-angg "LUA/UbExpr2.lua"))
-- (defun r  () (interactive) (find-angg "LUA/RAng1.lua"))
-- (defun rf () (interactive) (find-angg "LUA/RAngFormulas1.lua"))
-- (defun s  () (interactive) (find-angg "LUA/C2Subst1.lua"))
-- (defun cf () (interactive) (find-angg "LUA/C2Formulas1.lua"))

-- «.LExpr»		(to "LExpr")
-- «.LExpr-tests»	(to "LExpr-tests")
-- «.basic-ops»		(to "basic-ops")
-- «.basic-ops-test»	(to "basic-ops-test")
-- «.define_MV1»	(to "define_MV1")
-- «.define_MV1-tests»	(to "define_MV1-tests")
-- «.GaExpr»		(to "GaExpr")
-- «.GaExpr-tests»	(to "GaExpr-tests")
-- «.GaExpr-DFIminus»	(to "GaExpr-DFIminus")
-- «.substislazy»	(to "substislazy")
-- «.Subst»		(to "Subst")
-- «.Subst-S0»		(to "Subst-S0")
-- «.Subst-tests»	(to "Subst-tests")
-- «.Subst-test-apply»	(to "Subst-test-apply")
-- «.SubstLine»		(to "SubstLine")
-- «.SubstLine-tests»	(to "SubstLine-tests")

require "Pict2e1"     -- (find-angg "LUA/Pict2e1.lua")


-- «LExpr»  (to ".LExpr")
-- LaTeXable expressions, with a hack to allow underbraces.

LExpr = Class {
  type  = "LExpr",
  from  = function (fmt, ...) return LExpr {fmt=fmt, ...} end,
  __tostring = function (le) return le:tostring() end,
  __index = {
    getfield0 = function (le, s, ev)
        if s:match("%d") then return le[tonumber(s)] end
        return ev(s)
      end,
    getfield = function (le, s, ev)
        local result0 = le:getfield0(s, ev)
        if not result0 then error("Field '"..s.."' returned nil") end
        return tostring(result0)
      end,
    tostring0 = function (le, ev)
        local f = function (s) return le:getfield(s, ev) end
        return (le.fmt:gsub("<(.-)>", f))
      end,
    setu = function (le, u)
        le.u = u
        return le
      end,
    tostring = function (le, ev)
        if le.u then
          local over, under = le:tostring0(ev), tostring(le.u)
          return format("\\und{%s}{%s}", over, under)
        end
        return le:tostring0()
      end,
    struct = function (le) return mytostringp(le) end,
    topict = function (le, ev) return PictList({le:tostring(ev)}) end,
    sa     = function (le, name) return le:topict():sa(name) end,
    --
  },
}

-- «LExpr-tests»  (to ".LExpr-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Subst1.lua"
foo = function (a, b) return LExpr.from("foo[<1>, <2>]", a, b) end
= foo(20, 30)
= foo(20, 30):setu("bla")
= foo(20, 30):setu(foo(40, 50))
= foo(20, 30):setu(foo(40, 50)):struct()

--]]


-- «basic-ops»  (to ".basic-ops")

app   = function (f, x) return LExpr.from("<1>(<2>)",  f, x) end
mul   = function (a, b) return LExpr.from("<1> <2>",   a, b) end
Mul   = function (a, b) return LExpr.from("<1> · <2>", a, b) end
plus  = function (a, b) return LExpr.from("<1> + <2>", a, b) end
minus = function (a, b) return LExpr.from("<1> - <2>", a, b) end
eq    = function (a, b) return LExpr.from("<1> = <2>", a, b) end
exp   = function (a)    return LExpr.from("e^{<1>}",   a)    end
pot   = function (a, b) return LExpr.from("{<1>}^{<2>}",a,b) end
frac  = function (a, b) return LExpr.from("\\frac{<1>}{<2>}",a,b) end
sqrt  = function (a)    return LExpr.from("\\sqrt{<1>}", a)  end
paren = function (a)    return LExpr.from("(<1>)",     a)    end
Paren = function (a)    return LExpr.from("\\left(<1>\\right)", a) end
sen   = function (x)    return app("\\sen",  x) end
sin   = function (x)    return app("\\sin",  x) end
cos   = function (x)    return app("\\cos",  x) end
tan   = function (x)    return app("\\tan",  x) end
ln    = function (x)    return app("\\ln",   x) end
lnp   = function (x)    return app("\\ln'",  x) end
Intx  = function (a, b, body) return LExpr.from("\\D \\Intx{<1>}{<2>}{<3>}", a, b, body) end
Intu  = function (a, b, body) return LExpr.from("\\D \\Intu{<1>}{<2>}{<3>}", a, b, body) end
difx  = function (a, b, body) return LExpr.from(    "\\difx{<1>}{<2>}{<3>}", a, b, body) end
difu  = function (a, b, body) return LExpr.from(    "\\difu{<1>}{<2>}{<3>}", a, b, body) end
ddvar = function (x, f) return LExpr.from("\\frac{d}{d<1>}<2>", x, f) end

intvar = function (x, body)
    return LExpr.from("\\intvar{<1>}{<2>}", x, body)
  end
Intvar = function (x, a, b, body)
    return LExpr.from("\\D \\Intvar{<1>}{<2>}{<3>}{<4>}", x, a, b, body)
  end
difvar = function (x, a, b, body)
    return LExpr.from(    "\\difvar{<1>}{<2>}{<3>}{<4>}", x, a, b, body)
  end

substline = function (l, r) return LExpr.from(" <1> := <2> ", l, r) end

fp    = function (a) return app("f'", a) end
f     = function (a) return app("f",  a) end
gp    = function (a) return app("g'", a) end
g     = function (a) return app("g",  a) end
expr1 = "\\Expr"
x0    = "x_0"


-- «basic-ops-test»  (to ".basic-ops-test")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Subst1.lua"
x0 = "x_0"
fp = function (a) return app("f'", a) end
= fp(x0)
= fp(x0):struct()

--]]





-- «define_MV1»  (to ".define_MV1")
define_MV1 = function ()
    f     = function (x) return app("f",  x) end
    fp    = function (x) return app("f'", x) end
    g     = function (x) return app("g",  x) end
    gp    = function (x) return app("g'", x) end
    lnp   = function (x) return app("\\ln'", x) end
    a,b,x,u  = "a", "b", "x", "u"
    y,s,c,th = "y", "s", "c", "\\theta "
    x0,x1    = "x_0", "x_1"
    --
    eq5  = function (a, b, c, d, e)
        return LExpr.from([[
          \begin{array}{rcl}
            <1> &=& <2> \\
                &=& <3> \\
                &=& <4> \\
                &=& <5> \\
          \end{array} ]], a, b, c, d, e)
      end
    --
    -- From: (c2m221atisp 8 "formulas-mv-2022.1")
    --       (c2m221atisa   "formulas-mv-2022.1")
    MV1 = eq5(Intx  (a, b, mul(fp(g(x)), gp(x))),
              difx  (a, b, f(g(x))),
              minus (f(g(b)), f(g(a))),
              difu  (g(a), g(b), f(u)),
              Intx  (g(a), g(b), fp(u)))
  end

-- «define_MV1-tests»  (to ".define_MV1-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Subst1.lua"
define_MV1()
= MV1
= eq5(2, 3, 4, 5, 6, 7)

--]]




-- «GaExpr»  (to ".GaExpr")
--
-- GaExprs are similar to LExprs, but the contents of the fields are
-- retrieved with \ga{...}s.
--
GaExpr = Class {
  type = "GaExpr",
  from = function (src) return GaExpr {src=src, fmt=rtrim(src)} end,
  __tostring = function (gae) return gae.fmt end,
  __index = {
    lexpr = function (gae) return LExpr.from(fmt) end,
    set = function (gae)
        local sl = Set.new()
        for s in gae.fmt:gmatch("<(.-)>") do sl:add(s) end
        return sl
      end,
    gaify = function (gae)
        local f = function (s) return '\\ga{'..s..'}' end
        return (gae.fmt:gsub("<(.-)>", f))
      end,
    sas = function (gae, f)
        local out = ""
        local g = function (s)
            return format("  \\sa {%s} {%s}\n", s, tostring(f(s)))
          end
        for k,v in gae:set():gen() do out = out..g(k) end
        return out
      end,
    sagaify = function (gae, S_or_nil)
        local f = function (s) return (S_or_nil or id)(expr(s)) end
        return gae:sas(f)
            .. "  %\n"
            .. gae:gaify()
      end,
    struct = function (gae) return mytostringp(gae) end,
    tostring = function (gae, S_or_nil) return gae:sagaify(S_or_nil) end,
    tolexpr = function (gae, S_or_nil)
        return LExpr.from(gae:tostring(S_or_nil))
      end,
    topict = function (gae, S_or_nil)
        return PictList { gae:tostring(S_or_nil) }
      end,
  },
}

-- «GaExpr-DFIminus»  (to ".GaExpr-DFIminus")
DFIminus = GaExpr.from [[
  \begin{array}{lrcl}
    \text{Se:}    & <f(g(x))> &\eqnp{1}& x \\
    \text{Então:} & <gp(x)>   &\eqnp{6}& \D \frac{1}{<fp(g(x))>} \\
  \end{array}}
]]

-- «GaExpr-tests»  (to ".GaExpr-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Subst1.lua"
define_MV1()
= MV1
= MV1:struct()
= DFIminus
= DFIminus:struct()
= DFIminus:set()
= DFIminus:set():ksc()
= DFIminus:sas(id)
= DFIminus:tostring()
= f(g(x))

--]==]




-- «substislazy»  (to ".substislazy")
substislazy = nil
substislazy = true

-- «Subst»  (to ".Subst")
Subst = Class {
  type  = "Subst",
  from  = function (name, texname, bigstr)
      local grid = {}
      for _,li in ipairs(splitlines(bigstr)) do
        local left,right = li:match("^%s*(%S+)%s*:=%s*(.-)%s*$")
        if left then table.insert(grid, {left,right}) end
      end
      return Subst {name=name, texname=texname, bigstr=bigstr, grid=grid}
    end,
  __call = function (su, o)
      if substislazy then return LExpr.from("(<1>)<2>", o, su.texname) end
      if otype(o) == "GaExpr" then return o:tolexpr(su) end      
      return su:apply(o)
    end,
  __tostring = function (su) return rtrim(su.bigstr) end,
  __index = {
    itemtotex = function (su, item)
        return expr(item)
      end,
    linetex = function (su, i)
        return substline(expr(su.grid[i][1]), expr(su.grid[i][2])):tostring()
      end,
    bodytex = function (su)
        local body = ""
        for i=1,#su.grid do body = body..su:linetex(i).."\\\\\n" end
        return body
      end,
    --
    left      = function (su, i) return expr(su.grid[i][1]) end,
    leftlazy  = function (su, i) return expr(su.name)(su:left(i)) end,
    right     = function (su, i) return expr(su.grid[i][2]) end,
    linesubst = function (su, i) return substline(su:left(i), su:right(i)) end,
    linelazy  = function (su, i) return eq(su:leftlazy(i), su:right(i)) end,
    substs    = function (su)
        local body = ""
        for i=1,#su.grid do body = body..tostring(su:linesubst(i)).."\\\\\n" end
        return body
      end,
    lazys     = function (su)
        local body = ""
        for i=1,#su.grid do body = body..tostring(su:linelazy(i)).."\\\\\n" end
        return body
      end,
    --
    -- bmat0 = function (su) return "\\bmat{\n" .. su:bodytex() .. "}" end,
    -- bsm0  = function (su) return "\\bsm{\n"  .. su:bodytex() .. "}" end,
    bmat0     = function (su) return "\\bmat{\n" .. su:substs() .. "}" end,
    bsm0      = function (su) return "\\bsm{\n"  .. su:substs() .. "}" end,
    bmatlazy0 = function (su) return "\\bmat{\n" .. su:lazys() .. "}" end,
    bsmlazy0  = function (su) return "\\bsm{\n"  .. su:lazys() .. "}" end,
    bmat      = function (su) return LExpr.from(su:bmat0()) end,
    bsm       = function (su) return LExpr.from(su:bsm0()) end,
    bmatlazy  = function (su) return LExpr.from(su:bmatlazy0()) end,
    bsmlazy   = function (su) return LExpr.from(su:bsmlazy0()) end,
    -- New:
    bmatsa     = function (su) return su:bmat():sa(su.name) end,
    bmatlazysa = function (su)
        substislazy = true
        return su:bmatlazy():sa(su.name.." lazy")
      end,
    bmatsas    = function (su)
        return PictList { su:bmatsa(), su:bmatlazysa() }
      end,
    defs3 = function (su)
        substislazy = true
        return PictList {
          PictList { format("\\sa{[%s]}{%s}", su.name, su.texname) },
          su:bmatsa(),
          su:bmatlazysa()
        }
      end,
    --
    tostring = function (su) return su:bmat() end,
    struct = function (le) return mytostringp(le) end,
    --
    matchany = function (su, o)
        return SubstLine.matchany(su.grid, o)
      end,
    mapsubst = function (su, o)
        o = shallowcopy(o)
        local S = expr(su.name)
        for i=1,#o do o[i] = S:apply(o[i]) end
        return o
      end,
    applyimplicitrules = function (su, o)
        if type(o) == "string" then return o end
        if type(o) == "number" then return o end
        if otype(o) == "LExpr" then return su:mapsubst(o) end
        PPPV(o)
        error("Can't :applyimplicitrules(o)")
      end,
    apply = function (su, o)
        local i,result = su:matchany(o)
        if i then return result end
        return su:applyimplicitrules(o)
      end,
  },
}

-- «Subst-S0»  (to ".Subst-S0")
S0 = Subst.from("S0", "[S0]", [[
      f(expr1) := exp(S0(expr1))
     fp(expr1) := exp(S0(expr1))
      g(expr1) := ln (S0(expr1))
     gp(expr1) := lnp(S0(expr1))
  ]])

-- «Subst-tests»  (to ".Subst-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Subst1.lua"
= substline(fp(20),    30)
= substline(fp(expr1), x0)

substislazy = true

= S0.grid[2][1]
= S0:linetex(2)
= S0:bodytex()
= S0:bmat()
= S0:bmatlazy()
= S0:bsm()
= S0:bsmlazy()
= S0:bmatsas()
= S0:defs3()
= S0.bigstr

substislazy = true
= S0(fp(x0))
substislazy = falsa
= S0(fp(x0))

--]==]


-- «Subst-test-apply»  (to ".Subst-test-apply")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Subst1.lua"
dofile "Pict2e1.lua"
define_MV1()
substislazy = nil
= S0
= S0:struct()
=    f(g(22))
=    f(g(22)):struct()
= S0(f(g(22)))
= S0(f(g(22))):struct()
=    MV1
=    MV1:struct()
= S0(MV1)
= S0(MV1):struct()
=    DFIminus
=    DFIminus:struct()
= S0(DFIminus)
= S0(DFIminus):struct()
= S0(DFIminus):sa("foo")

substislazy = true
= S0(f(g(22)))

--]==]



-- «SubstLine»  (to ".SubstLine")
SubstLine = Class {
  type = "SubstLine",
  from = function (l0, r0, o1)
      return SubstLine {l0=l0, r0=r0, o1=o1}
    end,
  matchany = function (grid, o)
      for i=1,#grid do
        local sl = SubstLine.from(grid[i][1], grid[i][2], o)
        local ok,result = sl:matches()
        if ok then return i,result end  
      end
    end,
  __tostring = mytostringp,
  __index = {
    sampleapp      =       app("f", "_"),
    sampleappotype = otype(app("f", "_")),
    sampleappfmt   =       app("f", "_").fmt,
    isvar = function (sl, o) return type(o) == "string" end,
    isapp = function (sl, o)
        return otype(o) == sl.sampleappotype
           and o.fmt    == sl.sampleappfmt
      end,
    vartexname = function (sl, o) return o end,
    apptexname = function (sl, o) return o[1] end,
    apparg     = function (sl, o) return o[2] end,
    matchesvar = function (sl)
        if sl.l0:match("%(") then return false end
        sl.l1  = expr(sl.l0)
        if not sl:isvar(sl.l1) then error("Not a var: "..sl.l0) end
        if not sl:isvar(sl.o1) then return false end
        return sl:vartexname(sl.l1) == sl:vartexname(sl.o1)
      end,
    matchesapp = function (sl)
        if not sl.l0:match("%(") then return false end
        sl.l1  = expr(sl.l0)
        if not sl:isapp(sl.l1) then error("Not an app: "..sl.l0) end
        if not sl:isapp(sl.o1) then return false end
        return sl:apptexname(sl.l1) == sl:apptexname(sl.o1)
      end,
    appcode = function (sl)
        return "local expr1=...; return function (expr1) return "..sl.r0.." end"
      end,
    matches = function (sl)
        if sl:matchesvar() then return true,expr(sl.r0) end
        if sl:matchesapp() then return true,eval(sl:appcode())(sl:apparg(sl.o1)) end
        return false
      end,
  },
}


-- «SubstLine-tests»  (to ".SubstLine-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "C2Subst1.lua"
= S0:bmat()

--]]



-- Local Variables:
-- coding:  utf-8-unix
-- indent-tabs-mode: nil
-- End:
