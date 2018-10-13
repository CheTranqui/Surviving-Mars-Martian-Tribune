local Key1 = "DomeCrack"
local Key2 = "WhyDomes"

local function CheckStory1(dome)
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and IsValid(dome) then
		local AddEngStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local DomeName = dome.name or T{9013817, "Cracked dome"}

		AddEngStory({
			key = Key1,
			title = T{9013818, "<DomeName> Repaired, People Rejoice", DomeName = DomeName},
			story = T{9013819, "     <DomeName> recently developed a large crack, causing much of our precious oxygen to evaporate into the Martian atmosphere. Lucky for us oxygen breathing humans, however, our drones are not affected so deeply and were quick to react.  Hopefully the polymer-based super glue does the trick for many sol to come.  Keep an eye on <DomeName> in these coming days and be sure to report any shortness of breath to local authorities.", DomeName = DomeName}
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
	CheckStory1(self)
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key2] and ColonistsHaveArrived then
		local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory

		AddTopStory({
			key = Key2,
			title = T{9013890, "Why We Live In Domes"},
			story = T{9013891, "     Have you ever wondered why it is we live in domes today? The primary concerns for housing on Mars are appropriate atmospheric pressurization, temperatures, and radiation protection. While closing off and pressurizing caves was considered, the greenhouse effect of domes was deemed too valuable to ignore."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory2()
end