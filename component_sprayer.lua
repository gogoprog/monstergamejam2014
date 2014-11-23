ComponentSprayer = ComponentSprayer or {}
Map = Map or require 'map'

gengine.stateMachine(ComponentSprayer)

function ComponentSprayer:init()
    self:changeState("idle")
    self.damage = 350
    self.consumption = 10
    self.ammunition = 100
    self.maxAmmo = 100
end

function ComponentSprayer:insert()
end

function ComponentSprayer:remove()
    self:changeState("idle")
end

function ComponentSprayer:update(dt)
    self:updateState(dt)
    Game:setGaugeValue(1, self.ammunition / self.maxAmmo)
end

function ComponentSprayer.onStateEnter:spraying(dt)
    self.entity:insert()
    self.entity.animatedSprite:pushAnimation(self.entity.stillSprayingAnimation)
    self.entity.animatedSprite:pushAnimation(self.entity.startSprayingAnimation)
end

function ComponentSprayer.onStateUpdate:spraying(dt)
    for k, v in ipairs(Map.enemies) do
        if not(v.position.x - 16 > self.entity.position.x + 8
            or v.position.x + 16 < self.entity.position.x - 8
            or v.position.y - 32 > self.entity.position.y + 128
            or v.position.y + 32 < self.entity.position.y - 128) then

            v.enemy:takeDamage(self.damage * dt)
        end
    end

    self.ammunition = self.ammunition - (self.consumption * dt)
    if self.ammunition <= 0 then
        self:changeState("stopSpraying")
        self.ammunition = 0
    end

end

function ComponentSprayer.onStateEnter:stopSpraying(dt)
    self.entity.animatedSprite:removeAnimations()
    self.entity.animatedSprite:pushAnimation(self.entity.stopSprayingAnimation)
    self.time = 0
end

function ComponentSprayer.onStateUpdate:stopSpraying(dt)
    self.time = self.time + dt
    if self.time > 0.4 then
        self.entity:remove()
        self:changeState("idle")
    end
end

return ComponentSprayer