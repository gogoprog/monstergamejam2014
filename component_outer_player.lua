ComponentOuterPlayer = {}

function ComponentOuterPlayer:init()
    self.total = 0
    self.speed = 0
end

function ComponentOuterPlayer:insert()
end

function ComponentOuterPlayer:update(dt)
    local e = self.entity
    self.total = self.total + dt
    e.position.x = math.sin(self.total) * 100
end

function ComponentOuterPlayer:remove()
end