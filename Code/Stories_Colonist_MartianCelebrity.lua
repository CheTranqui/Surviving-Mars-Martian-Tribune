local TraitId = "Celebrity"
local Key1 = "MartianCelebrity"

local function CheckStory(colonist)
	local Sent = MartianTribune.Sent
	local MartianTribuneMod = MartianTribuneMod
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
	
	if not Sent[Key1] and IsValid(colonist) and colonist.traits[TraitId] then
		local AddSocialStory = MartianTribuneMod.Functions.AddSocialFreeStory
		local Name = (colonist and colonist.name) or T{9013682, "martian celebrity"}

		AddSocialStory({
			key = Key1,
			title = T{9013680, "The Answer To Life Is Always 42"},
			story = T{9013681, "     The lucky couple came forward today to announce that after 42 hours of labor, at 24:45 Martian Standard Time, their first child, <MTMartianCelebrityName> was born.  They are said to be only slightly fatigued, but absolutely jubilant upon the sight of the most dazzling, toothless smile imaginable staring back at them. Journalists from earth are already requesting photos of the new citizen.  We have a new celebrity in our midst!", MTMartianCelebrityName = Name},
			colonist = colonist
		})
	end
end

function OnMsg.ColonistBorn(colonist, event)
	-- using event == "born" filters out rebirths, androids & clones
	if colonist.traits[TraitId] and event == "born" then
		CheckStory(colonist)
	end
end