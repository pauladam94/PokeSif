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

## How to Run the Game
Executable for each platform are located in `bin/`
- there is only the one for linux

In a console use the binary of your platform 
(here we suppose it is called love) and run :
- In the directory of this repositorie (no other place)
```bash
chmod +x bin/love-11.5-x86_64.AppImage
```

To run the gartic phone idea game :
```bash
./bin/love-11.5-x86_64.AppImage Gartic_Phone_Idea
```

To run PokeSIF game :
```bash
./bin/love-11.5-x86_64.AppImage PokeSif_Game
```

## Classic workflow to Run the Game

### On Linux
```bash
git clone /link/to/repo
cd PokeSif
chmod +x bin/love-11.5-x86_64.AppImage
./bin/love-11.5-x86_64.AppImage ../PokeSif
```

### ON Windows
TODO
### On MacOS
TODO
### WebVersion 
This should work and run the current game implemented in the levels file.

# TODO
- text printing (once per level, static 10 character string)
  - find nice font.
- online multiplayer ?
