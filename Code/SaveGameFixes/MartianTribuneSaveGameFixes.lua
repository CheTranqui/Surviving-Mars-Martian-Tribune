-- Save Game updates - these are used to migrate a save game using an older version of this mod
-- to the current version.
local current_version = MartianTribuneMod.current_version
local SaveGameFixVersions = { 775, 776 }
for i = 1, #SaveGameFixVersions do
	local UpdateVersion = SaveGameFixVersions[i]
	MartianTribuneMod.SaveGameFixes[UpdateVersion] = {}
end

-- global as it is used in MartianTribune.lua
MartianTribuneMod.Functions.SaveGameUpdate = function(oldData)
	local MartianTribuneMod = MartianTribuneMod
	local SaveGameFixes = MartianTribuneMod.SaveGameFixes
	local VersionNumber = MartianTribune.VersionNumber or oldData.MartianTribune and oldData.MartianTribune.VersionNumber or 0

	if not SaveGameFixes then
		return
	end

	for i = 1, #SaveGameFixVersions do
		local UpdateVersion = SaveGameFixVersions[i]
		if VersionNumber < UpdateVersion then
			SaveGameFixes[UpdateVersion].Upgrade(oldData)
			VersionNumber = MartianTribune.VersionNumber
		end
	end

	-- Game data updated, set the saved version number to the current version.
	MartianTribune.VersionNumber = current_version
end
