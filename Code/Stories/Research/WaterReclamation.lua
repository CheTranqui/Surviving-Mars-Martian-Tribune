local TechId = "WaterReclamation"
local Key1 = "WaterReclamationTech1"
local Key2 = "WaterReclamationTech2"

--triggered via TechResearched
local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	
	if UICity.tech_status[TechId].researched ~= nil
		and not Sent[Key1]
		and not Sent[Key2]
	then
		local MartianTribuneMod = MartianTribuneMod
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		
		if ColonistsHaveArrived and UICity.labels.scientist ~= nil then
			local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
			-- local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
			local Colonist = GetColonistWithTrait("scientist")
			local Name = (Colonist and Colonist.name) or T{9013549, "random scientist"}

			AddStory({
				key = Key1,
				title = T{9013545, "Water Recovery Explained"},
				story = T{9013546, "     We recently sat down for an interview with <MTScientist> where we learned what lead to the new Water Reclamation technology: \"Well basically, we realised that the dome is very similar in design to a water purifier on Earth, except that it's missing the cup in the middle to collect all the water. That's what this new spire will do. It will collect the condensation from the dome's interior and convert it back into consumable water for the inhabitants, effectively cutting our water usage in half.\"", MTScientist = Name},
				-- colonist = IsValidColonist(Colonist) and Colonist or nil
			})
		else
			AddStory({
				key = Key2,
				title = T{9013547, "New Spire Does NOT Contain Swimming Pool"},
				story = T{9013548, "     Despite many requests, and the far reaching rumors about Project Whirlpool. It has been revealed that the recent spire design will not contain a swimming pool, but is instead a system for reclaiming water inside a dome and preparing it for re-use. Personally, while there is clear value in the end result, I think a pool would be far more fun."}
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