local Key1 = "ElPresidente"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local MartianTribuneMod = MartianTribuneMod
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
	local LeaderColonist = MartianTribune.LeaderColonist

	if not Sent[Key1] and IsValidColonist(LeaderColonist) then
		local LeaderName = MartianTribune.LeaderName
		local LeaderTitle = MartianTribune.LeaderTitle
		local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory

		AddTopStory({
			key = Key1,
			title = T{9013585, "El Presidente to Visit Mars"},
			story = T{9013586, "     The self-proclaimed El Presidente of Cayo de Fortuna has decided on an official visit to Mars.  He comes with hopes of meeting with <MTLeaderTitle> <MTLeader> and brokering a potential trade deal.", MTLeaderTitle = LeaderTitle, MTLeader = LeaderName}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end