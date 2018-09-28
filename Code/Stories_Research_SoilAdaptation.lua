local TechId = "SoilAdaptation"
local Key1 = "SoilAdaptationTech1"
local Key2 = "SoilAdaptationTech2"

local function CheckStory()
	local Sent = MartianTribune.Sent
	
	if UICity.tech_status[TechId].researched ~= nil
	and not Sent[Key1]
	and not Sent[Key2]
	then
		local AddEngStory = MartianTribuneMod.Functions.AddEngFreeStory
		local random_num = Random(1,2)
		if random_num == 1 then
			AddEngStory({
				key = Key1,
				title = T{9013564, "Adding Waste To The Dust Makes Soil"},
				story = T{9013565, "     Scientists have discovered that adding human waste to a water and dust mixture can create a viable soil for arable farming.  Botanists have immediately begun working with dome architects to create designs for the first Martian Farms that do not require electricity and might reduce our reliance on hydroponics."}
			})
		else
			AddEngStory({
				key = Key2,
				title = T{9013566, "Botanists Rejoice As Farming Becomes Viable"},
				story = T{9013567, "     It was once thought that the only possible way to make food on Mars would be with a significant number of hydroponic farms, but after many sol of rigorous research, it has been found that we can indeed make normal flat Farms inside our domes. Numerous botonists have betrayed their irrational fear of heights and urged the use of these new farms as soon as possible."}
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