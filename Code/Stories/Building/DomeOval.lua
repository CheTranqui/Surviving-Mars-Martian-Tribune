local Key1 = "OvalDome"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and UICity.labels.DomeOval ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		AddStory({
			key = Key1,
			title = T{9013616, "Oval Dome Declared Unnatural"},
			story = T{9013617, "     The building of the new Oval Dome has stirred a fair share of controversy on Mars. The Flat Mars League (FML) has come forward, claiming it unnatural. \"We have always built round domes, this new oval dome is an insult to Martian tradition. What's next? Square?\" The new dome design allows for two spires, which scientists have described as \"an incredible breakthrough\" stating that they can now throw paper airplanes from one spire to another without even striking the sides of the dome."}
		})
	end
end

local domeInit = DomeOval.GameInit
function DomeOval.GameInit(...)
	if domeInit then
		domeInit(...)
	end
	CheckStory()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end