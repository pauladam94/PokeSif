function love.load()
    love.graphics.setFont(love.graphics.newFont("/assets/Minecraft.ttf", 15))
    love.graphics.setDefaultFilter("nearest", "nearest")
    MAX_LEVEL = 1
    SCALE_FACTOR = 4
    SPRITE = {}
    HEIGHT = love.graphics.getHeight()
    WIDTH = love.graphics.getWidth()
    SPRITE_HEIGHT = 8
    SPRITE_WIDTH = 8
    for i = 1, MAX_LEVEL do
        SPRITE[i] = {
            love.graphics.newImage("level_" .. tostring(i) .. "/sprite_1.png"),
            love.graphics.newImage("level_" .. tostring(i) .. "/sprite_2.png"),
        }
    end
    CurrentLevel = 1
    EnteringLevel = true
    LevelLogic = {}
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
    -- Loading the level
    if EnteringLevel then
        LevelLogic = require("/level_" .. tostring(CurrentLevel) .. "/main")
        EnteringLevel = false
    end
    -- Changing the current Level
    if LevelLogic == nil then
        -- when the level doesn't exist
        love.graphics.print(
            "You finished the game",
            WIDTH / 2,
            love.graphics.getHeight / 2
        )
    elseif LevelLogic.change_level ~= nil then
        LevelLogic.change_level(LevelLogic)
    end
    LevelLogic:update(dt, KeysPressed)
end

function love.draw()
    local draw_table = LevelLogic:draw()
    assert(#LevelLogic <= 300)
    for _, sprite_info in pairs(draw_table) do
        assert(sprite_info.number_sprite == 1 or sprite_info.number_sprite == 2)
        assert(sprite_info.level >= 1 and sprite_info.level <= CurrentLevel)
        assert(sprite_info.x <= HEIGHT / SCALE_FACTOR)
        assert(sprite_info.y <= WIDTH / SCALE_FACTOR)
        assert(sprite_info.x >= 0)
        assert(sprite_info.y >= 0)
        love.graphics.draw(
            SPRITE[sprite_info.level][sprite_info.number_sprite],
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
