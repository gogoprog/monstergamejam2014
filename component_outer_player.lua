Factory = Factory or {}
ComponentOuterPlayer = {}
Map = Map or require 'Map'

function ComponentOuterPlayer:init()
    self.time = 0
    self.x_speed = 0
    self.x_maxSpeed = 10
    self.x_minSpeed = 1
    self.y_speed = 0
    self.y = 0
    self.y_maxSpeed = 10
    self.y_minSpeed = 1
    self.leftBoundary = 32
    self.rightBoundary = 512 - 32
    self.sprayerEntity = Factory:createSprayer()
end

function ComponentOuterPlayer:insert()
end

function ComponentOuterPlayer:update(dt)
    local e = self.entity
    local speedFactor = -8
    self.time = self.time + dt

    local x,y = gengine.input.mouse:getPosition()
    local wx, wy = self.camera:getWorldPosition(x,y)

    if wx < 10000 and wy < 10000 then
        self.x_speed = (speedFactor * (wx - e.position.x)) * dt
        self.y_speed = (speedFactor * (wy - Map.position - self.y)) * dt

        if math.abs(self.x_speed) < self.x_minSpeed and math.abs(self.x_speed) > 0.1 then
            if self.x_speed < 0 then
                self.x_speed = self.x_minSpeed * -1
            else
                self.x_speed = self.x_minSpeed
            end
        end

        e.position.x = e.position.x - self.x_speed
        self.y = self.y - self.y_speed
        e.position.y = self.y + Map.position

        if e.position.x > self.rightBoundary then
            e.position.x = self.rightBoundary
            self.x_speed = 0
        end

        if e.position.x < self.leftBoundary then
            e.position.x = self.leftBoundary
            self.x_speed = 0
        end

        if math.abs(self.x_speed) > 9 and self.time > 0.9 then
            self.time = 0
            gengine.audio.playSound(self.straffingSound)
        end
    end

    if gengine.input.mouse:isJustDown(1) then
        if self.sprayerEntity.sprayer.state == "idle" then
            self.sprayerEntity.sprayer:changeState("spraying")
        end
    end
    
    if gengine.input.mouse:isJustUp(1) then
        if self.sprayerEntity.sprayer.state == "spraying" then
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