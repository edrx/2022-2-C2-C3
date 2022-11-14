-- This file:
--   http://angg.twu.net/LUA/tikz1.lua.html
--   http://angg.twu.net/LUA/tikz1.lua
--           (find-angg "LUA/tikz1.lua")
-- Author: Eduardo Ochs <eduardoochs@gmail.com>
-- Version: 2022nov05
-- Public domain.
--
-- (defun t  () (interactive) (find-angg "LUA/tikz1.lua"))
-- (find-angg "LUA/Pict2e1.lua" "Show")
--
-- See: http://angg.twu.net/eev-tikz.html
--      http://angg.twu.net/eev-tikz.html#trying-it
--
-- Usage:
--    (setq eepitch-preprocess-regexp "^-- ? ? ?")
--    (eepitch-lua51)
--    (eepitch-kill)
--    (eepitch-lua51)
--   ee_dofile "~/LUA/tikz1.lua"  -- (find-angg "LUA/tikz1.lua")
--   tikzbody = tikz [=[
--     \draw[color=orange] (0,0)--(0,2)--(1,2);
--   ]=]
--   show()
--    (find-pdftoolsr-page "/tmp/tikz1.pdf")
--
-- See: (find-es "tikz" "axes")
--      (find-angg ".emacs.templates" "tikz1")
--
-- «.Show-class»	(to "Show-class")
-- «.Show-tests»	(to "Show-tests")
-- «.show»		(to "show")
-- «.savetex»		(to "savetex")
-- «.savetex-tests»	(to "savetex-tests")
-- «.Dang»		(to "Dang")
-- «.Dang-tests»	(to "Dang-tests")
-- «.texbody»		(to "texbody")
-- «.texbody-tests»	(to "texbody-tests")
-- «.tikzbody-tests»	(to "tikzbody-tests")
-- «.repl»		(to "repl")
-- «.repl2»		(to "repl2")
-- «.repl-tests»	(to "repl-tests")


-- «Show-class»  (to ".Show-class")
Show = Class {
  type = "Show",
  new  = function (bigstr) return Show {bigstr = bigstr} end,
  try  = function (bigstr) return Show.new(bigstr):try() end,
  __tostring = function (show)
      return format("Show: %s => %s", show:fnametex(), show.success or "?")
    end,
  __index = {
    fnametex = function () return "/tmp/tikz1.tex" end,
    fnamepdf = function () return "/tmp/tikz1.pdf" end,
    cmd      = function () return "cd /tmp/ && lualatex tikz1.tex < /dev/null" end,
    write = function (show)
        ee_writefile(show:fnametex(), show.bigstr)
        return show
      end,
    compile = function (show)
        local log = getoutput(show:cmd())
        local success = log:match "Success!!!"
        Show.log = log
        show.success = success 
        return show
      end,
    try = function (show)
        return show:write():compile()
      end,
  },
}

-- «Show-tests»  (to ".Show-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "tikz1.lua"
sh = Show.new [=[
  \documentclass{book}
  \begin{document}
  Hello
  \GenericWarning{Success:}{Success!!!}
  \end{document}
]=]
= sh.bigstr
= sh:try()
 (find-pdftools-page "/tmp/tikz1.pdf")

--]==]


--  ____                    
-- |  _ \  __ _ _ __   __ _ 
-- | | | |/ _` | '_ \ / _` |
-- | |_| | (_| | | | | (_| |
-- |____/ \__,_|_| |_|\__, |
--                    |___/ 
--
-- «Dang»  (to ".Dang")
-- When an object of the classe Dang is "expanded" by tostring all its
-- parts between double angle brackets are "expanded" by evaluation,
-- or, more precisely, by running dangeval on them...
-- Some examples:
--   dangeval("'foo'")                           --> "foo"
--   dangeval("'foo'..'bar'")                    --> "foobar"
--   dangeval("'foo','bar'")                     --> "foo"
--   dangeval("2+3")                             --> "5"
--   dangeval("nil")                             --> ""
--   dangeval("")                                --> ""
--   dangeval(":a='foo'; return a..'.'")         --> "foo."
--          dangreplace("(<<:a=2>>,<<a*a>>)")    --> "(,4)"
--   tostring(Dang.from("(<<:a=2>>,<<a*a>>)"))   --> "(,4)"

-- (find-angg "LUA/lua50init.lua" "eval-and-L")
dangeval = function (s)
    local r
    if s:match("^:")
    then r = eval(s:sub(2))
    else r = expr(s)
    end
    if r == nil then return "" end
    return tostring(r)
  end
dangreplace = function (bigstr)
    return (bigstr:gsub("<<(.-)>>", dangeval))
  end

Dang = Class {
  from = function (bigstr) return Dang {bigstr=bigstr} end,
  type = "Dang",
  __tostring = function (da) return dangreplace(da.bigstr) end,
  __index = {
    show     = function (da) return Show.new(tostring(da)) end,
    try      = function (da) return da:show():try() end,
  },
}

dang = function (bigstr) return Dang.from(bigstr) end
tikz = function (bigstr) return Dang.from(bigstr) end

-- «Dang-tests»  (to ".Dang-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "tikz1.lua"
a = "foo"
b = tikz "(<<a>>,<<aa>>)"
c = tikz ".<<b>>,<<2+3>>,<<:return 4+5>>."
= a         --> "foo"
= b         --> "(foo,)"
aa = "AAA"
= b         --> "(foo,AAA)"
= c         --> ".(foo,AAA),5,9."
= c.bigstr  --> ".<<b>>,<<2+3>>,<<:return 4+5>>."

--]==]



--      _                   
--  ___| |__   _____      __
-- / __| '_ \ / _ \ \ /\ / /
-- \__ \ | | | (_) \ V  V / 
-- |___/_| |_|\___/ \_/\_/  
--                          
-- «show»  (to ".show")
show = function ()
    print(' (find-anchor       "~/LUA/tikz1.lua")')
    print(' (find-fline         "/tmp/tikz1.tex")')
    print(' (find-pdftools-page "/tmp/tikz1.pdf")')
    print(' (find-fline         "/tmp/tikz1.log" :en')
    print(" Run this on error: = Show.log")
    print(texbody:try())
  end

-- «savetex»  (to ".savetex")
savetex = function ()
    texbody:show():write()
    print(' Saved the .tex in:')
    print(' (find-fline "/tmp/tikz1.tex")')
  end

-- «savetex-tests»  (to ".savetex-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "tikz1.lua"
= texbody.bigstr
savetex()
 (tikz-showtex)

hello = "HELLO"
savetex()
 (tikz-showtex)

x0,y0,x1,y1 = 0,0,3,2
tikzbody = tikz [=[ \draw (<<x0>>,<<y0>>) -- (<<x1>>,<<y1>>) ]=]
savetex()
 (tikz-showtex)

x1 = 4
savetex()
 (tikz-showtex)

usepackages = [=[\usetikzlibrary{positioning,arrows,calc}]=]
savetex()
 (tikz-showtex)

--]==]


--  _            _               _       
-- | |_ _____  _| |__   ___   __| |_   _ 
-- | __/ _ \ \/ / '_ \ / _ \ / _` | | | |
-- | ||  __/>  <| |_) | (_) | (_| | |_| |
--  \__\___/_/\_\_.__/ \___/ \__,_|\__, |
--                                 |___/ 
-- «texbody»  (to ".texbody")
scale = "1.0"
geometry = "paperwidth=148mm, paperheight=88mm,\n            "..
           "top=1.5cm, bottom=.25cm, left=1cm, right=1cm, includefoot"
saysuccess = "\\GenericWarning{Success:}{Success!!!}"

texbody = Dang.from [=[
\documentclass{book}
\usepackage{xcolor}
\usepackage{colorweb}
\usepackage{tikz}
\usepackage[<<geometry>>]{geometry}
<<usepackages>>
\begin{document}
\pagestyle{empty}
<<defs>>
<<hello>>
\scalebox{<<scale>>}{%
  \begin{tikzpicture}<<options>>
<<tikzbody>>%
  \end{tikzpicture}%
  }
%
<<repl>>
<<saysuccess>>
\end{document}
]=]


-- «texbody-tests»  (to ".texbody-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "tikz1.lua"
hello = "FOO"
show()
 (find-pdftoolsr-page "/tmp/tikz1.pdf")

hello = "\\FOO"
show()
= Show.log

--]==]


-- «tikzbody-tests»  (to ".tikzbody-tests")
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
dofile "tikz1.lua"
tikzbody = tikz [=[
  \draw[thick, color=orange] (0,0)--(1,2)--(2,0)--cycle;
]=]
show()
 (find-pdftoolsr-page "/tmp/tikz1.pdf")

--]==]



--                 _ 
--  _ __ ___ _ __ | |
-- | '__/ _ \ '_ \| |
-- | | |  __/ |_) | |
-- |_|  \___| .__/|_|
--          |_|      
--
-- «repl»  (to ".repl")
-- «repl2»  (to ".repl2")
-- Here's how this works. The default value for texbody includes a
-- "<<repl>>", and by default that expands to "". When we run
--
--   repl = repl2
--
-- this makes texbody include the code below. The function
-- run_repl2_now() is defined in my init file; see:
--   (find-angg "LUA/lua50init.lua" "Repl2.lua" "run_repl2_now")
--
repl2 = [=[
\directlua{ dofile(os.getenv("LUA_INIT"):sub(2)) }
\def\repl{\directlua{ print(); run_repl2_now()  }}
\def\luaprintmeaning#1{\directlua{
  print()
  print("#1: "..(token.get_meaning("#1") or ""))
}}
\nonstopmode
\repl
]=]

-- «repl-tests»  (to ".repl-tests")
-- The test below is very basic.
-- For more advanced tests, see:
--   (find-angg "LUA/Repl2.lua" "getmeaning-tests")
--   (find-angg "LUA/Repl2.lua" "texrun-tests")
-- To insert a block similar to the one below in your notes,
-- run `M-x tir'. See:
--   (find-angg     "LUA/tikz1.el" "tir")
--   (find-anchor "~/LUA/tikz1.el" "tir")
--
--[==[
 (eepitch-lua51)
 (eepitch-kill)
 (eepitch-lua51)
ee_dofile "~/LUA/tikz1.lua"
repl = repl2
savetex()

 (eepitch-shell)
 (eepitch-kill)
 (eepitch-shell)
  cd /tmp/ && lualatex tikz1.tex
print(token.get_meaning("newpage"))

--]==]



-- Local Variables:
-- coding:  utf-8-unix
-- End:
