ComponentOuterPlayer = ComponentOuterPlayer or require 'component_outer_player'
ComponentSpaceEnemy = ComponentSpaceEnemy or require 'component_space_enemy'
ComponentBullet = ComponentBullet or require 'component_bullet'
ComponentSprayer = ComponentSprayer or require 'component_sprayer'
require 'component_inner_player'
require 'component_bonus'
require 'component_shaker'
require 'component_inner_enemy'

Factory = Factory or {}

function Factory:init()
    gengine.graphics.texture.create("data/spaceship_empty.png")
    gengine.graphics.texture.create("data/spaceship_left.png")
    gengine.graphics.texture.create("data/spaceship_right.png")
    gengine.graphics.texture.create("data/monster1_fire.png")
    gengine.graphics.texture.create("data/inner_background.png")
    gengine.graphics.texture.create("data/inner_tile.png")
    gengine.graphics.texture.create("data/inner_bonus1.png")
    gengine.graphics.texture.create("data/inner_bonus2.png")

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

    texture = gengine.graphics.texture.create("data/monster1_death.png")
    atlas = gengine.graphics.atlas.create("farmer_down", texture, 16, 1)
    self.dyingMonsterAnimation = gengine.graphics.animation.create(
        "dyingMonsterAnimation",
        {
            atlas = atlas,
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
            framerate = 16,
            loop = false
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

    texture = gengine.graphics.texture.create("data/gauge1.png")
    gengine.graphics.atlas.create("gauge1", texture, 10, 1)
    texture = gengine.graphics.texture.create("data/gauge2.png")
    gengine.graphics.atlas.create("gauge2", texture, 10, 1)

    gengine.audio.sound.create("data/limace.fire.ogg")
    gengine.audio.sound.create("data/limace.dead.ogg")
    gengine.audio.sound.create("data/moteur.break.ogg")
    gengine.audio.sound.create("data/bonus1.ogg")
    gengine.audio.sound.create("data/bonus2.ogg")
    gengine.audio.sound.create("data/weapon.jet.start.ogg")
    gengine.audio.sound.create("data/weapon.jet.continu.ogg")
    gengine.audio.sound.create("data/ship_destruction.ogg")
end

function Factory:createSpaceShip(camera)
    local e = gengine.entity.create()
    local texture = gengine.graphics.texture.create("data/spaceship_empty.png")
    e.spaceShip = gengine.graphics.animation.create(
        "spaceShip",
        {
            atlas = gengine.graphics.atlas.create("spaceship_empty", texture, 1, 1),
            frames = { 0 },
            framerate = 1,
            loop = false
        }
        )

    texture = gengine.graphics.texture.create("data/spaceship_left.png")
    e.spaceShipLeft = gengine.graphics.animation.create(
        "spaceShipLeft",
        {
            atlas = gengine.graphics.atlas.create("spaceship_left", texture, 1, 1),
            frames = { 0 },
            framerate = 1,
            loop = false
        }
        )

    texture = gengine.graphics.texture.create("data/spaceship_right.png")
    e.spaceShipRight = gengine.graphics.animation.create(
        "spaceShipRight",
        {
            atlas = gengine.graphics.atlas.create("spaceship_right", texture, 1, 1),
            frames = { 0 },
            framerate = 1,
            loop = false
        }
        )

    texture = gengine.graphics.texture.create("data/spaceship_explosion.png")
    e.spaceShipExplosion = gengine.graphics.animation.create(
        "spaceShipExplosion",
        {
            atlas = gengine.graphics.atlas.create("spaceship_explosion", texture, 16, 1),
            frames = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 },
            framerate = 8,
            loop = false
        }
        )

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = e.spaceShipExplosion,
            extent = vector2(64, 64),
            layer = 0
        },
        "spaceShipAnimation"
        )

    e:addComponent(
        ComponentOuterPlayer(),
        {
            camera = camera,
            straffingSound = gengine.audio.sound.get("moteur.break")
        },
        "outer_player"
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
            extent = vector2(16, 256),
            color = vector4(0.5, 0, 0.5, 0.75),
            layer = 0
        },
        "animatedSprite"
        )

    e:addComponent(
        ComponentSprayer(),
        {
        },
        "sprayer"
        )

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

    e:addComponent(
        ComponentShaker(),
        {
        },
        "shaker"
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

    return e
end

function Factory:createGridBonus(id)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("inner_bonus" .. id),
            extent = vector2(32, 32),
            layer = 1,
            world = 1
        },
        "sprite"
        )

    e:addComponent(
        ComponentBonus(),
        {
            sound = gengine.audio.sound.get("bonus" .. id),
            id = id
        },
        "bonus"
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

    return e
end


function Factory:createInnerEnemy()
    local e = gengine.entity.create()

    e:addComponent(
        ComponentAnimatedSprite(),
        {
            animation = self.monsterAnimation,
            extent = vector2(32, -32),
            layer = 1,
            world = 1
        },
        "sprite"
        )

    e:addComponent(
        ComponentInnerEnemy(),
        {
        },
        "enemy"
        )

    return e
end

function Factory:createGauge(id)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            atlas = gengine.graphics.atlas.get("gauge" .. id),
            atlasItem = 1,
            extent = vector2(32, 128),
            layer = 3,
            world = 1
        },
        "sprite"
        )

    return e
end

return Factory
