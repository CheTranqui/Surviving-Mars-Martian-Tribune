local TraitId = "Whiner"
local Key1 = "Whiner"

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
		local Name = IsValidColonist(Colonist) and Colonist.name or T{9013870, "whiner colonist"}

		AddStory({
			key = Key1,
			title = T{9013871, "<WhinerColonist> whines", WhinerColonist = Name},
			story = T{9013872, "     <WhinerColonist> has complained repeatedly that on Earth they were one of the best submarine operators in the entire fleet. They moved to Mars because we had a shortage of submarine operators...We are not sure how much water <WhinerColonist> thought was on Mars, but its not enough to warrant a submarine.", WhinerColonist = Name}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end