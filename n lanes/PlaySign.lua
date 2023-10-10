--[[
    CS50 2018
    PlaySign Class
    Author: Evan Frankel
    esfbbmc@gmail.com
    Responsible for the flickering enter symbol
]]

PlaySign = Class{}

function PlaySign:init()

    -- enter sign is an "enter" image.
    self.image = love.graphics.newImage('enter.png')
    self.x = 156
    self.y = 80

    -- variable for how opaque the sign will be.
    self.light = 0

    self.timer = 0

end



function PlaySign:update(dt)

    -- have light level of the sign fluxuate for aesthetic effect.
    self.timer = self.timer + dt*5
    self.light = 255 * math.abs(math.sin(0.5 * self.timer))
end

function PlaySign:render()

    -- set color and opaqueness and then render the enter sign image.
    love.graphics.setColor(255, 255, 255, self.light)
    love.graphics.draw(self.image, self.x, self.y)
    love.graphics.setColor(255, 255, 255)
end