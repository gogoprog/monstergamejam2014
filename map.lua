require 'factory'
require 'map_definitions'

Map = {
    zones = {},
    speed = 200,
    position = 0,
    zoneIndex = 1,
    spaceSpeedFactor = 0.0000001,
    definition = nil,
    center = 0
}

function Map:init()
    gengine.graphics.texture.create("data/plateforme.png")
    gengine.graphics.texture.create("data/big_stars.png")
    gengine.graphics.texture.create("data/small_stars.png")
    gengine.graphics.texture.create("data/black.png")
    gengine.graphics.texture.create("data/space.png")

    self.cameraEntity = Factory:createCamera()

    self.cameraEntity:insert()

    local stars = {}
    stars[3] = Factory:createStars("big_stars", -2)
    stars[3]:insert()
    stars[2] = Factory:createStars("small_stars", -3)
    stars[2]:insert()
    stars[1] = Factory:createStars("space", -4)
    stars[1]:insert()
    self.stars = stars

    self.definition = MapDefinitions[1]
    self.zoneCount = #self.definition.zones

    self.zones[1] = Factory:createZone("black")
    self.zones[1]:insert()
    self.zones[1].position.y = 0
    self.zones[2] = Factory:createZone(self.definition.zones[1].texture)
    self.zones[2]:insert()
    self.zones[2].position.y = 1 * 1024
    self.zoneIndex = 1
    self:onNewZone(self.definition.zones[self.zoneIndex])
end

function Map:update(dt)
    self.position = self.position + dt * self.speed

    for k, zone in ipairs(self.zones) do
        if zone.position.y - self.cameraEntity.position.y < -1024 then
            zone.position.y = zone.position.y + 2 * 1024
            self.zoneIndex = self.zoneIndex + 1
            local def = self.definition.zones[((self.zoneIndex -1 ) % self.zoneCount) + 1]
            zone.sprite.texture = gengine.graphics.texture.get(def.texture)
            self:onNewZone(def)
        end
    end

    self.cameraEntity.position.y = self.position

    for k, stars in ipairs(self.stars) do
        stars.position = self.cameraEntity.position
        stars.sprite.uvOffset = vector2(1, - self.position * self.spaceSpeedFactor * self.speed * k)
    end
end

function Map:onNewZone(definition)
    if definition.enemies then
        for k, v in ipairs(definition.enemies) do
            local e = Factory:createSpaceEnemy()
            e.position.x = math.random(self.center - 200, self.center + 200)
            e.position.y = self.cameraEntity.position.y + 1 * 1024 + math.random(-200, 200)
            e:insert()
        end
    end
end

return Map