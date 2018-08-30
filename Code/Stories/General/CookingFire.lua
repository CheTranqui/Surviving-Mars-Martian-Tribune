local Key1 = "CookingFire"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local PopulatedApartments = FilterObjects({
		filter = function(apartment)
			return apartment.colonists and #apartment.colonists > 0
		end
	}, ColonistsHaveArrived and UICity.labels.Apartments or empty_table)

	if not Sent[Key1]
		and ColonistsHaveArrived
		and PopulatedApartments ~= nil
		and #PopulatedApartments > 0
	then
		local MartianTribuneMod = MartianTribuneMod
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local Apartment = table.rand(PopulatedApartments)
		local Colonist = table.rand(Apartment.colonists)
		local Name = IsValidColonist(Colonist) and Colonist.name or T{9013670, "random colonist"}

		AddStory({
			key = Key1,
			title = T{9013868, "Apartment Fire Tragedy Averted"},
			story = T{9013869, "     A fire in <apartments> almost killed several colonists recently. <ColonistName> was lucky to escape when their apartment went up in flames after an unfortunate cooking accident. Reports say after calling emergency services, they were informed that fire stations have yet to be built and water supply is short. Emergency dispatch recommended the colonist put out the fire themselves using whatever they may, \"water, pee, whatever!\", which they did, averting the near disaster.", ColonistName = Name}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end
