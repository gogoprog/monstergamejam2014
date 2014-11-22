ComponentOuterPlayer = ComponentOuterPlayer or require 'component_outer_player'
ComponentSpaceEnemy = ComponentSpaceEnemy or require 'component_space_enemy'
ComponentBullet = ComponentBullet or require 'component_bullet'
ComponentSprayer = ComponentSprayer or require 'component_sprayer'

Factory = Factory or {}

function Factory:init()
    gengine.graphics.texture.create("data/tracteur_128.png")
    gengine.graphics.texture.create("data/monster1_fire.png")

    local texture = gengine.graphics.texture.create("data/monster1.png")

    local atlas = gengine.graphics.atlas.create("monster", texture, 16, 1)
    self.monsterAnimation = gengine.graphics.animation.create(
        "monsterAnimation",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
            framerate = 16,
            loop = true
        }
        )

    gengine.audio.sound.create("data/limace.fire.ogg")
end

function Factory:createSpaceShip(camera)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("tracteur_128"),
            extent = vector2(64, 64),
            layer = 0
        }
        )

    e:addComponent(
        ComponentOuterPlayer(),
        {
            camera = camera
        }
        )

    return e
end

function Factory:createSprayer()
    local e = gengine.entity.create()

    local startFiringTexture = gengine.graphics.texture.create("data/fire_start.png")
    local startFiringAtlas = gengine.graphics.atlas.create("fire_start", startFiringTexture, 16, 1)

    local stillFiringTexture = gengine.graphics.texture.create("data/fire_middle.png")
    local stillFiringAtlas = gengine.graphics.atlas.create("fire_middle", stillFiringTexture, 16, 1)

    local stopFiringTexture = gengine.graphics.texture.create("data/fire_end.png")
    local stopFiringAtlas = gengine.graphics.atlas.create("fire_end", stopFiringTexture, 16, 1)

    e.startSprayingAnimation = gengine.graphics.animation.create(
        "startSpraying",
        {
            atlas = startFiringAtlas,
            frames = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 },
            framerate = 32,
            loop = false
        }
        )

    e.stillprayingAnimation = gengine.graphics.animation.create(
        "stillSpraying",
        {
            atlas = stillFiringAtlas,
            frames = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 },
            framerate = 5,
            loop = true
        }
        )

    e.stopSprayingAnimation = gengine.graphics.animation.create(
        "stopSpraying",
        {
            atlas = stopFiringAtlas,
            frames = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 },
            framerate = 5,
            loop = false
        }
        )

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            extent = vector2(16, 256),
            layer = 0
        },
        "animatedSprite"
        )

    e:addComponent(
        ComponentSprayer(),
        {
        },
        "sprayer")

    return e
end

function Factory:createZone(texture)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get(texture), 
            extent = vector2(512, 512),
            layer = -1
        },
        "sprite"
        )

    return e
end

function Factory:createStars(texture, layer)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get(texture), 
            extent = vector2(512, 4096),
            layer = layer
        },
        "sprite"
        )

    return e
end

function Factory:createCamera()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentCamera(),
        {
            extent = vector2(1024, 600)
        },
        "camera"
        )

    return e
end

function Factory:createSpaceEnemy()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = self.monsterAnimation,
            extent = vector2(32, 64),
            layer = 1
        },
        "sprite"
        )

    e:addComponent(
        ComponentSpaceEnemy(),
        {
            fireSound = gengine.audio.sound.get("limace.fire")
        },
        "enemy"
        )

    return e
end

function Factory:createBullet(speed)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("monster1_fire"),
            extent = vector2(16, 16),
            layer = 0
        }
        )

    e:addComponent(
        ComponentBullet(),
        {
            speed = speed
        }
        )

    return e
end

return Factory
