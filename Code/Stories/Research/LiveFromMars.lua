local TechId = "LiveFromMars"
local TraitId = "Celebrity"
local Key1 = "MarsRealityTV"
local Key2 = "LiveFromMarsTech1"
local Key3 = "LiveFromMarsTech2"

local function CheckStory1()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent

	if not Sent[Key1]
		and (Published[Key2] or Published[Key3])
		and ColonistsHaveArrived
		and CountColonistsWithTrait(TraitId) > 0
		and UICity.tech_status[TechId].researched ~= nil
	then
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local Sponsor = MartianTribune.Sponsor
		local Celebrity = GetColonistWithTrait(TraitId)
		local Name = Celebrity.name or T{9013637, "random celebrity"}

		AddStory({
			key = Key1,
			title = T{9013635, "Live From Mars Renewed for Season 2"},
			story = T{9013636, "     The hit Martian reality TV show, Planet Mars, has been renewed for a second season. <MTCelebrityName> will be the host for the second season.  <MTSponsor> has offered their full support of the endeavor, while our new director has already declared their disgust with working in the Martian environment declaring \"Dust. It's coarse, and rough, and irritating, and it just gets everywhere. EVERYWHERE!\"", MTCelebrityName = Name, MTSponsor = Sponsor},
			colonist = IsValidColonist(Celebrity) and Celebrity or nil
		})
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key2] and not Sent[Key3] then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local random_num = Random(1,2)

		if random_num == 1 then
			AddStory({
				key = Key2,
				title = T{9013834, "Reality Show from Mars a Huge Hit"},
				story = T{9013835, "     A reality show based on the Mars has been a huge hit on Earth, causing a surge in applicants to come move to the red planet.  The show called \"Mount Olympus\" is made up of two 15 minute segments, both of which consist of a camera staring at the rust colored dust that sometimes rolls down the side of the galaxy's biggest mountain."}
			})
		else
			local Sponsor = MartianTribune.Sponsor
			AddStory({
				key = Key3,
				title = T{9013836, "Martian Tribune Excluded From TV Venture"},
				story = T{9013837, "     <MTSponsor> has recently launched a new venture aimed at bringing more colonists to the red planet, a PR stunt at best.  The Martian Tribune, despite being the red planets only newspaper, was not invited to partake in this show and as such will not report on it.", MTSponsor = Sponsor}
			})
		end
	end
end

function OnMsg.TechResearched(tech_id, city, first_time)
	if tech_id == TechId then
		CheckStory2()
	end
end

function OnMsg.MartianTribuneCheckStories()
	if UICity.tech_status[TechId].researched ~= nil then
		CheckStory2()
		CheckStory1()
	end
end