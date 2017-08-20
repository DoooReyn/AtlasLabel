--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:30a2f4f5829f7fc241616437d2cbb191:1/1$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- +
            x=280,
            y=0,
            width=24,
            height=24,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 26,
            sourceHeight = 26
        },
        {
            -- 0
            x=252,
            y=0,
            width=28,
            height=49,

        },
        {
            -- 1
            x=224,
            y=0,
            width=28,
            height=49,

        },
        {
            -- 2
            x=196,
            y=0,
            width=28,
            height=49,

        },
        {
            -- 3
            x=168,
            y=0,
            width=28,
            height=49,

        },
        {
            -- 4
            x=140,
            y=0,
            width=28,
            height=49,

        },
        {
            -- 5
            x=112,
            y=0,
            width=28,
            height=49,

        },
        {
            -- 6
            x=84,
            y=0,
            width=28,
            height=49,

        },
        {
            -- 7
            x=56,
            y=0,
            width=28,
            height=49,

        },
        {
            -- 8
            x=28,
            y=0,
            width=28,
            height=49,

        },
        {
            -- 9
            x=0,
            y=0,
            width=28,
            height=49,

        },
    },
    
    sheetContentWidth = 304,
    sheetContentHeight = 49
}

SheetInfo.frameIndex =
{

    ["+"] = 1,
    ["0"] = 2,
    ["1"] = 3,
    ["2"] = 4,
    ["3"] = 5,
    ["4"] = 6,
    ["5"] = 7,
    ["6"] = 8,
    ["7"] = 9,
    ["8"] = 10,
    ["9"] = 11,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
