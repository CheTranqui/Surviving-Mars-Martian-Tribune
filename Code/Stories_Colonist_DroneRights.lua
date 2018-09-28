local TraitId = "Idiot"
local Key1 = "DroneRights"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1]
		and ColonistsHaveArrived
		and CountColonistsWithTrait(TraitId) > 0
	then
		local MartianTribuneMod = MartianTribuneMod
		local IdiotColonistFallbackName = MartianTribuneMod.Name.IdiotColonist
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory
		local Colonist = GetColonistWithTrait(TraitId)
		local Name = (Colonist and Colonist.name) or IdiotColonistFallbackName

		AddTopStory({
			key = Key1,
			title = T{9013761, "Push For Drone Rights"},
			story = T{9013762, "     It has been reported that a local alliance of Martians believe that because so many drones are now integral to our daily lives they now deserve the same rights as colonists. <MTDroneColonistName>, the leader of the self-dubbed Drone Alliance for Freedom and Transparency (DAFT) has stated that \"These drones do more work than all of the humans on Mars combined.\" When asked if this meant drones should be able to vote as well <MTDroneColonistName> responded, \"What? No. That's ridiculous. They are machines...\"", MTDroneColonistName = Name},
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end