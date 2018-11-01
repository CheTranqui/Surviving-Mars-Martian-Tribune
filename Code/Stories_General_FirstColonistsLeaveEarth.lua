local Key1 = "WaitForIt"

local function CheckStory1()
	local Sent = MartianTribune.Sent

	if not Sent[Key1] then
		local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory

		AddTopStory({
			key = Key1,
			title = T{9013910, "Wait For It…"},
			story = T{9013911, "     Prior to our own series of successful missions to establish this new colony there have been eight successful flights from Earth to Mars for various spacecraft. The average travel time for these spacecraft is a total of 237 days. The amazing thing is, however, that this is on top of the two year wait for each ideal launch window as the two planetary orbits come into sync allowing for the shortest possible flight. We here at the Martian Tribune would like to thank our wise leaders and planners for their provision as with nearly two years between possible launch windows, the margin for error is small indeed."}
		})
	end
end

function OnMsg.RocketLaunchFromEarth(rocket)
	if rocket.cargo > 0 then
		for i,cargo in ipairs(rocket.cargo) do
			if cargo.class == "Passengers" then
				CheckStory1()
				return
			end
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	if MartianTribune.ColonistsHaveArrived then
		CheckStory1()
	end
end