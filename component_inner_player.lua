
ComponentInnerPlayer = {}

function ComponentInnerPlayer:init()
    self.force = vector2(0, 0)
end

function ComponentInnerPlayer:insert()
end

function ComponentInnerPlayer:update(dt)
    local keyboard = gengine.input.keyboard

    local f = 100000000

    self.force:set(0, 0)

    if keyboard:isDown(79) then
        self.force.x = f
    end
    if keyboard:isDown(80) then
        self.force.x = -f
    end
    if keyboard:isDown(81) then
        self.force.y = -f
    end
    if keyboard:isDown(82) then
        self.force.y = f
    end

    self.entity.physic:applyLinearImpulse(self.force, vector2(0,0))
end

function ComponentInnerPlayer:remove()
end

return ComponentInnerPlayer