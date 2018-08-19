local Key1 = "FightClub1"
local Key2 = "FightClub2"

local function CheckStory1()
	local Sent = MartianTribune.Sent
	if not Sent[Key1] and CountColonistsWithTrait("Renegade") > 0 then
		local MartianTribuneMod = MartianTribuneMod
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local RenegadePerson = GetColonistWithTrait("Renegade")
		local Name = RenegadePerson.name or T{9013577, "random renegade"}

		AddStory({
			key = Key1,
			title = T{9013574, "They're Fighting, Stop Fighting!"},
			story = T{9013575, "     Local outspoken dome inhabitant, <MTRenegade> was caught instigating several fights this weekend.  Rumor has it that he was trying to build interest in a club.  After sobering up overnight, the renegade was quoted as saying, 'What club? There is no club.'", MTRenegade = Name},
			colonist = RenegadePerson
		})
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent

	if Published[Key1] and not Sent[Key2] then
		local SocialArchive = MartianTribune.SocialArchive
		local MartianTribuneMod = MartianTribuneMod
		local FindStoryInListByKey = MartianTribuneMod.Functions.FindStoryInListByKey

		local index, FightClub1 = FindStoryInListByKey(SocialArchive, Key1)
		if FightClub1 and UICity.day > (FightClub1.publishedDay + 9) then
			local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
			AddStory({
				key = Key2,
				title = T{9013578, "Fight Club Story Retraction"},
				story = T{9013579, "     The Martian Tribune would like to apologise for any upset caused in publishing details of the rumored club referenced in the story 'They're fighting, stop fighting'.  In consultation with local security, an attorney on retainer, and an unnamed source, we have come to the conclusion that it would be better were we not to talk about the aforementioned 'club'."}
			})
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
	CheckStory2()
end