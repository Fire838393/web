local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

print("Starting Base Spawner...")

local NUM_BASES = 8
local SPACING = 60
local PODIUMS_PER_BASE = 10
local SLOTS_PER_PODIUM = 10

local playerBasesFolder = Workspace:FindFirstChild("PlayerBases")
if not playerBasesFolder then
	playerBasesFolder = Instance.new("Folder")
	playerBasesFolder.Name = "PlayerBases"
	playerBasesFolder.Parent = Workspace
	print("Created PlayerBases folder in Workspace")
else
	print("Found existing PlayerBases folder")
	for _, child in pairs(playerBasesFolder:GetChildren()) do
		child:Destroy()
	end
	print("Cleared existing bases")
end

local function createSlot(slotNumber)
	local slot = Instance.new("Model")
	slot.Name = "Slot" .. slotNumber

	local platform = Instance.new("Part")
	platform.Name = "Platform"
	platform.Size = Vector3.new(1.2, 0.3, 1.2)
	platform.Color = Color3.fromRGB(200, 200, 200)
	platform.Material = Enum.Material.Plastic
	platform.Anchored = true
	platform.Parent = slot

	local spawn = Instance.new("Part")
	spawn.Name = "Spawn"
	spawn.Size = Vector3.new(0.1, 0.1, 0.1)
	spawn.Color = Color3.fromRGB(0, 255, 0)
	spawn.Material = Enum.Material.Neon
	spawn.Anchored = true
	spawn.Transparency = 0.5
	spawn.CanCollide = false
	spawn.Position = platform.Position + Vector3.new(0, 1, 0)
	spawn.Parent = slot

	local bobType = Instance.new("StringValue")
	bobType.Name = "BobType"
	bobType.Value = ""
	bobType.Parent = slot

	local bobModel = Instance.new("ObjectValue")
	bobModel.Name = "BobModel"
	bobModel.Value = nil
	bobModel.Parent = slot

	slot.PrimaryPart = platform
	return slot
end

spawn(function()
	wait(2)
	local basesFolder = ReplicatedStorage:FindFirstChild("Bases2")
	if basesFolder then
		print("Found existing base templates, using PlayerBaseTemplate1...")
		local template = basesFolder:FindFirstChild("PlayerBaseTemplate1")
		if template then
			for i = 1, NUM_BASES do
				local base = template:Clone()
				base.Name = "PlayerBase" .. i
				base.Parent = playerBasesFolder
				print("Spawned PlayerBase" .. i .. " using PlayerBaseTemplate1")
			end
		else
			print("PlayerBaseTemplate1 not found in Bases2 folder")
		end
	else
		print("No Bases2 folder found, system will wait...")
	end
end)

print("Base Spawning System loaded!")