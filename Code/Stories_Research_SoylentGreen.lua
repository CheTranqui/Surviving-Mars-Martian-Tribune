local TechId = "SoylentGreen"
local Key1 = "SoylentGreen"

local function CheckStory()
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and UIColony.tech_status[TechId].researched ~= nil then
		local AddSocialStory = MartianTribuneMod.Functions.AddSocialFreeStory
		AddSocialStory({
			key = Key1,
			title = T{9013638, "What Goes Around Comes Around"},
			story = T{9013639, "     As time moves on more and more colonists are born, and more and more are passing away, including just yesterday.  In other news, the newest food crop has come in! Make sure to check your nearest grocer for fresh produce and show them this article for a 0.5 percent discount!"}
		})
	end
end

function OnMsg.ColonistDied(colonist, reason)
	CheckStory()
end