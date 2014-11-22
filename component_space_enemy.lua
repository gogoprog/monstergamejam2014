ComponentSpaceEnemy = {}

function ComponentSpaceEnemy:init()
    self.total = 0
    self.backSpeed = 100
end

function ComponentSpaceEnemy:insert()
    self.basePosition = vector2(self.entity.position.x, self.entity.position.y)
end

function ComponentSpaceEnemy:update(dt)
    self.total = self.total + dt
    self.entity.position.x = self.basePosition.x + math.sin(self.total * 2) * 50

    self.entity.position.y = self.entity.position.y + self.backSpeed * dt
end

function ComponentSpaceEnemy:remove()
end

return ComponentSpaceEnemy