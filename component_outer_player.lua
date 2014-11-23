Factory = Factory or {}
ComponentOuterPlayer = {}
Map = Map or require 'Map'

local mabs = math.abs
gengine.stateMachine(ComponentOuterPlayer)

function ComponentOuterPlayer:init()
    self:changeState("alive")
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
    self.maxLife = 100
end

function ComponentOuterPlayer:insert()
end

function ComponentOuterPlayer:update(dt)
    self:updateState(dt)
    local e = self.entity
    local speedFactor = -8
    self.time = self.time + dt

    local x,y = gengine.input.mouse:getPosition()
    local wx, wy = self.camera:getWorldPosition(x,y)

    if mabs(wx) ~= 1/0 and mabs(wy) ~= 1/0 then
        if self.state == "alive" then
            self.x_speed = (speedFactor * (wx - e.position.x)) * dt
            self.y_speed = (speedFactor * (wy - Map.position - self.y)) * dt
        else
            self.x_speed = 0
            self.y_speed = 0
        end

        if math.abs(self.x_speed) < self.x_minSpeed and math.abs(self.x_speed) > 0.01 then
            if self.x_speed < 0 then
                self.x_speed = self.x_minSpeed * -1
            else
                self.x_speed = self.x_minSpeed
            end
        end

        if self.x_speed > self.x_minSpeed then
            self.entity.spaceShipAnimation:removeAnimations()
            self.entity.spaceShipAnimation:pushAnimation(self.entity.spaceShipLeft)
        elseif self.x_speed < -self.x_minSpeed then
            self.entity.spaceShipAnimation:removeAnimations()
            self.entity.spaceShipAnimation:pushAnimation(self.entity.spaceShipRight)
        elseif self.state == "alive" then
            self.entity.spaceShipAnimation:removeAnimations()
            self.entity.spaceShipAnimation:pushAnimation(self.entity.spaceShip)
        end

        self.y = self.y - self.y_speed
        e.position.y = self.y + Map.position 
        e.position.x = e.position.x - self.x_speed

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

        if self.state == "alive" then
            if self.life <= 0 then
                self:changeState("dying")
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
        end
    end

    self.sprayerEntity.position.x = e.position.x - 20
    self.sprayerEntity.position.y = 160 + e.position.y

    Game:setGaugeValue(2, self.life / self.maxLife)
end

function ComponentOuterPlayer:takeDamage(amount)
    self.life = self.life - amount
    Grid.cameraEntity.shaker:shake(0.5)
end

function ComponentOuterPlayer:addAmmo(amount)
    self.sprayerEntity.sprayer.ammunition = math.min(self.sprayerEntity.sprayer.ammunition + amount, self.sprayerEntity.sprayer.maxAmmo)
end

function ComponentOuterPlayer:addLife(count)
    self.life = math.min(self.life + count, self.maxLife)
end

function ComponentOuterPlayer.onStateEnter:dying(dt)
    self.entity.spaceShipAnimation:removeAnimations()
    self.entity.spaceShipAnimation:pushAnimation(self.entity.spaceShipExplosion)
    self.time = 0
    gengine.audio.playSound(gengine.audio.sound.get("ship_destruction"))
end

function ComponentOuterPlayer.onStateUpdate:dying(dt)
    self.time = self.time + dt
    if self.time > 2 then
        self.entity.spaceShipAnimation:removeAnimations()
        self.entity:remove()
        -- GAME OVER
    end
end

function ComponentOuterPlayer:remove()
end

return ComponentOuterPlayer