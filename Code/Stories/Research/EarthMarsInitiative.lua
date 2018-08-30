local TechId = "EarthMarsInitiative"
local Key1 = "EarthMarsInitiativeTech1"
local Key2 = "EarthMarsInitiativeTech2"

local function CheckStory()
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Sent[Key2] and UICity.tech_status[TechId].researched ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local random_num = Random(1,2)

		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013881, "Two planets working together as one"},
				story = T{9013882, "     Today marks an historic day, as the two inhabited planets in the Milky way galaxy sign the first ever interplanetary research treaty, agreeing to share all knowledge and to work together to advance the future of mankind. The Earth-Mars Initiative will see leaps and bounds in rates of research on both Earth and Mars, allowing for more rapid expansion into the future."}
			})
		else
			AddStory({
				key = Key2,
				title = T{9013883, "Sharing and Caring"},
				story = T{9013884, "     Researchers on Earth and Mars have today declared they will share all scientific knowledge possible between the two planets, and have vowed to care about people not on their own planet - a difficult task considering Humanity's history with rival countries, cities, tribes, etc."}
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