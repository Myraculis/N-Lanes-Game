--[[
    CS50 2018
    Player Class
    Author: Evan Frankel
    esfbbmc@gmail.com
    Player object is what is controlled by the person playing the game. Each lane corresponds with a single player.
]]

Player = Class{}

MOVE_TIME = 0.001

-- each player must know how many lanes there are and which one it belongs to in order to place it onscreen.
function Player:init(lanes,i)

    --This free Icons Png design of Pixel Car Purple Front PNG icons has been published by iconspng.com
    self.car = love.graphics.newImage('car.png')
    self.carright = love.graphics.newImage('carright.png')
    self.carleft = love.graphics.newImage('carleft.png')
    self.height = self.car:getHeight()

    -- place player onscreen according to number of lanes and which one it belongs to.
    self.lanes = lanes
    self.x = (VIRTUAL_WIDTH / lanes) / 4 + ((i-1)*(VIRTUAL_WIDTH / lanes)) - 7
    self.y = 240

    self.newx = 0
    self.movingleft = false
    self.movingright = false

    -- place a visual for the key used to control each player.
    self.keyx = (VIRTUAL_WIDTH / lanes) / 2 + ((i-1)*(VIRTUAL_WIDTH / lanes)) - 7 
    self.keyy = 250

    self.timer = 0

    -- variable for determining whether the player is on the left or right of its lane.
    self.onright = false

    -- determine which key will be used to control this player depending on which lane it is in.
    -- NOTE: strings are not as easy to work with in lua as they are in other languages...
    if i == 1 then
        self.key = 'q'
    else if i == 2 then
        self.key = 'w'
    else if i == 3 then
        self.key = 'e'
    else if i == 4 then
        self.key = 'r'
    else if i == 5 then
        self.key = 't'
    else if i == 6 then
        self.key = 'y'
    else if i == 7 then
        self.key = 'u'
    else if i == 8 then
        self.key = 'i'
    else if i == 9 then
        self.key = 'o'
    else if i == 10 then
        self.key = 'p'
    end
end
end
end
end
end
end
end
end
end
end



function Player:update(dt)
    self.timer = self.timer + dt

    --if the player has been set to move left then move the player 
    --left with a simple smooth movement timer-based animation
    if self.timer > MOVE_TIME and self.movingleft == true then
        self.timer = self.timer % COUNTDOWN_TIME
        self.x = self.x - 8

        if self.x == self.newx or self.x < self.newx then
            self.x = self.newx
            self.movingleft = false
            self.onright = false
        end
    end

    --if the player has been set to move right then move the player 
    --right with a simple smooth movement timer-based animation
    if self.timer > MOVE_TIME and self.movingright == true then
        self.timer = self.timer % COUNTDOWN_TIME
        self.x = self.x + 8

        if self.x == self.newx or self.x > self.newx then
            self.x = self.newx
            self.movingright = false
            self.onright = true
        end
    end

    -- control player movement when user presses correct key.
    if love.keyboard.wasPressed(self.key) then
        if not (self.movingleft or self.movingright) then
            if self.onright == true then
                self.movingleft = true

                self.newx = self.x - VIRTUAL_WIDTH / (2*self.lanes)
            else
                self.movingright = true

                self.newx = self.x + VIRTUAL_WIDTH / (2*self.lanes)
            end
        end
    end
end

function Player:render()

    -- render player sprite at according x and y onscreen 
    --and depending on which direction the car is moving
    if self.movingleft == true then

        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(self.carleft, self.x, self.y)

    else if self.movingright == true then

        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(self.carright, self.x, self.y)

    else

        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(self.car, self.x, self.y)

    end

    -- display key that controls each player
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(smallFont)
    love.graphics.print(tostring(self.key), self.keyx, self.keyy)

    love.graphics.setColor(255, 255, 255)
end
end
