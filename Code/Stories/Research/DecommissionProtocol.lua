local TechId = "DecommissionProtocol"
local Key1 = "DecommissionTech1"
local Key2 = "DecommissionTech2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local Sponsor = MartianTribune.Sponsor
	
	if UICity.tech_status[TechId].researched ~= nil
	and not Sent[Key1]
	and not Sent[Key2]
	then
		local AddStory = MartianTribuneMod.Functions.AddEngFreeStory
		local random_num = Random(1,2)
		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013537, "Drones Reminded That Structure Shells Look Silly"},
				story = T{9013538, "     Drones on Mars Have received a software upgrade that reminds them that leaving the shell of a former structure looks messy, unkept and serves no purpose, thus it is ok for them to remove the shell and make the surface look nice again.  We simply have to say \"please\", is all."}
			})
		else
			AddStory({
				key = Key2,
				title = T{9013539, "Decommissioning Buildings Necessary for Colonial Advancement"},
				story = T{9013540, "     <MTSponsor> has announced that some of the buildings made on Mars may need to not only be salvaged but entirely decommissioned and destroyed in order to pave the way for future construction. Drones have now been updated with the necessary tools to perform this function whenever instructed. Please be purposeful in making such requests.  All requests to decommission Spacebars will automatically be refused.", MTSponsor = Sponsor}
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
