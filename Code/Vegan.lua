local TraitId = "Vegan"
local Key1 = "Vegan1"
local Key2 = "Vegan2"
local Key3 = "Vegan3"
local Key4 = "Vegan4"

local function CheckStory1()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and CountColonistsWithTrait(TraitId) > 0 then
		local MartianTribuneMod = MartianTribuneMod
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local Colonist = GetColonistWithTrait(TraitId)

		if IsValidColonist(Colonist) then
			local VeganColonistFallbackName = MartianTribuneMod.Name.VeganColonist
			local Name = Colonist.name or VeganColonistFallbackName
			if Colonist.dome.labels.medic ~= nil then
				local Medic = table.rand(Colonist.dome.labels.medic)
				if IsValidColonist(Medic) then
					local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
					local MedicName = Medic.name
				
					AddStory({
						key = Key1,
						title = T{9013702, "Vegan Declares Mars Meat-Free Planet"},
						story = T{9013703, "     <MTVegan1Name> has stepped up to make their presence known today as they've declared Mars to be Vegan Atlantis.  With Earth now lost forever to the carnivores, Mars is as yet unmarred by the carnivorous and <MTVegan1Name> has vowed to do everything in their power to keep it that way.  Doesn't sound good for all the bacon lovers out there as <MTVegan1MedicName> has stepped up to back the proposition as well.  We'll have to wait and see if it sticks.", MTVegan1Name = Name, MTVegan1MedicName = MedicName},
						-- colonist = Colonist
					})
				end
			end
		end
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent

	if not Sent[Key2]
		and Published[Key1]
		and UICity.day >= Published[Key1]
		and CountColonistsWithTrait(TraitId) > 0
	then
		local MartianTribuneMod = MartianTribuneMod
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local VeganColonistFallbackName = MartianTribuneMod.Name.VeganColonist
		-- local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local LeaderTitle = MartianTribune.LeaderTitle
		local Sponsor = MartianTribune.Sponsor
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local Colonist = GetColonistWithTrait(TraitId)
		local Name = (Colonist and Colonist.name) or VeganColonistFallbackName

		AddStory({
			key = Key2,
			title = T{9013704, "Mars Still Meat Free"},
			story = T{9013705, "     <MTVegan2Name>'s ambitions have lead to the creation of a new foundation called the Vegan Martian Coalition. Their proposition of a meat-free Mars seems to be gaining momentum as 10 sol have now passed since the initial proposition and neither cattle nor hog has yet seen import.  Recognizing that opposition has been light, the <MTLeaderTitle> and <MTSponsor> have each agreed to sit down to discuss the issue more in depth.", MTVegan2Name = Name, MTLeaderTitle = LeaderTitle, MTSponsor = Sponsor},
			-- colonist = IsValidColonist(Colonist) and Colonist or nil
		})
	end
end

local function CheckStory3()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent

	if not Sent[Key3]
		and Published[Key2]
		and Published[Key1]
		and UICity.day >= (Published[Key2] + 11)
		and CountColonistsWithTrait(TraitId) > 0
	then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		AddStory({
			key = Key3,
			title = T{9013706, "Vegan Martian Coalition Gains Ground"},
			story = T{9013707, "     The VMC has announced Saturday to be Spudtato Day.  As the faction gains traction, so does their hold on Martian Cuisine, but perhaps this is one we can all get behind.  Let the fries flow!"}
		})
	end
end

local function CheckStory4()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent

	if not Sent[Key4]
		and Published[Key3]
		and Published[Key2]
		and Published[Key1]
		and UICity.day >= (Published[Key3] + 14)
		and CountColonistsWithTrait(TraitId) > 0
	then
		local LeaderTitle = MartianTribune.LeaderTitle
		local LeaderName = MartianTribune.LeaderName
		local Sponsor = MartianTribune.Sponsor
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory

		AddStory({
			key = Key4,
			title = T{9013708, "Vegan Martian Coalition Talks Stalled"},
			story = T{9013709, "     Though the VMC has managed to garner the favor of our <MTLeaderTitle> <MTLeader>, <MTSponsor> has claimed to receive millions of complaints from Earthlings who once desired to travel to Mars.  Applicants have begun to withdraw their applications by the thousands citing only one word on the cancellation form: \"bacon\".  While the backlash might dampen <MTSponsor>'s support, this reporter for one is pleased with the health benefits.  We'll keep you updated as the situation continues to progress.", MTLeaderTitle = LeaderTitle, MTLeader = LeaderName, MTSponsor = Sponsor}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
	CheckStory2()
	CheckStory3()
	CheckStory4()
end