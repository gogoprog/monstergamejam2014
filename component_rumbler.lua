ComponentRumbler = {}

function ComponentRumbler:init()
    self.timeLeft = 0
end

function ComponentRumbler:insert()
    self.baseRotation = self.entity.rotation
end

function ComponentRumbler:update(dt)
    if self.timeLeft > 0 then
        self.timeLeft = self.timeLeft - dt

        self.time = self.time + dt

        if self.time > 0.05 then
            local p = self.entity.position
            self.entity.rotation = math.random() * 0.2 - 0.1
            self.time = 0
        end

        if self.timeLeft <= 0 then
            self.entity.rotation = self.baseRotation
        end
    end
end

function ComponentRumbler:remove()

end

function ComponentRumbler:rumble(duration)
    self.timeLeft = duration
    self.time = 0
end

return ComponentRumbler
