local Key1 = "NoFood1"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived then
		-- defining "no food" as less than 1 day's supply for the colony.
		local CityResources = g_ResourceOverviewCity[UICity.map_id]
		local consumed = CityResources:GetFoodConsumedByConsumptionYesterday()
		local data = next(CityResources.data) and CityResources.data

		if data.Food == 0
			or (
				data.Food > 0
				and consumed > 0
				and (data.Food / consumed) <= 1
			)
		then
			local AddTopStory = MartianTribuneMod.Functions.AddTopPotentialStory

			AddTopStory({
				key = Key1,
				title = T{9013847, "Starving Colonists Create Alternatives"},
				story = T{9013848, "     Colonists are starving and have begun to pass around recipes calling for Martian dust in an attempt to not starve. Recipes such as roast dust, and dustloaf are becoming more popular, but botonists are declaring that not only are they disgusting, but they also have zero nutritional value. Best to stay away from this series of quirky innovative recipes."}
			})
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end