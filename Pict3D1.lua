-- This file:
--   http://angg.twu.net/LUA/Pict3D1.lua.html
--   http://angg.twu.net/LUA/Pict3D1.lua
--           (find-angg "LUA/Pict3D1.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- Support for 3D, version for Pict2e1.lua.
-- See: (find-angg "LUA/Pict2e1.lua")
--      (find-angg "LUA/Pict2e1-1.lua")
--      (find-angg "LUA/Piecewise1.lua")
--      (c3m212nfp 32 "quadraticas-exemplos")
--      (c3m212nfa    "quadraticas-exemplos")
--      (find-LATEX "2021-1-C3-3D.lua")
--
-- (defun a  () (interactive) (find-angg "LUA/Pict2e1.lua"))
-- (defun b  () (interactive) (find-angg "LUA/Pict3D1.lua"))
-- (defun ab () (interactive) (find-2b '(a) '(b)))
-- (defun et () (interactive) (find-angg "LATEX/2022pict2e.tex"))
-- (defun eb () (interactive) (find-angg "LATEX/2022pict2e-body.tex"))
-- (defun ao () (interactive) (find-angg "LATEX/2022pict2e.lua"))
-- (defun v  () (interactive) (find-pdftools-page "~/LATEX/2022pict2e.pdf"))
-- (defun tb () (interactive) (find-ebuffer (eepitch-target-buffer)))
-- (defun etv () (interactive) (find-wset "13o2_o_o" '(tb) '(v)))
-- (setenv "PICT2ELUADIR" "~/LATEX/")
--
-- (find-LATEXgrep "grep --color=auto -niH --null -e piecewise *.tex *.lua")

-- «.V3»			(to "V3")
-- «.V3-tests»			(to "V3-tests")
-- «.Line3D»			(to "Line3D")
-- «.Line3D-tests»		(to "Line3D-tests")
-- «.Pict2Dify»			(to "Pict2Dify")
-- «.Pict2Dify-tests»		(to "Pict2Dify-tests")
-- «.pictreplace»		(to "pictreplace")
-- «.Surface»			(to "Surface")
-- «.Surface-tests»		(to "Surface-tests")
-- «.QuadraticFunction»		(to "QuadraticFunction")
-- «.QuadraticFunction-tests»	(to "QuadraticFunction-tests")
-- «.nff»			(to "nff")
-- «.nff-test1»			(to "nff-test1")
-- «.nff-test2»			(to "nff-test2")
-- «.ThreeD»			(to "ThreeD")
-- «.ThreeD-tests»		(to "ThreeD-tests")

require "Pict2e1"      -- (find-angg "LUA/Pict2e1.lua")
require "Pict2e1-1"    -- (find-angg "LUA/Pict2e1-1.lua")

tow = function (vv, ww, a, b)
    local diff = ww-vv
    -- local diffrot90 = v(diff[2], -diff[1])
    return vv + (a or 0.5)*diff -- + (b or 0)*diffrot90
  end




-- «V3»  (to ".V3")
-- (find-es "dednat" "V3")
--
V3 = Class {
  type    = "V3",
  __tostring = function (v) return v:tostring() end,
  __add      = function (v, w) return V3{v[1]+w[1], v[2]+w[2], v[3]+w[3]} end,
  __sub      = function (v, w) return V3{v[1]-w[1], v[2]-w[2], v[3]-w[3]} end,
  __unm      = function (v) return v*-1 end,
  __mul      = function (v, w)
      local ktimesv   = function (k, v) return V3{k*v[1], k*v[2], k*v[3]} end
      local innerprod = function (v, w) return v[1]*w[1] + v[2]*w[2] + v[3]*w[3] end
      if     type(v) == "number" and type(w) == "table" then return ktimesv(v, w)
      elseif type(v) == "table" and type(w) == "number" then return ktimesv(w, v)
      elseif type(v) == "table" and type(w) == "table"  then return innerprod(v, w)
      else error("Can't multiply "..tostring(v).."*"..tostring(w))
      end
    end,
  __index = {
    tostring = function (v) return v:v3string() end,
    v3string = function (v) return pformat("(%s,%s,%s)", v[1], v[2], v[3]) end,
    v2string = function (v) return tostring(v:tov2()) end,
    --
    -- Convert v3 to v2 using a primitive kind of perspective.
    -- Adjust p1, p2, p3 to change the perspective.
    tov2 = function (v) return v[1]*v.p1 + v[2]*v.p2 + v[3]*v.p3 end,
    p1 = V{2,-1},
    p2 = V{2,1},
    p3 = V{0,2},
    --
    Line = function (A, v) return Line3D.from(A, A+v) end,
    Lines = function (A, v, w, i, j)
        local p = PictList {}
        for k=i,j do table.insert(p, (A+k*w):Line(v)) end
        return p
      end,
    --
    xticks = function (_,n,eps)
        eps = eps or 0.15
        return v3(0,-eps,0):Lines(v3(0,2*eps,0), v3(1,0,0), 0, n)
      end,
    yticks = function (_,n,eps)
        eps = eps or 0.15
        return v3(-eps,0,0):Lines(v3(2*eps,0,0), v3(0,1,0), 0, n)
      end,
    zticks = function (_,n,eps)
        eps = eps or 0.15
        return v3(-eps,0,0):Lines(v3(2*eps,0,0), v3(0,0,1), 0, n)
      end,
    axeswithticks = function (_,x,y,z)
        local p = PictList {}
	table.insert(p, v3(0,0,0):Line(v3(x+0.5, 0, 0)))
	table.insert(p, v3(0,0,0):Line(v3(0, y+0.5, 0)))
	table.insert(p, v3(0,0,0):Line(v3(0, 0, z+0.5)))
        table.insert(p, _:xticks(x))
        table.insert(p, _:yticks(y))
        table.insert(p, _:zticks(z))
        return p
      end,
    xygrid = function (_,x,y)
        return PictList {
          v3(0,0,0):Lines(v3(0,y,0), v3(1,0,0), 0, x),
          v3(0,0,0):Lines(v3(x,0,0), v3(0,1,0), 0, y)
        }
      end,
    gat = function (_,x,y,z)
        return PictList {
          _:xygrid       (x, y   ):Color("Gray"),
          _:axeswithticks(x, y, z)
        }
      end,
  },
}

v3 = function (x,y,z) return V3{x,y,z} end

-- Choose one:
V3.__index.tostring = function (v) return v:v2string() end
V3.__index.tostring = function (v) return v:v3string() end

-- (find-LATEX "2022pict2e.lua" "Surface")


-- «V3-tests»  (to ".V3-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Pict3D1.lua"
vv = v3(1, 2, 3)
ww = v3(10, 100, 1000)
= vv
= vv + ww
= - (vv + 10*ww)

= vv:xticks(2)
= vv:Line(ww)
= vv:xygrid(2, 3)
= vv:axeswithticks(2, 3, 4)
= vv:axeswithticks(2, 3, 4):twod()
= vv:gat(4, 3, 2)
= vv:gat(4, 3, 2):twod()

V3.__index.p1 = V{2,  -0.5}
V3.__index.p2 = V{0.5, 1.7}
V3.__index.p3 = V{0,   0.5}
Pict2e.bounds = PictBounds.new(v(0,-2), v(9.5,6))
= vv:gat(4, 3, 2):twod()
= vv:gat(4, 3, 2):twod():bshow("Bp")
 (etv)

--]]




--  _     _            _____ ____  
-- | |   (_)_ __   ___|___ /|  _ \ 
-- | |   | | '_ \ / _ \ |_ \| | | |
-- | |___| | | | |  __/___) | |_| |
-- |_____|_|_| |_|\___|____/|____/ 
--                                 
-- «Line3D»  (to ".Line3D")
-- (find-angg "LUA/Pict2e1.lua" "PictSub")

Line3D = PradClass.from {
  type = "Line3D",
  from = function (...)
      return Line3D { ... }
    end,
  __tostring = function (l3)
      return (l3.op or "\\Line")..mapconcat(tostring, l3)
    end,
  __index = {
    addpoint = function (l3, p) table.insert(l3, p); return l3 end,
    print = function (l3, out, ctx)
        l3:printitem(out, ctx, tostring(l3))
      end,
  },
}

-- «Line3D-tests»  (to ".Line3D-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Pict3D1.lua"
l3a = Line3D.from(v3(1,2,3), v3(4,5,6))
l3b = Line3D.from(v3(1,2,3), v3(4,5,6), v3(7,8,9))
l3s = PictSub { l3a, PictSub { l3a, l3b } }
= l3s
V3.__index.tostring = function (v) return v:v2string() end
= l3s
V3.__index.tostring = function (v) return v:v3string() end
= l3s

--]]


--  ____  _      _   ____  ____  _  __       
-- |  _ \(_) ___| |_|___ \|  _ \(_)/ _|_   _ 
-- | |_) | |/ __| __| __) | | | | | |_| | | |
-- |  __/| | (__| |_ / __/| |_| | |  _| |_| |
-- |_|   |_|\___|\__|_____|____/|_|_|  \__, |
--                                     |___/ 
-- «Pict2Dify»  (to ".Pict2Dify")
-- (find-angg "LUA/Pict2e1.lua" "PictSub")

Pict2Dify = PradClass.from {
  type    = "Pict2Dify",
  __tostring = function (p) return p:tostring() end,
  __index = {
    print = function (p, out, ctx)
        local oldV3tostring = V3.__index.tostring
        V3.__index.tostring = function (v) return v:v2string() end
        p:printitems(out, ctx)
        V3.__index.tostring = oldV3tostring
      end,
  },
}

PradClass.__index.twod = function (p)
    return Pict2Dify { p }
  end

-- «Pict2Dify-tests»  (to ".Pict2Dify-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Pict3D1.lua"
l3a = Line3D.from(v3(1,2,3), v3(4,5,6))
l3b = Line3D.from(v3(1,2,3), v3(4,5,6), v3(7,8,9))
l3s = PictSub { l3a, PictSub { l3a, l3b } }
= l3s
= PictList { Pict2Dify { l3a, l3s }, l3a }
= PictList { l3s:twod(), l3s }

--]]



-- «pictreplace»  (to ".pictreplace")
-- (find-es "dednat" "pictreplace")
--
-- pictreplace = function (bigstr)
--     -- local f = function (code) return tostring(expr(code)) end
--     local f = function (code) return deletecomments(tostring(expr(code))) end
--     local g = function (line) return (line:gsub("<([^<>]+)>", f)) end
--     return (bigstr:gsub("[^\n]+", g))
--   end
-- 
-- registerhead "%P" {
--   name   = "pictreplace",
--   action = function ()
--       local i,j,pictcode = tf:getblockstr(3)
--       output(pictreplace(pictcode))
--     end,
-- }



-- «Surface»  (to ".Surface")
-- (find-dn6 "picture.lua" "V")
-- (find-dn6 "diagforth.lua" "newnode:at:")
--
Surface = Class {
  type = "Surface",
  new  = function (f, x0, y0)
      return Surface {f=f, x0=x0, y0=y0, xy0=v(x0, y0)}
    end,
  __index = {
    xyz = function (s, xy, zvalue)
        return v3(xy[1], xy[2], zvalue or s.f(xy[1], xy[2]))
      end,
    xyztow = function (s, xy1, xy2, zvalue, k)
        return s:xyz(tow(xy1, xy2, k), zvalue)
      end,
    segment = function (s, xy1, xy2, zvalue, n)
        local seg = Line3D.from()
        for i=0,n do seg:addpoint(s:xyztow(xy1, xy2, zvalue, i/n)) end
        return seg
      end,
    pillar = function (s, xy)
        return Line3D.from(s:xyz(xy, 0), s:xyz(xy, nil))
      end,
    pillars = function (s, xy1, xy2, n)
        local pils = PictList {}
        for i=0,n do table.insert(pils, s:pillar(tow(xy1, xy2, i/n))) end
        return pils
      end,
    --
    segmentstuff = function (s, xy1, xy2, n, what)
        local stf = PictList {}
        if what:match"0" then table.insert(stf, s:segment(xy1, xy2, 0,   1)) end
        if what:match"c" then table.insert(stf, s:segment(xy1, xy2, nil, n)) end
        if what:match"p" then table.insert(stf, s:pillars(xy1, xy2,      n)) end
        return stf
      end,
    --
    stoxy = function (s, str)
        expr(format("v(%s)", str))
      end,
    squarestuff = function (s, dxy0s, dxy1s, n, what)
        local dxy0 = expr(format("v(%s)", dxy0s))
        local dxy1 = expr(format("v(%s)", dxy1s))
        local xy1 = s.xy0 + dxy0
        local xy2 = s.xy0+dxy1
        return s:segmentstuff(xy1, xy2, n, what)
      end,
    squarestuffp = function (s, n, what, pair)
        local dxy0,dxy1 = unpack(split(pair))
	return s:squarestuff(dxy0, dxy1, n, what)
      end,
    squarestuffps = function (s, n, what, listofpairs)
        local stf = PictList {}
        for _,pair in ipairs(listofpairs) do
          table.insert(stf, s:squarestuffp(n, what, pair))
        end
        return stf
      end,
    --
    horizontals = function (s, n, what)
        return s:squarestuffps(n, what, {
          "-1,-1 1,-1", "-1,0 1,0", "-1,1 1,1"
          })
      end,
    verticals = function (s, n, what)
        return s:squarestuffps(n, what, {
          "-1,-1 -1,1", "0,-1 0,1", "1,-1 1,1"
          })
      end,
    diagonals = function (s, n, what)
        return s:squarestuffps(n, what, {
          "-1,-1 1,1", "-1,1 1,-1"
          })
      end,
    square = function (s, n, what)
        return PictList { s:horizontals(n, what),
                          s:verticals  (n, what) }
      end,
  },
}



-- «Surface-tests»  (to ".Surface-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Pict3D1.lua"

F = function (x, y) return 10*x + y end
srf = Surface.new(F, 3, 4)
= srf:xyz(v(2, 5))
= srf:xyz(v(2, 5), 0)

= srf:xyztow(v(2,5), v(22,25), nil,  0.5)
= srf:xyztow(v(2,5), v(22,25), 0,    0.5)
= srf:segment(v(2,5), v(22,25), 0,   2)
= srf:segment(v(2,5), v(22,25), nil, 2)
= srf:pillar(v(2,5))
= srf:segmentstuff(v(2,5), v(22,25), 2, "0cp")

= srf:squarestuff("0,0", "2,2", 2, "0")
= srf:squarestuff("0,0", "2,2", 2, "c")
= srf:squarestuff("0,0", "2,2", 2, "p")
= srf:squarestuffp(             2, "p", "0,0 2,2")

= srf:square   (2, "p")
= srf:square   (4, "p")
= srf:square   (2, "c")
= srf:square   (4, "c")
= srf:square   (8, "c")
= srf:diagonals(2, "p")

fw = function (x) return max(min(x-2, 6-x), 0) end
FP = function (x,y) return min(fw(x), fw(y)) end
FC = function (x,y) return max(fw(x), fw(y)) end
sP = Surface.new(FP, 4, 4)
= sP:segment(v(0,4), v(6,4), nil, 6)

-- ^ Used by:
-- (c3m211cnp 15 "figura-piramide")
-- (c3m211cna    "figura-piramide")
-- (c3m211cnp 16 "cruz")
-- (c3m211cna    "cruz")

--]]


-- «QuadraticFunction»  (to ".QuadraticFunction")
--
QuadraticFunction = Class {
  type   = "QuadraticFunction",
  __call = function (q, ...) return q:f(...) end,
  __index = {
    f = function (q, x, y)
        local dx,dy = x - (q.x0 or 0), y - (q.y0 or 0)
        return (q.a or 0)
             + (q.Dx  or 0) * dx    + (q.Dy  or 0) * dy
             + (q.Dxx or 0) * dx*dx + (q.Dyy or 0) * dy*dy
             + (q.Dxy or 0) * dx*dy
      end,
  },
}

-- «QuadraticFunction-tests»  (to ".QuadraticFunction-tests")
-- Used by: (c3m211qp 2 "figuras-3D")
--          (c3m211qa   "figuras-3D")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "2021-1-C3-3D.lua"

qf = QuadraticFunction {x0=3, y0=2, a=100, Dx=0, Dy=0, Dxx=1, Dyy=1, Dxy=0}
= qf(3, 2)
= qf(3 + 1, 2)
= qf(3 + 1, 2 + 1)

qf = QuadraticFunction {Dx=10, Dy=1}
= qf(2, 3)

qf = QuadraticFunction {Dx=10, Dy=1, x0=20, y0=30, a=100}
= qf(20, 30)
= qf(22, 33)

qf = QuadraticFunction {Dxx=100, Dxy=10, Dyy=1}
= qf(2, 3)
= qf(2, 0)
= qf(0, 3)

--]]


--         __  __ 
--  _ __  / _|/ _|
-- | '_ \| |_| |_ 
-- | | | |  _|  _|
-- |_| |_|_| |_|  
--                
-- «nff»  (to ".nff")
-- Define a function in "notação de físicos".

nff = function (str)
    return Code.vc("x,y => local Dx,Dy = x-x0,y-y0; return "..str)
  end

-- «nff-test1»  (to ".nff-test1")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Pict3D1.lua"
x0,y0 = 3,2
= nff "Dx^2"
= nff "Dx^2"(5,5)

F = nff " Dx + Dy + 2 "
= F(3,2)
= F(4,2)
= F(4,3)

function (x, y) return 10*x + y end
srf = Surface.new(F, 3, 4)
= srf:xyz(v(2, 5))
= srf:xyz(v(2, 5), 0)

V3.__index.p1 = V{2,  -0.5}
V3.__index.p2 = V{0.5, 1.7}
V3.__index.p3 = V{0,   0.5}
Pict2e.bounds = PictBounds.new(v(0,-2), v(9.5,6))
= vv:gat(4, 3, 2):twod()
= vv:gat(4, 3, 2):twod():bshow("Bp")
 (etv)

--]]



-- «nff-test2»  (to ".nff-test2")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Pict3D1.lua"

V3.__index.p1 = V{2,  -0.5}
V3.__index.p2 = V{0.5, 1.7}
V3.__index.p3 = V{0,   0.5}
Pict2e.bounds = PictBounds.new(v(0,-2), v(9.5,6))
bg    = v3():gat(4, 3, 2)
x0,y0 =          3, 2

F     = nff " Dx^2 - Dy^2 + 2 "
srf   = Surface.new(F, x0, y0)
fg    = PictList {
          srf:square( 1, "0"),
          srf:square( 1, "p"):Color("Gray"),
          srf:square(16, "c")
        }
p     = PictList { bg, fg }
= p
= p:twod():bshow("p")
 (etv)

--]]



--  _____ _                   ____  
-- |_   _| |__  _ __ ___  ___|  _ \ 
--   | | | '_ \| '__/ _ \/ _ \ | | |
--   | | | | | | | |  __/  __/ |_| |
--   |_| |_| |_|_|  \___|\___|____/ 
--                                  
-- «ThreeD»  (to ".ThreeD")
-- Some common settings for 3D diagrams.

ThreeD = Class {
  type    = "ThreeD",
  set_432 = function ()
      V3.__index.p1 = V{2,  -0.5}
      V3.__index.p2 = V{0.5, 1.7}
      V3.__index.p3 = V{0,   0.5}
      Pict2e.bounds = PictBounds.new(v(0,-2), v(9.5,6))
      bg    = v3():gat(4, 3, 2)
      x0,y0 =          3, 2
    end,
  drawsurface = function (F)
      srf   = Surface.new(F, x0, y0)
      return PictList {
        bg,
        srf:square( 1, "0"),
        srf:square( 1, "p"):Color("Gray"),
        srf:square(16, "c")
      }
    end,
  __index = {
  },
}

-- «ThreeD-tests»  (to ".ThreeD-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Pict3D1.lua"

ThreeD.set_432()
p = PictList {
  ThreeD.drawsurface(nff " Dx^2 + Dy^2 + 2 "):pgat("p"), "\quad",
  ThreeD.drawsurface(nff " Dx^2 - Dy^2 + 2 "):pgat("p")
}
p:twod():bshow("")
 (etv)


--]]


-- (defun e () (interactive) (find-angg "LUA/Pict3D1.lua"))



-- Local Variables:
-- coding:  utf-8-unix
-- End:
