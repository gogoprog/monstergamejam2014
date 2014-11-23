Factory = Factory or {}
Map = Map or {}

ComponentResource = ComponentResource or {}

function ComponentResource:init()
    self.hitbox = vector2(x,y)
    self.time = 0
    self.backSpeed = 100
end

function ComponentResource:update(dt)
    self.time = self.time + dt
    self.entity.position.y = self.entity.position.y + self.backSpeed * dt

    if not(self.entity.position.x - (self.hitbox.x / 2) > Map.ship.position.x + (Map.ship.outer_player.hitbox.x / 2)
        or self.entity.position.x + (self.hitbox.x / 2) < Map.ship.position.x - (Map.ship.outer_player.hitbox.x / 2)
        or self.entity.position.y - (self.hitbox.y / 2) > Map.ship.position.y + (Map.ship.outer_player.hitbox.y / 2)
        or self.entity.position.y + (self.hitbox.y / 2) < Map.ship.position.y - (Map.ship.outer_player.hitbox.y / 2)) then

    self.entity:remove()
    gengine.entity.destroy(self.entity)

    end

end

function ComponentResource:insert()
end

function ComponentResource:remove()
end

return ComponentResource