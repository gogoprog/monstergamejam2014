Factory = Factory or require 'factory'

Map = {
    zones = {}
}

function Map:init()
    self.cameraEntity = gengine.entity.create()

    self.cameraEntity:addComponent(
        ComponentCamera(),
        {
            extent = vector2(1024, 600)
        },
        "camera"
        )

    self.cameraEntity:insert()

    for i=1,4 do
        gengine.graphics.texture.create("data/floor" .. i .. ".png")
    end

    for i=1,3 do
        self.zones[i] = Factory:createZone("floor1")
        self.zones[i]:insert()
        self.zones[i].position.y = (i-2) * 1024
    end
end

function Map:update(dt)

end

return Map