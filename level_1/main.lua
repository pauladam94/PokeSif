Level = {}

function Level:change_level()
end

function Level:draw()
    return {
        pos = {
            x = 0,
            y = 0,
        },
        level = 0,
        number_sprite = false,
    }
end

return Level
