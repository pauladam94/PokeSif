# PokeSif
Fully Extendable Game made with Löve-Lua.

## Levels
- Each level is located in ONE file and only ONE lua file.
- No love API can be used
- The file will be run at the beginning of each frame.
See [MAKE_LEVEL.md](MAKE_LEVEL.md) for more information about the level.

- Website to do pixel Art : [Pixel Art Online](https://www.piskelapp.com/p/create/sprite)
- Audacity works well for doing short sound fast.

## Development Stuff
- Hot Reload A Level : just press "r"

## How to build
Executable for each platform are located in `bin/`
(not yet, you can find one in the [Love2D Website]())

In a console use the binary of your platform 
(here we suppose it is called love) and run :
- In the directory PokeSif of :this repositorie (no other place)
```bash
love ../PokeSif
```

## Classic workflow to Run the Game

```bash
git clone /link/to/repo
cd PokeSif
bin/binary/for/your/os ../PokeSif
```

This should work and run the current game implemented in the levels file.

# TODO
- text printing (once per level, static 10 character string)
  - find nice font.
