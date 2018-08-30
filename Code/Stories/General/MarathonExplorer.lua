local Key1 = "MarathonExplorer"

local function CheckStory()
	local Sent = MartianTribune.Sent
	if not Sent[Key1] and UICity.day > 35 and UICity.labels.ExplorerRover ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory
		AddStory({
			key = Key1,
			title = T{9013587, "A Martian Marathon"},
			story = T{9013588, "     Mars' first RC Explorer has now traversed a whopping 42.2 Kilometers, or 26.2 miles, completing its own personal marathon on Mars. We at the Martian Tribune support this great explorer in its marathon effort. May the discoveries continue to pour in as a result of such diligence and dedication."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end