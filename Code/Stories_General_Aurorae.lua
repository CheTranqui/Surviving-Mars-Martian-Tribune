local Key1 = "Aurorae"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived then
		local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory

		AddTopStory({
			key = Key1,
			title = T{9013892, "Martian Aurora Unique In Origin"},
			story = T{9013893, "     The aurora that we see here on mars on such a regular basis turns out to be a bit unusual. While Earthling aurorae are due to an excess of electrons bombarding the planet, our own is a result of a proton shower sent off by the Sun's own solar winds which Earth mostly avoids due to its much more powerful magnetic field."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end