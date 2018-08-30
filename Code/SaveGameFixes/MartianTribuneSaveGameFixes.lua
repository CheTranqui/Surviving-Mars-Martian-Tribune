-- Save Game updates - these are used to migrate a save game using an older version of this mod
-- to the current version.
local current_version = MartianTribuneMod.current_version
MartianTribuneMod.SaveGameFixes[775] = {}

-- global as it is used in MartianTribune.lua
MartianTribuneMod.Functions.SaveGameUpdate = function(oldData)
	local MartianTribuneMod = MartianTribuneMod
	local SaveGameFixes = MartianTribuneMod.SaveGameFixes
	local VersionNumber = MartianTribune.VersionNumber or oldData.MartianTribune and oldData.MartianTribune.VersionNumber or 0

	if not SaveGameFixes then
		return
	end

	-- Initial upgrades, for versions 774 or lower to 775.
	if not VersionNumber or VersionNumber < 775 then
		if SaveGameFixes[775] then
			SaveGameFixes[775].Upgrade(oldData)
		end
	end

	-- Game data updated, set the saved version number to the current version.
	MartianTribune.VersionNumber = current_version
end
