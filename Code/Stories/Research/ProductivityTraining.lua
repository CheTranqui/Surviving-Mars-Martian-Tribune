local TechId = "ProductivityTraining"
local Key1 = "ProductivityTrainingTech1"
local Key2 = "ProductivityTrainingTech2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1]
		and not Sent[Key2]
		and ColonistsHaveArrived
		and UICity.tech_status[TechId].researched ~= nil
		and CountColonistsWithTrait("engineer") > 0
		and CountColonistsWithTrait("geologist") > 0
	then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local random_num = Random(1,2)

		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013877, "Martian-Specific Geology Training Started"},
				story = T{9013878, "     The Martian Tribune can report that all geologists have been trained in Martian-specific conditions, to recognise the difference between metals, rare metals and that random black rock that is on the surface but isn’t actually metal. As a by-product of this, engineers have been able to work more efficiently as they no longer need to sort out what is rock and what is metal using a magnet."}
			})
		else
			AddStory({
				key = Key2,
				title = T{9013879, "Engineering Books Imported to Mars"},
				story = T{9013880, "     After discovering a critical lack of training materials, books on engineering have been dispatched to Mars. The books contain specifics regarding machine parts production, and electronics production. All engineers are encouraged to read these books together with a geologist, which will increase the productivity of both of them in future."}
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