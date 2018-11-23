local TechId = "LowGTurbines"
local Key1 = "LowGTurbinesTech1"
local Key2 = "LowGTurbinesTech2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived

	if not Sent[Key1]
		and not Sent[Key2]
		and ColonistsHaveArrived
		and UICity.tech_status[TechId].researched ~= nil
	then
		local AddEngStory = MartianTribuneMod.Functions.AddEngFreeStory
		local random_num = Random(1,2)

		if random_num == 1 then
			AddEngStory({
				key = Key1,
				title = T{9013826, "Martian Gravity Allows Heavier Wind Turbines"},
				story = T{9013827, "     As gravity on Mars is just a third of that on Earth, it has been deemed worthwhile to construct wind turbines with a distinct, beefier design so that they might take greater advantage of the Martian winds. Let's get that polymer flowing so we can enjoy even more of that dizzyingly beautiful spin-farm!"}
			})
		else
			local LeaderName = MartianTribune.LeaderName
			AddEngStory({
				key = Key2,
				title = T{9013828, "Polymer Blades Means Poly-More Power"},
				story = T{9013829, "     <MTLeader> has followed through with the promised research into more effective power generation as scientists have found a way to upgrade the blades on the standard Martian wind turbine to effectively utilize a polymer composition. The new blades have proven to be much more efficient at bringing power to the people, with up to 33% more electrical goodness.", MTLeader = LeaderName}
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