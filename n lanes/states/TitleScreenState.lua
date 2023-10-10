--[[
    CS50 2018
    TitleScreenState Class
    Author: Evan Frankel
    esfbbmc@gmail.com
    The TitleScreenState is the starting screen of the game, shown on startup. It should
    display the flickering enter suggestion as well as an option for choosing the number
    of lanes the user wishes to include in their play session.
]]

TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()

    -- flashing enter symbol
    self.playsign = PlaySign()

    -- n starts at one and player will be able to increase or decrease it
    self.n = 1

    --light level for the n up and down arrows
    self.lightb = 0
    self.lightt = 0

    self.lanecap = 10
end

function TitleScreenState:update(dt)

    -- when player presses enter, transition to the main play state
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('lane', self.n)
    end

    -- increment n when player hits up arrow
    if love.keyboard.wasPressed('up') then
        if self.n < self.lanecap then
            self.n = self.n + 1
        end
    end

    -- decrement n when player hits down arrow
    if love.keyboard.wasPressed('down') then
        if self.n > 1 then
            self.n = self.n - 1
        end
    end

    -- if n cannot be decreased or cannot be increased, lower light level of respective arrow
    if self.n > 1 then
        self.lightb = 255
    else 
        self.lightb = 100
    end

    if self.n < self.lanecap then
        self.lightt = 255
    else
        self.lightt = 100
    end

    self.playsign:update(dt)
    self.playsign:render()
end

function TitleScreenState:render()

    -- display game title
    love.graphics.setColor(0,0,0,255)
    love.graphics.setFont(bigFont)
    love.graphics.printf('n Lanes', 0, 64, VIRTUAL_WIDTH, 'center')

    -- display n, which the player can change
    love.graphics.setFont(smallFont)
    love.graphics.printf('n = ' .. tostring(self.n), 0, 110, VIRTUAL_WIDTH, 'center')

    -- create the n arrows
    love.graphics.setColor(0,0,0,self.lightt)
    love.graphics.polygon('fill', 270, 110, 273.5, 105, 276, 110)

    love.graphics.setColor(0,0,0,self.lightb)
    love.graphics.polygon('fill', 270, 126, 273.5, 131, 276, 126)

    self.playsign:render()
end