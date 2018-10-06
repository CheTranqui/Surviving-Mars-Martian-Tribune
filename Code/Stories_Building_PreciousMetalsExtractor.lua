local Key1 = "SoundComplaint"
local Key2 = "MartianMetals"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local UICity = UICity

	if ColonistsHaveArrived and UICity.labels.PreciousMetalsExtractor ~= nil then
		local MartianTribuneMod = MartianTribuneMod

		if not Sent[Key1] then
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

		if not Sent[Key2] then
			local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory

			AddTopStory({
				key = Key2,
				title = T{9013898, "Martian Metals"},
				story = T{9013899, "     Ever wonder precisely what kinds of metals we're working with on a daily basis here on Mars? Similar to their Earthling counterparts, the more common ones are iron, aluminum, titanium and chromium. Rarer metals have been found in trace quantities, including cobalt, nickel, zinc, lithium, and gold, giving hope that we might locate a truly valuable vein in the near future. Let's see what our new Rare Metals Extractor uncovers, shall we?"}
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