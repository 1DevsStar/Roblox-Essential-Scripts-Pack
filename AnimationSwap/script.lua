-- Placer ce script dans un LocalScript dans StarterPlayerScripts
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Remplace les IDs par les tiens
local animations = {
	walk = 87812805869290,
	run = 73851053686510,
	crouch = 119621015307590
}

local currentState = "walk"
local animationTrack = nil

local function loadAnimation(id)
	if animationTrack then animationTrack:Stop() end
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://" .. id
	animationTrack = humanoid:LoadAnimation(anim)
	animationTrack:Play()
end

-- Change state
local function swapState()
	if currentState == "walk" then
		currentState = "run"
	elseif currentState == "run" then
		currentState = "crouch"
	else
		currentState = "walk"
	end
	loadAnimation(animations[currentState])
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.X then
		swapState()
	end
end)

-- Charge l'anim de départ
loadAnimation(animations.walk)
