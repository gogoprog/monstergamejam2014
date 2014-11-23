Map = Map or require 'map'
Factory = Factory or require 'factory'
require 'grid'

function init()
    gengine.application.setName("mgj")
    gengine.application.setExtent(1024, 600)
end

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)
    Factory:init()
    Map:init()
    Grid:init(15, 15)
end

function update(dt)
    Map:update(dt)
    Grid:update(dt)

    if gengine.input.keyboard:isJustDown(41) then
        gengine.application.quit()
    end
end

function stop()

end
