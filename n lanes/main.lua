 --[[
    CS50 2018
    n Lanes
    Author: Evan Frankel
    esfbbmc@gmail.com
    A game where you operate a carlike object and try to survive obstacles for as long as possible
    for maximum points. Possible to select a greater number of lanes for increasing difficulty and 
    local multiplayer potential.
]]

-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require 'push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

-- a basic StateMachine class which will allow us to transition to and from
-- game states smoothly and avoid monolithic code in one file
require 'StateMachine'

require 'states/BaseState'
--require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/LaneState'
require 'states/ScoreState'
require 'states/CreditState'

require 'player'
require 'lane'
require 'point'
require 'PlaySign'
require 'wall'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual resolution dimensions
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

 
-- global timer variable for keeping time across each class.
TIMER = 0

-- global score variable for keeping track of the score within a play session.
SCORE = 0

-- background of game window.
local background = love.graphics.newImage('background.png')

function love.load()

    -- initialize our nearest-neighbor filter
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    -- seed the RNG
    math.randomseed(os.time())

    -- app window title
    love.window.setTitle('n Lanes')

    -- initialize our nice-looking retro text fonts
    smallFont = love.graphics.newFont('font.ttf', 16)
    bigFont = love.graphics.newFont('font.ttf', 32)
    hugeFont = love.graphics.newFont('font.ttf', 56)
    love.graphics.setFont(smallFont)

    -- initialize our table of sounds
    sounds = {
        ['score'] = love.audio.newSource('score.wav', 'static'),

        -- http://www.orangefreesounds.com/elevator-music/
        ['music'] = love.audio.newSource('music.mp3', 'static')
    }

    -- begin playing music
    sounds['music']:setLooping(true)
    sounds['music']:play()

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['lane'] = function() return LaneState() end,
        ['score'] = function() return ScoreState() end,
        ['credit'] = function() return CreditState() end
    }
    gStateMachine:change('credit')

    -- initialize input table
    love.keyboard.keysPressed = {}

    -- initialize mouse input table
    love.mouse.buttonsPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

--[[
    LÖVE2D callback fired each time a mouse button is pressed; gives us the
    X and Y of the mouse, as well as the button in question.
]]
function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

--[[
    Equivalent to our keyboard function from before, but for the mouse buttons.
]]
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

--update everything
function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

--render everything
function love.draw()
    push:start()
    
    love.graphics.draw(background, 0)
    gStateMachine:render()
    
    push:finish()
end