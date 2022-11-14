-- This file:
--   http://angg.twu.net/LUA/Cabos2.lua.html
--   http://angg.twu.net/LUA/Cabos2.lua
--           (find-angg "LUA/Cabos2.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
--
-- (defun o () (interactive) (find-angg "LUA/Cabos1.lua"))
-- (defun e () (interactive) (find-angg "LUA/Cabos2.lua"))

-- «.XtoT»		(to "XtoT")
-- «.Xtot-tests»	(to "Xtot-tests")
-- «.StrOut»		(to "StrOut")
-- «.StrOut-tests»	(to "StrOut-tests")
-- «.StrGrid»		(to "StrGrid")
-- «.StrGrid-tests»	(to "StrGrid-tests")

-- __  ___      _____ 
-- \ \/ / |_ __|_   _|
--  \  /| __/ _ \| |  
--  /  \| || (_) | |  
-- /_/\_\\__\___/|_|  
--                    
-- «XtoT»  (to ".XtoT")

XtoT = Class {
  type  = "XtoT",
  from_ = function (x0, x1, t0, t1)
      return XtoT {x0=x0, x1=x1, t0=t0, t1=t1}
    end,
  from  = function (x0, x1, t0, t1)
      return XtoT.from_(x0, x1, t0, t1):functions()
    end,
  __tostring = mytostringp,
  __index = {
    xtot = function (xt, x)
        local x0,x1,t0,t1 = xt.x0, xt.x1, xt.t0, xt.t1
        return t0 + (x-x0)*(t1-t0)/(x1-x0)
      end,
    ttox = function (xt, t)
        local x0,x1,t0,t1 = xt.x0, xt.x1, xt.t0, xt.t1
        return x0 + (t-t0)*(x1-x0)/(t1-t0)
      end,
    functions = function (xt)
        local xtot = function (x) return xt:xtot(x) end
        local ttox = function (t) return xt:ttox(t) end
        return xt,xtot,ttox
      end,
  },
}

-- «Xtot-tests»  (to ".Xtot-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Cabos2.lua"
xt,xtot,ttox = XtoT.from(10, 20, 100, 200)
= xtot(12)
= ttox(120)

--]]

--  ____  _         ___        _   
-- / ___|| |_ _ __ / _ \ _   _| |_ 
-- \___ \| __| '__| | | | | | | __|
--  ___) | |_| |  | |_| | |_| | |_ 
-- |____/ \__|_|   \___/ \__,_|\__|
--                                 
-- «StrOut»  (to ".StrOut")

sprint = function (so, ...)
    local args = pack(...)
    return mapconcat(tostring, args, "\t", args.n).."\n"
  end

StrOut = Class {
  type = "StrOut",
  new  = function () return StrOut {out=""} end,
  __tostring = function (so) return so:tostring(so) end,
  __index = {
    add = function (so, str) so.out = so.out..str; return so end,
    print = function (so, ...) return so:add(sprint(...)) end,
    printf = function (so, ...) return so:add(format(...)) end,
    pprintf = function (so, ...) return so:add(pformat(...)) end,
    tostring = function (so) return so:tostring0() end,
    tostring0 = function (so) return (so.out:gsub("\n$", "")) end,
    tostring00 = function (so) return so.out end,
  },
}

-- «StrOut-tests»  (to ".StrOut-tests")
--[[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Cabos2.lua"
so = StrOut.new()
so:print(22, nil, "33", {}, nil)
= so

--]]

--  ____  _         ____      _     _ 
-- / ___|| |_ _ __ / ___|_ __(_) __| |
-- \___ \| __| '__| |  _| '__| |/ _` |
--  ___) | |_| |  | |_| | |  | | (_| |
-- |____/ \__|_|   \____|_|  |_|\__,_|
--                                    
-- «StrGrid»  (to ".StrGrid")
StrGrid = Class {
  type = "StrGrid",
  from = function (bigstr, x0, y0)
      x0 = x0 or 0
      y0 = y0 or 0
      local grid = {}
      for _,li in ipairs(splitlines(bigstr)) do
        local spl = split(li)
        if #spl > 0 then table.insert(grid, spl) end
      end
      local rows,cols = #grid, #grid[1]
      local xmin,ymin = x0, y0
      local xmax,ymax = x0+(cols-1), y0+(rows-1)
      local _,rtoy,ytor = XtoT.from(1,rows, ymax,y0)
      local _,ctox,xtoc = XtoT.from(1,cols, x0,xmax)
      return StrGrid {grid=grid,
        x0=x0, y0=y0,
        xmin=xmin, ymin=ymin,
        xmax=xmax, ymax=ymax,
        rows=rows, cols=cols,
        rtoy=rtoy, ytor=ytor,
        ctox=ctox, xtoc=xtoc
      }
    end,
  __tostring = function (sg) return mytostringv(sg.grid) end,
  __index = {
    get = function (sg, x, y)
        local r,c = sg.ytor(y), sg.xtoc(x)
        if not sg.grid[r] then return end
        return sg.grid[r][c]
      end,
    drawnodes = function (sg)
        local so = StrOut.new()
        for y=sg.ymax,sg.ymin,-1 do
          for x=sg.xmin,sg.xmax do
	    if sg:get(x,y) ~= "." then
              so:printf("  \\node at (%d,%d) {%s};\n", x, y, sg:get(x,y))
            end
          end
        end
        return so:tostring00()
      end,
    drawletters = function (sg)
        local so = StrOut.new()
        for y=sg.ymax,sg.ymin,-1 do
          for x=sg.xmin,sg.xmax do
            so:printf("  \\draw%s (%d,%d);\n", sg:get(x,y), x, y)
          end
        end
        return so:tostring00()
      end,
  },
}

-- «StrGrid-tests»  (to ".StrGrid-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "Cabos2.lua"

sg = StrGrid.from [[
  a b c d e f
  g h i j k l
  m n o p q r
]]
= sg
= sg:get(0,0)
= sg:get(1,0)
= sg:get(0,1)
= sg:get(10,0)
= sg:drawnodes()

sg = StrGrid.from([[
  a b c d e f
  g h i j k l
  m n o p q r
]], -4, -1)
= sg:drawnodes()

--]==]









-- Local Variables:
-- coding:  utf-8-unix
-- End:
