--[[
    CS50 2018
    lane Class
    Author: Evan Frankel
    esfbbmc@gmail.com
    Responsible for creating and operating each individual lane, including its own obstacles and player.
]]

lane = Class{}

-- each lane that is created needs to know how many lanes there are in total and which
-- one it is so it can place its object correctly.
function lane:init(lanes,i)

    self.timer = 0

    -- create a player for this lane and place it accordingly onscreen.
    self.player = Player(lanes, i)

    -- best way to render multiple obstacles onscreen at once without necessarily
    -- knowing how many is with an array.
    self.points = {}

    self.lanes = lanes
    self.i = i

    -- place lane-dividing wall
    local x = VIRTUAL_WIDTH / lanes * (i-1)
    self.wall = wall(x)

end


-- each lane must update constantly
function lane:update(dt)

    -- random number to slightly randomize interval between barriers, create barriers
    -- more frequently the more time has gone on to increase difficulty, but also make
    -- it more difficult less quickly the more lanes there are.
    self.timer = self.timer + dt * math.random(.05, 1.95) + TIMER * 0.0006 * 1.5 / self.lanes

    -- create new barrier after some interval.
    if self.timer > 2 then

        -- randomize whether barrier spawns on the left or the right.
        local a = math.random(1, 2)

        -- add new barrier to array of barriers, passing to the new barrier relevant
        -- information.
        table.insert(self.points, point(a,self.lanes,self.i))

        -- reset localized timer so new barriers are not constantly being created.
        self.timer = 0
    end 


    -- control reaction of each barrier to relevant events.
    for k, point in pairs(self.points) do

        -- update each barrier
        point:update(dt)

        -- when barrier reaches the player horizontally, player loses the game
        -- if the barrier hits them but gets a point otherwise.
        if (self.player.y + self.player.height >= point.y and self.player.y <= point.y + 12) then

            if ((point.onright == false and (self.player.x) < (point.x + point.width)) or (point.onright == true and (self.player.x + 7) > point.x)) then
                gStateMachine:change('score', SCORE, self.lanes)
            else
                if point.pointflag then
                    SCORE = SCORE + 1
                    sounds['score']:play()
                end
                point.pointflag = false
            end
        end

        -- if barrier reaches the bottom of the screen remove it from the array.
        if point.y > VIRTUAL_WIDTH then
            table.remove(self.points, k)
        end
    end

    
    self.player:update(dt)
    self.player:render()


end

-- each lane must render constantly
function lane:render()

    self.wall:render()

    -- render each barrier while it exists.
    for k, point in pairs(self.points) do
        point:render()
    end

    self.player:render()

    --display the player's score at the top of the screen while they are playing.
    love.graphics.setColor(0,0,0)
    love.graphics.setFont(smallFont)
    love.graphics.print('Score: ' .. tostring(SCORE), 8, 8)

    
end