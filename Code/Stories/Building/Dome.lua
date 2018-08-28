local Key1 = "DomeCrack"

local function CheckStory(dome)
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and IsValid(dome) then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local DomeName = dome.name or T{9013817, "Cracked dome"}

		AddStory({
			key = Key1,
			title = T{9013818, "Drone Repairs <DomeName> Dome", DomeName = DomeName},
			story = T{9013819, "     <DomeName> recently developed a large crack, allowing precious oxygen to escape. Lucky for us oxygen breathing humans the drones were quick to react, gluing a full box of polymers to the crack.", DomeName = DomeName}
		})
	end
end


local fixedFracture = Dome.RemoveFixedFracture
function Dome:RemoveFixedFracture(...)
	if fixedFracture then
		fixedFracture(self, ...)
	else
		ModLog("Original Dome:RemovedFixedFracture() function not found!")
	end
	CheckStory(self)
end