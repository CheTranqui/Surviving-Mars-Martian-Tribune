local Key1 = "CaptureTheFlag"

local function CheckStory()
	local Sent = MartianTribune.Sent

	if not Sent[Key1] then
		local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory

		AddStory({
			key = Key1,
			title = T{9013847, "Capture the flag game suspended"},
			story = T{9013848, "     The planned game of planetwide capture the flag has been suspended indefinitly as Mars has yet to agree on a single flag design. A competition will be held soon to design a flag, which will allow us to claim large swaths of Mars under our rule."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end