ComponentSprayer = ComponentSprayer or {}

gengine.stateMachine(ComponentSprayer)

function ComponentSprayer:init()
    self:changeState("idle")
end

function ComponentSprayer:insert()
end

function ComponentSprayer:remove()
    self:changeState("idle")
end

function ComponentSprayer:update(dt)
	self:updateState(dt)
end

function ComponentSprayer.onStateEnter:startSpraying(dt)
    self.entity:insert()
    self.entity.animatedSprite:pushAnimation(self.entity.stillprayingAnimation)
    self.entity.animatedSprite:pushAnimation(self.entity.startSprayingAnimation)
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