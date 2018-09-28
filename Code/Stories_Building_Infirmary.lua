local Key1 = "Domelenol"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived

	if not Sent[Key1] and ColonistsHaveArrived and UICity.labels.Infirmary ~= nil then
		local AddSocialStory = MartianTribuneMod.Functions.AddSocialFreeStory
		AddSocialStory({
			key = Key1,
			title = T{9013640, "Domelenol Now Available!"},
			story = T{9013641, "     Got any aches and pains? Go to your local infirmary and ask for some Domelenol, the only sponsor-approved painkiller on Mars. Warning: Domelenol will not cure earthsickness, headaches, being an idiot, toothaches, alcoholism, feelings of loneliness, gambling addiction, nausea or just about anything else. Use at your own risk."}
		})
	end
end

local infirmaryInit = Infirmary.GameInit
function Infirmary.GameInit(...)
	if infirmaryInit then
		infirmaryInit(...)
	end
	CheckStory()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end