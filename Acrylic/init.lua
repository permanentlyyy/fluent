local Acrylic = {
	AcrylicBlur = require(script.AcrylicBlur),
	CreateAcrylic = require(script.CreateAcrylic),
	AcrylicPaint = require(script.AcrylicPaint),
}

local baseEffect
local depthOfFieldDefaults = {}
local Initialized = false

function Acrylic.Enable()
	for _, effect in pairs(depthOfFieldDefaults) do
		effect.Enabled = false
	end
	baseEffect.Parent = game:GetService("Lighting")
end

function Acrylic.Disable()
	for _, effect in pairs(depthOfFieldDefaults) do
		effect.Enabled = effect.enabled
	end
	baseEffect.Parent = nil
end

function Acrylic.init()
	if Initialized then
		return
	end
	Initialized = true

	baseEffect = Instance.new("DepthOfFieldEffect")
	baseEffect.FarIntensity = 0
	baseEffect.InFocusRadius = 0.1
	baseEffect.NearIntensity = 1

	depthOfFieldDefaults = {}

	local function register(object)
		if object:IsA("DepthOfFieldEffect") then
			depthOfFieldDefaults[object] = { enabled = object.Enabled }
		end
	end

	for _, child in pairs(game:GetService("Lighting"):GetChildren()) do
		register(child)
	end

	if game:GetService("Workspace").CurrentCamera then
		for _, child in pairs(game:GetService("Workspace").CurrentCamera:GetChildren()) do
			register(child)
		end
	end

	Acrylic.Enable()
end

-- Fully undo init(): re-enable the game's effects, remove ours and reset state.
function Acrylic.Destroy()
	if not Initialized then
		return
	end
	Initialized = false

	for effect, data in pairs(depthOfFieldDefaults) do
		pcall(function()
			if effect and effect.Parent then
				effect.Enabled = data.enabled
			end
		end)
	end

	if baseEffect then
		baseEffect:Destroy()
		baseEffect = nil
	end

	depthOfFieldDefaults = {}
end

return Acrylic
