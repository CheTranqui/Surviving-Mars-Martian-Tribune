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
			title = T{9013864, "Colonists confuse lack of power for awesome Rave"},
			story = T{9013865, "     The colony having some power problems has lead to a strange turn of events, where many colonists after noticing the flickering lights around the dome mistakenly thought there was a dome-wide rave, and went out to the streets to party. When power is restored, the martian council will consider a yearly planet wide rave to celebrate and remember this moment."}
		})
	end
end

function OnMsg.OnSetWorking(building, working)
	if not working and IsKindOf(building, "Dome") then
		CheckStory(building)
	end
end