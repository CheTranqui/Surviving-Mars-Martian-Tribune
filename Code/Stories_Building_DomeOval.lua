local Key1 = "OvalDome"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and UICity.labels.DomeOval ~= nil then
		local AddEngStory = MartianTribuneMod.Functions.AddEngPotentialStory
		AddEngStory({
			key = Key1,
			title = T{9013616, "Martian Engineering Advances Shine"},
			story = T{9013617, "     The recent construction of our new Oval Dome has received numerous accolades by both <MTSponsor> and our Earthen brethren. This new dome design allows for two spires, which scientists describe as \"an incredible breakthrough\" stating that they can now throw paper airplanes from one spire to another without even striking the sides of the dome."}
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
