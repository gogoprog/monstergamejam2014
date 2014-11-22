Grid = Grid or {
    center = -256
}

function Grid:init(w, h)
    gengine.graphics.createWorlds(2)
    gengine.physics.createWorlds(1)
    self.background = Factory:createGridBackground()
    self.background:insert()
    self.background.position.x = self.center

    self.cameraEntity = Factory:createCamera(1)
    self.cameraEntity:insert()
end