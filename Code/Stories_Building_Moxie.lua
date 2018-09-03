local Key1 = "MoxieMagic"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	
	if not Sent[Key1] and UICity.labels.MOXIE ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		AddStory({
			key = Key1,
			title = T{9013610, "Moxie: Martian Magic"},
			story = T{9013611, "     This morning marks a milestone in the Martian memoirs. Moxie, the magic Martian machine makes mini mistrals, managing to maximise 02 from the mainly CO2 medium of Mars. Magnificent."}
		})
	end
end

-- Note: The message "ConstructionComplete" is fired *before* the building is moved into the final label, so for the first building 'UICity.labels.Building' will still be nil. Waiting for the Building:GameInit means that UICity.labels.Building will be set correctly.

local moxieInit = MOXIE.GameInit
function MOXIE.GameInit(...)
	if moxieInit then
		moxieInit(...)
	end
	CheckStory()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end