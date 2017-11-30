------------------------------------
-- Name : FontCache
-- Author : Reyn
-- Date : 2017-11-13
--
local FontCache = class('FontCache') 
local fileUtils = cc.FileUtils:getInstance()

function FontCache:ctor( ... )
    self.cache = {}
end

function FontCache:loadFont(jsonname)
    local data = self.cache[jsonname]
    if data then return data end

    local jsonFile = "Font/" .. jsonname .. ".json"
    local jsonImg  = "Font/" .. jsonname .. ".png"
    if not fileUtils:isFileExist(jsonFile) then
        return 
    end

    local str = fileUtils:getStringFromFile(jsonFile)
    if not str or string.len(str) == 0 then
        return 
    end
    
    local jsonData = json.decode(str)
    if not jsonData or not jsonData.frames then
        return 
    end 

    for i,v in ipairs(jsonData.frames) do
        jsonData["frm_"..v.filename] = v
    end

    self.cache[jsonname] = jsonData
    
    return jsonData
end

-- ansi 字符串转lua表
local function string2table(chars)
    local len = string.len(chars)
    local t = {}
    for i=1,len do
        t[i] = string.sub(chars,i,i)
    end
    return t
end

--获取json方式的图片字节点
-- @param: jsonname json字体文件名称
-- @param: chars 需要表现的字符文本
-- @param: charspace 字符间距 [默认为0]
-- @param: valignment 垂直对齐方式 [0:下对齐, 0.5:居中, 1:上对齐. 默认居中]
--
function FontCache:newText(jsonname, chars, charspace, valignment)
    if not chars or string.len(chars) == 0 then
        return nil
    end
    
    local jsonData = self:loadFont(jsonname)
    if not jsonData then 
        return nil 
    end

    local base = "Font/" 
    charspace  = type(charspace)  == "number" and charspace  or 0
    valignment = type(valignment) == "number" and valignment or 0.5

    local tchar = string2table(chars)
    local tsprite = {}
    local spriteName = base..jsonData.meta.image
    for i,v in ipairs(tchar) do
        local frameInfo = jsonData["frm_"..v]
        if frameInfo then
            local fontSp = cc.Sprite:create(spriteName)
            local frm  = frameInfo.frame
            local rect = cc.rect(frm.x, frm.y, frm.w, frm.h)
            fontSp:setTextureRect(rect)
            fontSp:setAnchorPoint(cc.p(0, valignment))
            table.insert(tsprite, fontSp)
        end
    end

    if #tsprite > 0 then
        local atlasNode = cc.Node:create()
        local w,h = 0,0
        for i,v in ipairs(tsprite) do
            atlasNode:addChild(v)
            v:setPositionX(w)
            local size = v:getContentSize()
            w = w + size.width + charspace
            h = h > size.height and h or size.height
        end
        atlasNode:setContentSize(w,h)
        return atlasNode
    end

    return nil
end

return FontCache
