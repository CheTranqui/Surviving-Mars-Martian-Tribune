local Key1 = "MarsDay"

local function CheckStory()
	local Sent = MartianTribune.Sent
	if not Sent[Key1] and UICity.day > 100 then
		local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
		AddStory({
			key = Key1,
			title = T{9013570, "Mars Day"},
			story = T{9013571, "     Today we celebrate Mars Day, a day of merriment and joy, to celebrate Humanity shooting for the stars, and finding a home away from home. We are Martians, and we are proud. Join with your friends and family in a great meal, come to the space bar for a drink, but most importantly: go to work and celebrate with your colleagues as well."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end