local TechId = "LowGFungi"
local Key1 = "LowGFungiTech1"
local Key2 = "LowGFungiTech2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	
	if ColonistsHaveArrived
	and UICity.tech_status[TechId].researched ~= nil
	and not Sent[Key1]
	and not Sent[Key2]
	then
		local AddEngStory = MartianTribuneMod.Functions.AddEngFreeStory
		local random_num = Random(1,2)
		if random_num == 1 then
			AddEngStory({
				key = Key1,
				title = T{9013560, "People With Mushroom Allergies Beware"},
				story = T{9013561, "     We have recently discovered the secret to growing mushrooms on Mars. It wasn't really too complicated as mushrooms can grow just about anywhere, but now we can farm them. If you have a mushroom allergy, we recommend taking one of the next shuttles to Earth, as a new Martian staple has been added to the menu."}
			})
		else
			AddEngStory({
				key = Key2,
				title = T{9013562, "Mushrooms on Mars"},
				story = T{9013563, "     Researchers have designed a new building that can be placed outside of a dome. It will be its own self-contained farm and will grow a specialized Martian Mushroom. It should be noted these specialized mushrooms are illegal on Earth, and should never be brought back when traveling back to the blue planet."}
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