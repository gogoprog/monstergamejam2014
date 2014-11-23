require 'grid'
require 'game'

function init()
    gengine.application.setName("mgj")
    gengine.application.setExtent(1024, 600)
end

function start()
    gengine.graphics.setClearColor(0,0.1,0.1,1)
    Game:init()
end

function update(dt)
    Game:update(dt)
    if gengine.input.keyboard:isJustDown(41) then
        gengine.application.quit()
    end
end

function stop()

end
