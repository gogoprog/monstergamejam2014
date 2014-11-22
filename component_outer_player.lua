ComponentOuterPlayer = {}

function ComponentOuterPlayer:init()
    self.total = 0
    self.speed = 0.1
    self.lastMousePosition = 0
end

function ComponentOuterPlayer:insert()
end

function ComponentOuterPlayer:update(dt)
    local e = self.entity
    local speedFactor = -3
    self.total = self.total + dt

    local x,y = gengine.input.mouse:getPosition()
    local wx, wy = self.camera:getWorldPosition(x,y)

    if wx < 40000 then
        if x ~= self.lastMousePosition or wx == math.floor(e.position.x + .5) then
            self.lastMousePosition = x
            self.speed = (speedFactor * (wx - e.position.x)) * dt
        end
        e.position.x = e.position.x - self.speed
        print(self.speed .. " - " .. math.floor(e.position.x + .5) .. " - " .. wx)
    end

    if gengine.input.mouse:isJustDown(1) then
    end

    if gengine.input.mouse:isJustDown(3) then
    end
end

function ComponentOuterPlayer:remove()
end

return ComponentOuterPlayer