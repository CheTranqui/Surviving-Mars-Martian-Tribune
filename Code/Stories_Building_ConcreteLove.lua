local BuildingClass = "RegolithExtractor"
local Key1 = "ConcreteLove"

local function CheckStory()
	local Sent = MartianTribune.Sent
	if not Sent[Key1] and MapCount("map", BuildingClass) > 1 then
		local AddEngStory = MartianTribuneMod.Functions.AddEngFreeStory
		AddEngStory({
			key = Key1,
			title = T{9013614, "Concrete Extractor Loves Its Job"},
			story = T{9013615, "     Concrete Extractor #2 has been observed to really love its job extracting concrete for the embetterment of humanity, always putting in 100% exactly. Unlike the other extractors, Concrete Extractor #2 is programmed specifically to remember every piece of concrete it extracts, and it's programmer claims that it even develops an emotional connection with the concrete it extracts. Love is in the air, folks!  ...and the concrete."}
		})
	end
end

local extractorInit = RegolithExtractor.GameInit
function RegolithExtractor.GameInit(...)
	if extractorInit then
		-- is defined in the game code, so this one *should* always be defined.
		extractorInit(...)
	end
	CheckStory()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end