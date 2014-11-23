require 'grid_definitions'

Grid = Grid or {
    center = -256,
    blocks = {},
    bonuses = {},
    tileSize = 32,
    time = 0,
    duration = 1
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

    self:load(GridDefinitions[1])
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

function Grid:putRandomBonus(count)
    while count > 0 do
        local x, y = math.random(0, self.width - 1), math.random(0, self.height - 1)
        if not self:isBlocked(x, y) and not self:isBonus(x, y) then
            local e = Factory:createGridBonus()
            e.position.x, e.position.y = self:getPosition(x, y)
            e:insert()
            self.bonuses[y * self.width + x] = e
            count = count - 1
        end
    end
end

function Grid:load(definition)
    local blocks = self.blocks
    for k, v in ipairs(definition) do
        local n = k - 1
        if v > 0 then
            local e = Factory:createBlock()
            local c, r = n % self.width, math.floor(n / self.width)
            e.position.x, e.position.y = self:getPosition(c, r)
            blocks[r * self.width + c] = true
            e:insert()
        end
    end
end

function Grid:update(dt)
    self.time = self.time + dt

    if self.time >= self.duration then
        self:putRandomBonus(1)
        self.time = 0
    end
end

function Grid:getPosition(c, r)
    return self.origin.x + self.tileSize * (c + 0.5), self.origin.y + self.tileSize * (r + 0.5)
end

function Grid:isBlocked(c, r)
    return self.blocks[r * self.width + c] or c < 0 or r < 0 or c >= self.width or r >= self.height
end

function Grid:isBonus(c, r)
    return self.bonuses[r * self.width + c]
end

function Grid:getBonus(c, r)
    return self.bonuses[r * self.width + c]
end