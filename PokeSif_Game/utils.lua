function Posx(direction)
    if direction == "left" then
        return -1
    elseif direction == "right" then
        return 1
    end
    return 0
end

function Posy(direction)
    if direction == "up" then
        return -1
    elseif direction == "down" then
        return 1
    end
    return 0
end

function InsertBackground(result, background)
    for x = 1, 16 do
        for y = 1, 16 do
            table.insert(result,
                {
                    x = (x - 1) * 16,
                    y = (y - 1) * 16,
                    sprite = background[y][x]
                })
        end
    end
end

function DirToInt(direction)
    if direction == "up" then
        return 1
    elseif direction == "down" then
        return 2
    elseif direction == "left" then
        return 3
    elseif direction == "right" then
        return 4
    end
end
