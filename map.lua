Map = {}

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
end