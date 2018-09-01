local Key1 = "Rockets3"
local Key2 = "Rockets0"
local Key3 = "RocketObservation"
local Key4 = "GiantWhaleRocket"

--  checks for current on-planet rocket count.  Determines release of Rockets0 and Rockets3
--  will check each day after Sol 10
local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local RocketCount = MapCount("map", "SupplyRocket")
	local UICity = UICity

	if UICity.day > 10 then
		local LeaderTitle = MartianTribune.LeaderTitle
		local LeaderName = MartianTribune.LeaderName
	
		if not Sent[Key1] and ColonistsHaveArrived and RocketCount > 2 then
			local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory
			AddStory({
				key = Key1,
				title = T{9013770, "Rocket Silhouettes Mar Martian Landscape"},
				story = T{9013771, "    With so many rockets planetside, one would think that we have more than enough to succeed and flourish, but all those resources are languishing in the hands of <MTLeaderTitle> <MTLeader>.  Perhaps it's time to fire up that Drone Assembler, a few more Fuel Refineries, and redistribute the workload.  If things remain as they are, who knows how much longer <MTLeaderTitle> <MTLeader> will remain in office...", MTLeaderTitle = LeaderTitle, MTLeader = LeaderName}
			})
		end
		if not Sent[Key2] and ColonistsHaveArrived and RocketCount == 0 then
			local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory
			AddStory({
				key = Key2,
				title = T{9013772, "<MTLeaderTitle> Sets High Standard", MTLeaderTitle = LeaderTitle},
				story = T{9013773, "    With the <MTLeaderTitle>'s efficient and effective use of Earth's resupply we are well on our way to gaining a strong foothold on the Red Planet.  This begs the question: are you doing your part? As we continue to develop our resources, and our culture, on this planet each one of us plays an integral role in leading us closer and closer to the safety and security that we need.  Follow <MTLeaderTitle> <MTLeader>'s example!  How can you become more efficient and effective today?  Let us know in your letter to the editor!  Select letters will be published in Saturday's edition.", MTLeaderTitle = LeaderTitle, MTLeader = LeaderName}
			})
		end
		if not Sent[Key3] and RocketCount > 1 then
			local RecentRocket = UICity.labels.SupplyRocket[RocketCount]
			local MostRecentRocket = (RecentRocket and RecentRocket.name) or T{9013746, "recent rocket"}
			local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory

			AddStory({
				key = Key3,
				title = T{9013744, "Drones Watch In Awe"},
				story = T{9013745, "     All the Drones on Mars watch in amazement as the rocket <MTMostRecentRocket> lands safely on the surface. Kicking up storm of red dust, this rocket brings us even closer to the dream of a future of Martian civilisation.", MTMostRecentRocket = MostRecentRocket}
			})
		end
	end

	if not Sent[Key4]
		and RocketCount > 0
		and ColonistsHaveArrived
		and CountColonistsWithTrait("Child") > 0
	then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory

		AddStory({
			key = Key4,
			title = T{9013866, "Children Confused by Giant Whale Statue"},
			story = T{9013867, "     Children on Mars have reported confusion and fear of the \"Giant Whale\" outside the dome. After realising that they are referring to the Rocket sent from Earth, older Martians were confused by the children even knowing what a whale looks like. \"There are no pictures of whales, the kids just decided that is what the rockets looked like. It is amazing that they were right, but they've no need to fear!\""}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end
