local TechId = "MagneticFiltering"
local Key1 = "MagneticMoxieTech1"
local Key2 = "MagneticMoxieTech2"

local function CheckStory()
	local Sent = MartianTribune.Sent
	
	if UICity.tech_status[TechId].researched ~= nil
	and not Sent[Key1]
	and not Sent[Key2]
	then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local random_num = Random(1,2)
		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013556, "But How Do They Work?"},
				story = T{9013557, "     Our Martian Moxies will now be able to put magnets into their filtration chambers in order to create more oxygen. We don't fully understand how, and when a scientist explained it to us, we fell asleep about 45 minutes in. Nonetheless, they assure us that it works as intended, but that we may need to take some iron supplements to enhance the effects to desired levels."}
			})
		else
			AddStory({
				key = Key2,
				title = T{9013558, "Moxie Magnets Make Magic"},
				story = T{9013559, "     Scientists Have developed a novel magnetic attachment for the Moxie. The attachment filters out far more of the tiny metals floating in the Martian atmosphere than previously thought possible.  This new filtration technique allows the Moxie to more effectively create that life saving oxygen that we so desperately need."}
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