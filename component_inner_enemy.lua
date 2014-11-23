
ComponentInnerEnemy = {}

local mabs = math.abs

function ComponentInnerEnemy:init()
    self.force = vector2(0, 0)
    self.fromPosition = vector2(0, 0)
    self.toPosition = vector2(0, 0)
    self.col = 0
    self.row = 0
    self.targetCol = 0
    self.targetRow = 0
    self.moving = false
end

function ComponentInnerEnemy:insert()
end

function ComponentInnerEnemy:update(dt)
    local move = false
    if not self.moving then
        local dx, dy
        local farmer_position = Grid.farmer.position
        local p = self.entity.position

        dx = p.x - farmer_position.x
        dy = p.y - farmer_position.y

        if mabs(dx) > mabs(dy) then
            if not self:tryMove(self.col - dx/mabs(dx), self.row) and dy ~= 0 then
                self:tryMove(self.col, self.row - dy/mabs(dy))
            end
        elseif mabs(dx) < mabs(dy) then
            if not self:tryMove(self.col, self.row - dy/mabs(dy)) and dx ~= 0 then
                self:tryMove(self.col - dx/mabs(dx), self.row)
            end
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
            if Grid:isBonus(self.col, self.row) then
                --Grid:getBonus(self.col, self.row).bonus:pick()
            end
        end
    end
end

function ComponentInnerEnemy:remove()
end

function ComponentInnerEnemy:tryMove(c, r)
    if not Grid:isBlocked(c , r) then
        self.fromPosition:set(self.entity.position.x, self.entity.position.y)
        self.toPosition.x, self.toPosition.y = Grid:getPosition(c, r)
        self.moving = true
        self.time = 0
        self.duration = 0.4
        self.targetRow = r
        self.targetCol = c

        return true
    end

    return false
end

return ComponentInnerEnemy