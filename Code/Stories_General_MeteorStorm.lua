local Key1 = "DeflectingMeteors"

local function CheckStory1()
	local Sent = MartianTribune.Sent

	if not Sent[Key1] then
		local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory

		AddTopStory({
			key = Key1,
			title = T{9013908, "Deflecting Meteors Is a Planet’s Job"},
			story = T{9013909, "     The frequency and strength of meteor showers depends heavily upon the local magnetosphere. It is theorized that Mars once had an internal dynamo, as Earth does now, which previously protected the planet from such space debris. Once that shut down all that now remains are just how many rocks were magnetized, and how strongly. Thankfully, in this location, we have one of those smaller, local magnetospheres serving as an invisible protector on top of the security provided by each of our domes."}
		})
	end
end

function OnMsg.MeteorStorm()
	CheckStory1()
end