local TraitId = "Saint"
local Key1 = "ReligiousArtifact"

-- triggered via OnMsg.NewDay
local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and CountColonistsWithTrait(TraitId) > 0 then
		local MartianTribuneMod = MartianTribuneMod
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local Colonist = GetColonistWithTrait(TraitId)
		local Name = (Colonist and Colonist.name) or T{9013657, "random saint"}

		AddStory({
			key = Key1,
			title = T{9013655, "Religious Artifact Found on Mars"},
			story = T{9013656, "     <MTSaint> has found what appears to be a religious artifact on Mars. The item, shaped like the Point of Origin symbol from Stargate fame, has been heralded as undeniable proof of <MTSaint>'s new religion as the one true faith. Sceptics however are reported saying \"..its just a stupid, useless rock.. there are thousands of them all around! What's so special about this one?\"", MTSaint = Name},
			colonist = IsValidColonist(Colonist) and Colonist or nil
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end