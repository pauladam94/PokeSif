# PokeSif
Fully Extendable Game made with Löve-Lua.

## Defining feature
- pixel art game

## Game rules
Fixed Size Window :
- must be a power of two (probably 512 * 512)

# Levels
- Each level is located in ONE file and only ONE lua file.
- anything love propose is possible to be used
    - EXCEPT : love.window stuff
    - EXCETP : 
The file should only have pure function.

The file will be run at the beginning of each

# API for levels

level_table is storing the current table of a level.

## Persistence of data for ONE level
The current table of the level can hold any value and this will stay persistent
the whole level.

## Change level :
> describe how to change the level when out of bounds
change_level(level,

## Draw Sprites :
> describe what to draw at a given moment
- return a table (of max size 100 to see)

eacht element os this table contains :
- position for the sprite to be draw

{
  {x, y},
  level,
  number_sprite
}

### Conditions :
- 0 < x <= widht
- 0 < y <= height
- 
- number_sprites (false | true)

## Allowed behavior in level :
- send

## Rules inside Level Functions :
- NOT any use of io
- NOT use of the filesytem
- NOT any use of love function
- functions should not crash

## How the map is defined :

# Is there a global state of the game ?
So that there can be state about ?

- [Pixel Art Online](https://www.piskelapp.com/p/create/sprite)

# TODO
- sound (1s sound per level, can be played at any frame)
  - return by the update function
- text printing (once per level, static 10 character string)
- transition between level
  - level transition
