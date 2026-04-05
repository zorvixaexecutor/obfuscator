local slf = {}

local function toHex(str)
    return (str:gsub(".", function(c)
        return string.format("%02X", string.byte(c))
    end))
end

local function fromHex(hex)
    return (hex:gsub("..", function(cc)
        return string.char(tonumber(cc, 16))
    end))
end
function slf:makekey(str)
    local key = tostring(math.random(1000000000000,9999999999999))
    local t = {}
    for i = 1, #str do
        local c = string.byte(str, i)
        local k = string.byte(key, 1 + ((i-1) % #key))
        t[i] = string.char(bit32.bxor(c, k))
    end
    return toHex(table.concat(t)), key
end
function slf:key(key, key2)
    local t = {}
    for i = 1, #key do
        local c = string.byte(key, i)
        local k = string.byte(key2, 1 + ((i-1) % #key2))
        t[i] = string.char(bit32.bxor(c, k))
    end
    return toHex(table.concat(t))
end
function slf:obfuscate(str, key)
    local t = {}
    for i = 1, #str do
        local c = string.byte(str, i)
        local k = string.byte(key, 1 + ((i-1) % #key))
        t[i] = string.char(bit32.bxor(c, k))
    end
    return toHex(table.concat(t))
end

function slf:deobfuscate(hex, key)
    local gibberish = fromHex(hex)
    local t = {}
    for i = 1, #gibberish do
        local c = string.byte(gibberish, i)
        local k = string.byte(key, 1 + ((i-1) % #key))
        t[i] = string.char(bit32.bxor(c, k))
    end
    loadstring(table.concat(t))()
end

return slf
