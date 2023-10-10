--[[
    CS50 2018
    ScoreState Class
    Author: Evan Frankel
    esfbbmc@gmail.com
    Responsible for the game state once the player has lost in a game session.
    Displays the score they acquired during the session and offers a route
    to play again.
]]

ScoreState = Class{__includes = BaseState}

-- When we transition to score state, we expect the player to have played
-- and earned a score that we pass on so we can render it here.
function ScoreState:enter(score,i)
    self.score = score
    self.i = i
end

function ScoreState:update(dt)

    -- go back to title screen if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('title')
    end
end

function ScoreState:render()

    love.graphics.setColor(0,0,0,255)
    
    -- display "Oof! You lost!"
    love.graphics.setFont(bigFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    -- display the score that the player acquired
    love.graphics.setFont(smallFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    -- prompt the user to press enter to play again
    love.graphics.printf('Press Enter to Return to Title!', 0, 185, VIRTUAL_WIDTH, 'center')
end

