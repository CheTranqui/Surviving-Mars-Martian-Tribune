local TraitId = "Martianborn"
local Key1 = "FirstMartianbornDied"

local function CheckStory(colonist)
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent

	-- Note: since this is a dead colonist, IsValidColonist would return false. Checking only IsValid checks only if there is a valid entity passed regardless of whether that entity is "alive".
	if not Sent[Key1] and IsValid(colonist) and colonist.traits[TraitId] then
		local AddStory = MartianTribuneMod.Functions.AddTopUrgentStory
		local Name = colonist.name or T{9013663, "first dead martian"}
		local LeaderTitle = MartianTribune.LeaderTitle

		AddStory({
			key = Key1,
			title = T{9013661, "Petition to Rename Dome"},
			story = T{9013662, "     A petition has arrived at the Martian Tribune asking that a dome of ours be re-named in honor of <MTDeadMartianName>. We at the bureau also feel it would be a great way to remember the dead. If you would like to add your name to the petition, stop by the bureau before next Monday when we officially present the petition to the <MTLeaderTitle> on behalf of the martian people.", MTDeadMartianName = Name, MTLeaderTitle = LeaderTitle}
		})
	end
end

function OnMsg.ColonistDied(colonist, reason)
	if colonist.traits[TraitId] then
		CheckStory(colonist)
	end
end