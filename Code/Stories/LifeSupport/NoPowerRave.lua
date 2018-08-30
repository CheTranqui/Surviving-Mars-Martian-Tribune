local Key1 = "NoPowerRave"

local function CheckStory(dome)
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1]
		and ColonistsHaveArrived
		and IsValid(dome)
		and not dome:HasPower()
		and dome.labels.Colonist
		and #dome.labels.Colonist > 0
		and #UICity.labels.Colonist <= 60
	then
		local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory

		AddStory({
			key = Key1,
			title = T{9013864, "Lack of Power Leads to Awesome Rave"},
			story = T{9013865, "     The colony's recent power problems have lead to an intriguing turn of events. Upon noticing the flickering lights throughout the dome, many colonists mistook the music played by several more artistically inclined domemates as a dome-wide rave, which in turn lead to a giant street party. The evening was such a great time for the community that local officials have decided to make this an annual event to commemorate this moment."}
		})
	end
end

function OnMsg.OnSetWorking(building, working)
	if not working and IsKindOf(building, "Dome") then
		CheckStory(building)
	end
end
