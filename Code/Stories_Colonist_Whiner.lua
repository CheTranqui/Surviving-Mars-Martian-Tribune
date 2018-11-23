local IncludedTraits = { "Whiner", "engineer" }
local ExcludedTraits = { "Martianborn" }
local Key1 = "Whiner"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1]
		and ColonistsHaveArrived
		and CountColonistsWithTrait(IncludedTraits[1]) > 0
		and CountColonistsWithTrait(IncludedTraits[2]) > 0
	then
		-- Note: this doesn't guarantee that there is a colonist with both traits, so we test for getting a valid colonist from the combined search before actually generating the story.
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistMatchingTraits = MartianTribuneMod.Functions.GetColonistMatchingTraits
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local Colonist = GetColonistMatchingTraits(IncludedTraits, ExcludedTraits)

		if IsValidColonist(Colonist) then
			local AddSocialStory = MartianTribuneMod.Functions.AddSocialPotentialStory
			local Name = Colonist.name or T{9013870, "whiner colonist"}

			AddSocialStory({
				key = Key1,
				title = T{9013871, "<WhinerColonist> Confused by Lack of Submarines", WhinerColonist = Name},
				story = T{9013872, "     <WhinerColonist> has declared repeatedly that on Earth they were one of the best submarine operators in the entire fleet. They moved to Mars because we had a shortage of submarine operators. We are not sure how much water <WhinerColonist> thought was on Mars, but it is definitely not enough to warrant a submarine!  ...unless it's a really, really small one.", WhinerColonist = Name},
				colonist = Colonist
			})
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end
