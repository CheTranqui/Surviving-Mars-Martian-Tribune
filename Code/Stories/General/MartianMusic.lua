local Key1 = "MartianMusic"

--  put into FREE stories
local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived then
		local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
		AddStory({
			key = Key1,
			title = T{9013651, "Martian Music Voted Best in Galaxy"},
			story = T{9013652, "   The Martian rock group, Red Rock Rocks, has been voted best in the galaxy by an unbiased vote conducted online. The group is famous for songs such as \"4th Rock from the sun\", \"Red Rocks Rock\", \"Dome sweet Dome\", and \"Martian Madness\". The timing of such a vote is fortuitous as they have also just released their brand new album called \"Dark side of Phobos\"."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end