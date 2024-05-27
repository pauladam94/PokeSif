local level = {
    posx = 0,
    posy = 0,
    speed = 5
}

function level:change_level()
end

function level:update(dt, keys_pressed)
    if keys_pressed.down then
        level.posy = level.posy + level.speed * dt
    end
    if keys_pressed.up then
        level.posy = level.posy - level.speed * dt
    end
    if keys_pressed.left then
        level.posx = level.posx - level.speed * dt
    end
    if keys_pressed.right then
        level.posx = level.posx + level.speed * dt
    end

    if level.posx < 0 then
        level.posx = 0
    end
    if level.posy < 0 then
        level.posy = 0
    end
end

function level:draw()
    local result = {}
    for x = 0, 15 do
        for y = 0, 15 do
            result[x + y * 16] = {
                x = x,
                y = y,
                level = 1,
                number_sprite = 1
            }
        end
    end
    result[257] = {
        x = level.posx,
        y = level.posy,
        level = 1,
        number_sprite = 2
    }
    return result
end

return level
