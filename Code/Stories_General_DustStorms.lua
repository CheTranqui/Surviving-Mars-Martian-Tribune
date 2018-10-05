local Key1 = "DustStormWarning"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and #UICity.labels.Colonist > 35 then
		local Sponsor = MartianTribune.Sponsor
		local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory

		AddTopStory({
			key = Key1,
			title = T{9013894, "Dust Storms and Dome Self-Sufficiency"},
			story = T{9013895, "     <MTSponsor> has declared that our progress on the Red Planet has been a truly remarkable feat and has issued a notice for all Martian residents: \"Every six to eight Earthen years a dust storm has been known to cover the entire surface of Mars for a minimum of one week and at times up to six months. With the most recent storm in 2007, the next one is imminent. Remember to make each dome fully self-sufficient to overcome this future eventuality.\"", MTSponsor = Sponsor}
		})
  end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end