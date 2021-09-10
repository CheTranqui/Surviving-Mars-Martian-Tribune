local Key1 = "AirSupply1"
local Key2 = "AirSupply2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local LastAirIssue = MartianTribune.Count.LastAirIssue or 0
	local UICity = UICity

	-- if after Sol 20 and 14 days+ have passed since last story
	if UICity.day > 20 and (LastAirIssue == nil or UICity.day - LastAirIssue >= 14) then
		local CityResources = g_ResourceOverviewCity[UICity.map_id]
		local AirBalance = CityResources.data.total_air_demand - CityResources.data.total_air_production

		if AirBalance > 0 then
			local AirHoursRemaining = CityResources.data.total_air_storage / AirBalance

			if AirHoursRemaining < 12 then
				local Sent = MartianTribune.Sent
				local AddEngStory = MartianTribuneMod.Functions.AddEngPotentialStory
				MartianTribune.Count.LastAirIssue = UICity.day

				local random_num =
					(not Sent[Key1] and Sent[Key2] and 1)
					or (Sent[Key1] and not Sent[Key2] and 2)
					or Random(1,2)


				if random_num == 1 then
					AddEngStory({
						key = Key1,
						title = T{9013603, "Oxygen Short: Time To Lay Low"},
						story = T{9013604, "     Oxygen production is a bit under current demand for the time being.  It's best to lie low for a few days!  Save that exercise until details have been sorted, more Moxies constructed, and for the drones to complete any necessary maintenance."}
					})
				elseif random_num == 2 then
					AddEngStory({
						key = Key2,
						title = T{9013605, "Oxygen Production Goals Unmet"},
						story = T{9013606, "     If you find yourself with chest pains in these next few days, it might be better to consult with your local engineer than your local doctor!  Our current oxygen production is just short of demand.  Expect the atmosphere to be a bit thin in the coming days and prepare for the worst."}
					})
				end
			end
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end