ComponentBonus = {}

function ComponentBonus:init()
    self.timeLeft = 5
end

function ComponentBonus:insert()
end

function ComponentBonus:update(dt)
    self.entity.rotation = self.entity.rotation + dt

    self.timeLeft = self.timeLeft - dt

    self.entity.sprite.alpha = self.timeLeft / 5

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

local effects = {
    function()
        Map.ship.outer_player:addAmmo(5)
    end,
    function()
        Map.ship.outer_player:addLife(5)
    end
}
function ComponentBonus:pick()
    effects[self.id]()
    gengine.audio.playSound(self.sound)
    self.entity:remove()
    gengine.entity.destroy(self.entity)
end

return ComponentBonus