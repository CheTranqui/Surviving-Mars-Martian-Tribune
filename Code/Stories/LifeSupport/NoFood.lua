local Key1 = "NoFood1"
local Key2 = "NoFood2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Sent[Key2] and ColonistsHaveArrived then
		-- defining "no food" as less than 1 day's supply for the colony.
		local ResourceOverviewObj = ResourceOverviewObj
		local consumed = ResourceOverviewObj:GetFoodConsumedByConsumptionYesterday()
		local data = next(ResourceOverviewObj.data) and ResourceOverviewObj.data

		if data.Food > 0
			and consumed > 0
			and (data.Food / consumed) <= 1
		then
			local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory
			local random_num = Random(1,2)

			if random_num == 1 then
				AddStory({
					key = Key1,
					title = T{9013851, "Food Shortage! Can we cannabalise?"},
					story = T{9013852, "     With Food at a desperately low level, colonists are considering some of the most dire options available to them. Cannabilism has come up, with many people voting to eat the botonists as \"its all their fault anyway, they should be the first to go\". The Martian Tribune would like to remind people that journalists are critical to a colony's survival."}
				})
			else
				AddStory({
					key = Key2,
					title = T{9013853, "Starving colonists turn to other sources of nutrition"},
					story = T{9013854, "     Colonists are starving, and have started publishing recipes that call for martian dust, in an attempt to not starve. Such recipes such as roast dust, and dustloaf are becoming more popular, but reports say that they are not only disgusting, but also have no nutritional value."}
				})
			end
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end