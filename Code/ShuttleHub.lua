local Key1 = "ShuttleHub"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	
	if not Sent[Key1] and ColonistsHaveArrived and UICity.labels.ShuttleHub ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
		AddStory({
			key = Key1,
			title = T{9013676, "The Wright Way"},
			story = T{9013677, "     As recent research turns into technological innovation the Martian Aviation Authority has announced its first inter-dome flights with their new CO2 powered flying drones. Move from dome to dome with the new luxury passanger drones, or just watch as the MAA goes about it's business transfering food and other supplies to where its most needed."}
		})
	end
end

local shuttleHubInit = ShuttleHub.GameInit
function ShuttleHub.GameInit(...)
	if shuttleHubInit then
		shuttleHubInit(...)
	end
	CheckStory()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end