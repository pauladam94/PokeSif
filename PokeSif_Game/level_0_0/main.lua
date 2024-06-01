local level = {
    posx = 0,
    posy = 0,
    speed = 5,
    i = 0,
    transition = nil,
    direction = "up",
    time = 0,
    frame = 0
}

local g = GRASS
local w = WALL
local win = WINDOW
local background = {
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { win, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { win, g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
    { w,   g, g, g, g, g, g, g, g, g, g, g, g, g, g, g },
}

local colission = {
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    { true,  false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
}

function level:update(dt, keys_pressed)
    local result = {}
    if self.transition == nil then
        if keys_pressed.down then
            self.transition = { direction = "down", state = 0 }
        elseif keys_pressed.up then
            self.transition = { direction = "up", state = 0 }
        elseif keys_pressed.left then
            self.transition = { direction = "left", state = 0 }
        elseif keys_pressed.right then
            self.transition = { direction = "right", state = 0 }
        end
    end
    if self.transition ~= nil then
        self.direction = self.transition.direction
        self.transition.state = self.transition.state + dt * self.speed
        if self.transition.state > 1 then
            self.posx = self.posx + Posx(self.transition.direction)
            self.posy = self.posy + Posy(self.transition.direction)
            self.transition = nil
        end
    end

    self.i = self.i + 1;

    self.time = self.time + dt
    self.frame = math.floor((self.time % 1) * 4)

    if self.posy >= 16 then
        result.next_level_direction = "down"
    elseif self.posx >= 16 then
        result.next_level_direction = "right"
    end

    return result
end

function level:draw()
    require "utils"
    local result = {}
    InsertBackground(result, background)
    local sprites = {
        CHARACTER_1_UP_1,
        CHARACTER_1_DOWN_1,
        CHARACTER_1_LEFT_1,
        CHARACTER_1_RIGHT_1
    }
    if self.transition == nil then
        table.insert(result,
            {
                x = self.posx * 16,
                y = self.posy * 16,
                sprite = CHARACTER_1,
                sub_sprite = sprites[DirToInt(self.direction)] + self.frame
            })
    else
        table.insert(result,
            {
                x = self.posx * 16 +
                    Posx(self.transition.direction) * self.transition.state * 16,
                y = self.posy * 16 +
                    Posy(self.transition.direction) * self.transition.state * 16,
                sprite = CHARACTER_1,
                sub_sprite = sprites[DirToInt(self.direction)] + self.frame
            })
    end
    return result
end

return level
