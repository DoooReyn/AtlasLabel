local AtlasLabel = {}

AtlasLabel.Alignment = {
    Top    = 1.0,
    Center = 0.5,
    Bottom = 0.0
}

local ErrorCode = {
    [1] = "File does not exist.",
    [2] = "Failed to parse LuaFont file.",
    [3] = "Text must not be empty.",
    [4] = "Failed to parse text.",
}

local function onCreateError(filename, code)
    printInfo("Error when creating AtlasLabel '%s'. %s", filename, ErrorCode[code])
end

local function getFrameRect(luaFont, name)
    local idx = luaFont:getFrameIndex(name)
    if not idx then return nil end
    return luaFont:getSheet().frames[idx]
end

function AtlasLabel:create(filename, text, charspace, alignment)
    local basename = "fonts/" .. filename
    local luaname  = basename .. ".lua"
    local resname  = basename .. ".png"

    local fileutil = cc.FileUtils:getInstance()
    if not fileutil:isFileExist(luaname) or not fileutil:isFileExist(resname) then
        onCreateError(filename, ErrorCode[1])
        return nil
    end

    local luaFont = require(basename)
    if not luaFont then
        onCreateError(filename, ErrorCode[2])
    	return nil
    end

    if not text or type(text) ~= "string" or string.len(text) == 0 then
        onCreateError(filename, ErrorCode[3])
    	return nil
    end

    charspace = type(charspace) == "number" and charspace or 0
    alignment = type(alignment) == "number" and alignment or AtlasLabel.Alignment.Center

    local chars = string.utf8chars(text)
    local w, h = 0, 0
    local label = cc.Node:create()
    for _,v in ipairs(chars) do
        local rect = getFrameRect(luaFont, v)
        if rect then
            local charSp = cc.Sprite:create(resname)
            charSp:setTextureRect(rect)
            charSp:setAnchorPoint(cc.p(0, alignment))
            charSp:setPositionX(w)
            charSp:addTo(label)
            w = w + rect.width + charspace
            h = h > rect.height and h or rect.height
        end
    end
    if w == 0 and h == 0 then
        onCreateError(filename, ErrorCode[4])
        return nil
    end
    label:setContentSize(w,h)

    return label
end

function AtlasLabel:createWithFontInfo(fontInfo)
    return self:create(fontInfo.font, fontInfo.text, fontInfo.charspace, fontInfo.alignment)
end

return AtlasLabel