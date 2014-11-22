require "component_outer_player"

Factory = Factory or {}

function Factory:init()
	gengine.graphics.texture.create("data/tracteur_128.png")
end

function Factory:createSpaceShip()
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

    	}
    	)

    return e
end