local TraitId = "Celebrity"
local Key1 = "MartianFashion"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and CountColonistsWithTrait(TraitId) > 0 then
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local Colonist = GetColonistWithTrait(TraitId)
		local Name = IsValidColonist(Colonist) and Colonist.name or T{9013637, "random celebrity"}

		AddStory({
			key = Key1,
			title = T{9013873, "Martian Fashion Makes <CelebrityName> millions.", CelebrityName = Name},
			story = T{9013874, "     <CelebrityName> has been designing and selling clothing for years, taking strong inspiration from the standard Martian jumpsuits, and selling them on Earth. The fashionista has noted that the red security outfit is the most popular on Earth, which is good because we have a lot of them to spare.", CelebrityName = Name},
			colonist = IsValidColonist(Colonist) and Colonist or nil
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end