Map = Map or require 'map'
Factory = Factory or require 'factory'

function init()
    gengine.application.setName("mgj")
    gengine.application.setExtent(1024, 600)
end

local ship

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)
    Factory:init()
    Map:init()
    ship = Factory:createSpaceShip(Map.cameraEntity.camera)
    ship:insert()
end

function update(dt)
    Map:update(dt)
    ship.position.y = Map.position - 200

    if gengine.input.keyboard:isJustDown(41) then
        gengine.application.quit()
    end
end

function stop()

end
