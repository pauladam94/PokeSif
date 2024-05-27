local level = {}

function level:change_level()
end

function level:draw()

    return {
        pos = {
            x = 0,
            y = 0,
        },
        level = 0,
        number_sprite = false,
    }
end

return level
