local TechId = "CompactPassengerModule"
local Key1 = "CompactPassengerTech1"

local function CheckStory()
	local Sent = MartianTribune.Sent
	if not Sent[Key1] and UICity.tech_status[TechId].researched ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		AddStory({
			key = Key1,
			title = T{9013591, "Shuttle Capacity Doubled"},
			story = T{9013592, "     Researchers have discovered that it is possible to add up to ten more seats to our passenger shuttles, allowing up to 22 new colonists to come to Mars at once! This new discovery was made when a researcher knocked his chair over, causing him to realise that there is no up or down in space, so we could simply add more seats to the \"ceiling\" of the previous design."}
		})
	end
end

function OnMsg.TechResearched(tech_id, city, first_time)
	if tech_id == TechId then
		CheckStory()
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end