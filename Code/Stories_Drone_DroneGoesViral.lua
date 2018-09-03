local Key1 = "DroneGoesViral"

local function CheckStory()
	local Sent = MartianTribune.Sent
	if not Sent[Key1] and MapCount("map", "Drone") > 2 then
		local MartianTribuneMod = MartianTribuneMod
		local GetRandomDroneName = MartianTribuneMod.Functions.GetRandomDroneName
		local AddEngStory = MartianTribuneMod.Functions.AddEngFreeStory

		local Drone1 = GetRandomDroneName()
		local Drone2 = GetRandomDroneName()
		-- make sure that they are not the same drone
		while Drone2 == Drone1 do
			Drone2 = GetRandomDroneName()
		end
		AddEngStory({
			key = Key1,
			title = T{9013612, "Video of Martian Drone Goes Viral"},
			story = T{9013613, "     An adorable video of <MTDrone1> picking up some metal has gone viral on Earth, resulting in many copycat videos being created. <MTDrone2>, a relative of <MTDrone1>, who reportedly took the video has said (after translation from binary) \"I do not understand why it has gone viral, <MTDrone1> was only doing their job\", in response, an earthling video production expert stated \"I know it's just doing its job, but it's SOO cute!\"", MTDrone1 = Drone1, MTDrone2 = Drone2}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end