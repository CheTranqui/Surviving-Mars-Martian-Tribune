local TechId = "LiveFromMars"
local TraitId = "Celebrity"
local Key1 = "MarsRealityTV"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1]
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
			story = T{9013636, "     The hit martian reality TV show, Planet Mars, has been renewed for a second season. <MTCelebrityName> will be the host for the second season.  <MTSponsor> has offered their full support of the endeavor, while our new director has already declared their disgust with working in the Martian environment declaring 'Dust. It's coarse, and rough, and irritating, and it just gets everywhere. EVERYWHERE!'", MTCelebrityName = Name, MTSponsor = Sponsor},
			colonist = IsValidColonist(Celebrity) and Celebrity or nil
		})
	end
end

function OnMsg.TechResearched(tech_id, city, first_time)
	if tech_id == TechId then
		CheckStory()
	end
end

function OnMsg.MartianTribuneCheckStories()
	if UICity.tech_status[TechId].researched ~= nil then
		CheckStory()
	end
end