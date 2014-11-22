ComponentOuterPlayer = {}

function ComponentOuterPlayer:init()
    self.total = 0
    self.speed = 0
    self.lastMousePosition = 0
    self.maxSpeed = 6
    self.minSpeed = 1
end

function ComponentOuterPlayer:insert()
end

function ComponentOuterPlayer:update(dt)
    local e = self.entity
    local speedFactor = -3
    self.total = self.total + dt

    local x,y = gengine.input.mouse:getPosition()
    local wx, wy = self.camera:getWorldPosition(x,y)

    if wx < 10000 then
        self.speed = (speedFactor * (wx - e.position.x)) * dt
        -- print(self.speed)
        -- if self.speed == nil then
        --     self.speed = 0
        -- else
        --     if math.abs(self.speed) > maxSpeed then
        --         self.speed = self.maxSpeed
        --     elseif math.abs(self.speed) < minSpeed then
        --         self.speed = self.minSpeed
        --     end
        -- end
        e.position.x = e.position.x - self.speed
    end

    if gengine.input.mouse:isJustDown(1) then
    end

    if gengine.input.mouse:isJustDown(3) then
    end
end

function ComponentOuterPlayer:remove()
end

return ComponentOuterPlayer