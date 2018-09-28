local Key1 = "ArcologyInuendo"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Arcologies = UICity.labels.Arcology
	
    if not Sent[Key1] and ColonistsHaveArrived and Arcologies ~= nil then
		local AddEngStory = MartianTribuneMod.Functions.AddEngFreeStory
		local Arcology = table.rand(Arcologies)
		local ArcologyDomeName =
			(IsValid(Arcology) and Arcology.parent_dome.name)
			or T{9013609, "arcology dome"}

		AddEngStory({
			key = Key1,
			title = T{9013607, "First Dome-Penetrating Structure Erected"},
			story = T{9013608, "     The Arcology erected in <MTArcologyDomeName> has been praised as an exquisite example of engineering, poking through the rounded dome, to a firm stance with a rounded bottom. As ever, the typical architectural tropes remain well intact, as one of the arcology residents put it, \"How are we not doing phrasing anymore?  Seriously, the entire building is one giant inuendo!\"", MTArcologyDomeName = ArcologyDomeName}
		})
	end
end

local arcologyInit = Arcology.GameInit
function Arcology.GameInit(...)
	if arcologyInit then
		arcologyInit(...)
	end
	CheckStory()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end