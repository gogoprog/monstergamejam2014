
ComponentInnerPlayer = {}

function ComponentInnerPlayer:init()

end

function ComponentInnerPlayer:insert()
end

function ComponentInnerPlayer:update(dt)
    local keyboard = gengine.input.keyboard

    local f = 100000000

    if keyboard:isJustDown(79) then
        self.entity.physic:applyForceToCenter(vector2(f, 0))
    end
    if keyboard:isJustDown(80) then
        self.entity.physic:applyForceToCenter(vector2(-f, 0))
    end
    if keyboard:isJustDown(81) then
        self.entity.physic:applyForceToCenter(vector2(0, -f))
    end
    if keyboard:isJustDown(82) then
        self.entity.physic:applyForceToCenter(vector2(0, f))
    end
end

function ComponentInnerPlayer:remove()
end

return ComponentInnerPlayer