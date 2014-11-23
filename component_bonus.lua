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
    for k, v in pairs(Grid.bonuses) do
        if v == self.entity then
            Grid.bonuses[k] = nil
            break
        end
    end
end

function ComponentBonus:pick()
    Map.ship.outer_player:addAmmo(5)

    gengine.audio.playSound(self.sound)
    self.entity:remove()
    gengine.entity.destroy(self.entity)
end

return ComponentBonus