local Key1 = "OopsIBrokeItAgain"

local function CheckStory(workplace, idiot)
	local Sent = MartianTribune.Sent
	local MartianTribuneMod = MartianTribuneMod
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

	if not Sent[Key1] and IsValid(workplace) and IsValidColonist(idiot) then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local IdiotColonistFallbackName = MartianTribuneMod.Name.IdiotColonist

		local Workplace = workplace.display_name or T{9013675, "idiot's workplace"}
		local Name = idiot.name or IdiotColonistFallbackName

		AddStory({
			key = Key1,
			title = T{9013673, "Oops I Broke It Again"},
			story = T{9013674, "     Dome dimwit <MTIdiotName> has once again managed to again find a way to get around the idiot-proof safety features of the local <MTIdiotWorkplace> with an amazing display of acrobatics, luck, and skill. Once again <MTIdiotName> found themselves holding a vital part of the building in their hand as they left work today. \"I honestly have no idea how they managed it. The building can't function without it, so we keep it behind three feet of concrete... yet, somehow, they still managed to walk off with it. I'm not even mad. It really is just plain amazing.\"", MTIdiotName = Name, MTIdiotWorkplace = Workplace},
			colonist = idiot
		})
	end
end

-- Hook into the SetMalfunction call to send a custom message for a workplace breakdown
-- that can be used to identify when an Idiot has caused a malfunction.
local originalSetMalfunction = RequiresMaintenance.SetMalfunction
function RequiresMaintenance:SetMalfunction(...)
	-- Note: The original RequiresMaintenance:SetMalfunction function states that if
	-- self.maintenance_phase == false this is a direct call to break this building.
	-- So check that
	--   a) The building is one that needs maintenance (won't be broken if not)
	--   b) self.maintenance_phase == false (is a direct call to break this item)
	--   c) This item is a Workplace
	-- If all 3 conditions are met prior to running the original function, this is likely
	-- to be a breakdown due to an Idiot worker.
	local MayBeIdiotBreakdown = self:DoesRequireMaintenance() and self.maintenance_phase == false and self:IsKindOf("Workplace")

	-- Call the original function to actually *set* the maintenance requirements (we
	-- don't want to lose the original functionality)
	originalSetMalfunction(self, ...)

	-- Now check the workplace for an Idiot worker, and if found send a message we can
	-- listen for stating that an idiot broke the building.
	if MayBeIdiotBreakdown then
		local MartianTribuneMod = MartianTribuneMod
		local GetWorkers = MartianTribuneMod.Functions.GetWorkers
		local Workers = GetWorkers(self)
		if Workers ~= nil and #Workers > 0 then
			local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
			local IdiotWorker = GetColonistWithTrait("Idiot", Workers)
			if IsValid(IdiotWorker) then
				-- Treat this as a breakdown at workplace 'self' caused by IdiotWorker.
				Msg("MartianTribuneIdiotBreakdown", self, IdiotWorker)
			end
		end
	end
end

function OnMsg.MartianTribuneIdiotBreakdown(workplace, idiot)
	CheckStory(workplace, idiot)
end
