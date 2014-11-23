ComponentBonus = {}

function ComponentBonus:init()

end

function ComponentBonus:insert()
end

function ComponentBonus:update(dt)
    self.entity.rotation = self.entity.rotation + dt
end

function ComponentBonus:remove()
end

return ComponentBonus