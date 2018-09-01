local Key1 = "IdiotFML"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and CountColonistsWithTrait("Idiot") > 0 then
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local Sponsor = MartianTribune.Sponsor
		local IdiotColonistFallbackName = MartianTribuneMod.Name.IdiotColonist

		local Colonist = GetColonistWithTrait("Idiot")
		local Name = (Colonist and Colonist.name) or IdiotColonistFallbackName
		AddStory({
			key = Key1,
			title = T{9013671, "Flat Mars League Gains Traction"},
			story = T{9013672, "     <MTSponsor>'s recent announcement that cursory scans of the Martian surface are complete has prompted an interesting response from the public.  The Flat Mars League (FML) has come forward to declare that the scans provide full evidence, beyond any doubt, that Mars is indeed flat.  Their spokesman, <MTIdiotName>, has pointed to the clear squareness of the resulting map, and the fact that the horizon is so obviously flat as well.  When asked about Earth, <MTIdiotName> stated that, \"Unlike Mars, Earth has been observed to be round\".", MTSponsor = Sponsor, MTIdiotName = Name},
			colonist = IsValidColonist(Colonist) and Colonist or nil
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end