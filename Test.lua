
local MainScene = class("MainScene", cc.load("mvc").ViewBase)
local AtlasLabel = require("app.coms.AtlasLabel")

function MainScene:onCreate()
    -- add background image
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)

    local label = AtlasLabel:create("AtlasLabel", "+2017.08.20+", 0, AtlasLabel.Alignment.Top)
    if label then
    	label:setAnchorPoint(display.CENTER)
    	label:move(display.cx, display.cy+80)
    	label:addTo(self)
    end

    local label = AtlasLabel:createWithFontInfo({font="AtlasLabel", text="+2017.08.20+", charspace=4, alignment=AtlasLabel.Alignment.Bottom})
    if label then
    	label:setAnchorPoint(display.CENTER)
    	label:move(display.cx, display.cy-80)
    	label:addTo(self)
    end
end

return MainScene
