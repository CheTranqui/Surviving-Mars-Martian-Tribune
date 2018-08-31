local Key1 = "FoodShortage1"
local Key2 = "FoodShortage2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Sent[Key2] then
		local MartianTribuneMod = MartianTribuneMod
		local GetPopulatedDomes = MartianTribuneMod.Functions.GetPopulatedDomes
		local populatedDomes = GetPopulatedDomes()

		local domesWithoutFood = FilterObjects({
			filter = function(dome)
				return CountObjects({
					filter = function(building)
						return building.consumption_resource_type
							and building.consumption_resource_type == "Food"
							and building.consumption_stored_resources == 0
					end
				}, dome.labels.Building) > 1
			end
		}, populatedDomes)

		if #domesWithoutFood > 0 then
			local Dome = table.rand(domesWithoutFood)
			local DomeName = IsValid(Dome) and Dome.name or T{9013838, "dome without food"}
			local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
			local random_num = Random(1, 2)

			if random_num == 1 then
				local LeaderTitle = MartianTribune.LeaderTitle
				local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
				local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
				local Botanist = GetColonistWithTrait("botanist")
				local BotanistName = IsValidColonist(Botanist) and Botanist.name
					or T{9013688, "random botanist"}

				AddStory({
					key = Key1,
					title = T{9013839, "Tighten Your Belts"},
					story = T{9013840, "     <MTFoodDome> is on an unanticipated diet today as their food supply was recently destroyed as the harsh Martian winds blew so much dust into it as to make it inedible and irrecoverably contaminated.  The <MTLeaderTitle> has promised that <MTFoodBotanist> is looking into the issue and food stores will be replenished shortly, but only time will tell.", MTFoodDome = DomeName, MTLeaderTitle = LeaderTitle, MTFoodBotanist = BotanistName}
				})
			else
				AddStory({
					key = Key2,
					title = T{9013841, "Colonists Starving in <MTFoodDome>", MTFoodDome = DomeName},
					story = T{9013842, "     Starvation has set in on an already beleaguered <MTFoodDome>.  Please send any stores you have set aside to us, if you have them, and we will be sure to redistribute them ASAP.", MTFoodDome = DomeName}
				})
			end
		end
	end
end

function OnMsg.ColonistStatusEffect(colonist, status_effect, bApply, now)
	if bApply and status_effect == "StatusEffect_Starving" then
		CheckStory()
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end