--[[
    CS50 2018 
    LaneState Class
    Author: Evan Frankel
    esfbbmc@gmail.com
    Essentially the game state in which the game is played. Creates and contains and controls
    each game object while the game is being played.
]]

LaneState = Class{__includes = BaseState}


function LaneState:enter(lanes)
    self.timer = 0

    TIMER = 0
    SCORE = 0

    -- create and population an array of 
    -- lanes according to the n that the player 
    -- chose, and let each lane know which one it is.
    self.lanes = {}
    for i = 1,lanes,1 do
        table.insert(self.lanes, lane(lanes,i))
    end

end


function LaneState:update(dt)

    TIMER = TIMER + dt

    -- update each lane in the array of lanes 
    for k, lane in pairs(self.lanes) do
        lane:update(dt)
    end

    
end


function LaneState:render()
    
    -- render each lane in the array of lanes
    for k, lane in pairs(self.lanes) do
        lane:render()
    end
end

--[[
    Called when this state changes to another state.
]]
function LaneState:exit()
end
