local TraitId = "ColonyLeader"
local Key1 = "LeaderDied1"
local Key2 = "LeaderDied2"

local function LeaderDiedStory(colonist)
	local Name = (colonist and colonist.name) or T{9013737, "dead leader"}
	local LeaderTitle = MartianTribune.LeaderTitle
	local AddTopStory = MartianTribuneMod.Functions.AddTopUrgentStory
	local random_num = Random(1,2)

	if random_num == 1 then
		AddTopStory({
			key = Key1,
			title = T{9013733, "Mars is in Mourning"},
			story = T{9013734, "     Today is a solemn day.  <MTLeaderTitle> <MTDeadLeader> no longer walks the world of the living.  Martian society would not be what it is today without the indelible touch of <MTLeaderTitle> <MTDeadLeader> in so many places.  Please take a moment today to stop by your local spacebar and lift one up in honor of the late, great <MTLeaderTitle>.  What are your best memories of the now former <MTLeaderTitle>?  Send in your letters to the editor.  Select entries will be printed in Thursday's edition.  Thank you for your service, <MTDeadLeader>.  You will be missed.", MTLeaderTitle = LeaderTitle, MTDeadLeader = Name}
		})
	else
		AddTopStory({
			key = Key2,
			title = T{9013735, "Mars Mourns <MTLeaderTitle>'s Passing", MTLeaderTitle = MartianTribune.LeaderTitle},
			story = T{9013736, "     <MTLeaderTitle> <MTDeadLeader> served us honorably for many a sol and their passing has not gone unnoticed.  Despite serving Mars well during their tenure, it is suspected that they never quite fully adapted to the realities of life on Mars and between the stresses of daily Martian life, serving as our <MTLeaderTitle>, and many a sleepless night, a heart attack finally took them from us.  May your slumber, <MTLeaderTitle> <MTDeadLeader>, be deep and pleasant.  You will be missed.", MTLeaderTitle = LeaderTitle, MTDeadLeader = Name}
		})
	end
end

function OnMsg.ColonistDied(colonist, reason)
	if colonist == MartianTribune.LeaderColonist then
		LeaderDiedStory(colonist)
		colonist:RemoveTrait(TraitId)
		Msg("MartianTribuneLeaderDied")
	end
end
