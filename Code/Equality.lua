local Key1 = "Equality"

--  put into FREE stories
local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and UICity.day > 50 then
		local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
		local LeaderTitle = MartianTribune.LeaderTitle
		local Sponsor = MartianTribune.Sponsor

		AddStory({
			key = Key1,
			title = T{9013653, "<MTLeaderTitle> Praised For Culture of Equality", MTLeaderTitle = LeaderTitle},
			story = T{9013654, "     In a recent G20 Summit, Mars has been praised for its fully representative gender-based equality. Martian men, women, and those identifying as Other all have equal and ready access to all services, job opportunities, and representation. This has been attributed to <MTSponsor> who has gone on record as not really caring about \"things like gender, as long as they get the job done.\"", MTSponsor = Sponsor}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end