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
			title = T{9013871, "<WhinerColonist> Confused by Lack of Submarines", WhinerColonist = Name},
			story = T{9013872, "     <WhinerColonist> has-whiner name- has declared repeatedly that on Earth they were one of the best submarine operators in the entire fleet. They moved to Mars because we had a shortage of submarine operators. We are not sure how much water -name- thought was on Mars, but it is definitely not enough to warrant a submarine!  \...unless it's a really, really small one.", WhinerColonist = Name}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end
