local Key1 = "ElonMusk"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived

	if not Sent[Key1] and ColonistsHaveArrived then
		local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory
		AddStory({
			key = Key1,
			title = T{9013554, "It's a bird!  It's a plane! It's..."},
			story = T{9013555, "     Nope, it's a 2018 Tesla Roadster.  The car was originally hurled into space by the eccentric billionaire Elon Musk through his now famous spacefaring organization, Space X.  The Roadster is just now passing Mars in an eliptical orbit before continuing on its course back toward low Earth orbit.  Without this groundbreaking Roadster, we may not be where we are today.  Be sure to look up and thank the cars that we made it here safely!"}
		})
	end
end

function OnMsg.ColonistArrived()
	CheckStory()
end