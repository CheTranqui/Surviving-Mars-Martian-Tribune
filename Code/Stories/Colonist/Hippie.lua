local TraitId = "botanist"
local Key1 = "Hippie"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and CountColonistsWithTrait(TraitId) > 0 then
		local MartianTribuneMod = MartianTribuneMod
		local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		-- local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

		local Colonist = GetColonistWithTrait(TraitId)
		local Name = (Colonist and Colonist.name) or T{9013688, "random botanist"}
		AddStory({
			key = Key1,
			title = T{9013686, "The Grass Couldn't Be Greener"},
			story = T{9013687, "     Local botanist <MTHippieName> has been caught smoking what officers referred to as \"the greatest stuff on the planet\", which was found to be grown in their very own closet. Though technically not illegal on Mars, questions have been raised as to how the botanist got the plant here in the first place. Dome security declared to us that \"it's definitely home-grown, it really is pretty high quality\". Unfortunately this was all the information we could gather as the officers were all quite insistent on returning to their spudtato snacks.  We will keep you updated as more news unfolds.", MTHippieName = Name},
			-- colonist = IsValidColonist(Colonist) and Colonist or nil
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end