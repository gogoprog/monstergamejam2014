ComponentSprayer = ComponentSprayer or {}
Map = Map or require 'map'

gengine.stateMachine(ComponentSprayer)

function ComponentSprayer:init()
    self:changeState("idle")
    self.damage = 350
end

function ComponentSprayer:insert()
end

function ComponentSprayer:remove()
    self:changeState("idle")
end

function ComponentSprayer:update(dt)
	self:updateState(dt)
end

function ComponentSprayer.onStateEnter:spraying(dt)
    self.entity:insert()
    self.entity.animatedSprite:pushAnimation(self.entity.stillSprayingAnimation)
    self.entity.animatedSprite:pushAnimation(self.entity.startSprayingAnimation)
end

function ComponentSprayer.onStateUpdate:spraying(dt)
    for k, v in ipairs(Map.enemies) do
        if (v.position.x + 16 > self.entity.position.x - 8 and v.position.x - 16 < self.entity.position.x + 8)
            and (v.position.x - 16 > self.entity.position.x - 16 and self.entity.position.x - 16 < self.entity.position.x +16)
            and (v.position.y - 32 < self.entity.position.y + 64 and v.position.y - 32 > self.entity.position.y - 64) then
            
            v.enemy:takeDamage(self.damage * dt)
        end
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