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


function slf:key(str,key)
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
	local success, err = pcall(function()
		loadstring(table.concat(t))()
	end)
	if not success then
		warn("Wrong key")
	end
end

return slf
