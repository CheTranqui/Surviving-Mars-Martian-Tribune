
local Key1 = "PowerSupply1"
local Key2 = "PowerSupply2"

local function CheckStory()
	local UICity = UICity
	local MartianTribune = MartianTribune
	local LastPowerIssue = MartianTribune.Count.LastPowerIssue or 0

	-- if after Sol 20 and 14 days+ have passed since last story
	if UICity.day > 20 and (LastPowerIssue == nil or UICity.day - LastPowerIssue >= 14) then
		local ResourceOverviewObj = ResourceOverviewObj
		local PowerBalance = ResourceOverviewObj.data.total_power_demand - ResourceOverviewObj.data.total_power_production

		-- If production is lower than demand
		if PowerBalance > 0 then
			local PowerHoursRemaining = ResourceOverviewObj.data.total_power_storage / PowerBalance

			-- If stored resources run out within 12 hours
			if PowerHoursRemaining < 12 then
				local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
				local Sent = MartianTribune.Sent

				MartianTribune.Count.LastPowerIssue = UICity.day
				local random_num =
					(not Sent[Key1] and Sent[Key2] and 1)
					or (Sent[Key1] and not Sent[Key2] and 2)
					or Random(1,2)

				if random_num == 1 then
					AddStory({
						key = Key1,
						title = T{9013595, "Word of the Day:  Power Conservation"},
						story = T{9013596, "     Leadership has declared it a non-issue, but the flickering lights are not your imagination: our power infrastructure is failing us and no longer meets the burgeoning demands of our colony.  Please remember to turn off all lights and electronics when not in use.  Your neighbors will thank you for it."}
					})
				else
					local LeaderTitle = MartianTribune.LeaderTitle
					AddStory({
						key = Key2,
						title = T{9013597, "Power Grid Depleted"},
						story = T{9013598, "     If it feels a little colder in your dome today than yesterday, that may be because our power grid is maxed and the <MTLeaderTitle> seems to be doing nothing about it.  Dress warmly, this isn't the first day the power's gone out and it likely won't be the last.", MTLeaderTitle = LeaderTitle}
					})
				end
			end
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end