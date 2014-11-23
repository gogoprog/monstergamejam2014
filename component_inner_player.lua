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
    self.idleTime = 0
    self.idling = true
    self.isHunting = false
    self.isDying = false
    self.life = 3
end

function ComponentInnerPlayer:insert()
end

function ComponentInnerPlayer:update(dt)
    if self.isDying then
        self.time = self.time + dt

        if self.time > 1.6 then
            self.time = 0
            self.isDying = false

            self.life = self.life - 1

            if self.life < 0 then
                Map.ship.outer_component:takeDamage(Map.ship.outer_component.life)
            else
                Grid:newRound()
            end
        end
    else
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

            if not self.moving then
                self.idleTime = self.idleTime + dt

                if self.idleTime > 0.4 then
                    self.idling = true
                    self.entity.animatedSprite:removeAnimations()
                    self.entity.animatedSprite:pushAnimation(Factory.farmerIdleAnimation)
                    self.entity.animatedSprite.extent = vector2(22, 22)
                    self.idleTime = 0
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
                    Grid:getBonus(self.col, self.row).bonus:pick()
                end

            end
        end

        if not self.isHunting then
            for k, v in ipairs(Grid.enemies) do
                local p = self.entity.position
                local op = v.position

                if gengine.math.getSquareDistance(op, p) < 10 * 10 then
                    self:beDead()
                end
            end
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
        if self.idling then
            self.entity.animatedSprite:removeAnimations()
            self.entity.animatedSprite:pushAnimation(Factory.farmerDownAnimation)
            self.entity.animatedSprite.extent = vector2(40, 32)
            self.idling = false
            self.idleTime = 0
        end

        return true
    end

    return false
end

function ComponentInnerPlayer:beDead()
    gengine.audio.playSound(Factory.farmerDieSound)
    self.isDying = true
    self.time = 0
    self.entity.animatedSprite:removeAnimations()
    self.entity.animatedSprite:pushAnimation(Factory.farmerDeadAnimation)
    self.entity.animatedSprite.extent = vector2(22, 22)
end

return ComponentInnerPlayer