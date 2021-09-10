local TechId = "EarthMarsInitiative"
local Key1 = "EarthMarsInitiativeTech1"
local Key2 = "EarthMarsInitiativeTech2"

local function CheckStory()
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Sent[Key2] and UIColony.tech_status[TechId].researched ~= nil then
		local AddEngStory = MartianTribuneMod.Functions.AddEngFreeStory
		local random_num = Random(1,2)

		if random_num == 1 then
			AddEngStory({
				key = Key1,
				title = T{9013881, "Two Planets Working Together As One"},
				story = T{9013882, "     Today marks an historic day, as the two inhabited planets in the Milky way galaxy sign the first ever interplanetary research treaty, agreeing to share all knowledge and to work together to advance the future of mankind. The Earth-Mars Initiative will see leaps and bounds in rates of research on both Earth and Mars, allowing for more rapid expansion into the future."}
			})
		else
			AddEngStory({
				key = Key2,
				title = T{9013883, "Sharing is Caring"},
				story = T{9013884, "     Researchers on Earth and Mars have today declared they all scientific advances will be shared between the two planets, stating that this is an obvious extension of providing sufficient care and support to ensure the success of the newly founded colony.  This kind of openness and sharing is truly unprecidented in the turbulent history of mankind and bodes well for the future."}
			})
		end
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