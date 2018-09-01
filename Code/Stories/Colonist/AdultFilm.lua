local TraitId = "Sexy"
local Key1 = "AdultFilm"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1]
		and ColonistsHaveArrived
		and UICity.day > 20
		and CountColonistsWithTrait(TraitId) > 2
	then
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory
		local Colonist = GetColonistWithTrait(TraitId)
		local Name = (Colonist and Colonist.name) or T{9013760, "sexy colonist"}
		local Sponsor = MartianTribune.Sponsor

		AddStory({
			key = Key1,
			title = T{9013758, "SpaceXXX"},
			story = T{9013759, "     In an unexpected turn of events, <MTSexyColonistName> has officially produced the first ever Martian adult film.  Starring 11 different colonists with <MTSexyColonistName> as the lead, it has become quite a hit on earth.  The film also provides a sneak peek into Martian pipe work and our stockpiles of electronics and machine parts in the background.  <MTSponsor> has declared themselves not responsible for the social implications of such actions, but did praise the artistic vision of the Director calling it a \"unique and innovative production\".", MTSexyColonistName = Name, MTSponsor = Sponsor},
			colonist = IsValidColonist(Colonist) and Colonist or nil
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end