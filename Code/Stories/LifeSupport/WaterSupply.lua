local Key1 = "WaterSupply1"
local Key2 = "WaterSupply2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local LastWaterIssue = MartianTribune.Count.LastWaterIssue or 0
	local UICity = UICity

	-- if after Sol 20 and 14 days+ have passed since last story
	if UICity.day > 20 and (LastWaterIssue == nil or UICity.day - LastWaterIssue >= 14) then
		local ResourceOverviewObj = ResourceOverviewObj
		local WaterBalance = ResourceOverviewObj.data.total_water_demand - ResourceOverviewObj.data.total_water_production

		-- If production is less than demand
		if WaterBalance > 0 then
			local WaterHoursRemaining = ResourceOverviewObj.data.total_water_storage / WaterBalance
			
			-- If stored resources run out within 12 hours
			if WaterHoursRemaining < 12 then
				local Sent = MartianTribune.Sent
				local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
				MartianTribune.Count.LastWaterIssue = UICity.day

				local random_num =
					(not Sent[Key1] and Sent[Key2] and 1)
					or (Sent[Key1] and not Sent[Key2] and 2)
					or Random(1,2)

				if random_num == 1 then
					local LeaderName = MartianTribune.LeaderName
					local LeaderTitle = MartianTribune.LeaderTitle

					AddStory({
						key = Key1,
						title = T{9013599, "Water Shortage Rumors Abound"},
						story = T{9013600, "     Water is on short supply these days.  <MTLeaderTitle> <MTLeader> has declared the shortage to be an outright lie, but rumors abound that plans are in the works to boost output in these coming sol.", MTLeaderTitle = LeaderTitle, MTLeader = LeaderName}
					})
				elseif random_num == 2 then
					AddStory({
						key = Key2,
						title = T{9013601, "Let It Mellow"},
						story = T{9013602, "     Conservation is the name of the game in our domes today as we find ourselves short on water production and storage.  In the coming days, we urge you to adopt a new philosophy if you haven't already: 'if it's yellow let it mellow, if it's brown flush it down.'  Hopefully this is a temporary situation.  We will advise you when the situation has improved."}
					})
				end
			end
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end