local Themes = {
	Names = {
		"Dark",
		"Darker",
		"AMOLED",
		"Light",
		"Balloon",
		"SoftCream",
		"Aqua",
		"Amethyst",
		"Rose",
		"Midnight",
		"Forest",
		"Sunset",
		"Ocean",
		"Emerald",
		"Sapphire",
		"Cloud",
		"Grape",
		"Bloody",
		"Arctic",
	},
}

for _, Theme in next, script:GetChildren() do
	local Required = require(Theme)
	Themes[Required.Name] = Required
end

return Themes
