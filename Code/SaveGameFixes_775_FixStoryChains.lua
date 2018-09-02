
-- Remove later stories from a chain if the previous stories have not yet been published. This is to
-- fix the issue where both chainstory1 and chainstory2 have been placed in the list of potential
-- stories, risking the second being shown before the first.
MartianTribuneMod.SaveGameFixes[775].FixUnpublishedStoryChains = function(list)
	-- Martian Tribune Version 774 => 775+
	local FindStoryInListByKey = MartianTribuneMod.Functions.FindStoryInListByKey
	local MartianTribune = MartianTribune

	if not MartianTribune.VersionNumber or MartianTribune.VersionNumber < 775 then
		local olympics1Index, olympics1 = FindStoryInListByKey(list, "OlympicsBid1")
		if olympics1Index then
			local olympics2Index, olympics2 = FindStoryInListByKey(list, "OlympicsBid2")
			if olympics2Index then
				table.remove(list, olympics2Index)
				MartianTribune.Sent.OlympicsBid2 = nil
			end
		end

		local fightClub1Index, fightClub1 = FindStoryInListByKey(list, "FightClub1")
		if fightClub1 then
			local fightClub2Index, fightClub2 = FindStoryInListByKey(list, "FightClub2")
			if fightClub2Index then
				table.remove(list, fightClub2Index)
				MartianTribune.Sent.FightClub2 = nil
			end
		end

		local pewPewIndex, pewPew = FindStoryInListByKey(list, "PewPew")
		if pewPewIndex then
			local pewPew2Index, pewPew2 = FindStoryInListByKey(list, "PewPewPew")
			if pewPew2Index then
				table.remove(list, pewPew2Index)
				MartianTribune.Sent.PewPewPew = nil
			end
		end

		for i = 1,3 do
			local veganIndex, vegan = FindStoryInListByKey(list, "Vegan"..i)
			if veganIndex then
				for j = i+1, 4 do
					local veganChainIndex, veganChain = FindStoryInListByKey(list, "Vegan"..j)
					if veganChainIndex then
						table.remove(list, veganChainIndex)
						if j == 1 then
							MartianTribune.Sent.Vegan1 = nil
						elseif j == 2 then
							MartianTribune.Sent.Vegan2 = nil
						elseif j == 3 then
							MartianTribune.Sent.Vegan3 = nil
						elseif j == 4 then
							MartianTribune.Sent.Vegan4 = nil
						end
					end
				end
			end
		end

		local domeDelay1Index, domeDelay1 = FindStoryInListByKey(list, "DomeDelay1")
		if domeDelay1Index then
			local domeDelay2Index, domeDelay2 = FindStoryInListByKey(list, "DomeDelay2")
			if domeDelay2Index then
				table.remove(list, domeDelay2Index)
				MartianTribune.Sent.DomeDelay2 = nil
			end
		end

		for i = 1, 2 do
			local droneHackIndex, droneHack = FindStoryInListByKey(list, "DroneHack"..i)
			if droneHackIndex then
				for j = i+1, 3 do
					local droneHackChainIndex, droneHackChain = FindStoryInListByKey(list, "DroneHack"..j)
					if droneHackChainIndex then
						table.remove(list, droneHackChainIndex)
						if j == 2 then
							MartianTribune.Sent.DroneHack2 = nil
						elseif j == 3 then
							MartianTribune.Sent.DroneHack3 = nil
						end
					end
				end
			end
		end
	end
end
