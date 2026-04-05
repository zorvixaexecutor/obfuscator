local slf = {}

function slf:obfuscate(str, key)
    local t = {}
    for i = 1, #str do
        local c = string.byte(str, i)
        local k = string.byte(key, 1 + ((i-1) % #key))
        table.insert(t, string.char(bit32.bxor(c, k)))
    end
    return table.concat(t)
end

function slf:deobfuscate(gibberish, key)
    local t = {}
    for i = 1, #gibberish do
        local c = string.byte(gibberish, i)
        local k = string.byte(key, 1 + ((i-1) % #key))
        table.insert(t, string.char(bit32.bxor(c, k)))
    end
    return table.concat(t)
end

return slf
