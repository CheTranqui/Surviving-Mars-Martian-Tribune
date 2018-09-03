local Key1 = "SoundComplaint"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local UICity = UICity

	if not Sent[Key1] and ColonistsHaveArrived and UICity.labels.PreciousMetalsExtractor ~= nil then
		local Extractor = table.rand(UICity.labels.PreciousMetalsExtractor)
		if IsValid(Extractor) then
			local AddSocialStory = MartianTribuneMod.Functions.AddSocialPotentialStory
			local GetRandomWorker = MartianTribuneMod.Functions.GetRandomWorker
			local LeaderName = MartianTribune.LeaderName
			local Colonist = GetRandomWorker(Extractor)
			local ColonistName = (Colonist and Colonist.name) or T{9013694, "random rare metals colonist"}
			local DomeName = 
				(Colonist and Colonist.dome and Colonist.dome.name)
				or T{9013695, "random rare metals dome"}

			AddSocialStory({
				key = Key1,
				title = T{9013692, "Sound Complaint Filed"},
				story = T{9013693, "     <MTRareMetalsColonist> has lodged a formal complaint against <MTLeader>'s natural resource exploitation.  In the complaint they declared the primary contributor to be the new Rare Metals Extractor near <MTRareMetalsDome>.  There was also mention of sleep being precious and the constant pounding leaving not a moment of reprieve.  <MTLeader> declared themselves unmoved by the complaint.", MTRareMetalsColonist = ColonistName, MTLeader = LeaderName, MTRareMetalsDome = DomeName},
			})
		end
	end
end

local extractorInit = PreciousMetalsExtractor.GameInit
function PreciousMetalsExtractor.GameInit(...)
	if extractorInit then
		extractorInit(...)
	end
	CheckStory()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end