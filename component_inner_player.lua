
ComponentInnerPlayer = {}

function ComponentInnerPlayer:init()
    self.force = vector2(0, 0)
    self.fromPosition = vector2(0, 0)
    self.toPosition = vector2(0, 0)
    self.col = 0
    self.row = 0
    self.targetCol = 0
    self.targetRow = 0
    self.moving = false
end

function ComponentInnerPlayer:insert()
end

function ComponentInnerPlayer:update(dt)
    local keyboard = gengine.input.keyboard
    local move = false
    if not self.moving then
        if not move and keyboard:isDown(79) then
            move = move or self:tryMove(self.col + 1, self.row)
        end
        if not move and keyboard:isDown(80) then
            move = move or self:tryMove(self.col - 1, self.row)
        end
        if not move and keyboard:isDown(81) then
            move = move or self:tryMove(self.col, self.row - 1)
        end
        if not move and keyboard:isDown(82) then
            move = move or self:tryMove(self.col, self.row + 1)
        end
    else
        self.time = self.time + dt
        local p = self.entity.position
        local f = self.time / self.duration
        f = math.min(f, 1)

        p.x = self.fromPosition.x + (self.toPosition.x - self.fromPosition.x) * f
        p.y = self.fromPosition.y + (self.toPosition.y - self.fromPosition.y) * f

        if f == 1 then
            self.col = self.targetCol
            self.row = self.targetRow
            self.moving = false
        end
    end
end

function ComponentInnerPlayer:remove()
end

function ComponentInnerPlayer:tryMove(c, r)
    if not Grid:isBlocked(c , r) then
        self.fromPosition:set(self.entity.position.x, self.entity.position.y)
        self.toPosition.x, self.toPosition.y = Grid:getPosition(c, r)
        self.moving = true
        self.time = 0
        self.duration = 0.2
        self.targetRow = r
        self.targetCol = c

        return true
    end

    return false
end

return ComponentInnerPlayer