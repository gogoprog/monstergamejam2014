require 'map_definitions'

Map = {
    zones = {},
    speed = 200,
    position = 0,
    zoneIndex = 1,
    spaceSpeedFactor = 0.0000001,
    definition = nil,
    center = 256,
    zoneSize = 600,
    enemies = {}
}

function Map:init()
    for i=0, 2 do
        gengine.graphics.texture.create("data/plateforme" .. i .. ".png")
    end
    gengine.graphics.texture.create("data/big_stars.png")
    gengine.graphics.texture.create("data/small_stars.png")
    gengine.graphics.texture.create("data/black.png")
    gengine.graphics.texture.create("data/space.png")

    self.cameraEntity = Factory:createCamera(0)

    self.cameraEntity:insert()

    local stars = {}
    stars[3] = Factory:createStars("big_stars", -2)
    stars[3]:insert()
    stars[2] = Factory:createStars("small_stars", -3)
    stars[2]:insert()
    stars[1] = Factory:createStars("space", -4)
    stars[1]:insert()
    self.stars = stars

    for k, star in ipairs(stars) do
        star.position.x = self.center
    end

    self.definition = MapDefinitions[1]
    self.zoneCount = #self.definition.zones

    self.zones[1] = Factory:createZone("black")
    self.zones[1]:insert()
    self.zones[1].position.x = self.center
    self.zones[1].position.y = 0
    self.zones[2] = Factory:createZone(self.definition.zones[1].texture)
    self.zones[2]:insert()
    self.zones[2].position.x = self.center
    self.zones[2].position.y = 1 * self.zoneSize

end

function Map:start()
    self.zoneIndex = 1
    self:onNewZone(self.definition.zones[self.zoneIndex])

    self.ship = Factory:createSpaceShip(self.cameraEntity.camera)
    self.ship:insert()
end

function Map:update(dt)
    self.position = self.position + dt * self.speed

    for k, zone in ipairs(self.zones) do
        if zone.position.y - self.cameraEntity.position.y < -self.zoneSize then
            zone.position.y = zone.position.y + 2 * self.zoneSize
            zone.position.x = self.center
            self.zoneIndex = self.zoneIndex + 1
            local def = self.definition.zones[((self.zoneIndex -1 ) % self.zoneCount) + 1]
            zone.sprite.texture = gengine.graphics.texture.get(def.texture)
            self:onNewZone(def)
        end
    end

    self.cameraEntity.position.y = self.position

    for k, stars in ipairs(self.stars) do
        stars.position.y = self.cameraEntity.position.y
        stars.sprite.uvOffset = vector2(1, - self.position * self.spaceSpeedFactor * self.speed * k)
    end
end

function Map:onNewZone(definition)
    if definition.enemies then
        for k, v in ipairs(definition.enemies) do
            local e = Factory:createSpaceEnemy()
            e.position.x = math.random(self.center - 200, self.center + 200)
            e.position.y = self.cameraEntity.position.y + 1 * self.zoneSize + math.random(-200, 200)
            e:insert()
            self.enemies[#self.enemies+1] = e
        end
    end
end

return Map