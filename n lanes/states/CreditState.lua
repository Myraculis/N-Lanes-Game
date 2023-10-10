--[[
    CS50
    Credit State
    Author: Evan Frankel
    esfbbmc@gmail.com
    Opens the game in like "made by this studio" style with my name
]]

CreditState = Class{__includes = BaseState}

-- takes 1 second to count down each time
COUNTDOWN_TIME = 0.1

function CreditState:init()
    self.count = 3
    self.timer = 0
    self.flag = true

    -- light level for the credit sign
    self.light = 0
end


function CreditState:update(dt)
    self.timer = self.timer + dt

    -- light level of the "Made By: Evan Frankel" increases so it looks like a fade
    if self.timer > COUNTDOWN_TIME and self.flag == true then
        self.timer = self.timer % COUNTDOWN_TIME
        self.light = self.light + 10

        if self.light == 250 then
            self.flag = false
        end
    end

    -- light level of the "Made By: Evan Frankel" decreases so it looks like a fade
    if self.timer > COUNTDOWN_TIME and self.flag == false then
        self.timer = self.timer % COUNTDOWN_TIME
        self.light = self.light - 10

        -- when credit animation is finished, change to title screen
        if self.light == 0 then
            gStateMachine:change('title')
        end
    end
end


function CreditState:render()
    -- render "Made By: Evan Frankel" according to the increasing and decreasing light level
    love.graphics.setFont(hugeFont)
    love.graphics.setColor(0,0,0,self.light)
    love.graphics.printf("Made by:", 0, 80, VIRTUAL_WIDTH, 'center')
    love.graphics.printf("Evan Frankel", 0, 140, VIRTUAL_WIDTH, 'center')
end