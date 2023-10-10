--[[
    CS50 2018
    point Class
    Author: Evan Frankel
    esfbbmc@gmail.com
    Responsible for each barrier that the player must avoid to gain points and stay alive.
]]

point = Class{}

function point:init(a,lanes,i)

    self.lanes = lanes

    -- determine width of barrier depending on how many lanes there are
    self.width = VIRTUAL_WIDTH / lanes / 2

    -- a is randomly 1 or 2 so randomly choose which side barrier will spawn on
    if a == 1 then
        self.x = ((i-1)*(VIRTUAL_WIDTH / lanes)) + self.width
    else
        self.x = ((i-1)*(VIRTUAL_WIDTH / lanes))
    end

    self.y = 0

    self.timer = 0

    self.onright = false

    if a == 1 then
        self.onright = true
    end

    self.pointflag = true
end



function point:update(dt)
    self.timer = self.timer + dt

    -- barriers will continuously move down on the screen, faster over time.
    if self.y > -12 then
        self.y = self.y + 60 * dt + 0.04 * TIMER
    else
        self.remove = true
    end
end

function point:render()

    -- render each barrier onto the screen
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', self.x, self.y, self.width, 12)

    love.graphics.setColor(255, 255, 255)
end