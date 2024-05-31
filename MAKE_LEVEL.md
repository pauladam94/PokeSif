# Data Types
```lua
-- 1 <= level_number : integer <= current_level
-- 0 <= x : float <= 16
-- 0 <= y : float <= 16
-- 1 <= sprite_number : int <= 2
-- 
update_info {
  -- nil means no sound
  sound = level_number | nil,
  -- nil means that we stay in the current level
  next_level_direction = "up" | "down" | "left" | "right" | nil
}

frame_info {
  {
    x,
    y,
    level_number,
    sprite_number
  }
  {
    x,
    y,
    text,
  }
  ,
  ... -- max 300 of them
  {x, y, level_number, sprite_number} 
}
```

# What a level should contain
```lua
local level = {
  text_intro = string -- max 10th characters
  level:update(dt, keys_pressed, bounds) -> update_info
  level:draw(bounds) -> frame_info
}
```


## Rules inside Level Functions :
- NO use of io/filesytem
- NO use of love function
- functions should not crash (or it will crash the game)

