Factory = Factory or {}
Map = Map or {}

ComponentSpaceEnemy = {}
gengine.stateMachine(ComponentSpaceEnemy)

function ComponentSpaceEnemy:init()
    self:changeState("alive")
    self.total = 0
    self.backSpeed = 100
    self.time = 0
    self.shootTime = math.random() * 2  + 1
    self.life = 100
    self.collision_damage = 30
end

function ComponentSpaceEnemy:insert()
    self.basePosition = vector2(self.entity.position.x, self.entity.position.y)
end

function ComponentSpaceEnemy:update(dt)
    self.total = self.total + dt
    self.entity.position.x = self.basePosition.x + math.sin(self.total * 2) * 50

    self.entity.position.y = self.entity.position.y + self.backSpeed * dt

    self.time = self.time + dt

    if self.state == "alive" then
        if self.time > self.shootTime then
            self.time = 0
            self.shootTime = math.random() * 2  + 1
            
            local e = Factory:createBullet(-200)
            e:insert()
            e.position = vector2(self.entity.position.x, self.entity.position.y)

            gengine.audio.playSound(self.fireSound)
        end

        if not(self.entity.position.x - 16 > Map.ship.position.x + 32
            or self.entity.position.x + 16 < Map.ship.position.x - 32
            or self.entity.position.y - 32 > Map.ship.position.y + 32
            or self.entity.position.y + 32 < Map.ship.position.y - 32) then

            self:takeDamage(self.life + 1)
            Map.ship.outer_player:takeDamage(self.collision_damage)
        end

        if self.life <= 0 then
            self:changeState("dying")
        end
    end

    if self.entity.position.y - Map.cameraEntity.position.y < -512 then
        self:killIt()
    end

    self:updateState(dt)
end

function ComponentSpaceEnemy:remove()
end

function ComponentSpaceEnemy:takeDamage(amount)
    if self.state == "alive" then
        self.entity.rumbler:rumble(0.4)
        self.life = self.life - amount
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

function ComponentSpaceEnemy.onStateEnter:dying(dt)
    self.entity.sprite:removeAnimations()
    self.entity.sprite.extent = vector2(64, 64)
    self.entity.sprite:pushAnimation(Factory.dyingMonsterAnimation)
    gengine.audio.playSound(gengine.audio.sound.get("limace.dead"))
    self.time = 0
end

function ComponentSpaceEnemy.onStateUpdate:dying(dt)
    self.time = self.time + dt
    if self.time > 1 then
        self:killIt()
    end
end

return ComponentSpaceEnemy