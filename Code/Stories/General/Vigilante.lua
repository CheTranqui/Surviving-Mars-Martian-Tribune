local Key1 = "Vigilante"

--  put into FREE stories  -- also initiates story on Dome To Dome Messaging
local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and CountObjects{class = "Dome"} > 2 then
		local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
		AddStory({
			key = Key1,
			title = T{9013647, "Vigilante Justice"},
			story = T{9013648, "     A rumor has begun circulating around the domes of a masked vigilante running around preventing crime. Given the name of the Red Lantern has been spotted on multiple occasions preventing petty crimes and saving lives.  Spottings include, but are not limited to; telling youth to stop throwing rocks, pushing a person out of the way of a rapidly moving drone, and stopping a theft in the local grocer."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end