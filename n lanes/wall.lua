--[[
    CS50 2018
    wall Class
    Author: Evan Frankel
    esfbbmc@gmail.com
    Responsible for visually dividing the screen into lanes
]]

wall = Class{}

function wall:init(x)

    --take input and place the wall according to which lane is creating it.
    if x == 0 then
        self.x = x - 4
    else
        self.x = x - 2
    end
    
    self.y = 0

    self.timer = 0
end



function wall:update(dt)
    self.timer = self.timer + dt

    
end

function wall:render()

    -- render the wall onscreen
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', self.x, self.y, 4, VIRTUAL_HEIGHT)

    love.graphics.setColor(255, 255, 255)
end