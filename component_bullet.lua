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

    if not(self.entity.position.x - 8 > Map.ship.position.x + 32
        or self.entity.position.x + 8 < Map.ship.position.x - 32
        or self.entity.position.y - 8 > Map.ship.position.y + 32
        or self.entity.position.y + 8 < Map.ship.position.y - 32) then

        self.entity:remove()
        gengine.entity.destroy(self.entity)
        Map.ship.outer_player:takeDamage(self.damage)
        Grid.enemyToSpawn = Grid.enemyToSpawn + 1
    end
end

function ComponentBullet:remove()
end

return ComponentBullet