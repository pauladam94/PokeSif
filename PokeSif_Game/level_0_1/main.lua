local level = {
    posx = 0,
    posy = 0,
    speed = 50,
    i = 0,
}

local g = GRASS
local w = WALL
local background = {
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
}

function level:update(dt, keys_pressed)
    local result = {}
    if keys_pressed.down then
        self.posy = self.posy + self.speed * dt
    end
    if keys_pressed.up then
        self.posy = self.posy - self.speed * dt
    end
    if keys_pressed.left then
        self.posx = self.posx - self.speed * dt
    end
    if keys_pressed.right then
        self.posx = self.posx + self.speed * dt
    end
    if self.posx < 0 then
        self.posx = 0
    end
    if self.posy < 0 then
        self.posy = 0
    end
    if self.posx > 256 - 16 then
        self.posx = 256 - 16
    end
    if self.posy > 256 - 16 then
        self.posy = 256 - 16
    end

    if self.i >= 200 then
        result.next_level_direction = "up"
    end
    self.i = self.i + 1;
    if self.i % 100 == 0 then
        result.sound = 1;
    end
    return result
end

function level:draw()
    local result = {}

    InsertBackground(result, background)
    table.insert(result,
        {
            x = self.posx,
            y = self.posy,
            sprite = BASIC_CHARACTER
        })
    return result
end

return level
