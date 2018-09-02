local Key1 = "CookingFire"

local function CheckStory(apartment)
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1]
		and ColonistsHaveArrived
		and IsValid(apartment)
		and apartment.colonists
		and #apartment.colonists > 0
	then
		local MartianTribuneMod = MartianTribuneMod
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
		local Colonist = table.rand(apartment.colonists)
		local DomeName = apartment.parent_dome.name
		local Name = IsValidColonist(Colonist) and Colonist.name or T{9013670, "random colonist"}

		AddStory({
			key = Key1,
			title = T{9013868, "Apartment Fire Tragedy Averted"},
			story = T{9013869, "     A fire in an apartment in <DomeName> almost killed several colonists recently. <ColonistName> was lucky to escape when their apartment went up in flames after an unfortunate cooking accident. Reports say that when <ColonistName> called emergency services, they were informed that fire stations have yet to be built and the water supply was short. Emergency dispatch recommended that they put out the fire themselves using whatever they may, \"water, pee, whatever!\", which they did, averting the near disaster.", ColonistName = Name, DomeName = DomeName}
		})
	end
end

function OnMsg.MartianTribuneBuildingMalfunction(building)
	if building:IsKindOf("Apartments") and building.colonists and #building.colonists > 0 then
		CheckStory(building)
	end
end

function OnMsg.MartianTribuneUnmaintainedBuildingBroken(building)
	if building:IsKindOf("Apartments") and building.colonists and #building.colonists > 0 then
		CheckStory(building)
	end
end
