local TraitId = "Guru"
local Key1 = "GuruGarden"

local function GetGuruGarden(colonist)
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
	return IsValidColonist(colonist) and colonist.dome and (
		colonist.dome.labels.GardenNatural_Medium ~= nil or colonist.dome.labels.GardenNatural_Small ~= nil
	)
end

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and CountColonistsWithTrait(TraitId) > 0 then
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local GuruColonist = GetColonistWithTrait(TraitId)
		if GetGuruGarden(GuruColonist) then
			local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
			local Name = GuruColonist.name or T{9013584, "random guru"}
			AddStory({
				key = Key1,
				title = T{9013582, "Guru In The Garden"},
				story = T{9013583, "     Martian Guru <MTGuru> has informed the Martian Tribune that they will be holding frequent meditation and contemplation sesions in the dome's garden. \"The garden is the natural spot for gurus like me, it lets me reach a more intense inner core, and connect more deeply with others and with nature.\"", MTGuru = Name},
				colonist = GuruColonist
			})
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end
