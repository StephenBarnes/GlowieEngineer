local function glow(layer)
	if type(layer) ~= "table" then return end
	if layer.apply_runtime_tint then
		layer.draw_as_glow = true
		layer.blend_mode = "additive"
	end
end

local function glow_recursive(x)
	if x == nil then return end
	if type(x) ~= "table" then return end
	glow(x)
	for _, key in pairs{"picture", "sheet", "layers", "stripes", "pictures", "sheets", "animations"} do
		glow_recursive(x[key])
	end
	if x[1] ~= nil then
		for _, y in pairs(x) do
			glow_recursive(y)
		end
	end
end

for _, corpse in pairs(data.raw["character-corpse"]) do
	for _, x in pairs(corpse) do
		glow_recursive(x)
	end
end
for _, character in pairs(data.raw.character) do
	for _, animation in pairs(character.animations) do
		for _, x in pairs(animation) do
			glow_recursive(x)
		end
	end
end