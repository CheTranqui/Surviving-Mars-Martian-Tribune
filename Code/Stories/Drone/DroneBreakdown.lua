local Key1 = "DroneBreakdown"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Removed = MartianTribune.Removed
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Removed[Key1] and MapCount("map", "Drone") > 2 then
		local MartianTribuneMod = MartianTribuneMod
		local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory
		local GetRandomDroneName = MartianTribuneMod.Functions.GetRandomDroneName
		local Drone1 = GetRandomDroneName()
		local Drone2 = GetRandomDroneName()
		-- make sure they are not the same drone
		while Drone2 == Drone1 do
			Drone2 = GetRandomDroneName()
		end
		AddStory({
			key = Key1,
			title = T{9013589, "<MTDrone1> Breakdown", MTDrone1 = Drone1},
			story = T{9013590, "     <MTDrone1> suffered a minor fault to its front left wheel yesterday causing the drone to be unable to complete tasks for the sol. The lucky drone had friends, however, namely <MTDrone2> who noticed <MTDrone1> struggling and helped to repair their wheel before sol's end.", MTDrone1 = Drone1, MTDrone2 = Drone2}
		})
	end
end

local function CheckRemoveStory()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Removed = MartianTribune.Removed
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived

	if not Published[Key1] and not Removed[Key1] and ColonistsHaveArrived then
		MartianTribuneMod.Functions.RemoveTopPotentialStory(Key1)
	end
end

function OnMsg.ColonistArrived()
	CheckRemoveStory()
end

function OnMsg.MartianTribuneCheckStories()
	CheckRemoveStory()
	CheckStory()
end