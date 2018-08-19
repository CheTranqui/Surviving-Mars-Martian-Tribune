local TraitId = "Youth"
local Key1 = "DroneHack1"
local Key2 = "DroneHack2"
local Key3 = "DroneHack3"

local function CheckStory1()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and CountColonistsWithTrait(TraitId) > 0 then
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local Teenager = GetColonistWithTrait(TraitId)

		if IsValidColonist(Teenager) then
			local TeenagerColonistFallbackName = MartianTribuneMod.Name.TeenagerColonist
			local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
			local Name = Teenager.name or TeenagerColonistFallbackName
			local DomeName = (Teenager.dome and Teenager.dome.name) or T{9013717, "random teenager's dome"}
		
			AddStory({
				key = Key1,
				title = T{9013715, "Teenager Takes Drone for a Joyride"},
				story = T{9013716, "     Last night <MTTeenagerJoyrideName> hacked the code.  Working their way into the mainframe, one would expect havoc throughout the colony this morning, but apparently they had their sights set on something a little more exciting.  <MTTeenagerJoyrideName> simply took over a local drone and went out for a little joyride, eventually to end the ride face-first into the side of <MTTeenagerJoyrideDome>, go figure.  Kids will be kids, I guess.", MTTeenagerJoyrideName = Name, MTTeenagerJoyrideDome = DomeName},
				-- colonist = Teenager
			})
		end
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent

	if not Sent[Key2]
		and Published[Key1]
		and CountColonistsWithTrait(TraitId) > 0
	then
		local MartianTribuneMod = MartianTribuneMod
		local FindStoryInListByKey = MartianTribuneMod.Functions.FindStoryInListByKey
		local SocialArchive = MartianTribune.SocialArchive
		local index, DroneHack1 = FindStoryInListByKey(SocialArchive, Key1)

		if DroneHack1 and UICity.day >= (DroneHack1.publishedDay + 5) then
			local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
			local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
			-- local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
			local TeenagerColonistFallbackName = MartianTribuneMod.Name.TeenagerColonist
			local Teenager = GetColonistWithTrait(TraitId)
			local Name = (Teenager and Teenager.name) or TeenagerColonistFallbackName

			AddStory({
				key = Key2,
				title = T{9013719, "New Sport Established On Mars"},
				story = T{9013720, "     Our Earthling counterparts might have their Ski Jumping, but we here on Mars have our very own Drone Jumping. After hacking a few drones last night, lead by <MTDroneHack2Name>, several teenagers went joy riding in the dunes, eventually finding what has now been dubbed Marathon Hill as the site of Mars' very first Out-Dome sport: Drone Jumping.", MTDroneHack2Name = Name},
				-- colonist = IsValidColonist(Teenager) and Teenager or nil
			})
		end
	end
end

local function CheckStory3()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent
	local UICity = UICity

	if not Sent[Key3]
		and Published[Key2]
		and Published[Key1]
		and UICity.labels.SecurityStation ~= nil
		and UICity.labels.Colonist ~= nil
	then
		local MartianTribuneMod = MartianTribuneMod
		local FindStoryInListByKey = MartianTribuneMod.Functions.FindStoryInListByKey
		local SocialArchive = MartianTribune.SocialArchive
		local index, DroneHack2 = FindStoryInListByKey(SocialArchive, Key2)

		if DroneHack2 and UICity.day >= (DroneHack2.publishedDay + 15) then
			local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
			-- local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
			local Colonist = table.rand(UICity.labels.Colonist)
			local Name = (Colonist and Colonist.name) or T{9013723, "random drone hacker"}

			AddStory({
				key = Key3,
				title = T{9013721, "New Martian Law Enforced"},
				story = T{9013722, "     <MTDroneHack3Name> was brought in to the Security Station last night on charges of Unsanctioned Drone Use.  Under the new Martian Law it is now prohibited to hack into drones for personal use.  To make things worse, <MTDroneHack3Name> is alleged to have been siphoning off Rare Metals for personal gain.  Expect formal charges in the coming days.", MTDroneHack3Name = Name},
				-- colonist = IsValidColonist(Colonist) and Colonist or nil
			})
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
	CheckStory2()
	CheckStory3()
end