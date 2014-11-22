Factory = Factory or {}

ComponentSpaceEnemy = {}

function ComponentSpaceEnemy:init()
    self.total = 0
    self.backSpeed = 100
    self.time = 0
    self.shootTime = math.random() * 2  + 1
end

function ComponentSpaceEnemy:insert()
    self.basePosition = vector2(self.entity.position.x, self.entity.position.y)
end

function ComponentSpaceEnemy:update(dt)
    self.total = self.total + dt
    self.entity.position.x = self.basePosition.x + math.sin(self.total * 2) * 50

    self.entity.position.y = self.entity.position.y + self.backSpeed * dt

    self.time = self.time + dt

    if self.time > self.shootTime then

        self.time = 0
        self.shootTime = math.random() * 2  + 1
        
        local e = Factory:createBullet(-200)
        e:insert()
        e.position = vector2(self.entity.position.x, self.entity.position.y)
    end
end

function ComponentSpaceEnemy:remove()
end

return ComponentSpaceEnemy