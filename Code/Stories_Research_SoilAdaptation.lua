local TechId = "SoilAdaptation"
local Key1 = "SoilAdaptationTech1"
local Key2 = "SoilAdaptationTech2"
local Key3 = "MartianSoil"

local function CheckStory1()
	local Sent = MartianTribune.Sent
	
	if UIColony.tech_status[TechId].researched ~= nil
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

local function CheckStory2()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent

	if (Published[Key1] or Published[Key2]) and not Sent[Key3] then
		local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory

		AddTopStory({
			key = Key3,
			title = T{9013896, "Martian Soil Good For Farming"},
			story = T{9013897, "     A study at Villanova University in 2017 utilized simulated Martian Soil to test a variety of crops for potential in Martian agriculture and the results were promising. Lettuce grew particularly well, along with numerous other crops, though potatoes may not be as common in the future as they are with our imported Earthling soil now. ...just be sure to wash the food before eating as that percolate does mankind no good to ingest."}
		})
	end
end

function OnMsg.TechResearched(tech_id, city, first_time)
	if tech_id == TechId then
		CheckStory1()
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
	CheckStory2()
end