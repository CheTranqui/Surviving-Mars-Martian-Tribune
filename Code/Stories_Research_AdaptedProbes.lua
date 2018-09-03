local TechId = "AdaptedProbes"
local Key1 = "AdaptedProbesTech1"
local Key2 = "AdaptedProbesTech2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Sent[Key2] and UICity.tech_status[TechId].researched ~= nil then
		local AddEngStory = MartianTribuneMod.Functions.AddEngFreeStory
		local Sponsor = MartianTribune.Sponsor
		local random_num = Random(1,2)

		if random_num == 1 then
			AddEngStory({
				key = Key1,
				title = T{9013830, "Probes Probing Deeper Than They Ever Probed Before"},
				story = T{9013831, "     Probes brought from Earth now have the added bonus of being able to see even deeper into the Martian surface, possibly revealing previously undiscovered resources. The probes, pioneered by a <Sponsor> subsidiary, have also miniaturized the design reducing both price and production time.", Sponsor = Sponsor}
			})
		else
			AddEngStory({
				key = Key2,
				title = T{9013832, "Beauty is More Than Surface Deep"},
				story = T{9013833, "     The Deep Sea Division of Research Corp, a subsidiary of <Sponsor>, has developed a new imaging technology capable of looking down into the deeper crusts of the red planet. New probes have now been made available by <Sponsor> to our burgeoning colony that can now scan significantly deeper, and potentially reveal more, and larger, metal and water deposits.", Sponsor = Sponsor}
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