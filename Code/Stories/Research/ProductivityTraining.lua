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
		and CountColonistsWithTrait("geologist") > 0
	then
		local MartianTribuneMod = MartianTribuneMod
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local random_num = Random(1,2)

		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013877, "Engineers Thankful To Leave Magnets At Home"},
				story = T{9013878, "     We are proud to report that all Martian geologists have recently elucidated the distinction between the local metals, rare metals, and the curious black surface rocks that aren't quite the same thing. After several rigorous training sessions our engineers may now work more efficiently as they no longer need magnets to sort rock from metal."}
			})
		else
			local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
			local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
			local Colonist = GetColonistWithTrait("geologist")
			local Name = IsValidColonist(Colonist) and Colonist.name or T{9013885, "random geologist"}

			AddStory({
				key = Key2,
				title = T{9013879, "Heavy Metal Rocks"},
				story = T{9013880, "     <Geologist> just released a new book regarding the local geoscape of Mars. Of particular interest is the composition and detailed descriptions of the local metals, rare metals, polymers, and more found on and under the surface. The new book, \"Heavy Metal Rocks\" has become standard reading for our local engineers and geologists and the productivity boost is already evident.", Geologist = Name}
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