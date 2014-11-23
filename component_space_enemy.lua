Factory = Factory or {}
Map = Map or {}

ComponentSpaceEnemy = {}

function ComponentSpaceEnemy:init()
    self.total = 0
    self.backSpeed = 100
    self.time = 0
    self.shootTime = math.random() * 2  + 1
    self.life = 100
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

        gengine.audio.playSound(self.fireSound)
    end

    if self.entity.position.y - Map.cameraEntity.position.y < -512 then
        self:killIt()
    end
end

function ComponentSpaceEnemy:remove()
end

function ComponentSpaceEnemy:takeDamage(amount)
    self.life = self.life - amount
    if self.life <= 0 then
        self:killIt()
    end
end

function ComponentSpaceEnemy:killIt()
    for k, v in ipairs(Map.enemies) do
        if v == self.entity then
            table.remove(Map.enemies, k)
            break
        end
    end
    self.entity:remove()
    gengine.entity.destroy(self.entity)
end

return ComponentSpaceEnemy