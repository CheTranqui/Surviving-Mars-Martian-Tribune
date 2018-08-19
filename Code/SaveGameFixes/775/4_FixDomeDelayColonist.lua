-- Fix colonist for DomeDelay story chain, 774 => 775+.
-- This one is specific to data migration to 775.
MartianTribuneMod.SaveGameFixes[775].FixDomeDelayColonist = function(oldData)
	local MartianTribuneMod = MartianTribuneMod
	local FindStoryInListByKey = MartianTribuneMod.Functions.FindStoryInListByKey
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
	local MartianTribune = MartianTribune
	local SocialArchive = MartianTribune.SocialArchive
	local SocialPotentialStories = MartianTribune.SocialPotentialStories

	-- Need to find the colonist used for DomeDelay1 if DomeDelay2 is not generated.
	local domeDelay2PubIndex, domeDelay2Pub = FindStoryInListByKey(SocialArchive, "DomeDelay2")
	local domeDelay2PotentialIndex, domeDelay2Potential = FindStoryInListByKey(SocialPotentialStories, "DomeDelay2")
	if oldData.MTEarthlingDelayName and not domeDelay2PubIndex and not domeDelay2PotentialIndex then
		-- Find Earthlings with the same name
		local colonists = FilterObjects({
			filter = function(colonist)
				return colonist.name == oldData.MTEarthlingDelayName and not colonist.traits.Martianborn
			end
		}, UICity.labels.Colonist or empty_table)

		-- Find the DomeDelay1 story
		local domeDelay1PubIndex, domeDelay1Pub = FindStoryInListByKey(SocialArchive, "DomeDelay1")
		local domeDelay1PotentialIndex, domeDelay1Potential = FindStoryInListByKey(SocialPotentialStories, "DomeDelay1")

		if colonists and #colonists > 0 then
			if domeDelay1Pub and not IsValidColonist(domeDelay1Pub.colonist) then
				-- try to restore a pinned earthling colonist with that name
				local pinned = FilterObjects({
					filter = function(colonist)
						return colonist.is_pinned
					end
				}, colonists)
				if pinned and #pinned > 0 then
					domeDelay1Pub.colonist = table.random(pinned)
				else
					-- fallback to any earthling colonist with that name
					domeDelay1Pub.colonist = table.random(colonists)
				end
			else
				if domeDelay1Potential and not IsValidColonist(domeDelay1Potential.colonist) then
					domeDelay1Potential.colonist = table.random(colonists)
				end
			end
		end
		if domeDelay1Pub then
			domeDelay1Pub.colonist_name = oldData.MTEarthlingDelayName
		elseif domeDelay1Potential then
			domeDelay1Potential.colonist_name = oldData.MTEarthlingDelayName
		end
	end
end
