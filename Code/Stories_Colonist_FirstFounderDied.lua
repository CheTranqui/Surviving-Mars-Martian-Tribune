local TraitId = "Founder"
local Key1 = "FirstFounderDied"

-- triggered via OnMsg.ColonistDied
local function CheckStory(colonist)
	local Sent = MartianTribune.Sent

	-- Note: since this is a dead colonist, IsValidColonist would return false. Checking only IsValid checks only if there is a valid entity passed regardless of whether that entity is "alive".
	if not Sent[Key1] and IsValid(colonist) and colonist.traits[TraitId] then
		local AddSocialStory = MartianTribuneMod.Functions.AddSocialUrgentStory
		local Name = colonist.name or T{9013685, "dead founder"}

		AddSocialStory({
			key = Key1,
			title = T{9013683, "First Founder Passed Away"},
			story = T{9013684, "     Today marks a sad day on Mars as two planets mourn in unison.  The first death on Mars, Founder <MTDeadFounder> passed away today. As one of the very first Founders to ever set foot on the Red Planet, <MTDeadFounder> will go down in history as having set the highest of standards.  They were a brave soul, who's impact can be seen all around us, and shall not be forgotten.", MTDeadFounder = Name}
		})
	end
end

function OnMsg.ColonistDied(colonist, reason)
	if colonist.traits[TraitId] then
		CheckStory(colonist)
	end
end