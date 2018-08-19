local Key1 = "MovingDomes"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local Domes = UICity.labels.Dome or empty_table
	if not Sent[Key1] and ColonistsHaveArrived and #Domes > 2 then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local Dome1 = table.rand(Domes)
		local Dome2 = table.rand(Domes)
		while Dome1 == Dome2 do
			Dome2 = table.rand(Domes)
		end
		local Dome1Name = (Dome1 and Dome1.name) or T{9013691, "random dome <num>", num=1}
		local Dome2Name = (Dome2 and Dome2.name) or T{9013691, "random dome <num>", num=2}

		AddStory({
			key = Key1,
			title = T{9013689, "The Rock Is Always Redder"},
			story = T{9013690, "     In a recent survey performed by the Martian Tribune a number of citizens have expressed disappointment after moving to a new dome.  One citizen in particular hit the nail on the head saying, 'I always thought that moving from <MTMovingDome1> to <MTMovingDome2> would be a huge upgrade in lifestyle, but I've have found it to be basically the same as before. I guess it's true what they say: The rock is redder on the other side.'", MTMovingDome1 = Dome1Name, MTMovingDome2 = Dome2Name}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end