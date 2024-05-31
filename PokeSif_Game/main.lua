function DRAW_TABLE(frame_info, dx, dy, in_transition)
    -- assert(#frame_info <= 300)
    for _, sprite_info in pairs(frame_info) do
        assert(
            sprite_info.sprite_number == BOUNDS.sprite_number.min or
            sprite_info.sprite_number == BOUNDS.sprite_number.max
        )
        if not in_transition then
            assert(
                sprite_info.level_number >= BOUNDS.level_number.min and
                sprite_info.level_number <= CurrentLevel
            )
        end
        assert(sprite_info.x <= HEIGHT / (SCALE_FACTOR * SPRITE_HEIGHT))
        assert(sprite_info.y <= WIDTH / (SCALE_FACTOR * SPRITE_WIDTH))
        assert(sprite_info.x >= 0)
        assert(sprite_info.y >= 0)

        love.graphics.draw(
            SPRITE[sprite_info.level_number][sprite_info.sprite_number],
            (sprite_info.x + dx) * SCALE_FACTOR * SPRITE_WIDTH,
            (sprite_info.y + dy) * SCALE_FACTOR * SPRITE_HEIGHT,
            0,
            SCALE_FACTOR,
            SCALE_FACTOR
        )
    end
end

function love.load()
    love.graphics.setFont(love.graphics.newFont("assets/m04.TTF", 13))
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
        SOUND[i] = love.audio.newSource(
            "level_" .. tostring(i) .. "/sound.mp3", "static")
    end
    SPEED_TRANSITION = 0.5
    PrecedentDraw = nil
    NextDraw = nil
    TransitionState = nil
    TransitionDirection = nil

    FrameInfo = nil
    CurrentLevel = 1
    -- same behavior as the line below
    -- LevelLogic = loadfile("level_" .. tostring(CurrentLevel) .. "/main.lua")
    -- LevelLogic = LevelLogic()
    LevelLogic = dofile("../level_" .. tostring(CurrentLevel) .. "/main.lua")
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
    if TransitionState == nil then
        FrameInfo = LevelLogic:update(dt, KeysPressed, BOUNDS)
    end
    if FrameInfo.sound ~= nil then
        love.audio.play(SOUND[FrameInfo.sound])
    end

    -- change level
    if FrameInfo.next_level_direction ~= nil then
        CurrentLevel = CHANGE_LEVEL(
            CurrentLevel,
            FrameInfo.next_level_direction
        )
        TransitionDirection = FrameInfo.next_level_direction
        FrameInfo.next_level_direction = nil
        TransitionState = 0
    end

    -- Hot ReLoading the Level
    if TransitionState == 0 or love.keyboard.isDown("r") then
        LevelLogic = dofile("level_" .. tostring(CurrentLevel) .. "/main.lua")
        NextDraw = LevelLogic:draw()
    end

    -- Update Transition state
    if TransitionState ~= nil then
        TransitionState = TransitionState + dt * SPEED_TRANSITION
    end

    -- End of transition
    if TransitionState ~= nil and TransitionState >= 1 then
        TransitionState = nil
    end
end

function love.draw()
    if TransitionState == nil then
        PrecedentDraw = LevelLogic:draw()
        DRAW_TABLE(PrecedentDraw, 0, 0)
    else
        if TransitionDirection == "up" then
            DRAW_TABLE(PrecedentDraw, 0, TransitionState * 16, true)
            DRAW_TABLE(NextDraw, 0, TransitionState * 16 - 16, true)
        elseif TransitionDirection == "down" then
            DRAW_TABLE(PrecedentDraw, 0, -TransitionState * 16, true)
            DRAW_TABLE(NextDraw, 0, -TransitionState * 16 + 16, true)
        elseif TransitionDirection == "left" then
            DRAW_TABLE(PrecedentDraw, -TransitionState * 16, 0, true)
            DRAW_TABLE(NextDraw, -TransitionState * 16 + 16, 0, true)
        elseif TransitionDirection == "right" then
            DRAW_TABLE(PrecedentDraw, TransitionState * 16, 0, true)
            DRAW_TABLE(NextDraw, TransitionState * 16 - 16, 0, true)
        end
    end

    -- love.graphics.print("ABCDEFGHUIJ", 0, 0)
    -- love.graphics.print("First Level here blabla", 10, 10)
    -- love.graphics.print("azertyuiopqsdfghjklmwxcvbn", 10, 100)
    -- love.graphics.print("1234567890", 10, 200)
    if love.keyboard.isDown("escape") then
        love.window.close()
    end
end
