require 'map'
require "factory"

function init()
    gengine.application.setName("mgj")
    gengine.application.setExtent(1024, 600)
end

local cameraEntity

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)
    Factory:init()
    local e = Factory:createSpaceShip()
    e:insert()
    Map:init()
end

function update(dt)

    if gengine.input.keyboard:isJustDown(41) then
        gengine.application.quit()
    end
end

function stop()

end
