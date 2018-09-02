local TraitId = "Martianborn"
local Key1 = "HappyBirthday"

local function CheckStory(colonist)
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

	if not Sent[Key1]
		and ColonistsHaveArrived
		and IsValidColonist(colonist)
		and CountColonistsWithTrait(TraitId) >= 4
	 then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local Name = (colonist and colonist.name) or T{9013660, "random birthday colonist"}

		AddStory({
			key = Key1,
			title = T{9013658, "A Baby-Step For Mankind, A Huge Leap For Martianborn!"},
			story = T{9013659, "     Today marks yet another milestone in Martian colonization: Today we celebrate the a special Martianborn birthday! Indeed, with <MTBirthdayName>'s birthday today we are reminded that this Red Planet is indeed ours! Let this serve as a sign that the Red Planet has truly become the realm of man! It is time to sing, cheer and celebrate at this wonderful news! Happy Birthday <MTBirthdayName>. May your life be long and prosperous.", MTBirthdayName = Name},
			-- colonist = colonist
		})
	end
end

function OnMsg.ColonistBorn(colonist, event)
	if colonist.traits[TraitId] then
		CheckStory(colonist)
	end
end