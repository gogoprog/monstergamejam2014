ComponentBullet = {}

function ComponentBullet:init()
    self.speed = -100
end

function ComponentBullet:insert()
end

function ComponentBullet:update(dt)
    self.entity.position.y = self.entity.position.y + self.speed * dt

    if self.entity.position.y < -512 then
        self.entity:unregister()
        gengine.entity.destroy(self.entity)
    end
end

function ComponentBullet:remove()
end

return ComponentBullet