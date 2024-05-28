function love.load()
    love.graphics.setFont(love.graphics.newFont("/assets/Minecraft.ttf", 15))
    love.graphics.setDefaultFilter("nearest", "nearest")
    MAX_LEVEL = 2
    SCALE_FACTOR = 4
    HEIGHT = love.graphics.getHeight()
    WIDTH = love.graphics.getWidth()
    CHANGE_LEVEL = function(level, direction)
        if level == 1 then
            return 2
        else
            return 1
        end
    end
    SPRITE_HEIGHT = 8
    SPRITE_WIDTH = 8
    BOUNDS = {
        x = { min = 0, max = WIDTH / (SPRITE_WIDTH * SCALE_FACTOR) - 1 },
        y = { min = 0, max = WIDTH / (SPRITE_WIDTH * SCALE_FACTOR) - 1 },
        level_number = { min = 1, max = MAX_LEVEL },
        sprite_number = { min = 1, max = 2 }
    }
    SPRITE = {}
    SOUND = {}
    for i = 1, MAX_LEVEL do
        SPRITE[i] = {
            love.graphics.newImage("level_" .. tostring(i) .. "/sprite_1.png"),
            love.graphics.newImage("level_" .. tostring(i) .. "/sprite_2.png"),
        }
        SOUND[i] = love.audio.newSource("level_" .. tostring(i) .. "/sound.mp3", "static")
    end
    CurrentLevel = 1
    EnteringLevel = false
    LevelLogic = dofile("level_" .. tostring(CurrentLevel) .. "/main.lua")
    KeysPressed = {
        up = false,
        down = false,
        left = false,
        right = false,
        space = false,
        x = false,
    }
end

function love.keyreleased(key)
    if KeysPressed[key] ~= nil then
        KeysPressed[key] = false
    end
end

function love.keypressed(key)
    if KeysPressed[key] ~= nil then
        KeysPressed[key] = true
    end
end

function love.update(dt)
    -- Get Frame Info from the level
    local frame_info = LevelLogic:update(dt, KeysPressed, BOUNDS)
    if frame_info.sound ~= nil then
        love.audio.play(SOUND[frame_info.sound])
    end

    -- change level
    if frame_info.next_level_direction ~= nil then
        CurrentLevel = CHANGE_LEVEL(
            CurrentLevel,
            frame_info.next_level_direction
        )
        EnteringLevel = true
    end

    -- Hot ReLoading the Level
    if EnteringLevel or love.keyboard.isDown("r") then
        LevelLogic = {}
        LevelLogic = dofile("level_" .. tostring(CurrentLevel) .. "/main.lua")
        EnteringLevel = false
    end
end

function love.draw()
    local draw_frame_info = LevelLogic:draw()
    assert(#LevelLogic <= 300)
    for _, sprite_info in pairs(draw_frame_info) do
        assert(
            sprite_info.sprite_number == BOUNDS.sprite_number.min or
            sprite_info.sprite_number == BOUNDS.sprite_number.max
        )
        assert(
            sprite_info.level_number >= BOUNDS.level_number.min and
            sprite_info.level_number <= CurrentLevel
        )
        assert(sprite_info.x <= HEIGHT / (SCALE_FACTOR * SPRITE_HEIGHT))
        assert(sprite_info.y <= WIDTH / (SCALE_FACTOR * SPRITE_WIDTH))
        assert(sprite_info.x >= 0)
        assert(sprite_info.y >= 0)
        love.graphics.draw(
            SPRITE[sprite_info.level_number][sprite_info.sprite_number],
            sprite_info.x * SCALE_FACTOR * SPRITE_WIDTH,
            sprite_info.y * SCALE_FACTOR * SPRITE_HEIGHT,
            0,
            SCALE_FACTOR,
            SCALE_FACTOR
        )
    end
    if love.keyboard.isDown("escape") then
        love.window.close()
    end
end
