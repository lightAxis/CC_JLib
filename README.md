CC_JLib
===

Object-oriented Jiseok Library used in Computercraft, including various UI apis and classes.    
Easy to use, optimized as possible


Features
---
- Various UI Elements, TextArea, Border, Margin, Textblock
- Easy to use UI Elements api, one-shot-rendering method
- Enrionment Variable & Namespace appiled to avoid name collision with other libraries
- Selection build to debug test functions in both Lua & ComputerCraft environments
- Require-based package modulation, faster than using dofile function
- TODO : Button API, Screen Scroll, Interactive UI API, Examples


Object Oriented Programming
---
In this repo, I used [middleclass](https://github.com/kikito/middleclass) apis for using OOP functions in lua languege.    
middleclass is a powerful lua OOP library able to make class, inheritance, metamethods(operator overloading), class static variable(class variable) and weak mixin functions.   
it is at [JLib/Class/middleclass.lua](./JLib/Class/middleclass.lua)


Packages
---
- **Class**    
OOP library for lua. using middleclass.lua
- **LibGlobal**    
Global variables and methods using in CC_JLib. Environment variables and global static methods like sting function overloading
- **MathLib**    
Mathmetics library. Vector2, Vector3 is implemented
- **ReactorControl**    
Controls BigReactors mode reactor. PI controller for control inner energy buffer.
- **Screentext**    
very very simple api to display text on screen. like banners
- **UI**   
all modules used in drawing & calculating UI


How To Include
---
require [JLib/init.lua](./init.lua). JLib must be at /CC_JLib/JLib in absolute path in yout CC computer.    
Than, include all UI Headers(modules) by includeing UI.Include.lua

**example code**
```lua
-- register package.path CC_JLib path
require("CC_JLib.JLib.init")

-- include all UI modules in CC_JLib
require("UI.Include")
```

init.lua file has one local variable to select your running environment.    
In init.lua, Also you can add new Environment number of your own

**Init.lua**
```lua
-- select your environment
-- 0 : jasuk500, 1 : CC, 2 : replit.com
local environment = 0

if (environment == 0) then
    -- in another env
    package.path = package.path .. ";D:/lua/CC_JLib/JLib/?.lua"
    package.path = package.path .. ";/home/jisuk500/asdf/CC_JLib/JLib/?.lua"

    require("LibGlobal.LibVariables")
    JLib.LibVariables.static.ENVIRONMENT =
        JLib.LibVariables.static.eENVIRONMENT.Lua

elseif (environment == 1) then
    -- CC env
    package.path = package.path .. ";CC_JLib/JLib/?.lua"

    require("LibGlobal.LibVariables")
    JLib.LibVariables.static.ENVIRONMENT =
        JLib.LibVariables.static.eENVIRONMENT.CC

elseif (environment == 2) then
    -- replit env
    package.path = package.path .. ";/home/runner/CCsource/JLib/?.lua"

    require("LibGlobal.LibVariables")
    JLib.LibVariables.static.ENVIRONMENT =
        JLib.LibVariables.static.eENVIRONMENT.Lua

end
```

UI APIs
---
- UIElement    
abstract class for all UI element, virtual function 'render()' is included