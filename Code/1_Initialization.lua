-- 1. PRIMARY SAVE GAME DATA STORAGE
GlobalVar("MartianTribune", false)

local function AddStory(story, list)
	local MartianTribune = MartianTribune
	MartianTribune.Sent[story.key] = true
	list[#list + 1] = story
end

local function RemoveStory(key, list)
	local MartianTribune = MartianTribune
	local FindStoryInListByKey = MartianTribuneMod.Functions.FindStoryInListByKey
	local index, story = FindStoryInListByKey(list, key)
	if index then
		table.remove(list, index)
	end
	MartianTribune.Removed[key] = true
end

-- 2. PRIMARY NON-SAVE DATA STORE FOR SHARING COMMON FUNCTIONS, NAMES, MOD_DIR, ETC
-- Note: Using the "name" field in a list means that it is used as a title in any Examine windows in ECM when debugging
MartianTribuneMod = {
	mod_dir = CurrentModPath,
	current_version = Mods["lf1iELO"].version,
	Functions = { name = "Martian Tribune Common Functions" },
	Name = { name = "Common Colonist Fallback Name strings" },
	News = { name = "Shared popup Fake News items" },
	SaveGameFixes = { name = "Save Game Data Migrations" },
	Titles = { name = "Custom Sponsor Leadership Titles" }
}

local MessagesPath = "UI/Messages/"
local TutorialsPath = MessagesPath.."Tutorials/Tutorial"
local EventsPath = MessagesPath.."Events/"
local ModPath = CurrentModPath.."UI/"

-- Note: these are currently in filename order for the file containing each story.
MartianTribuneMod.StoryImages = {
	["ArcologyInuendo"] = ModPath.."Arcology.png",
	["ConcreteLove"] = TutorialsPath.."1/Tutorial1_ConcreteExtractor.tga",
	["DomeCrack"] = ModPath.."CrackedDome.png",
	["WhyDomes"] = MessagesPath.."dome.tga",
	["Domelenol"] = EventsPath.."25_medical_check.tga",
	["University"] = MessagesPath.."martian_university.tga",
	["PewPew"] = MessagesPath.."meteors.tga",
	["PewPewPew"] = MessagesPath.."meteors.tga",
	["MoxieMagic"] = EventsPath.."18_moxie.tga",
	["SoundComplaint"] = TutorialsPath.."5/Tutorial5_Popup3_Mining.tga",
	["MartianMetals"] = MessagesPath.."deposits_2.tga",
	["ShuttleHub"] = TutorialsPath.."5/Tutorial5_Popup2_Shuttles.tga",
	["Connoisseur"] = MessagesPath.."spacebar.tga",
	["Spy"] = TutorialsPath.."4/Tutorial4_ManagingJobs.tga",
	["WatchWhatYouEat"] = MessagesPath.."universal_depot.tga",
	["TunnelGuangzhou"] = MessagesPath.."tunnel.tga",
	["AdultFilm"] = MessagesPath.."colonists.tga",
	["ConcretePaving"] = TutorialsPath.."1/Tutorial1_ConcreteExtractor.tga",
	["DroneHack1"] = MessagesPath.."recharge_station.tga",
	["DroneHack2"] = MessagesPath.."dome.tga",
	["DroneHack3"] = MessagesPath.."drone.tga",
	["DroneHack4"] = MessagesPath.."security_station.tga",
	["DroneRights"] = EventsPath.."11_idiot.tga",
	["DomeDelay1"] = EventsPath.."11_idiot.tga",
	["DomeDelay2"] = EventsPath.."11_idiot.tga",
	["EarthTourism"] = MessagesPath.."beyond_earth_mystery_01.tga",
	["FightClub1"] = EventsPath.."13_renegades.tga",
	["FirstFounderDied"] = TutorialsPath.."4/Tutorial4_Founders.tga",
	["FirstMartianbornDied"] = MessagesPath.."death.tga",
	["FoundersFirstWords"] = TutorialsPath.."4/Tutorial4_Founders.tga",
	["FoundersLegacy"] = MessagesPath.."colonists.tga",
	["GuruGarden"] = MessagesPath.."stone_garden.tga",
	["HappyBirthday"] = EventsPath.."09_fireworks.tga",
	["IdiotFML"] = EventsPath.."11_idiot.tga",
	["LeaderDied1"] = MessagesPath.."death.tga",
	["LeaderDied2"] = MessagesPath.."death.tga",
	["MartianCelebrity"] = MessagesPath.."birth.tga",
	["MartianFashion"] = MessagesPath.."colonists.tga",
	["MovingDomes"] = TutorialsPath.."5/Tutorial5_Popup9_Passages.tga",
	["NewLeader1"] = EventsPath.."02_video_call_2.tga",
	["NewLeader2"] = EventsPath.."09_fireworks.tga",
	["NewLeader3"] = EventsPath.."01_video_call.tga",
	["FounderNewLeader"] = MessagesPath.."colonists.tga",
	["OopsIBrokeItAgain"] = EventsPath.."11_idiot.tga",
	["StarvingColonist"] = TutorialsPath.."4/Tutorial4_Food.tga",
	["Whiner"] = EventsPath.."11_idiot.tga",
	["DroneBreakdown"] = MessagesPath.."drone.tga",
	["DroneGoesViral"] = TutorialsPath.."1/Tutorial1_DronesAndResources.tga",
	["DroneShortage"] = TutorialsPath.."1/Tutorial1_DronesAndDroneHubs.tga",
	["AgingGracefully"] = EventsPath.."19_frozen_landscape.tga",
	["Aurorae"] = MessagesPath.."space.tga",
	["CookingFire"] = EventsPath.."23_red_alert.tga",
	["DomeForbidBirth1"] = MessagesPath.."birth.tga",
	["DomeForbidBirth2"] = MessagesPath.."birth.tga",
	["DustStormWarning"] = MessagesPath.."dust_storm.tga",
	["FutureExpansion"] = EventsPath.."29_shuttle.tga",
	["MarathonExplorer"] = MessagesPath.."exploration.tga",
	["MarsDay"] = EventsPath.."09_fireworks.tga",
	["DeflectingMeteors"] = MessagesPath.."dredgers_mystery_01.tga",
	["Passport"] = EventsPath.."05_mysterious_stranger.tga",
	["Rockets3"] = EventsPath.."27_rocket_launch.tga",
	["Rockets0"] = TutorialsPath.."1/Tutorial1_UnloadRocket.tga",
	["RocketObservation"] = TutorialsPath.."1/Tutorial1_LandRocket.tga",
	["GiantWhaleRocket"] = MessagesPath.."beyond_earth_mystery_01.tga",
	["Vigilante"] = EventsPath.."05_mysterious_stranger.tga",
	["NoHumans"] = MessagesPath.."deposits.tga",
	["WeAreMartian"] = EventsPath.."07_explorer_flag.tga",
	["ExplorationContinues"] = MessagesPath.."exploration_3.tga",
	["SoundOfMars"] = MessagesPath.."debris.tga",
	["MarsName"] = MessagesPath.."outsource.tga",
	["DroneReverse"] = MessagesPath.."drone.tga",
	["DroneToys"] = MessagesPath.."drone.tga",
	["NuclearThreat"] = MessagesPath.."the_last_war_mystery_03.tga",
	["AtlantisFound"] = MessagesPath.."crater.tga",
	["AirSupply1"] = EventsPath.."28_building_construction.tga",
	["AirSupply2"] = EventsPath.."28_building_construction.tga",
	["FoodShortage1"] = MessagesPath.."emergency.tga",
	["FoodShortage2"] = MessagesPath.."emergency.tga",
	["NoFood1"] = MessagesPath.."colonists.tga",
	["NoPowerRave"] = EventsPath.."09_fireworks.tga",
	["PowerSupply1"] = TutorialsPath.."3/Tutorial3_Priority.tga",
	["PowerSupply2"] = TutorialsPath.."3/Tutorial3_Priority.tga",
	["WaterSupply1"] = TutorialsPath.."3/Tutorial3_WaterTower.tga",
	["WaterSupply2"] = TutorialsPath.."3/Tutorial3_WaterTower.tga",
	["DecommissionTech1"] = TutorialsPath.."3/Tutorial3_ClearingBuildings.tga",
	["DecommissionTech2"] = TutorialsPath.."3/Tutorial3_ClearingBuildings.tga",
	["ScratchingTheSurface"] = TutorialsPath.."2/Tutorial2_SensorTower.tga",
	["HackThePlanet"] = TutorialsPath.."2/Tutorial2_SensorTower.tga",
	["EarthMarsInitiativeTech1"] = EventsPath.."03_discussion.tga",
	["EarthMarsInitiativeTech2"] = EventsPath.."03_discussion.tga",
	["HygroscopicVaporatorsTech1"] = EventsPath.."18_moxie.tga",
	["LowGFungiTech1"] = EventsPath.."14_fungal_farm.tga",
	["LowGFungiTech2"] = EventsPath.."14_fungal_farm.tga",
	["LowGHydroTech1"] = EventsPath.."16_polymer_factory.tga",
	["LowGHydroTech2"] = EventsPath.."16_polymer_factory.tga",
	["LowGTurbinesTech1"] = TutorialsPath.."3/Tutorial3_WindTurbine.tga",
	["LowGTurbinesTech2"] = TutorialsPath.."3/Tutorial3_WindTurbine.tga",
	["MagneticMoxieTech1"] = EventsPath.."18_moxie.tga",
	["MagneticMoxieTech2"] = EventsPath.."18_moxie.tga",
	["ProductivityTrainingTech1"] = MessagesPath.."deposits_2.tga",
	["ProductivityTrainingTech2"] = MessagesPath.."deposits_2.tga",
	["SoilAdaptationTech1"] = MessagesPath.."farm.tga",
	["SoilAdaptationTech2"] = MessagesPath.."farm.tga",
	["MartianSoil"] = MessagesPath.."farm.tga",
	["WaterReclamationTech1"] = ModPath.."WaterReclamationSystem.png",
	["WaterReclamationTech2"] = ModPath.."WaterReclamationSystem.png",
}

-- 3. COMMON FUNCTION DEFINITIONS

-- Compare two translatable strings (e.g. story titles)
MartianTribuneMod.Functions.CompareTranslationStrings = function(string1, string2)
	return _InternalTranslate(string1) == _InternalTranslate(string2)
end

-- Add custom title for sponsor
MartianTribuneMod.Functions.AddLeaderTitleForSponsor = function(sponsorName, title)
	MartianTribuneMod.Titles[sponsorName] = title
end

-- Find a story in a list
MartianTribuneMod.Functions.FindStoryInListByKey = function(list, storyKey)
	for i = 1, #list do
		if list[i].key == storyKey then
			return i,list[i]
		end
	end
end

-- Add stories to the urgent/potential/free lists.
MartianTribuneMod.Functions.AddTopUrgentStory = function(story)
	AddStory(story, MartianTribune.TopUrgentStories)
end
MartianTribuneMod.Functions.AddTopPotentialStory = function(story)
	AddStory(story, MartianTribune.TopPotentialStories)
end
MartianTribuneMod.Functions.AddTopFreeStory = function(story)
	AddStory(story, MartianTribune.TopFreeStories)
end
MartianTribuneMod.Functions.AddEngUrgentStory = function(story)
	AddStory(story, MartianTribune.EngUrgentStories)
end
MartianTribuneMod.Functions.AddEngPotentialStory = function(story)
	AddStory(story, MartianTribune.EngPotentialStories)
end
MartianTribuneMod.Functions.AddEngFreeStory = function(story)
	AddStory(story, MartianTribune.EngFreeStories)
end
MartianTribuneMod.Functions.AddSocialUrgentStory = function(story)
	AddStory(story, MartianTribune.SocialUrgentStories)
end
MartianTribuneMod.Functions.AddSocialPotentialStory = function(story)
	AddStory(story, MartianTribune.SocialPotentialStories)
end
MartianTribuneMod.Functions.AddSocialFreeStory = function(story)
	AddStory(story, MartianTribune.SocialFreeStories)
end

-- Remove stories to the potential/free lists.
MartianTribuneMod.Functions.RemoveTopUrgentStory = function(key)
	RemoveStory(key, MartianTribune.TopUrgentStories)
end
MartianTribuneMod.Functions.RemoveTopPotentialStory = function(key)
	RemoveStory(key, MartianTribune.TopPotentialStories)
end
MartianTribuneMod.Functions.RemoveTopFreeStory = function(key)
	RemoveStory(key, MartianTribune.TopFreeStories)
end
MartianTribuneMod.Functions.RemoveEngUrgentStory = function(key)
	RemoveStory(key, MartianTribune.EngUrgentStories)
end
MartianTribuneMod.Functions.RemoveEngPotentialStory = function(key)
	RemoveStory(key, MartianTribune.EngPotentialStories)
end
MartianTribuneMod.Functions.RemoveEngFreeStory = function(key)
	RemoveStory(key, MartianTribune.EngFreeStories)
end
MartianTribuneMod.Functions.RemoveSocialUrgentStory = function(key)
	RemoveStory(key, MartianTribuneMod.SocialUrgentStories)
end
MartianTribuneMod.Functions.RemoveSocialPotentialStory = function(key)
	RemoveStory(key, MartianTribune.SocialPotentialStories)
end
MartianTribuneMod.Functions.RemoveSocialFreeStory = function(key)
	RemoveStory(key, MartianTribune.SocialFreeStories)
end

-- Check if a particular colonist is valid and alive
MartianTribuneMod.Functions.IsValidColonist = function(colonist)
	local isDying = Colonist.IsDying(colonist)
	return not isDying and isDying ~= nil
end

local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

-- Find a random colonist who does not have a specific trait.
MartianTribuneMod.Functions.GetColonistWithoutTrait = function(trait, colonistList)
	local colonists = MapFilter(
		colonistList or UICity.labels.Colonist or empty_table,
		function(colonist)
			return IsValidColonist(colonist) and colonist.traits and not colonist.traits[trait]
		end
	)
	if colonists and #colonists > 0 then
		return table.rand(colonists)
	end
	return nil
end

-- Find a random colonist who does have a specific trait.
MartianTribuneMod.Functions.GetColonistWithTrait = function(trait, colonistList)
	local colonists = MapFilter(
		colonistList or UICity.labels.Colonist or empty_table,
		function(colonist)
			return IsValidColonist(colonist) and colonist.traits and colonist.traits[trait]
		end
	)
	if colonists and #colonists > 0 then
		return table.rand(colonists)
	end
	return nil
end

-- Find a random colonist who does/does not have multiple specific traits.
MartianTribuneMod.Functions.GetColonistMatchingTraits = function(includeTraitList, excludeTraitList, colonistList)
	local colonists = MapFilter(
		colonistList or UICity.labels.Colonist or empty_table,
		function(colonist)
			local matches = IsValidColonist(colonist) and colonist.traits
			for i = 1, #(includeTraitList or empty_table) do
				matches = matches and colonist.traits[includeTraitList[i]]
			end
			for i = 1, #(excludeTraitList or empty_table) do
				matches = matches and not colonist.traits[excludeTraitList[i]]
			end
			return matches
		end
	)
	if colonists and #colonists > 0 then
		return table.rand(colonists)
	end
	return nil
end

-- Find the name of a random drone
MartianTribuneMod.Functions.GetRandomDroneName = function()
	local Drones = MapGet("map", "Drone")
	if Drones and #Drones > 0 then
		return table.rand(Drones).name
	end
	return T{9013810, "Drone #<num>", num=1}
end

-- Find all the populated domes within the given list of domes.
-- If no list is provided, it will use the list of domes in the colony.
MartianTribuneMod.Functions.GetPopulatedDomes = function(domeList)
	-- default to all domes if no list is provided
	return MapFilter(
		domeList or UICity.labels.Dome or empty_table,
		function(dome)
			return dome.labels.Colonist and #dome.labels.Colonist > 0
		end
	)
end

-- Find all the populated domes with no power
MartianTribuneMod.Functions.GetPopulatedDomesWithoutPower = function()
	return MapFilter(
		g_DomesWithNoLifeSupport or empty_table,
		function(dome)
			return IsValid(dome)
				and not dome:HasPower()
				and dome.labels.Colonist
				and #dome.labels.Colonist > 0
		end
	)
end

-- Find all the populated domes with no air
MartianTribuneMod.Functions.GetPopulatedDomesWithoutAir = function()
	return MapFilter(
		g_DomesWithNoLifeSupport or empty_table,
		function(dome)
			return IsValid(dome)
				and not dome:HasAir()
				and dome.labels.Colonist
				and #dome.labels.Colonist > 0
		end
	)
end

-- Find all the populated domes with no water
MartianTribuneMod.Functions.GetPopulatedDomesWithoutWater = function()
	return MapFilter(
		g_DomesWithNoLifeSupport or empty_table,
		function(dome)
			return IsValid(dome)
				and not dome:HasWater()
				and dome.labels.Colonist
				and #dome.labels.Colonist > 0
		end
	)
end

-- Retrieve the list of workers for a specific workplace
MartianTribuneMod.Functions.GetWorkers = function(workplace)
	if IsValid(workplace) then
		local Workers = {}
		for k, shift in pairs(workplace.workers) do
			for s, worker in pairs(shift) do
				if IsValidColonist(worker) then
					Workers[#Workers + 1] = worker
				end
			end
		end
		return Workers
	end
	return nil
end

-- Choose a random worker for a specific workplace
MartianTribuneMod.Functions.GetRandomWorker = function(workplace)
	local Workers = MartianTribuneMod.Functions.GetWorkers(workplace)
	if Workers ~= nil then
		return table.rand(Workers)
	end
	return nil
end

-- Check whether a cold wave is active
MartianTribuneMod.Functions.IsColdWaveActive = function()
	return g_ColdWave ~= false
end

MartianTribuneMod.Functions.IsColdWavePredicted = function()
	return IsOnScreenNotificationShown("ColdWave")
end

-- Add an image for a particular story key (for mods interfacing with MT)
MartianTribuneMod.Functions.RegisterStoryImage = function(storyKey, image)
	if storyKey and image then
		MartianTribuneMod.StoryImages[storyKey] = image
	end
end

-- 4. COMMON COLONIST FALLBACK NAME STRINGS
MartianTribuneMod.Name.SilentLeader = T{9013508, "Silent Leader"}
MartianTribuneMod.Name.IdiotColonist = T{9013763, "idiot colonist"}
MartianTribuneMod.Name.VeganColonist = T{9013811, "random vegan"}
MartianTribuneMod.Name.TeenagerColonist = T{9013718, "random teenager"}
