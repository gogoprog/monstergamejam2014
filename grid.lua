Grid = Grid or {
    center = -256,
    blocks = {},
    tileSize = 32
}

function Grid:init(w, h)
    self.width = w
    self.height = h
    self.origin = vector2(self.center - self.width * self.tileSize * 0.5, - self.height * self.tileSize * 0.5)

    gengine.graphics.createWorlds(2)

    self.background = Factory:createGridBackground()
    self.background:insert()
    self.background.position.x = self.center

    self.cameraEntity = Factory:createCamera(1)
    self.cameraEntity:insert()

    self.farmer = Factory:createInnerPlayer()
    self.farmer.position.x, self.farmer.position.y = self:getPosition(0, 0)
    self.farmer:insert()

    self:putRandomTiles(50)
end

function Grid:putRandomTiles(count)
    while count > 0 do
        local x, y = math.random(0, self.width - 1), math.random(0, self.height - 1)
        if not self:isBlocked(x, y) then
            self.blocks[y * self.width + x] = true
            local e = Factory:createBlock()
            e.position.x, e.position.y = self:getPosition(x, y)
            e:insert()
            count = count - 1
        end
    end
end

function Grid:update(dt)
    self.farmer.rotation = 0
end

function Grid:getPosition(c, r)
    return self.origin.x + self.tileSize * (c + 0.5), self.origin.y + self.tileSize * (r + 0.5)
end

function Grid:isBlocked(c, r)
    return self.blocks[r * self.width + c] or c < 0 or r < 0 or c >= self.width or r >= self.height
end