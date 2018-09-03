local EntityId = "MartianUniversity"
local Key1 = "University"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	
	if not Sent[Key1]
	and ColonistsHaveArrived
	and UICity.labels.MartianUniversity ~= nil
	then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		AddStory({
			key = Key1,
			title = T{9013678, "MRU Opens Its Doors"},
			story = T{9013679, "     After months of construction and planning the Martian Red University has opened its doors to Martians and colonists alike offering classes in Martian Botony, Martian Engineering, Martian Geology, Martian Medical Care, and Martian Science.  MRU is already being recognized as an accredited third level educational institute throughout the entire planet. Sign up now and become marginally less useless today!"}
		})
	end
end

local uniInit = MartianUniversity.GameInit
function MartianUniversity.GameInit(...)
	if uniInit then
		uniInit(...)
	end
	CheckStory()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end