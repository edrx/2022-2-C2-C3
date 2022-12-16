-- This file:
--   http://angg.twu.net/LUA/Lazy5.lua.html
--   http://angg.twu.net/LUA/Lazy5.lua
--           (find-angg "LUA/Lazy5.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
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
-- (defun l2 () (interactive) (find-angg "LUA/Lazy2.lua"))
-- (defun l3 () (interactive) (find-angg "LUA/Lazy3.lua"))
-- (defun l4 () (interactive) (find-angg "LUA/Lazy4.lua"))
-- (defun l5 () (interactive) (find-angg "LUA/Lazy5.lua"))

-- «.trimcode»				(to "trimcode")
-- «.string.show»			(to "string.show")
-- «.string.show-tests»			(to "string.show-tests")
-- «.TName»				(to "TName")
--  «.TName-tests»			(to "TName-tests")
-- «.Lazy»				(to "Lazy")
--  «.Lazy-named»			(to "Lazy-named")
--  «.Lazy-getfield»			(to "Lazy-getfield")
--  «.Lazy-totex»			(to "Lazy-totex")
--  «.Lazy-processfmt0»			(to "Lazy-processfmt0")
--  «.Lazy-show»			(to "Lazy-show")
--  «.Lazy-tests-totex»			(to "Lazy-tests-totex")
--  «.Lazy-tests-named»			(to "Lazy-tests-named")
--  «.Lazy-tests-processfmt0»		(to "Lazy-tests-processfmt0")
--  «.Lazy-tests-show»			(to "Lazy-tests-show")
-- «.Subst»				(to "Subst")
--  «.Subst-makerecursive»		(to "Subst-makerecursive")
--  «.Subst-compile»			(to "Subst-compile")
--  «.Subst-bmat»			(to "Subst-bmat")
--  «.Subst-tfmt»			(to "Subst-tfmt")
--  «.Subst-tests»			(to "Subst-tests")
--  «.Subst-tests-makerecursive»	(to "Subst-tests-makerecursive")
--  «.Subst-tests-compile»		(to "Subst-tests-compile")
--  «.Subst-tests-bmat»			(to "Subst-tests-bmat")
--  «.Subst-tests-tfmt»			(to "Subst-tests-tfmt")


require "Pict2e1"    -- (find-angg "LUA/Verbatim1.lua" "Pict2e1")
require "Verbatim1"  -- (find-angg "LUA/Verbatim1.lua" "Verbatim1")


oerror = function (o, fmt, ...)
    PPP(o)
    error(format(fmt, myunpack(map(mytostringp, {...}))))
  end

tolua = function (o)
    if type(o) == "number" then return tostring(o) end
    if type(o) == "string" then return format("%q", o) end
    if type(o) ~= "table"  then oerror(o, "Bad type to :tolua") end
    if not o.tolua then oerror(o, "No :tolua") end
    return o:tolua()
  end

totex = function (o, stot)
    if type(o) == "number" then return tostring(o) end
    if type(o) == "string" then return o end
    if not o.totex then oerror(o, "No :totex") end
    return o:totex(stot)
  end

expr1     = function (s) return expr(s) or error("expr failed") end
totexexpr = function (s) return totex(expr1(s)) end

ltype = function (o)
    if otype(o) ~= "Lazy" then return otype(o) end
    if not o.kind then oerror(o, "no kind") end
    return o.kind
  end

maparraypart = function (f, A)
    local B = shallowcopy(A)
    for i=1,#B do B[i] = f(B[i]) end
    return B
  end


--  _        _                         _      
-- | |_ _ __(_)_ __ ___   ___ ___   __| | ___ 
-- | __| '__| | '_ ` _ \ / __/ _ \ / _` |/ _ \
-- | |_| |  | | | | | | | (_| (_) | (_| |  __/
--  \__|_|  |_|_| |_| |_|\___\___/ \__,_|\___|
--                                            
-- «trimcode»  (to ".trimcode")
-- Tests: (find-angg "LUA/Lazy2.lua" "trimcode-tests")

trimcode0 = function (bigstr, n)
    local lines = splitlines(rtrim(bigstr))
    lines = map(untabify, lines)
    lines = map(rtrim,    lines)
    if #lines == 0 then return VTable({}) end
    local initspaces = lines[1]:match("^( *)")
    n = n or #initspaces
    local f = function (li) return li:sub(n+1) end
    return VTable(map(f, lines))
  end
trimcode = function (bigstr, n)
    return table.concat(trimcode0(bigstr, n), "\n")
  end



--      _        _                   _                   
--  ___| |_ _ __(_)_ __   __ _   ___| |__   _____      __
-- / __| __| '__| | '_ \ / _` | / __| '_ \ / _ \ \ /\ / /
-- \__ \ |_| |  | | | | | (_| |_\__ \ | | | (_) \ V  V / 
-- |___/\__|_|  |_|_| |_|\__, (_)___/_| |_|\___/ \_/\_/  
--                       |___/                           
--
-- «string.show»  (to ".string.show")
-- (find-angg "LUA/Pict2e1.lua" "Show")
string.show = function (str, ops)
    return Show.try(str:show0(ops):tostringp())
  end
string.show0 = function (str, ops)
    local p = PictList { str }
    local scale = function (op) return op:match("^([%d%.]+)$") end
    for _,op in ipairs(split(ops)) do
      if     op == "d"  then p = p:d()
      elseif op == "dd" then p = p:dd()
      elseif scale(op)  then p = p:scalebox(scale(op))
      else error("Unknown op")
      end
    end
    return p
  end

-- «string.show-tests»  (to ".string.show-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy5.lua"
= ("22 \\cdot foo")
= ("22 \\cdot foo"):show("  dd")
 (etv)
= ("22 \\cdot foo"):show("4 dd")
 (etv)
= Show.log

--]==]




--  _____ _   _                      
-- |_   _| \ | | __ _ _ __ ___   ___ 
--   | | |  \| |/ _` | '_ ` _ \ / _ \
--   | | | |\  | (_| | | | | | |  __/
--   |_| |_| \_|\__,_|_| |_| |_|\___|
--                                   
-- «TName»  (to ".TName")
-- See: (to "Subst-tfmt")
TName = Class {
  type = "TName",
  from = function (name, tname0)
      tname0 = tname0 or name
      local tname1,tname2 = unpack(split(tname0))
      tname2 = tname2 or ""
      return TName {name=name,         -- example: "S1"
                    tname0=tname0,     -- example: "S _1"
                    tname1=tname1,     -- example: "S"
                    tname2=tname2}     -- example: "_1"
    end,
  __tostring = mytostringvp,
  __index = {
    format = function (tn, fmt)
        local f = function (fieldname) return tn[fieldname] end
        return (fmt:gsub("<(.-)>", f))
      end,
    -- (find-LATEX "edrxgac2.tex" "C2-substnames")
    csname = function (tn)
        return tn:format("{\\CSname{<tname1>}{<tname2>}}")
      end,
    cfname = function (tn)
        return tn:format("{\\CFname{<tname1>}{<tname2>}}")
      end,
  },
}

-- «TName-tests»  (to ".TName-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy5.lua"
= TName.from("S1", "S _1")
= TName.from("S1", "S _1"):csname()
= TName.from("S1", "S _1"):cfname()

--]]



--  _                    
-- | |    __ _ _____   _ 
-- | |   / _` |_  / | | |
-- | |__| (_| |/ /| |_| |
-- |_____\__,_/___|\__, |
--                 |___/ 
--
-- «Lazy»  (to ".Lazy")
Lazy = Class {
  type    = "Lazy",
  --
  var0 = function (name, fmt)
      return Lazy {kind="var", [0]=name, fmt=(fmt or name)}
    end,
  ang0 = function (name, fmt0)
      return Lazy({kind="ang", [0]=name, fmt0=fmt0}):g_processfmt0()
    end,
  fun0 = function (name, fmt)
      fmt = fmt or format("%s(<1>)", name)
      return function (...)
          return Lazy {kind="fun", [0]=name, fmt=fmt, ...}
        end
    end,
  --
  set = function (name, o) _G[name] = o; return o end,
  var = function (name, fmt)  return Lazy.set(name, Lazy.var0(name, fmt))  end,
  ang = function (name, fmt0) return Lazy.set(name, Lazy.ang0(name, fmt0)) end,
  fun = function (name, fmt)  return Lazy.set(name, Lazy.fun0(name, fmt))  end,
  --
  -- «Lazy-named»  (to ".Lazy-named")
  -- (to "Lazy-tests-named")
  namedformula = function (name, tname0, la)
      local name_  = name.."_"
      local cfname = TName.from(name, tname0):cfname()
      Lazy.set(name, la)
      Lazy.var(name_, cfname)
    end,
  namedang = function (name, tname0, fmt0)
      local name_  = name.."_"
      local cfname = TName.from(name, tname0):cfname()
      Lazy.ang(name, fmt0)
      Lazy.var(name_, cfname)
    end,
  --
  __tostring = function (la) return la:tolua() end,
  __call = function (la, ...)
    end,
  __index = {
    tolua = function (la)
        if la.kind == "var" then return la[0] end
        if la.kind == "ang" then return la[0] end
        if la.kind == "fun" then
          local args = mapconcat(tolua, la, ", ")
          return format("%s(%s)", la[0], args)
        end
        oerror(la, "No kind!")
      end,
    totex  = function (la, stot) return la:g_totex(stot) end,
    totree = function (la)       return SynTree.from(la) end,
    tree   = function (la)       return SynTree.from(la) end,
    --
    -- «Lazy-getfield»  (to ".Lazy-getfield")
    -- Methods based on (the idea of) "getfield".
    -- They all start with the prefix "g_".
    --
    -- «Lazy-totex»  (to ".Lazy-totex")
    -- (to "Lazy-tests-totex")
    g_trim  = function (la, s) return (s:gsub("^(%d+):.*$", "%1")) end,
    g_trimn = function (la, s) return tonumber(la:g_trim(s)) or error("can't g_trimn") end,
    g_get   = function (la, s) return la[la:g_trimn(s)]      or error("can't g_get") end,
    g_getf  = function (la,s,f) return f(la:g_get(s))        or error("can't g_getf") end,
    g_gsub  = function (la, fmt, f)
        local g = function (s) return la:g_getf(s,f) end
        return (fmt:gsub("<(.-)>", g))
      end,
    g_fmt   = function (la, f)    return la:g_gsub(la.fmt, f) end,
    g_totex = function (la, stot) return la:g_fmt(stot or totex) end,
    --
    -- «Lazy-processfmt0»  (to ".Lazy-processfmt0")
    -- (to "Lazy-tests-processfmt0")
    g_numberallangs = function (la, fmt0, ev)
        local angbodies = {}
        local f = function (s)
            table.insert(angbodies, s)
            return format("<%d:%s>", #angbodies, s)
          end
        local fmt = fmt0:gsub("<(.-)>", f)
        local evbodies = ev and map(ev, angbodies)
        return fmt,angbodies,evbodies
      end,
    g_processfmt0 = function (la)
        local ev = function (s0) return totex(expr(s0)) end
        local fmt,angbodies,evbodies = la:g_numberallangs(la.fmt0, expr1)
        for i,evbody in ipairs(evbodies) do la[i] = evbody end
        la.fmt = fmt
        return la
      end,
    --
    -- «Lazy-show»  (to ".Lazy-show")
    -- (to "Lazy-tests-show")
    -- (find-angg "LUA/Lazy2.lua" "Lazy-topict")
    show = function (la, ops) return la:totex():show(ops) end,
    sa = function (la, name) return PictList({ la:totex() }):sa(name) end,
  },
}

-- «Lazy-tests-totex»  (to ".Lazy-tests-totex")
-- (to "Lazy-totex")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy5.lua"

foo = Lazy {fmt="<1>*<2>", 22, "astr"}
bar = Lazy {fmt="<1> + <2>", foo, 33}
= foo:g_get("1")
= foo:g_get("2")
= foo:g_get("2:plic(bar)")
= foo:g_get("3")           -- err
= foo:g_gsub(foo.fmt, id)
= foo:g_gsub(foo.fmt, mytostring)
= foo:g_fmt(mytostring)
= foo:g_fmt(totex)
= foo:g_fmt(id)
= foo:g_totex()
= bar:g_totex()
= totex(foo)
= totex(bar)

Lazy.var("a")
Lazy.var("a1", "a_1")
Lazy.fun("f")
Lazy.fun("fp",  "f'(<1>)")
Lazy.fun("mul",  "<1> \\cdot <2>")
Lazy.fun("plus", "<1> + <2>")
= mul(f(a),fp(a1))
= mul(f(a),fp(a1)):tree()
= mul(f(a),fp(a1)):totex()

--]]


-- «Lazy-tests-named»  (to ".Lazy-tests-named")
-- (to "Lazy-named")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy5.lua"
Lazy.var("a")
Lazy.var("a1", "a_1")
Lazy.fun("f")
Lazy.fun("fp",  "f'(<1>)")
Lazy.fun("mul",  "<1> \\cdot <2>")

= Lazy.namedformula("MM", nil, mul(f(a),fp(a1)))
= Lazy.namedang   ("AMM", nil, "<MM_> = (<MM>)")
= MM,   MM:totex()
= MM_,  MM_:totex()
= AMM,  AMM:totex()
= AMM_, AMM_:totex()
= Lazy.ang("_", "<MM_> = (<MM>)"):sa("foobar")
= Lazy.ang("_", "<MM_> = (<MM>)"):show("dd")
 (etv)

--]]

-- «Lazy-tests-processfmt0»  (to ".Lazy-tests-processfmt0")
-- (to "Lazy-processfmt0")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy5.lua"
Lazy.var("a")
Lazy.var("a1", "a_1")
Lazy.fun("f")
Lazy.fun("fp",  "f'(<1>)")
Lazy.fun("mul", "<1>*<2>")
= totexexpr("fp(a1)")
= expr1("fp(a1)")
= expr1("fp(a1)"):tree()
Lazy.ang("aaa", "<f(a)>:<fp(a1)>")
= aaa
= aaa:tree()
= aaa:totex()

--]]

-- «Lazy-tests-show»  (to ".Lazy-tests-show")
-- (to "Lazy-show")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy5.lua"
Lazy.fun("mul", "<1> \\cdot <2>")
= mul(22, "foo")
= mul(22, "foo"):tree()
= mul(22, "foo"):totex()
= mul(22, "foo"):show("dd")
 (etv)
= mul(22, "foo"):show("4 dd")
 (etv)

--]]



--  ____        _         _   
-- / ___| _   _| |__  ___| |_ 
-- \___ \| | | | '_ \/ __| __|
--  ___) | |_| | |_) \__ \ |_ 
-- |____/ \__,_|_.__/|___/\__|
--                            
-- «Subst»  (to ".Subst")
Subst = Class {
  type = "Subst",
  from = function (src)
      return Subst({ src=src }):split():compile():settexbody()
    end,
  from3 = function (name, tname0, src)
      return Subst.from(src):setname(name, tname0)
    end,
  named = function (name, tname0, src)
      local name_ = name.."_"
      local S = Subst.from(src):setname(name, tname0)
      _G[name] = S
      local S_ = Lazy.var(name_, S:texname())
      return S, S_
    end,
  --
  -- «Subst-makerecursive»  (to ".Subst-makerecursive")
  -- (to "Subst-tests-makerecursive")
  funmatch = function (pato, o)
      return ltype(pato) == "fun"
         and ltype(o)    == "fun"
         and pato[0]     == o[0]
    end,
  varmatch = function (pato, o)
      return ltype(pato) == "var"
         and ltype(o)    == "var"
         and pato[0]     == o[0]
    end,
  match    = function (pato, o)
      return Subst.funmatch(pato, o)
          or Subst.varmatch(pato, o)
    end,
  makerecursive = function (S_core)
      local S
      S = function (o)
          if type(o) == "number" then return o end
          if type(o) == "string" then return o end
          local is    = function (pato) return Subst.match(pato, o) end
          local arg   = function (n)    return   o[n or 1] end
          local Sarg  = function (n)    return S(o[n or 1]) end
          local Sresult = S_core(o,is,arg,Sarg)
  	  if Sresult then return Sresult end
          return maparraypart(S, o)
        end
      return S
    end,
  --
  __tostring = function (su) return rtrim(su.src) end,
  __call = function (su, o) return su:a(o) end,
  __index = {
    split = function (su)
        su.srcpairs = VTable {}
        for _,li in ipairs(splitlines(su.src)) do
          local l,r = li:match("^(.-):=(.*)$")
          if l then table.insert(su.srcpairs, {l,r}) end
        end
        return su
      end,
    --
    -- «Subst-compile»  (to ".Subst-compile")
    -- (to "Subst-tests-compile")
    lualine0 = function (su, l, r, loc)
        return format("    if is(%s) then %sreturn %s end", l, loc, r) 
      end,
    lualine = function (su, l, r)
        local evl = expr1(l)
        if ltype(evl) == "fun" then
          local var = evl[1]
          if not ltype(l) == "fun" then error("not fun(var)") end
          local varname = var[0]
          local loc = format("local %s=Sarg(); ", varname)
          return su:lualine0(l, r, loc)
        elseif ltype(evl) == "var" then
          return su:lualine0(l, r, "                ")
        end
        error("l is neither fun nor var")    
      end,
    code0 = function (su)
        local ll = function (i)
            return su:lualine(su.srcpairs[i][1],
                              su.srcpairs[i][2])
          end
        return mapconcat(ll, seq(1, #su.srcpairs), "\n")
      end,
    code1 = function (su)
        return "Subst.makerecursive(function (o,is,arg,Sarg)\n"
            .. su:code0()
            .. "\n  end)"
      end,
    code2   = function (su) return expr(su:code1())  end,
    compile = function (su) su.compiled = su:code2(); return su end,
    apply   = function (su, o) return su.compiled(o) end,
    a       = function (su, o) return su.compiled(o) end,
    --
    -- «Subst-bmat»  (to ".Subst-bmat")
    -- (to "Subst-tests-bmat")
    settexbody = function (su)
        local texline = function (lr)
            local texl,texr = totexexpr(lr[1]), totexexpr(lr[2])
            return format("      %s := %s \\\\\n", texl, texr)
          end
        su.texbody = mapconcat(texline, su.srcpairs)
        return su
      end,
    bmat = function (su) return "  \\bmat{\n"..su.texbody.."  }" end,
    bsm  = function (su) return "  \\bsm{\n" ..su.texbody.."  }" end,
    --
    -- «Subst-tfmt»  (to ".Subst-tfmt")
    -- (to "Subst-tests-tfmt")
    -- See: (to "TName")
    setname = function (su, name, tname0)
        tname0 = tname0 or name
        local tname1,tname2 = unpack(split(tname0))
        tname2 = tname2 or ""
        local tname = format("\\text{%s}%s", tname1, tname2)
        su.name, su.tname0, su.tname1, su.tname2, su.tname =
           name,    tname0,    tname1,    tname2,    tname
        return su
      end,
    tfmt = function (su, fmt)
        local f = function (fieldname) return su[fieldname] end
        return (fmt:gsub("<(.-)>", f))
      end,
    texname = function (su)
        return su:tfmt("\\CSname{<tname1>}{<tname2>}")
      end,
    sas = function (su)
        return su:tfmt(trimcode([[
          \sa{[<name>]}{\CSname{<tname1>}{<tname2>}}
          \sa{[<name>] bmat}{{\bmat{<texbody>  }}}
          \sa{[<name>] bsm}{{\bsm{<texbody>  }}}
        ]]))
     end,
    --
    totex = function (su) return su:bmat() end,
    show0 = function (su)
        if su.tname then return su:texname().."="..su:bmat() end
        return su:bmat()
      end,
    show = function (su, ops)
        return su:show0():show(ops)
      end,
  },
}

-- «Subst-tests»  (to ".Subst-tests")
-- «Subst-tests-makerecursive»  (to ".Subst-tests-makerecursive")
-- (to "Subst-makerecursive")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy5.lua"
Lazy.var("a")
Lazy.var("a1", "a_1")
Lazy.fun("f")
Lazy.fun("g")
Lazy.fun("fp",  "f'(<1>)")
Lazy.fun("mul", "<1>*<2>")
mm = mul(fp(a1), f(g(a)))
ssa = Subst.makerecursive(function (o,is,arg,Sarg)
    print(o, is(a))
    if is(g(a)) then return mul(42,Sarg()) end
    if is(f(a)) then return mul(arg(),Sarg()) end
  end)

=     mm :tree()
= ssa(mm):tree()

--]]

-- «Subst-tests-compile»  (to ".Subst-tests-compile")
-- (to "Subst-compile")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy5.lua"
Lazy.var("a")
Lazy.var("a1", "a_1")
Lazy.fun("f")
Lazy.fun("fp",  "f'(<1>)")
Lazy.fun("mul", "<1>*<2>")
mm = mul(fp(a1), f(a))
ss = Subst.from [[
    f(a) := fp(a)
    a1   := a
  ]]
= ss
= ss  (mm)
=      mm :tree()
= ss:a(mm):tree()
= ss  (mm):tree()
= ss      :show("dd")
 (etv)

--]==]

-- «Subst-tests-bmat»  (to ".Subst-tests-bmat")
-- (to "Subst-bmat")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy5.lua"
Lazy.var("a")
Lazy.var("a1", "a_1")
Lazy.fun("f")
Lazy.fun("fp",  "f'(<1>)")
Lazy.fun("mul", "<1>*<2>")
mm = mul(fp(a1), f(a))
ss = Subst.from [[
    f(a) := fp(a)
    a1   := a
  ]]
= ss:bmat()
= ss:show("dd")
 (etv)

--]==]


-- «Subst-tests-tfmt»  (to ".Subst-tests-tfmt")
-- (to "Subst-tfmt")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Lazy5.lua"
Lazy.var("a")
Lazy.var("a1", "a_1")
Lazy.fun("f")
Lazy.fun("fp",  "f'(<1>)")
Lazy.fun("mul", "<1> \\cdot <2>")
Lazy.fun("Paren", "\\left(<1>\\right)")
mm = mul(fp(a1), f(a))

Subst.named("S1", "S _1", [[
    f(a) := fp(a)
    a1   := a
  ]])
= S1
= S1:bmat()
= S1_
= S1_:totex()
PPPV(S1)

= S1.tname
= S1:texname()
= S1:bmat()
= S1:bsm()
= S1:sas()
= S1:show0()
= S1:show("dd")
 (etv)

--]==]




-- Local Variables:
-- coding:  utf-8-unix
-- End:
