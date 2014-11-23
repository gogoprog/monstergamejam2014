require 'map'
require 'factory'

Game = {}

gengine.stateMachine(Game)

function Game:init()
    Factory:init()
    Map:init()
    Grid:init(15, 15)
    self.logo = Factory:createLogo()
    self.yeehaa = gengine.audio.sound.create("data/Yha.ogg")
    self:changeState("menu")
end

function Game:update(dt)
    self:updateState(dt)
end

function Game.onStateEnter:menu()
    gengine.gui.loadFile("gui/menu.html")
    gengine.audio.playMusic("data/menu.ogg")

    self.logo:insert()
end

function Game.onStateUpdate:menu(dt)
    if gengine.input.keyboard:isJustDown(44) then
        self:changeState("started")
    end
end

function Game.onStateExit:menu()
    gengine.gui.loadFile("about:blank")
    self.logo:remove()
end

function Game.onStateEnter:started()
    Map:start()
    self.gauges = {}
    local g

    g = Factory:createGauge(1)
    g.position.y = 128
    g:insert()
    self.gauges[1] = g

    g = Factory:createGauge(2)
    g.position.y = -128
    g:insert()
    self.gauges[2] = g

    gengine.audio.playMusic("data/music.ogg")
    gengine.audio.playSound(self.yeehaa)
end

function Game.onStateUpdate:started(dt)
    Map:update(dt)
    Grid:update(dt)
end

function Game.onStateExit:started()
end

function Game:setGaugeValue(id, value)
    self.gauges[id].sprite.atlasItem = math.min(math.floor(value * 10), 9)
    self.gauges[id].sprite:init()
end