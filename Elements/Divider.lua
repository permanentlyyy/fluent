local Root = script.Parent.Parent
local Creator = require(Root.Creator)

local New = Creator.New

local Divider = {}
Divider.__index = Divider
Divider.__type = "Divider"

function Divider:New(Idx, Config)
	if type(Idx) == "table" then
		Config = Idx
	end
	Config = Config or {}

	local Object = setmetatable({}, Divider)

	local Inset = Config.Inset or 0

	Object.Frame = New("Frame", {
		Name = "Divider",
		Size = UDim2.new(1, -(Inset * 2), 0, Config.Height or 1),
		Position = UDim2.fromOffset(Inset, 0),
		BackgroundTransparency = Config.Transparency or 0.4,
		LayoutOrder = 7,
		Parent = self.Container,
		ThemeTag = {
			BackgroundColor3 = Config.Color or "ElementBorder",
		},
	})

	return Object
end

return Divider
