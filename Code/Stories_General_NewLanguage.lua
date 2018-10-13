local Key1 = "NewLanguage"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and UICity.day > 125 then
		local AddSocialStory = MartianTribuneMod.Functions.AddSocialFreeStory

		AddSocialStory({
			key = Key1,
			title = T{9013645, "New Language Develops on Mars"},
			story = T{9013646, "     It has been reported that the language spoken on Mars has changed so much from those spoken on earth that it is now mutually unintelligble when compared to any language on Earth and thus must be classified as its very own language. Some experts have claimed that it is not a new language, but rather a combination of Swahili and Irish.  This strikes us here at the Martian Tribune as quite odd, however, as no one speaking either of those languages has yet come to Mars."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end