local sprites            = {}

GRASS                    = 1
WALL                     = 2
BASIC_CHARACTER          = 3
WINDOW                   = 4
CHARACTER_1              = 5

sprites[GRASS]           = love.graphics.newImage("assets/1.png")
sprites[WALL]            = love.graphics.newImage("assets/2.png")
sprites[BASIC_CHARACTER] = love.graphics.newImage("assets/3.png")
sprites[WINDOW]          = love.graphics.newImage("assets/4.png")
sprites[CHARACTER_1]     = love.graphics.newImage("assets/5.png")

CHARACTER_1_UP_1         = 6
CHARACTER_1_UP_2         = 7
CHARACTER_1_UP_3         = 8
CHARACTER_1_UP_4         = 9
for i = 6, 9 do
    sprites[i] = love.graphics.newQuad((i - 6) * 16, 0, 16, 16, sprites[CHARACTER_1])
end

CHARACTER_1_LEFT_1 = 10
CHARACTER_1_LEFT_2 = 11
CHARACTER_1_LEFT_3 = 12
CHARACTER_1_LEFT_4 = 13
for i = 10, 13 do
    sprites[i] = love.graphics.newQuad((i - 10) * 16, 16, 16, 16, sprites[CHARACTER_1])
end

CHARACTER_1_DOWN_1 = 14
CHARACTER_1_DOWN_2 = 15
CHARACTER_1_DOWN_3 = 16
CHARACTER_1_DOWN_4 = 17
for i = 14, 17 do
    sprites[i] = love.graphics.newQuad((i - 14) * 16, 16 * 2, 16, 16, sprites[CHARACTER_1])
end

CHARACTER_1_RIGHT_1 = 18
CHARACTER_1_RIGHT_2 = 19
CHARACTER_1_RIGHT_3 = 20
CHARACTER_1_RIGHT_4 = 21
for i = 18, 21 do
    sprites[i] = love.graphics.newQuad((i - 18) * 16, 16 * 3, 16, 16, sprites[CHARACTER_1])
end

ROAD_UP = 22
sprites[ROAD_UP] = love.graphics.newImage("assets/6.png")

EARTH = 23
sprites[EARTH] = love.graphics.newImage("assets/earth.png")

return sprites
