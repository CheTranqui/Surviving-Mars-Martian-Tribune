local TechId = "LowGTurbines"
local Key1 = "LowGTurbinesTech1"
local Key2 = "LowGTurbinesTech2"

local function CheckStory()
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Sent[Key2] and UICity.tech_status[TechId].researched ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local random_num = Random(1,2)

		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013826, "Martian Gravity Allows Heavier Wind Turbines"},
				story = T{9013827, "     With gravity on Mars being approximately 1/3 that of Earth, it is possible to construct wind turbines with heavier blades, thus allowing them to spin for longer after the pitiful Martian wind spins them for us. Adding blocks of polymers to the construction of the blades for wind turbines has allowed extra momentum to bring more \"spinnyness\", resulting in more power to the network."}
			})
		else
			local LeaderName = MartianTribune.LeaderName
			AddStory({
				key = Key2,
				title = T{9013828, "Polymer Blades Means Poly-More Power"},
				story = T{9013829, "     <MTLeader> has confirmed that researchers have come up with a way to change the blades on martian wind turbine to those of a polymer composition. The new blades have been found to be much more efficient and bringing power to the people, with up to 33% more production of electrical goodness.", MTLeader = LeaderName}
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