local TraitId = "Founder"
local Key1 = "FoundersLegacy"

local function GetFoundersLegacyBuilding(FoundersDome)
	local FoundersDomeRelaxation = T{9013757, "your local park"}
	if IsValid(FoundersDome) then
		if FoundersDome.labels.Spacebar ~= nil then
			FoundersDomeRelaxation = T{9013750, "Spacebar"}
		elseif FoundersDome.labels.OpenAirGym ~= nil then
			FoundersDomeRelaxation = T{9013751, "Open Air Gym"}
		elseif FoundersDome.labels.GardenStone ~= nil then
			FoundersDomeRelaxation = T{9013752, "Stone Garden"}
		elseif FoundersDome.labels.FountainLarge ~= nil then
			FoundersDomeRelaxation = T{9013753, "Fountain"}
		elseif FoundersDome.labels.GardenNatural_Medium ~= nil then
			FoundersDomeRelaxation = T{9013754, "Natural Garden"}
		elseif FoundersDome.labels.Apartments ~= nil then
			FoundersDomeRelaxation = T{9013755, "Apartments"}
		elseif FoundersDome.labels.LivingQuarters ~= nil then
			FoundersDomeRelaxation = T{9013756, "Living Quarters"}
		end
	end
	return FoundersDomeRelaxation
end

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local FoundersDeadSol = MartianTribune.Count.FoundersDeadSol

	if not Sent[Key1] and ColonistsHaveArrived and FoundersDeadSol ~= nil then
		if UICity.day >= (FoundersDeadSol + 10) and UICity.labels.Dome ~= nil then
			local Dome = UICity.labels.Dome[1]
			local FoundersLegacyDome = (Dome and Dome.name) or T{9013749, "every dome"}
			local FoundersLegacyBuilding = GetFoundersLegacyBuilding(FoundersLegacyDome)
			local NumFounders = MartianTribune.Count.NumFounders
			local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory

			AddStory({
				key = Key1,
				title = T{9013747, "The Founder's Legacy"},
				story = T{9013748, "     There are only <MTFoundersCount> people who will ever be known as Founders.  These extraordinary men and women risked their lives to venture into the Final Frontier and gain a foothold on the Red Planet.  They toiled day and night, working non-stop to ensure constant and consistent air flow, water pressure, power generation, and more.  As we go about our sol we must remember to take a moment and honor those who came before us, those who made all that we see around us possible.  We will be celebrating Founder's Sol at noon tomorrow at the <MTFoundersLegacyBuilding> in <MTFoundersLegacyDome> where we will be taking <MTFoundersCount> minutes of silence in memory of these most excellent of individuals.", MTFoundersCount = NumFounders, MTFoundersLegacyBuilding = FoundersLegacyBuilding, MTFoundersLegacyDome = FoundersLegacyDome}
			})
		end
	end
end

function OnMsg.ColonistDied(colonist)
	local MartianTribune = MartianTribune
	local FoundersDeadSol = MartianTribune.Count.FoundersDeadSol

	if FoundersDeadSol == nil and CountColonistsWithTrait(TraitId) == 0 then
		-- all founders are now dead (note that with ProjectPhoenix, this may take centuries to occur)
		MartianTribune.Count.FoundersDeadSol = UICity.day
	elseif FoundersDeadSol ~= nil then
		CheckStory()
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end