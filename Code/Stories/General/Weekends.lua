local Key1 = "Weekends"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and #UICity.labels.Colonist > 300 then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory

		AddStory({
			key = Key1,
			title = T{9013855, "Children Struggling to Understand Concept of Weekends"},
			story = T{9013856, "     Teachers on Mars have reported that Martianborn children struggle to comprehend the concept of a weekend. A weekend is an Earth Tradition, where for two sols (called 'days' on Earth) many citizens will cease working, and have a day \"off\". \"But then how does the colony survive?\" ask many of the children. Next, we will be trying to explain the concept of megacities to them."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end