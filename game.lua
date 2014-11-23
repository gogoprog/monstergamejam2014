require 'map'
require 'factory'

Game = {}

gengine.stateMachine(Game)

function Game:init()
    self:changeState("menu")
    Factory:init()
    Map:init()
    Grid:init(15, 15)
end

function Game:update(dt)
    self:updateState(dt)
end

function Game.onStateEnter:menu()
    gengine.gui.loadFile("gui/menu.html")
end

function Game.onStateUpdate:menu(dt)
    if gengine.input.keyboard:isJustDown(44) then
        self:changeState("started")
    end
end

function Game.onStateExit:menu()
    gengine.gui.loadFile("about:blank")
end

function Game.onStateEnter:started()
    Map:start()
end

function Game.onStateUpdate:started(dt)
    Map:update(dt)
    Grid:update(dt)
end