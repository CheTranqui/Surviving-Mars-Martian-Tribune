local Key1 = "OopsIBrokeItAgain"

local function CheckStory(workplace, idiot)
	local Sent = MartianTribune.Sent
	local MartianTribuneMod = MartianTribuneMod
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

	if not Sent[Key1] and IsValid(workplace) and IsValidColonist(idiot) then
		local AddEngStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local IdiotColonistFallbackName = MartianTribuneMod.Name.IdiotColonist

		local Workplace = workplace.display_name or T{9013675, "idiot's workplace"}
		local Name = idiot.name or IdiotColonistFallbackName

		AddEngStory({
			key = Key1,
			title = T{9013673, "Oops I Broke It Again"},
			story = T{9013674, "     Dome dimwit <MTIdiotName> has once again managed to again find a way to get around the idiot-proof safety features of the local <MTIdiotWorkplace> with an amazing display of acrobatics, luck, and skill. Once again <MTIdiotName> found themselves holding a vital part of the building in their hand as they left work today. \"I honestly have no idea how they managed it. The building can't function without it, so we keep it behind three feet of concrete... yet, somehow, they still managed to walk off with it. I'm not even mad. It really is just plain amazing.\"", MTIdiotName = Name, MTIdiotWorkplace = Workplace},
			colonist = idiot
		})
	end
end

function OnMsg.MartianTribuneBuildingMalfunction(building)
	if building:IsKindOf("Workplace") then
		local MartianTribuneMod = MartianTribuneMod
		local GetWorkers = MartianTribuneMod.Functions.GetWorkers
		local Workers = GetWorkers(building)
		if Workers ~= nil and #Workers > 0 then
			local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
			local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
			local IdiotWorker = GetColonistWithTrait("Idiot", Workers)
			if IsValidColonist(IdiotWorker) then
				-- Treat this as a breakdown at workplace 'self' caused by IdiotWorker.
				CheckStory(building, IdiotWorker)
			end
		end
	end
end
