local Key1 = "DomeDelay1"
local Key2 = "DomeDelay2"

local function CheckStory1()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local DomeBuiltDay = MartianTribune.Count.DomeBuiltDay

	if not Sent[Key1] and ColonistsHaveArrived and UICity.day > 40 and DomeBuiltDay ~= nil then

		if DomeBuiltDay and UICity.day >= (DomeBuiltDay + 10) then
			local MartianTribuneMod = MartianTribuneMod
			local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
			local GetColonistWithoutTrait = MartianTribuneMod.Functions.GetColonistWithoutTrait
			local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
			local Colonist = GetColonistWithoutTrait("Martianborn")
			local Name = (Colonist and Colonist.name) or T{9013714, "random earthling"}
			local LeaderTitle = MartianTribune.LeaderTitle

			AddStory({
				key = Key1,
				title = T{9013710, "Earthling Causes Delay"},
				story = T{9013711, "     If you've been wondering why no new domes have been built of late, look no further than <MTEarthlingDelayName>.  Apparently they're now taking signatures for a petition to halt all mining operations, claiming them to be \"raping and pillaging Mars of its natural resources.\"  The <MTLeaderTitle> has taken note of <MTEarthlingDelayName> and should be releasing a statement later this very sol.", MTEarthlingDelayName = Name, MTLeaderTitle = LeaderTitle},
				colonist_name = Name,
				colonist = IsValidColonist(Colonist) and Colonist or nil
			})
		end
	elseif DomeBuiltDay == nil and MapCount("map", "Dome") > 0 then
		-- Missed the day when the last dome was built. Set it to "today" so that the delay chain can start in a while
		MartianTribune.Count.DomeBuiltDay = UICity.day
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent

	if not Sent[Key2] and Published[Key1] and UICity.day >= (Published[Key1] + 5) then
		local MartianTribuneMod = MartianTribuneMod
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local Sponsor = MartianTribune.Sponsor
		local Name = (IsValidColonist(DomeDelay1Story.colonist) and DomeDelay1Story.colonist.name)
			or DomeDelay1Story.colonist_name
			or T{9013714, "random earthling"}

		AddStory({
			key = Key2,
			title = T{9013712, "Earthling Claims To Be Misunderstood"},
			story = T{9013713, "     As proof that rumors travel faster than light, word of <MTEarthlingDelayName>'s attempt to halt mining operations has already reached <MTSponsor>'s ears on Earth.  While our sponsor yet to make any formal declarations, <MTEarthlingDelayName> has already gone on the record to declare that it was all a giant April Fool's Day joke.  Whether it is or not, it is not April, and this reporter is not amused.", MTEarthlingDelayName = Name, MTSponsor = Sponsor}
		})
	end
end

local domeInit = Dome.GameInit
function Dome.GameInit(...)
	if domeInit then
		domeInit(...)
	end
	MartianTribune.Count.DomeBuiltDay = UICity.day
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
	CheckStory2()
end