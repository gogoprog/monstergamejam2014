ComponentOuterPlayer = ComponentOuterPlayer or require 'component_outer_player'

Factory = Factory or {}

function Factory:init()
    gengine.graphics.texture.create("data/tracteur_128.png")
end

function Factory:createSpaceShip(camera)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get("tracteur_128"),
            extent = vector2(128, 128),
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

function Factory:createStars(texture)
    local e = gengine.entity.create()

    e:addComponent(
        ComponentSprite(),
        {
            texture = gengine.graphics.texture.get(texture), 
            extent = vector2(512, 4096),
            layer = -2
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
