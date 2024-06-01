-- this draw complete table to the screen into a theoretical 256 * 256 screen
function DRAW_TABLE(frame_info, dx, dy)
    for _, sprite_info in pairs(frame_info) do
        sprite_info.scale = sprite_info.scale or 1
        if sprite_info.sub_sprite == nil then
            love.graphics.draw(
                SPRITES[sprite_info.sprite],
                (sprite_info.x + dx) * WIDTH / 256,
                (sprite_info.y + dy) * HEIGHT / 256,
                0,
                SCALE_FACTOR * sprite_info.scale,
                SCALE_FACTOR * sprite_info.scale)
        else
            love.graphics.draw(
                SPRITES[sprite_info.sprite],
                SPRITES[sprite_info.sub_sprite],
                (sprite_info.x + dx) * WIDTH / 256,
                (sprite_info.y + dy) * HEIGHT / 256,
                0,
                SCALE_FACTOR * sprite_info.scale,
                SCALE_FACTOR * sprite_info.scale)
        end
    end
end

function love.load()
    love.graphics.setFont(love.graphics.newFont("assets/m04.TTF", 13))
    love.graphics.setDefaultFilter("nearest", "nearest")
    EXISTING_LEVEL = require "all_existing_levels"
    SCALE_FACTOR = love.graphics.getHeight() / 256
    HEIGHT = love.graphics.getHeight()
    WIDTH = love.graphics.getWidth()
    GLOBAL_STATE = {}
    CHANGE_LEVEL = function(direction)
        CurrentLevel.y = CurrentLevel.y + Posy(direction)
        CurrentLevel.x = CurrentLevel.x + Posx(direction)
    end
    SPRITE_HEIGHT = 8
    SPRITE_WIDTH = 8
    SOUND = {}
    SPRITES = require "sprite_load"
    SPEED_TRANSITION = 1
    PrecedentDraw = nil
    NextDraw = nil
    TransitionState = nil
    TransitionDirection = nil
    FrameInfo = nil
    CurrentLevel = { x = 0, y = 0 }
    LevelLogic = dofile("PokeSif_Game/level_" ..
        tostring(CurrentLevel.x) .. "_" .. tostring(CurrentLevel.y) .. "/main.lua")
    KeysPressed = {
        up = false,
        down = false,
        left = false,
        right = false,
        space = false,
        x = false,
    }
    if love.keypressed("escape") then
        love.window.close()
    end
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
        FrameInfo = LevelLogic:update(dt, KeysPressed)
    end
    if FrameInfo.sound ~= nil then
        love.audio.play(SOUND[FrameInfo.sound])
    end
    -- change level
    if FrameInfo.next_level_direction ~= nil then
        CHANGE_LEVEL(FrameInfo.next_level_direction)
        TransitionDirection = FrameInfo.next_level_direction
        FrameInfo.next_level_direction = nil
        TransitionState = 0
    end
    -- Hot ReLoading the Level
    if TransitionState == 0 or love.keyboard.isDown("r") then
        LevelLogic = dofile("PokeSif_Game/level_"
            .. tostring(CurrentLevel.x) .. "_"
            .. tostring(CurrentLevel.y) .. "/main.lua")
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
        DRAW_TABLE(PrecedentDraw,
            -Posx(TransitionDirection) * TransitionState * 256,
            -Posy(TransitionDirection) * TransitionState * 256
        )
        DRAW_TABLE(NextDraw,
            -Posx(TransitionDirection) * 256 * (TransitionState - 1),
            -Posy(TransitionDirection) * 256 * (TransitionState - 1)
        )
    end
    if love.keyboard.isDown("escape") then
        love.window.close()
    end
end
