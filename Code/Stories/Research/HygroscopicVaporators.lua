local TechId = "HygroscopicVaporators"
local Key1 = "HygroscopicVaporatorsTech1"

local function CheckStory()
	local Sent = MartianTribune.Sent
	
	if not Sent[Key1] and UICity.tech_status[TechId].researched ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		AddStory({
			key = Key1,
			title = T{9013550, "Painting Water Vaporators"},
			story = T{9013551, "     Scientists have recently discovered that painting water vaporators with Hygroscopic Paint actually has the effect of increasing water output.  In celebration, the Martian Tribune would like to announce the First Annual Vaporator Graffiti Contest!  Grab your paint brushes and let's see those designs!  The top five entries, voted on by you, our faithful readers, will become the new designs for all future vaporators!"}
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