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

end

function ComponentSprayer.onStateEnter:startSpraying(dt)
    self.entity:insert()
    self.entity.animatedSprite:pushAnimation(self.entity.startSprayingAnimation)
end

return ComponentSprayer