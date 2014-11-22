ComponentOuterPlayer = ComponentOuterPlayer or require 'component_outer_player'
ComponentSpaceEnemy = ComponentSpaceEnemy or require 'component_space_enemy'

Factory = Factory or {}

function Factory:init()
    gengine.graphics.texture.create("data/tracteur_128.png")
    gengine.graphics.texture.create("data/monster1.png")

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

function Factory:createZone(texture)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get(texture), 
            extent = vector2(512, 1024),
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
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("monster1"),
            extent = vector2(64, 64),
            layer = 1
        },
        "sprite"
        )

    e:addComponent(
        ComponentSpaceEnemy(),
        {
        },
        "enemy"
        )

    return e
end
