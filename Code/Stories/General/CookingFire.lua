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
			title = T{9013868, "Fire almost kills colonist"},
			story = T{9013869, "     <ColonistName> was lucky to escape with their life when their apartment went up in flames yesterday after an unfortunate cooking accident. Reports say the colonist called emergency services but was informed that the closest fire station was in the Adams area Fire district, and thus would take a very long time to respond. Dispatch recommended the colonist put out the fire themselves, which they did.", ColonistName = Name}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end