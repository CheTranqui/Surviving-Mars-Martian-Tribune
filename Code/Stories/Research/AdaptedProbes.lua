local TechId = "AdaptedProbes"
local Key1 = "AdaptedProbesTech1"
local Key2 = "AdaptedProbesTech2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Sent[Key2] and UICity.tech_status[TechId].researched ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local Sponsor = MartianTribune.Sponsor
		local random_num = Random(1,2)

		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013830, "Probes Probing Deeper than they ever Probed Before"},
				story = T{9013831, "     Probes brought from Earth now have the added bonus of being able to see deep into the surface, possibly revealing previously unseen resources. The probes pioneered by <MTSponsor> subsidiary \"A New Awesome Life\" have also become cheaper to build due to streamlining of the production process.", MTSponsor = Sponsor}
			})
		else
			AddStory({
				key = Key2,
				title = T{9013832, "Look Up, Look Down"},
				story = T{9013833, "     After looking up from Earth to the great beyond of Mars, finally we have the technology to look down into the deep crusts of the red planet. New probes ordered by <MTSponsor> can now scan significantly deeper, and will reveal larger deposits of metal, water and rare metals.", MTSponsor = Sponsor}
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