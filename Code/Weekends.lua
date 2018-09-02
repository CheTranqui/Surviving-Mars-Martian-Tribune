local Key1 = "Weekends"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1]
		and ColonistsHaveArrived
		and #UICity.labels.Colonist > 300
		and MapCount("map", "School") > 1
	then
		local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory

		AddStory({
			key = Key1,
			title = T{9013855, "Children Struggling to Understand Concept of Weekends"},
			story = T{9013856, "     Teachers on Mars have reported that Martianborn children struggle to comprehend the concept of a weekend. A weekend is an Earth Tradition, where for two sols (called 'days' on Earth) many citizens will cease working and relax for a time instead. \"But how does the colony survive then?\" ask the children. Next week's cultural lesson revolves around capitals and life in a metropolis."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end
