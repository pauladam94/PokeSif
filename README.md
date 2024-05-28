# PokeSif
Fully Extendable Game made with Löve-Lua.

## Game rules
- Fixed Size Window : 512 * 512
- Each level is located in one file

# Levels
- Each level is located in ONE file and only ONE lua file.
- No love API can be used

The file will be run at the beginning of each frame.

# API for levels

level_table is storing the current table of a level.

## Persistence of data for ONE level
The current table of the level can hold any value and this will stay persistent
the whole level.

## Change level :
> describe how to change the level when out of bounds
change_level(level,

## Draw Sprites :
- Return a table of sprite to draw in this format :
```lua
{
  { x, y, level, number_sprite },
  { x, y, level, number_sprite },
  ... -- 300 max
}
```
- 0 < x : float <= 16
- 0 < y : float <= 16
- 1<= level_sprite : int <= current_level
- 1 <= number_sprites : int <= 2

## Rules inside Level Functions :
- NO use of io/filesytem
- NO use of love function
- functions should not crash (or it will crash the game)

# Map :
512 * 512
8*8 sprite are draw in 32*32.

# Is there a global state of the game ?
So that there can be state about ?

- [Pixel Art Online](https://www.piskelapp.com/p/create/sprite)

# Development Stuff
- Hot Reload : press "r"

# TODO
- text printing (once per level, static 10 character string)
  - find nice font.
  - on
- Level Transition (hard part)
  - capture the frame
  - generate next frame
  - do a slide
