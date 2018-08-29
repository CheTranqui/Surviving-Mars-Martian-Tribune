local Key1 = "DomeCrack"

local function CheckStory(dome)
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and IsValid(dome) then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local DomeName = dome.name or T{9013817, "Cracked dome"}

		AddStory({
			key = Key1,
			title = T{9013818, "<DomeName> Repaired, People Rejoice", DomeName = DomeName},
			story = T{9013819, "     <DomeName> recently developed a large crack, causing much of our precious oxygen to evaporate into the martian atmosphere. Lucky for us oxygen breathing humans, however, our drones are not affected so deeply and were quick to react.  Hopefully the polymer-based super glue does the trick for many sol to come.  Keep an eye on <DomeName> in these coming days and be sure to report any shortness of breath to local authorities.", DomeName = DomeName}
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