Factory = Factory or {}
ComponentOuterPlayer = {}

function ComponentOuterPlayer:init()
    self.total = 0
    self.speed = 0
    self.lastMousePosition = 0
    self.maxSpeed = 10
    self.minSpeed = 1
    self.leftBoundary = 32
    self.rightBoundary = 512 - 32
    self.sprayerEntity = Factory:createSprayer()
end

function ComponentOuterPlayer:insert()
end

function ComponentOuterPlayer:update(dt)
    local e = self.entity
    local speedFactor = -8
    self.total = self.total + dt

    local x,y = gengine.input.mouse:getPosition()
    local wx, wy = self.camera:getWorldPosition(x,y)

    if wx < 10000 then
        self.speed = (speedFactor * (wx - e.position.x)) * dt

        if math.abs(self.speed) < self.minSpeed and math.abs(self.speed) > 0.1 then
            if self.speed < 0 then
                self.speed = self.minSpeed * -1
            else
                self.speed = self.minSpeed
            end
        end

        e.position.x = e.position.x - self.speed

        if e.position.x > self.rightBoundary then
            e.position.x = self.rightBoundary
        end

        if e.position.x < self.leftBoundary then
            e.position.x = self.leftBoundary
        end
    end

    if gengine.input.mouse:isJustDown(1) then
        if self.sprayerEntity.sprayer.state == "idle" then
            self.sprayerEntity.sprayer:changeState("startSpraying")
        end
    end
    
    if gengine.input.mouse:isJustUp(1) then
        if self.sprayerEntity.sprayer.state == "startSpraying" then
            self.sprayerEntity.sprayer:changeState("stopSpraying")
        end
    end

    if gengine.input.mouse:isJustDown(3) then
    end

    self.sprayerEntity.position.x = e.position.x
    self.sprayerEntity.position.y = 160 + e.position.y
end

function ComponentOuterPlayer:remove()
end

return ComponentOuterPlayer