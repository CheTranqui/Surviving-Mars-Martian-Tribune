local Key1 = "PetRock"
local Key2 = "MarsIPanRock"
local IncludedTraits = { "Celebrity", "Martianborn" }
local ExcludedTraits = { "Child" }

local function CheckStory1()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived then
		local MartianTribuneMod = MartianTribuneMod
		local AddSocialStory = MartianTribuneMod.Functions.AddSocialFreeStory
		local Colonist = table.rand(UICity.labels.Colonist)
		local Name = (Colonist and Colonist.name) or T{9013732, "Pet Rock Owner"}

		AddSocialStory({
			key = Key1,
			title = T{9013730, "Struggling Colonist Adopts Pet"},
			story = T{9013731, "     <MTPetRockColonistName>, like most of us, has been struggling to cope with the harsh Martian environment.  On Earth, many of us had pets to help us through the difficult days, but there are no dogs on Mars, so <MTPetRockColonistName> decided to adopt a pet rock instead.  What did they name this newfound source of comfort and snuggles?  Why, Olympus Mons, of course!  Hopefully little Oly can help them through these tough times.", MTPetRockColonistName = Name},
		})
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent

	if Published[Key1]
		and not Sent[Key2]
		and CountColonistsWithTrait(IncludedTraits[1]) > 0
		and CountColonistsWithTrait(IncludedTraits[2]) > 0
	then
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistMatchingTraits = MartianTribuneMod.Functions.GetColonistMatchingTraits
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local Colonist = GetColonistMatchingTraits(IncludedTraits, ExcludedTraits)

		-- Wait until we have a martianborn celebrity and they are no longer a child (Martian Celebrity story).
		if IsValidColonist(Colonist) then
			local AddSocialStory = MartianTribuneMod.Functions.AddSocialPotentialStory
			local Name = Colonist.name or T{9013637, "random celebrity"}

			AddSocialStory({
				key = Key2,
				title = T{9013845, "Martian Social Network Gains Traction"},
				story = T{9013846, "     The Martian social network MarsIpan-Rock has been a huge hit, generating gobs of followers on both Mars and Earth. The site focuses heavily on photos of pet rocks, with the odd Martian showing their face to their pets' followers on occasion. <CelebrityName>, a pet rock enthusiast, has even garnered over 3.6 billion followers in awe of their pet rock Eurasia.  Mars, and its rocks, are clearly at the vanguard of changing the social landscape.", CelebrityName = Name}
			})
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
	CheckStory2()
end
