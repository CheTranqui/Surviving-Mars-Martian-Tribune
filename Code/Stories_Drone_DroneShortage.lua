local Key1 = "DroneShortage"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local Domes = MapCount("map", "Dome")

	if not Sent[Key1] and ColonistsHaveArrived and Domes > 0 then
		local Drones = MapCount("map", "Drone")
		local DroneRatio = Drones / Domes
		if DroneRatio < 12 then
			local LeaderTitle = MartianTribune.LeaderTitle
			local LeaderName = MartianTribune.LeaderName
			local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
			AddStory({
				key = Key1,
				title = T{9013593, "A Clinic on Inefficiency"},
				story = T{9013594, "     Attending a clinic is often a place to learn, unless you're <MTLeaderTitle> <MTLeader>.  Apparently it's expected that resources will move themselves and planning is just plain overrated.  <MTLeaderTitle>, we need more drones and we need them yesterday!  I only hope that everyone receives their food and other essential supplies in time.", MTLeaderTitle = LeaderTitle, MTLeader = LeaderName}
			})
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end