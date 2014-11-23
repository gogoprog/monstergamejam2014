local Map = Map or {}

ComponentBullet = {}

function ComponentBullet:init()
    self.speed = -100
    self.damage = 3
end

function ComponentBullet:insert()
end

function ComponentBullet:update(dt)
    self.entity.position.y = self.entity.position.y + self.speed * dt

    if self.entity.position.y - Map.cameraEntity.position.y < -512 then
        self.entity:remove()
        gengine.entity.destroy(self.entity)
    end
end

function ComponentBullet:remove()
end

return ComponentBullet