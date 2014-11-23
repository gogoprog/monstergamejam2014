Grid = Grid or {
    center = -256,
    blocks = {},
    tileSize = 32
}

function Grid:init(w, h)
    self.width = w
    self.height = h
    gengine.graphics.createWorlds(2)
    gengine.physics.createWorlds(1)

    gengine.physics.worlds[1]:setGravity(vector2(0, 0))

    self.background = Factory:createGridBackground()
    self.background:insert()
    self.background.position.x = self.center

    self.cameraEntity = Factory:createCamera(1)
    self.cameraEntity:insert()

    self.farmer = Factory:createInnerPlayer()
    self.farmer.position.x = self.center
    self.farmer:insert()

    local wall
    local offset = 256 - 16
    wall = Factory:createInvisibleBlock(512, 32)
    wall.position.x = self.center
    wall.position.y = -offset
    wall:insert()

    wall = Factory:createInvisibleBlock(512, 32)
    wall.position.x = self.center
    wall.position.y = offset

    wall:insert()

    wall = Factory:createInvisibleBlock(32, 512)
    wall.position.x = self.center - offset
    wall:insert()

    wall = Factory:createInvisibleBlock(32, 512)
    wall.position.x = self.center + offset
    wall:insert()

    self.origin = vector2(self.center - self.width * self.tileSize * 0.5, - self.height * self.tileSize * 0.5)

    self:putRandomTiles(5)
end

function Grid:putRandomTiles(count)
    while count > 0 do
        local x, y = math.random(0, self.width), math.random(0, self.height)
        if not self.blocks[y * self.width + x] then
            self.blocks[y * self.width + x] = true
            local e = Factory:createBlock()
            e.position.x = self.origin.x + self.tileSize * x
            e.position.y = self.origin.y + self.tileSize * y
            e:insert()
            count = count - 1
        end
    end
end