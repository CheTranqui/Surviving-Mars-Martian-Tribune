local Key1 = "EarthTourism"

local function CheckStory()
	local Sent = MartianTribune.Sent

	if not Sent[Key1] then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory

		AddStory({
			key = Key1,
			title = T{9013820, "Tourism to Earth Only Somewhat Viable"},
			story = T{9013821, "     The Earth Tourism Board is attempting to show the benefits of Martians visiting Earth in a collosal tourism push. Pushing the benefits such as \"try meat!\" and \"water, we have oceans of it\". Martians are facing problems once arriving on Earth however due to a lack of understanding currency. \"I went to a grocer and asked to pick up my rations, and they just looked at me like I was from a different planet.\""}
		})
	end
end

function OnMsg.ColonistLeavingMars(colonist, rocket)
	CheckStory()
end