ComponentShaker = {}

function ComponentShaker:init()
    self.timeLeft = 0
end

function ComponentShaker:insert()
    local p = self.entity.position
    self.basePosition = vector2(p.x, p.y)
end

function ComponentShaker:update(dt)
    if self.timeLeft > 0 then
        self.timeLeft = self.timeLeft - dt

        self.time = self.time + dt

        if self.time > 0.05 then
            local p = self.entity.position
            p.x = self.basePosition.x + math.random(-3, 3)
            p.y = self.basePosition.y + math.random(-3, 3)
            self.time = 0
        end

        if self.timeLeft <= 0 then
            self.entity.position:set(self.basePosition.x, self.basePosition.y)
        end
    end
end

function ComponentShaker:remove()

end

function ComponentShaker:shake(duration)
    self.timeLeft = duration
    self.time = 0
end

return ComponentShaker