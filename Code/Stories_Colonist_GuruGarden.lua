local TraitId = "Guru"
local Key1 = "GuruGarden"

local function HasGarden(labels)
	return labels.GardenAlleys_Small ~= nil and #labels.GardenAlleys_Small > 0
		or labels.GardenAlleys_Medium ~= nil and #labels.GardenAlleys_Medium > 0
		or labels.GardenNatural_Small ~= nil and #labels.GardenNatural_Small > 0
		or labels.GardenNatural_Medium ~= nil and #labels.GardenNatural_Medium > 0
		or labels.GardenNatural_Large ~= nil and #labels.GardenNatural_Large > 0
		or labels.GardenStone ~= nil and #labels.GardenStone > 0
end

local function GetGuruGarden(colonist)
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
	return IsValidColonist(colonist)
		and colonist.dome
		and HasGarden(colonist.dome.labels)
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
			local AddSocialStory = MartianTribuneMod.Functions.AddSocialFreeStory
			local Name = GuruColonist.name or T{9013584, "random guru"}
			AddSocialStory({
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
