local level = {
    intro_text = "Wtf is this game ?",
    posx = 0,
    posy = 0,
    speed = 5,
    i = 0,
}

function level:update(dt, keys_pressed, bounds)
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
    if self.posx > bounds.x.max then
        self.posx = bounds.x.max
    end
    if self.posy > bounds.y.max then
        self.posy = bounds.y.max
    end
    if self.i >= 200 then
        result.next_level_direction = "down"
    end
    self.i = self.i + 1;
    if self.i % 100 == 0 then
        result.sound = 1;
    end
    return result
end

function level:draw(bounds)
    local result = {}
    for x = 0, 15 do
        for y = 0, 15 do
            result[x + y * 16] = {
                x = x,
                y = y,
                level_number = 1,
                sprite_number = 1
            }
        end
    end
    result[257] = {
        x = self.posx,
        y = self.posy,
        level_number = 1,
        sprite_number = 2
    }
    return result
end

return level
