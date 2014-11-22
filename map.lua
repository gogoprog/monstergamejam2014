require 'factory'
require 'map_definitions'

Map = {
    zones = {},
    speed = 100,
    position = 0,
    zoneIndex = 1,
    definition = nil
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
    stars[3] = Factory:createStars("big_stars", -1)
    stars[3]:insert()
    stars[2] = Factory:createStars("small_stars", -2)
    stars[2]:insert()
    stars[1] = Factory:createStars("space", -3)
    stars[1]:insert()
    self.stars = stars

    self.definition = MapDefinitions[1]
    self.zoneCount = #self.definition.zones

    for i=1,3 do
        self.zones[i] = Factory:createZone(self.definition.zones[i])
        self.zones[i]:insert()
        self.zones[i].position.y = (i-2) * 1024
    end

    zoneIndex = 3
end

function Map:update(dt)
    self.position = self.position + dt * self.speed

    for k, zone in ipairs(self.zones) do
        if zone.position.y - self.cameraEntity.position.y < -1024 then
            zone.position.y = zone.position.y + 2 * 4096
            self.zoneIndex = self.zoneIndex + 1
            zone.sprite.texture = gengine.graphics.texture.get(self.definition.zones[((self.zoneIndex -1 ) % self.zoneCount) + 1])
        end
    end

    self.cameraEntity.position.y = self.position

    for k, stars in ipairs(self.stars) do
        stars.position = self.cameraEntity.position
        stars.sprite.uvOffset = vector2(1, - self.position * 0.0000001 * self.speed * k)
    end
end

return Map;