local Key1 = "ConcretePaving"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local UICity = UICity

	if not Sent[Key1] and ColonistsHaveArrived and UICity.labels.RegolithExtractor ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		-- local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local Colonist = table.rand(UICity.labels.Colonist)
		local Name = (Colonist and Colonist.name) or T{9013698, "random person"}

		AddStory({
			key = Key1,
			title = T{9013696, "Paving Over The Problem"},
			story = T{9013697, "     <MTConcreteName> has lodged a formal complaint with authorities today after the plans to construct yet another Concrete Extractor was announced. <MTConcreteName> declared within that they 'did not come to another planet to pave it over.'", MTConcreteName = Name},
			-- colonist = IsValidColonist(Colonist) and Colonist or nil
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end