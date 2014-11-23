ComponentBonus = {}

function ComponentBonus:init()
    self.timeLeft = 5
end

function ComponentBonus:insert()
end

function ComponentBonus:update(dt)
    self.entity.rotation = self.entity.rotation + dt

    self.timeLeft = self.timeLeft - dt

    if self.timeLeft < 0 then

        self.entity:remove()
        gengine.entity.destroy(self.entity)
    end
end

function ComponentBonus:remove()
end

return ComponentBonus