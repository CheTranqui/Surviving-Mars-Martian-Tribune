local Key1 = "FoundersFirstWords"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
    local Sent = MartianTribune.Sent

    if not Sent[Key1] and ColonistsHaveArrived and CountColonistsWithTrait("Founder") > 0 then
        local MartianTribuneMod = MartianTribuneMod
        local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
        local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory
		local Colonist = GetColonistWithTrait("Founder")
		local Name = Colonist.name or T{9013576, "random founder"}
		AddStory({
			key = Key1,
			title = T{9013572, "First Words Spoken On Mars"},
			story = T{9013573, "     \"Our journey began with one small step and one giant leap. Today, we take another of each, and begin to find our stride\". Powerful words from <MTFounderName> as Humanity expands for the first time to another planet.", MTFounderName = Name},
			colonist = Colonist
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
    CheckStory()
end