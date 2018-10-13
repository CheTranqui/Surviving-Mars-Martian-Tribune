local Key1 = "VirtueOverVices"

-- triggered via OnMsg.ColonistBorn
local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived then
		local LeaderColonist = MartianTribune.LeaderColonist
		local MartianTribuneMod = MartianTribuneMod
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

		if IsValidColonist(LeaderColonist)
			and (LeaderColonist.traits.Glutton
				or LeaderColonist.traits.Gambler
				or LeaderColonist.traits.Alcoholic)
		then
			local LeaderName = MartianTribune.LeaderName
			local LeaderTitle = MartianTribune.LeaderTitle
			local AddTopStory = MartianTribuneMod.Functions.AddTopPotentialStory

			AddTopStory({
				key = Key1,
				title = T{9013664, "Virtue Over Vices"},
				story = T{9013665, "     The stresses of colonizing a new planet have clearly taken their toll on <MTLeaderTitle> <MTLeader> as the foolishness of last night's escapades will not be long forgotten.  <MTLeaderTitle>, learn to control your vices better before they take us all down with you!  If things don't change soon, it might be time to start looking for a new leader.", MTLeaderTitle = LeaderTitle, MTLeader = LeaderName},
				colonist = LeaderColonist
			})
		end
	end
end

function OnMsg.ColonistBorn()
	CheckStory()
end