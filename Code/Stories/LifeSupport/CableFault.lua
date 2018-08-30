local TraitId = "scientist"
local Key1 = "CableFault"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and CountColonistsWithTrait(TraitId) > 0 then
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory

		local Colonist = GetColonistWithTrait(TraitId)
		local Name = IsValidColonist(Colonist) and Colonist.name or T{9013549, "random scientist"}

		AddStory({
			key = Key1,
			title = T{9013875, "Cables leaking electricity!"},
			story = T{9013876, "     One of the many cables around Mars has reported a major fault, and requested a drone to come fix it. While waiting for the drone, the cable is leaking large amounts of electricity into the atmosphere. We asked <ScientistName> about this phenomenon. \"We have no idea how the electricty leaks out, electricity shouldn’t work like that. But here we are, leaking it anyway.\"", ScientistName = Name}
		})
	end
end

local breakableSupplyGridElementBreak = BreakableSupplyGridElement.Break
function BreakableSupplyGridElement:Break(...)
	-- Note: after original function called, self:CanBreak() will be set to false even if it had been
	-- breakable (because it can't break again while still broken). So record whether this element was
	-- breakable first, and use that to determine whether it could have been broken after running the
	-- original function.
	local canBreak = self:CanBreak()

	if breakableSupplyGridElementBreak then
		breakableSupplyGridElementBreak(self, ...)
	end

	if canBreak and self.supply_resource == "electricity" then
		CheckStory()
	end
end