ComponentOuterPlayer = ComponentOuterPlayer or require 'component_outer_player'
ComponentSpaceEnemy = ComponentSpaceEnemy or require 'component_space_enemy'
ComponentBullet = ComponentBullet or require 'component_bullet'
ComponentSprayer = ComponentSprayer or require 'component_sprayer'
require 'component_inner_player'

Factory = Factory or {}

function Factory:init()
    gengine.graphics.texture.create("data/tracteur_128.png")
    gengine.graphics.texture.create("data/monster1_fire.png")
    gengine.graphics.texture.create("data/inner_background.png")
    gengine.graphics.texture.create("data/inner_tile.png")

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

    texture = gengine.graphics.texture.create("data/farmer_down.png")
    atlas = gengine.graphics.atlas.create("farmer_down", texture, 16, 1)
    self.farmerDownAnimation = gengine.graphics.animation.create(
        "farmerDown",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
            framerate = 16,
            loop = true
        }
        )

    texture = gengine.graphics.texture.create("data/farmer_up.png")
    atlas = gengine.graphics.atlas.create("farmer_up", texture, 16, 1)
    self.farmerUpAnimation = gengine.graphics.animation.create(
        "farmerUp",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
            framerate = 16,
            loop = true
        }
        )

    gengine.audio.sound.create("data/limace.fire.ogg")
    gengine.audio.sound.create("data/moteur.break.ogg")
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
            camera = camera,
            straffingSound = gengine.audio.sound.get("moteur.break")
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
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
            framerate = 32,
            loop = false
        }
        )

    e.stillSprayingAnimation = gengine.graphics.animation.create(
        "stillSpraying",
        {
            atlas = stillFiringAtlas,
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
            framerate = 32,
            loop = true
        }
        )

    e.stopSprayingAnimation = gengine.graphics.animation.create(
        "stopSpraying",
        {
            atlas = stopFiringAtlas,
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
            framerate = 32,
            loop = false
        }
        )

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            extent = vector2(16, 128),
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

function Factory:createCamera(w)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentCamera(),
        {
            extent = vector2(1024, 600),
            world = w
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

function Factory:createBlock()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("inner_tile"),
            extent = vector2(32, 32),
            layer = 1,
            world = 1
        }
        )

    e:addComponent(
        ComponentPhysic(),
        {
            extent = vector2(32, 32),
            type = "static"
        }
        )

    return e
end

function Factory:createGridBackground()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("inner_background"),
            extent = vector2(512, 512),
            layer = 0,
            world = 1
        }
        )

    return e
end

function Factory:createInvisibleBlock(w, h)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentPhysic(),
        {
            extent = vector2(w, h),
            type = "static"
        }
        )

    return e
end


function Factory:createInnerPlayer()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = self.farmerDownAnimation,
            extent = vector2(40, 32),
            layer = 2,
            world = 1
        },
        "animatedSprite"
        )

    e:addComponent(
        ComponentInnerPlayer(),
        {
        }
        )

    e:addComponent(
        ComponentPhysic(),
        {
            extent = vector2(30, 30),
            type = "dynamic",
            density = 1,
            friction = 1.3
        },
        "physic"
        )

    return e
end

return Factory
