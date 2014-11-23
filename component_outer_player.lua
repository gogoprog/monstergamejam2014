Factory = Factory or {}
ComponentOuterPlayer = {}
Map = Map or require 'Map'

local mabs = math.abs

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
    self.life = 100
end

function ComponentOuterPlayer:insert()
end

function ComponentOuterPlayer:update(dt)
    local e = self.entity
    local speedFactor = -8
    self.time = self.time + dt

    local x,y = gengine.input.mouse:getPosition()
    local wx, wy = self.camera:getWorldPosition(x,y)

    if mabs(wx) ~= 1/0 and mabs(wy) ~= 1/0 then
        self.x_speed = (speedFactor * (wx - e.position.x)) * dt
        self.y_speed = (speedFactor * (wy - Map.position - self.y)) * dt

        if math.abs(self.x_speed) < self.x_minSpeed and math.abs(self.x_speed) > 0.1 then
            if self.x_speed < 0 then
                self.x_speed = self.x_minSpeed * -1
            else
                self.x_speed = self.x_minSpeed
            end
        end

        if self.x_speed > 0.1 then
            self.entity.sprite.texture = gengine.graphics.texture.get("spaceship_left")
        elseif self.x_speed < -0.1 then
            self.entity.sprite.texture = gengine.graphics.texture.get("spaceship_right")
        else
            self.entity.sprite.texture = gengine.graphics.texture.get("spaceship_empty")
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

    if gengine.input.mouse:isDown(1) then
        if self.sprayerEntity.sprayer.state == "idle" and self.sprayerEntity.sprayer.ammunition > 0 then
            self.sprayerEntity.sprayer:changeState("spraying")
        end
    end
    
    if gengine.input.mouse:isJustUp(1) then
        if self.sprayerEntity.sprayer.state == "spraying" then
            self.sprayerEntity.sprayer:changeState("stopSpraying")
        end
    end

    self.sprayerEntity.position.x = e.position.x - 20
    self.sprayerEntity.position.y = 160 + e.position.y
end

function ComponentOuterPlayer:takeDamage(amount)
    self.life = self.life - amount
    Grid.cameraEntity.shaker:shake(0.5)

    if( self.life <= 0 ) then
        --GAME OVER
    end
end

function ComponentOuterPlayer:addAmmo(amount)
    self.sprayerEntity.sprayer.ammunition = self.sprayerEntity.sprayer.ammunition + amount
end

function ComponentOuterPlayer:addLife(count)
    self.life = self.life + count
end


function ComponentOuterPlayer:remove()
end

return ComponentOuterPlayer