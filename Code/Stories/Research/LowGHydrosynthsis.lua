-- Note: in-game tech has no 'e' in synth'e'sis, so name is 'LowGHydrosynthsis'
local TechId = "LowGHydrosynthsis"
local Key1 = "LowGHydroTech1"
local Key2 = "LowGHydroTech2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local Sponsor = MartianTribune.Sponsor
	
	if not Sent[Key1]
		and not Sent[Key2]
		and UICity.tech_status[TechId].researched ~= nil
	then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local random_num = Random(1,2)
		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013533, "Fuel of the Future"},
				story = T{9013534, "     Researchers have recently completed designs for the construction of Martian Fuel Refineries and the Polymer Factories using only drones and parts found on the surface of Mars. This is a huge breakthrough in Martian engineering as before this point all fuel refineries and polymer factories had to be imported as fully built structures from Earth, an expensive and time consuming process that may now be bypassed thanks to their hard work and diligence."}
			})
		else
			AddStory({
				key = Key2,
				title = T{9013535, "Drones Imbued With the Secrets of Hydrosynthesis"},
				story = T{9013536, "     Martian Drones have recently been given the plans for fuel refinery and polymer factory construction, which up until now was a closely guarded secret from <MTSponsor>. This advancement will let us create both fuel and polymers, without any support from Earth, requiring only locally sourced water.", MTSponsor = Sponsor}
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