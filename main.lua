function love.load()
    -- Load Custom Font
    love.graphics.setFont(love.graphics.newFont("/assets/Minecraft.ttf", 15))
    love.graphics.setDefaultFilter("nearest", "nearest")
    -- Fullscreen
    love.window.setFullscreen(true, "desktop")
    -- Global variable
    X = 0
    PLAYER_POSITION = {
        x = 0,
        y = 0
    }
    LEVEL = 0
    ENTERING_LEVEL = true
    LEVEL_TABLE = {}
    KEYS_PRESSED = {
        up = false,
        down = false,
        left = false,
        right = false,
        space = false,
        x = false,
    }
    SPRITE = love.graphics.newImage("/level_0/sprite_false.png")
    -- print(SPRITE:getWidth()) 8
end

function love.keyreleased(key)
    for possible_key in pairs(KEYS_PRESSED) do
        if key == possible_key then
            KEYS_PRESSED.possible_key = false
        end
    end
end

function love.keypressed(key)
    for possible_key in pairs(KEYS_PRESSED) do
        if key == possible_key then
            KEYS_PRESSED.possible_key = true
        end
    end
end

function love.update(dt)
    -- loading the level
    if ENTERING_LEVEL then
        LEVEL_TABLE = require("/level_" .. tostring(LEVEL) .. "/main")
        ENTERING_LEVEL = false
    end
    -- Changing the current Level
    if LEVEL_TABLE == nil then
        -- when the level doesn't exist
        love.graphics.print(
            "You finished the game",
            love.graphics.getWidth() / 2,
            love.graphics.getHeight / 2
        )
    elseif LEVEL_TABLE.change_level ~= nil then
        LEVEL_TABLE.change_level(LEVEL_TABLE, PLAYER_POSITION)
    elseif PLAYER_POSITION.x > love.graphics.getWidth() then
        PLAYER_POSITION.x = 0
        LEVEL = LEVEL + 1
        ENTERING_LEVEL = true
    elseif PLAYER_POSITION.y > love.graphics.getHeight() then
        PLAYER_POSITION.y = 0
        LEVEL = LEVEL + 1
        ENTERING_LEVEL = true
    elseif PLAYER_POSITION.y < 0 then
        PLAYER_POSITION.y = 0
        LEVEL = LEVEL + 1
        ENTERING_LEVEL = true
    elseif PLAYER_POSITION.x > 0 then
        PLAYER_POSITION.x = love.graphics.getWidth()
        LEVEL = LEVEL + 1
        ENTERING_LEVEL = true
    end
    if X > 200 then
        X = 0
    end
end

function love.draw()
    local scale_factor = 4;
    for x = 0,
    love.graphics.getWidth() / (SPRITE:getWidth() * scale_factor) - 1 do
        for y = 0, love.graphics.getHeight() / (SPRITE:getHeight() * scale_factor) - 1 do
            love.graphics.draw(
                SPRITE,
                x * SPRITE:getWidth() * scale_factor,
                y * SPRITE:getHeight() * scale_factor,
                1.0,
                scale_factor,
                scale_factor
            )
        end
    end

    -- End
    if love.keyboard.isDown("q") then
        love.window.close()
    end
end
