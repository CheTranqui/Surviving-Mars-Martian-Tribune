-- script organization is as follows:
-- Section 1 = Global variable declaration/initialization
-- Section 2 = Utility functions designed to be reused for multiple stories
-- Section 3 = functions designed to insert or remove stories to/from the various story tables
-- Section 4 = story table initialization and population
-- Section 5 = the core functioning logic that controls popups
-- Section 6 = OnMsg functions to trigger various events and to change particular variables.  OnMsg.Newday() is the most important one

local MTText = {}
MTText.StringIdBase = 9013487
local MT_mod_dir = CurrentModPath

-- Section 1: Declare the Global Vars that need to be saved/reloaded.
-- Using GlobalVar means that these are automatically written out to the save game, and if starting
-- a new game or loading one that hasn't used this mod they will be initialized to the defaults given
-- in the GlobalVar function parameter.
GlobalVar("g_MTTopPotentialStories", false)
GlobalVar("g_MTTopFreeStories", false)
GlobalVar("g_MTTopArchive", false)
GlobalVar("g_MTEngPotentialStories", false)
GlobalVar("g_MTEngFreeStories", false)
GlobalVar("g_MTEngArchive", false)
GlobalVar("g_MTSocialPotentialStories", false)
GlobalVar("g_MTSocialFreeStories", false)
GlobalVar("g_MTSocialArchive", false)
-- sorted alphabetically so that it is easier to check if a variable already exists.
GlobalVar("MT02Shortage1StorySent", false)
GlobalVar("MT02Shortage2StorySent", false)
GlobalVar("MTAdultFilmStorySent", false)
GlobalVar("MTAirSupply1StorySent", false)
GlobalVar("MTAirSupply2StorySent", false)
GlobalVar("MTArcologyInuendoStorySent", false)
GlobalVar("MTColonistsHaveArrived", false)
GlobalVar("MTColonyApproved", false)
GlobalVar("MTCompactPassengerStorySent", false)
GlobalVar("MTConcreteLoveStorySent", false)
GlobalVar("MTConcretePavingStorySent", false)
GlobalVar("MTConnoisseurStorySent", false)
GlobalVar("MTCurrentAirIssue", 0)
GlobalVar("MTCurrentPowerIssue", 0)
GlobalVar("MTCurrentWaterIssue", 0)
GlobalVar("MTDomeCount", 0)
GlobalVar("MTDomeDelayDays", 0)
GlobalVar("MTDomeDelay1StorySent", false)
GlobalVar("MTDomeDelay2DaysWaiting", 0)
GlobalVar("MTDomeDelay2StoryInitiated", false)
GlobalVar("MTDomeDelay2StorySent", false)
GlobalVar("MTDomelenolStorySent", false)
GlobalVar("MTDroneBreakdownStoryRemoved", false)
GlobalVar("MTDroneBreakdownStorySent", false)
GlobalVar("MTDroneGoesViralStorySent", false)
GlobalVar("MTDroneHack2StoryInitiated", false)
GlobalVar("MTDroneHack2StorySent", false)
GlobalVar("MTDroneHack3StoryInitiated", false)
GlobalVar("MTDroneHack3StorySent", false)
GlobalVar("MTDroneHackDay", 0)
GlobalVar("MTDroneRightsStorySent", false)
GlobalVar("MTDroneShortageStorySent", false)
GlobalVar("MTEarthlingDelayName", false)
GlobalVar("MTElonMuskStorySent", false)
GlobalVar("MTElPresidenteStorySent", false)
GlobalVar("MTEngStory", 0)
GlobalVar("MTEqualityStorySent", false)
GlobalVar("MTFightClubStorySent", false)
GlobalVar("MTFightClub2StorySent", false)
GlobalVar("MTFightClub2Wait", 0)
GlobalVar("MTFinancesStorySent", false)
GlobalVar("MTFirstFounderDiedStorySent", false)
GlobalVar("MTFirstMartianbornDiedStorySent", false)
GlobalVar("MTFoundersCount", 12)
GlobalVar("MTFoundersDeadSol", 0)
GlobalVar("MTFoundersFirstWordsStorySent", false)
GlobalVar("MTFoundersLegacyStorySent", false)
GlobalVar("MTFutureExpansionStorySent", false)
GlobalVar("MTGuruGardenStorySent", false)
GlobalVar("MTHackThePlanetStoryRemoved", false)
GlobalVar("MTHackThePlanetStorySent", false)
GlobalVar("MTHappyBDayStorySent", false)
GlobalVar("MTHippieStorySent", false)
GlobalVar("MTIdiotFMLStorySent", false)
GlobalVar("MTLeaderColonist", false)
GlobalVar("MTLeaderTitle", nil)
GlobalVar("MTMarathonExplorerStorySent", false)
GlobalVar("MTMarsDayStorySent", false)
GlobalVar("MTMarsRealityTVStorySent", false)
GlobalVar("MTMartianCelebrityStorySent", false)
GlobalVar("MTMartianFaithStorySent", false)
GlobalVar("MTMartianMusicStorySent", false)
GlobalVar("MTMartianOlympicsStorySent", false)
GlobalVar("MTMartianOlympicsWait", 0)
GlobalVar("MTMovingDomesStorySent", false)
GlobalVar("MTMoxieMagicStorySent", false)
GlobalVar("MTNewLanguageStorySent", false)
GlobalVar("MTNewLeaderChosenIndex", false)
GlobalVar("MTNewStoryPushed", 0)
GlobalVar("MTNoHumansStoryRemoved", false)
GlobalVar("MTOlympicBidStorySent", false)
GlobalVar("MTOopsIBrokeItAgainStorySent", false)
GlobalVar("MTOvalDomeUnnaturalStorySent", false)
GlobalVar("MTO2Shortage1StorySent", false)
GlobalVar("MTO2Shortage2StorySent", false)
GlobalVar("MTPassportStorySent", false)
GlobalVar("MTPetRockStorySent", false)
GlobalVar("MTPewPewPewStorySent", false)
GlobalVar("MTPewPewStorySent", false)
GlobalVar("MTPewPewWaitingPeriod", 0)
GlobalVar("MTPowerSupply1StorySent", false)
GlobalVar("MTPowerSupply2StorySent", false)
GlobalVar("MTRareMetalsComplaintStorySent", false)
GlobalVar("MTRefuseHitsFanStorySent", false)
GlobalVar("MTReligiousArtifactStorySent", false)
GlobalVar("MTRocketObservationStorySent", false)
GlobalVar("MTrockets0StorySent", false)
GlobalVar("MTrockets3StorySent", false)
GlobalVar("MTScratchingTheSurfaceStoryRemoved", false)
GlobalVar("MTScratchingTheSurfaceStorySent", false)
GlobalVar("MTShuttleHubStorySent", false)
GlobalVar("MTSocialStory", 0)
GlobalVar("MTSoylentGreenStorySent", false)
GlobalVar("MTSpyStorySent", false)
GlobalVar("MTTeenagerJoyrideStorySent", false)
GlobalVar("MTThisIncidentDay", 0)
GlobalVar("MTTopFPStory", 0)
GlobalVar("MTUniversityStorySent", false)
GlobalVar("MTVegan1StoryHasBeenSent", false)
GlobalVar("MTVegan3StorySent", false)
GlobalVar("MTVegan4StorySent", false)
GlobalVar("MTVeganDinerStorySent", false)
GlobalVar("MTVeganPurgatoryDays", 0)
GlobalVar("MTVeganStory2HasBeenSent", false)
GlobalVar("MTVigilanteStorySent", false)
GlobalVar("MTVirtueOverVicesStorySent", false)
GlobalVar("MTWatchWhatYouEatStorySent", false)
GlobalVar("MTWaterShortage1StorySent", false)
GlobalVar("MTWaterShortage2StorySent", false)
GlobalVar("MTWaterSupply1StorySent", false)
GlobalVar("MTWaterSupply2StorySent", false)

-- data not retained when saving that can be regenerated on start up.
local MTMissionSponsor = false

local MTNewTopStory = nil
local MTNewEngStory = nil
local MTNewSocialStory = nil

local MTArchiveIndex = 1
local MTIdiotColonistFallbackName = T{MTText.StringIdBase + 276, "idiot colonist"}
local MTVeganColonistFallbackName = T{MTText.StringIdBase + 324, "random vegan"}
local MTTeenagerColonistFallbackName = T{MTText.StringIdBase + 231, "random teenager"}

local MTNoNews = {
	title = T{MTText.StringIdBase + 277, "No news of interest at this point in time."},
	story = " "
}

local MTTopArchiveDepleted = {
	title = T{MTText.StringIdBase + 278, "<newline>     The Top Story Archives have been depleted."},
	story = " "
}

local MTArchiveDepleted2 = {
	title = " ",
	story = " "
}

local MTEngArchiveDepleted = {
	title = T{MTText.StringIdBase + 279, "<newline>     The Engineering Story Archives have been depleted."},
	story = " "
}

local MTSocialArchiveDepleted = {
	title = T{MTText.StringIdBase + 280, "<newline>     The Social Story Archives have been depleted."},
	story = " "
}

--  In game Sponsor.name possibilities:
--		International Mars Mission = "IMM"
--		USA = "NASA"
--		Blue Sun Corporation = "BlueSun"
--		China = "CSNA"
--		India = "ISRO"
--		Europe = "ESA"
--		SpaceY = "SpaceY"
--		Church of the New Ark = "NewArk"
--		Russia = "Roscosmos"
--		Paradox Interactive = "paradox"
--		Stargate Command = "stargatecommand"
--		Trinova = "Trinova"
local MTSponsors = {
	IMM = T{MTText.StringIdBase + 1, "International Mars Mission"},
	BlueSun = T{MTText.StringIdBase + 2, "Blue Sun Corporation"},
	CSNA = T{MTText.StringIdBase + 3, "China"},
	ISRO = T{MTText.StringIdBase + 4, "India"},
	ESA = T{MTText.StringIdBase + 5, "Europe"},
	SpaceY = T{MTText.StringIdBase + 6, "SpaceY"},
	NewArk = T{MTText.StringIdBase + 7, "Church of the New Ark"},
	Roscosmos = T{MTText.StringIdBase + 8, "Russia"},
	paradox = T{MTText.StringIdBase + 9, "Paradox"},
	stargatecommand = T{MTText.StringIdBase + 10, "Stargate Command"},
	Trinova = T{MTText.StringIdBase + 11, "Trinova"}
}

local MTSponsor = false

-- Section 2: Utility functions designed to be reused for multiple stories

-- Find a random colonist who does not have a specific trait.
local function MTGetColonistWithoutTrait(trait, colonistList)
	local colonists = FilterObjects({
		filter = function(colonist)
			return colonist and colonist.traits and not colonist.traits[trait]
		end},
	colonistList or UICity.labels.Colonist or empty_table)
	if colonists and #colonists > 0 then
		return table.rand(colonists)
	end
	return nil
end

-- Find a random colonist who does have a specific trait.
local function MTGetColonistWithTrait(trait, colonistList)
	local colonists = FilterObjects({
		filter = function(colonist)
			return colonist and colonist.traits and colonist.traits[trait]
		end},
	colonistList or UICity.labels.Colonist or empty_table)
	if colonists and #colonists > 0 then
		return table.rand(colonists)
	end
	return nil
end

-- Find the name of a random drone
local function MTGetRandomDroneName()
	local Drones = GetObjects{class = "Drone"}
	if #Drones > 0 then
		return table.rand(Drones).name
	end
	return T{MTText.StringIdBase + 323, "Drone #<num>", num=1}
end

-- Find all the populated domes within the given list of domes (e.g. "domes without power").
-- If no list is provided, it will use the list of domes in the colony.
local function MTGetPopulatedDomes(domeList)
	-- default to all domes if no list is provided
	return FilterObjects({
		filter = function(dome)
			return dome.labels.Colonist and #dome.labels.Colonist > 0
		end},
	domeList or UICity.labels.Dome or empty_table)
end

-- Retrieve the list of workers for a specific workplace
local function MTGetWorkers(workplace)
	if IsValid(workplace) then
		local MTWorkers = {}
		for k, shift in pairs(workplace.workers) do
			for s, worker in pairs(shift) do
				table.insert(MTWorkers, worker)
			end
		end
		return MTWorkers
	end
	return nil
end

-- Choose a random worker for a specific workplace
local function MTGetRandomWorker(workplace)
	local MTWorkers = MTGetWorkers(workplace)
	if (IsValid(MTWorkers)) then
		return table.rand(MTWorkers)
	end
	return nil
end

-- Initialize the Mission Sponsor details
-- This has to wait until the save game data has loaded so that it uses the Mission Sponsor from the Save.
local function SetupMissionSponsor()
	MTMissionSponsor = GetMissionSponsor()
	MTSponsor = MTSponsors[MTMissionSponsor.name] or T{MTText.StringIdBase + 12, "Mission Sponsor"}
end

-- Generate a "Title" to use for the Colony Leader
local function MTGetLeaderTitle(sponsorname)
	if not MTLeaderTitle then
		local MTtitles = {
			IMM = T{MTText.StringIdBase + 13, "CEO"},
			BlueSun = T{MTText.StringIdBase + 14, "CFO"},
			CSNA = T{MTText.StringIdBase + 15, "President"},
			ISRO = T{MTText.StringIdBase + 16, "Prime Minister"},
			ESA = T{MTText.StringIdBase + 15, "President"},
			SpaceY = T{MTText.StringIdBase + 17, "Chairman"},
			NewArk = T{MTText.StringIdBase + 18, "Oracle"},
			Roscosmos = T{MTText.StringIdBase + 15, "President"},
			paradox = T{MTText.StringIdBase + 14, "CFO"},
			stargatecommand = T{MTText.StringIdBase + 19, "Major General"},
			Trinova = T{MTText.StringIdBase + 20, "COO"}
		}

		if sponsorname == "IMM" or sponsorname == "BlueSun" or sponsorname == "SpaceY" or sponsorname == "paradox" then
			-- if one of the above 4, randomly pick one of the 3 and return that
			local MTBusinessTitleRandom = Random(1,3)  -- randomize these corps to get one of the 3 following leader types
			if MTBusinessTitleRandom == 1 then
				return T{MTText.StringIdBase + 17, "Chairman"}
			elseif MTBusinessTitleRandom == 2 then
				return T{MTText.StringIdBase + 14, "CFO"}
			else
				return T{MTText.StringIdBase + 13, "CEO"}
			end
		elseif MTtitles[sponsorname] == nil then
			return T{MTText.StringIdBase + 15, "President"}  -- if unaccounted for, they get a "President"
		else
			return MTtitles[sponsorname] -- if it wasn't those 4, and wasn't unaccounted for, then return the name provided
		end
	else
		return MTLeaderTitle
	end
end

local function PostprocessTrait(trait_id)
	local trait = TraitPresets[trait_id]
	if not trait then
		print("Did not find trait "..trait_id.." inside TraitPresets")
		return
	end
	trait:AddIncompatible()
	trait._incompatible = string.gsub(trait._incompatible, " ", "")
	local tbl = string.tokenize(trait._incompatible, ",", false, true)
	for _, val in ipairs(tbl) do
		local class = TraitPresets[val]
		class:AddIncompatible()
		assert(class, "Invalid trait:", val)
		rawset(trait.incompatible, val, true)
		rawset(class.incompatible, trait_id, true)
	end
	if trait.rare then 
		g_RareTraits[trait_id] = true
	else
		g_NoneRareTraits[trait_id] = true
	end
	if trait.hidden_on_start then
		g_HiddenTraitsDefault[trait_id] = true
	end
	TraitPresets[trait_id] = trait
end

-- Leadership "trait" so that it can be displayed in the colonist info.
local function MTUpdateLeaderTrait()
	if MTSponsor and not TraitPresets.ColonyLeader then
		local trait = TraitPreset:new()
		trait.name = "ColonyLeader"
		trait.id = trait.name
		trait.display_name = MTLeaderTitle
		trait.description = _InternalTranslate(T{9014489,"<MTSponsor> <MTLeaderTitle>", MTSponsor = MTSponsor, MTLeaderTitle = _InternalTranslate(MTLeaderTitle)})
		trait.category = "other"
		trait.group = trait.category
		trait.weight = 30
		trait.rare = false
		trait.auto = false
		trait.show_in_traits_ui = true
		trait.hidden_on_start = true
		trait.dome_filter_only = true
		trait.incompatible = {}
		TraitPresets.ColonyLeader = trait
		PostprocessTrait(trait.id)
	end
	GuruTraitBlacklist.ColonyLeader = true
end

-- Create a list of rare traits that exist within the colony for use in selecting a leader
local function MTLeaderSetTraitSearch()  -- populates table with rare traits that are present
	if not UICity then
		return empty_table
	end
	
	local MTLeaderTraitTable = {}
	if (CountColonistsWithTrait("Genius") > 0) then  
		table.insert(MTLeaderTraitTable, "Genius")
	end
	if (CountColonistsWithTrait("Celebrity") > 0) then
		table.insert(MTLeaderTraitTable, "Celebrity")
	end
	if (CountColonistsWithTrait("Empath") > 0) then
		table.insert(MTLeaderTraitTable, "Empath")
	end
	if (CountColonistsWithTrait("Guru") > 0) then
		table.insert(MTLeaderTraitTable, "Guru")
	end
	if (CountColonistsWithTrait("Saint") > 0) then
		table.insert(MTLeaderTraitTable, "Saint")
	end
	return MTLeaderTraitTable
end

-- Retrieve the current Leader's name, selecting a new leader from the current list of
-- colonists if one does not exist.
-- Defaults to "Silent Leader" if no colonists exist
local function MTGetLeaderName()
	local MTLeaderName =
		(IsValid(MTLeaderColonist) and MTLeaderColonist.name)
		or T{MTText.StringIdBase + 21, "Silent Leader"}

	if not IsValid(MTLeaderColonist) and MTColonistsHaveArrived then  -- this only happens on New Game when colonists first land, or when current leader dies
		local MTLeaderTraitTable = MTLeaderSetTraitSearch()  -- which rare traits are in the colony?
		if (#MTLeaderTraitTable > 0) then  -- pick a trait to single out
			local MTLeaderTrait = table.rand(MTLeaderTraitTable)
			MTLeaderColonist = MTGetColonistWithTrait(MTLeaderTrait)
		end
		-- failed to find a usable leader with a rare trait
		local colonists = UICity.labels.Colonist or empty_table
		if not IsValid(MTLeaderColonist) and #colonists > 0 then
			-- if none with rare traits,
			MTLeaderColonist = table.rand(colonists) -- random colonist is chosen
		end
		if IsValid(MTLeaderColonist) then
			MTLeaderColonist:AddTrait("ColonyLeader")
			MTLeaderName = MTLeaderColonist.name
		end
	end  -- if we have a leader already chosen and alive, then they stay leader
	return MTLeaderName
end

--  access g_MTTopArchive and extract the archived story
local function MTGetTopArchives(MTArchiveIndexNum)
	local MTTempTopArchive = MTTopArchiveDepleted
	if #g_MTTopArchive > 0 and MTArchiveIndexNum > 0 and MTArchiveIndexNum <= #g_MTTopArchive then
		MTTempTopArchive = g_MTTopArchive[MTArchiveIndexNum]
	end
	return MTTempTopArchive
end

--  access g_MTEngArchive and extract the archived story
local function MTGetEngArchives(MTArchiveIndexNum)
	local MTTempEngArchive = MTEngArchiveDepleted  -- if archive empty, send default message
	if #g_MTEngArchive > 0 and MTArchiveIndexNum > 0 and MTArchiveIndexNum <= #g_MTEngArchive then
		MTTempEngArchive = g_MTEngArchive[MTArchiveIndexNum]  -- else send EngArchive's old story
	end
	return MTTempEngArchive
end

--  access g_MTSocialArchive and extract the archived story
local function MTGetSocialArchives(MTArchiveIndexNum)
	local MTTempSocialArchive = MTSocialArchiveDepleted  -- if archive empty, send default message
	if #g_MTSocialArchive > 0 and MTArchiveIndexNum > 0 and MTArchiveIndexNum <= #g_MTSocialArchive then
		MTTempSocialArchive = g_MTSocialArchive[MTArchiveIndexNum]  -- else send SocArchive's old story
	end
	return MTTempSocialArchive
end

-- request comes from new story day
local function MTSetTopStory()
	-- Assume there will be no news.
	MTNewTopStory = MTNoNews
	-- this retrieves a new story out of the tables of potential and free stories
	if #g_MTTopPotentialStories > 0 then  -- if potential stories are available
		local MTTopStoryRandom = Random(1,#g_MTTopPotentialStories)  -- pick a random number out of the total available
		MTNewTopStory = g_MTTopPotentialStories[MTTopStoryRandom]	-- claim it as current
		table.remove(g_MTTopPotentialStories, MTTopStoryRandom)	-- pull it out of the potential list
		table.insert(g_MTTopArchive, MTNewTopStory)  -- adds it to the Top Story Archives
	elseif #g_MTTopFreeStories > 0 then
		local MTTopStoryRandom = Random(1,#g_MTTopFreeStories) -- if no potential stories are available, pick from the free ones
		MTNewTopStory = g_MTTopFreeStories[MTTopStoryRandom]   -- claim this as the current story
		table.remove(g_MTTopFreeStories, MTTopStoryRandom)   --  pull it from the FreeStories list
		table.insert(g_MTTopArchive, MTNewTopStory)  -- adds it to the Top Story Archives
	end
end

local function MTGetTopStory()
	if MTNewTopStory == nil then
		MTNewTopStory = MTNoNews
	end
	return MTNewTopStory
end

-- request comes from new story day
local function MTSetEngStory()
	-- Assume there will be no news.
	MTNewEngStory = MTNoNews
	-- this retrieves a new story out of the tables of potential and free stories
	if #g_MTEngPotentialStories > 0 then  -- if potential stories are available
		local MTEngStoryRandom = Random(1,#g_MTEngPotentialStories)  -- pick a random number out of the total available
		MTNewEngStory = g_MTEngPotentialStories[MTEngStoryRandom]	-- claim it as current
		table.remove(g_MTEngPotentialStories, MTEngStoryRandom)	-- pull it out of the potential list
		table.insert(g_MTEngArchive, MTNewEngStory)  -- adds it to the Eng Story Archives
	elseif #g_MTEngFreeStories > 0 then
		local MTEngStoryRandom = Random(1,#g_MTEngFreeStories) -- if no potential stories are available, pick from the free ones
		MTNewEngStory = g_MTEngFreeStories[MTEngStoryRandom]   -- claim this as the current story
		table.remove(g_MTEngFreeStories, MTEngStoryRandom)   --  pull it from the FreeStories list
		table.insert(g_MTEngArchive, MTNewEngStory)  -- adds it to the Eng Story Archives
	end
end

local function MTGetEngStory()
	if MTNewEngStory == nil then
		MTNewEngStory = MTNoNews
	end
	return MTNewEngStory
end

-- request comes from new story day
local function MTSetSocialStory()
	-- Assume there will be no news.
	MTNewSocialStory = MTNoNews
	-- this retrieves a new story out of the tables of potential and free stories
	if #g_MTSocialPotentialStories > 0 then  -- if potential stories are available
		local MTSocialStoryRandom = Random(1,#g_MTSocialPotentialStories)  -- pick a random number out of the total available
		MTNewSocialStory = g_MTSocialPotentialStories[MTSocialStoryRandom]	-- claim it as current
		table.remove(g_MTSocialPotentialStories, MTSocialStoryRandom)	-- pull it out of the potential list
		table.insert(g_MTSocialArchive, MTNewSocialStory)  -- adds it to the Social Story Archives
	elseif #g_MTSocialFreeStories > 0 then
		local MTSocialStoryRandom = Random(1,#g_MTSocialFreeStories) -- if no potential stories are available, pick from the free ones
		MTNewSocialStory = g_MTSocialFreeStories[MTSocialStoryRandom]   -- claim this as the current story
		table.remove(g_MTSocialFreeStories, MTSocialStoryRandom)   --  pull it from the FreeStories list
		table.insert(g_MTSocialArchive, MTNewSocialStory)  -- adds it to the Social Story Archives
	end
end

local function MTGetSocialStory()
	if MTNewSocialStory == nil then
		MTNewSocialStory = MTNoNews
	end
	return MTNewSocialStory
end

-- Section 3: functions governing insert/remove of stories into their respective tables
------------- starting with story release functions.
------------- unless otherwise noted, the Story functions are triggered via OnMsg.NewDay()

-- triggered via TechResearched
local function MTLowGHydroStory()
	local MTLowGHydroRandom = Random(1,2)
	if MTLowGHydroRandom == 1 then
		local MTLowGHydro1 = {
			title = T{MTText.StringIdBase + 46, "Fuel of the Future"},
			story = T{MTText.StringIdBase + 47, "     Researchers have recently completed designs for the construction of Martian Fuel Refineries and the Polymer Factories using only drones and parts found on the surface of Mars. This is a huge breakthrough in Martian engineering as before this point all fuel refineries and polymer factories had to be imported as fully built structures from Earth, an expensive and time consuming process that may now be bypassed thanks to their hard work and diligence."}}
		table.insert(g_MTEngPotentialStories, MTLowGHydro1)
	else
		local MTLowGHydro2 = {
			title = T{MTText.StringIdBase + 48, "Drones Imbued With the Secrets of Hydrosynthesis"},
			story = T{MTText.StringIdBase + 49, "     Martian Drones have recently been given the plans for fuel refinery and polymer factory construction, which up until now was a closely guarded secret from <MTSponsor>. This advancement will let us create both fuel and polymers, without any support from Earth, requiring only locally sourced water.", MTSponsor = MTSponsor}
		}
		table.insert(g_MTEngPotentialStories, MTLowGHydro2)
	end
end

-- triggered via TechResearched
local function MTDecomissionStory()
	local MTDecomissionRandom = Random(1,2)
	if MTDecomissionRandom == 1 then
		local MTDecomission1 = {
			title = T{MTText.StringIdBase + 50, "Drones Reminded That Structure Shells Look Silly"},
			story = T{MTText.StringIdBase + 51, "     Drones on Mars Have received a software upgrade that reminds them that leaving the shell of a former structure looks messy, unkept and serves no purpose, thus it is ok for them to remove the shell and make the surface look nice again.  We simply have to say 'please', is all."}
		}
		table.insert(g_MTEngPotentialStories, MTDecomission1)
	else
		local MTDecomission2 = {
			title = T{MTText.StringIdBase + 52, "Decommissioning Buildings Necessary for Colonial Advancement"},
			story = T{MTText.StringIdBase + 53, "     <MTSponsor> has announced that some of the buildings made on Mars may need to not only be salvaged but entirely decommissioned and destroyed in order to pave the way for future construction. Drones have now been updated with the necessary tools to perform this function whenever instructed. Please be purposeful in making such requests.  All requests to decommission Spacebars will automatically be refused.", MTSponsor = MTSponsor}
		}
		table.insert(g_MTEngPotentialStories, MTDecomission2)
	end
end

-- triggered via TechResearched
local function MTFuelCompressionStory()
	MTFuelCompressionRandom = Random(1,2)
	if MTFuelCompressionRandom == 1 then
		local MTFuelCompression1 = {
			title = T{MTText.StringIdBase + 54, "Rockets Now Made More Spacious"},
			story = T{MTText.StringIdBase + 55, "     Scientists have discovered a way to fit up to 10,000kg more junk food and supplies in each rocket sent to Mars. By squeezing the fuel into a smaller tank, they have created more cargo space. 'It's amazing we didn't think of this earlier, just make the fuel tank smaller.  It might pertain to rockets, but it is definitely not rocket science'."}
		}
		table.insert(g_MTEngPotentialStories, MTFuelCompression1)
	else
		local MTFuelCompression2 = {
			title = T{MTText.StringIdBase + 56, "Looser Safety Restrictions Means More Room For Cargo"},
			story = T{MTText.StringIdBase + 57, "     Claiming to employ new, improved Kerbal construction methods, <MTSponsor> has taken the liberty of removing nearly all of the safety features from our Mars-bound rockets, replacing them instead with a healthy supply of MK16 Parachutes.  This one, relatively minor change allows us to fit 10,000kg more cargo in the Ship and should keep colonists safe in their travels regardless.  Hopefully.", MTSponsor = MTSponsor}
		}
		table.insert(g_MTEngPotentialStories, MTFuelCompression2)
	end
end

--triggered via TechResearched
local function MTWaterReclamationStory()
	if UICity.labels.scientist ~= nil then
		local MTScientistPerson = MTGetColonistWithTrait("scientist")
		local MTScientistName =
			(MTScientistPerson and MTScientistPerson.name)
			or T{MTText.StringIdBase + 62, "random scientist"}
		if IsValid(MTScientistPerson) and not MTScientistPerson.is_pinned then
			MTScientistPerson:TogglePin()
		end
		local MTWaterReclamation1 = {
			title = T{MTText.StringIdBase + 58, "Water Recovery Explained"},
			story = T{MTText.StringIdBase + 59, "     We recently sat down for an interview with <MTScientist> where we learned what lead to the new Water Reclamation technology: 'Well basically, we realised that the dome is very similar in design to a water purifier on Earth, except that it's missing the cup in the middle to collect all the water. That's what this new spire will do. It will collect the condensation from the dome's interior and convert it back into consumable water for the inhabitants, effectively cutting our water usage in half.'", MTScientist = MTScientistName}
		}
		table.insert(g_MTEngPotentialStories, MTWaterReclamation1)
	else
		local MTWaterReclamation2 = {
			title = T{MTText.StringIdBase + 60, "New Spire Does NOT Contain Swimming Pool"},
			story = T{MTText.StringIdBase + 61, "     Despite many requests, and the far reaching rumors about Project Whirlpool. It has been revealed that the recent spire design will not contain a swimming pool, but is instead a system for reclaiming water inside a dome and preparing it for re-use. Personally, while there is clear value in the end result, I think a pool would be far more fun."}
		}
		table.insert(g_MTEngPotentialStories, MTWaterReclamation2)
	end
end

-- triggered via TechResearched
local function MTHygroscopicVaporatorsStory()
	local MTHygroscopic1 = {
		title = T{MTText.StringIdBase + 63, "Painting Water Vaporators"},
		story = T{MTText.StringIdBase + 64, "     Scientists have recently discovered that painting water vaporators with Hygroscopic Paint actually has the effect of increasing water output.  In celebration, the Martian Tribune would like to announce the First Annual Vaporator Graffiti Contest!  Grab your paint brushes and let's see those designs!  The top five entries, voted on by you, our faithful readers, will become the new designs for all future vaporators!"}
	}
	table.insert(g_MTEngPotentialStories, MTHygroscopic1)
end

-- triggered via ColonistBorn
local function MTFutureExpansionStory()
	if not MTFutureExpansionStorySent and #(UICity.labels.Colonist or empty_table) > 600 then
		local MTFutureExpansion = {
			title = T{MTText.StringIdBase + 65, "Successful Martian Colony Brings Hope"},
			story = T{MTText.StringIdBase + 66, "     Our beautiful Martian colony, that started many sol ago has brought hope to humanity, inspiring her to look beyond, unto other planets, with a desire to colonise other rocks within the Milky Way. Most of the impetus at the moment are for colonisation of the moon, Europa, Venus and Jupiter.  Russia has stated that it would consider trying to colonise Pluto, though this was before realising Russia is already bigger than the icy dwarf planet."}
		}
		table.insert(g_MTTopPotentialStories, MTFutureExpansion)
		MTFutureExpansionStorySent = true
	end
end

-- triggered via ColonistArrived
local function MTElonMuskStory()
	if not MTElonMuskStorySent then
		local MTElonMusk = {
			title = T{MTText.StringIdBase + 67, "It's a bird!  It's a plane! It's..."},
			story = T{MTText.StringIdBase + 68, "     Nope, it's a 2018 Tesla Roadster.  The car was originally hurled into space by the eccentric billionaire Elon Musk through his now famous spacefaring organization, Space X.  The Roadster is just now passing Mars in an eliptical orbit before continuing on its course back toward low Earth orbit.  Without this groundbreaking Roadster, we may not be where we are today.  Be sure to look up and thank the cars that we made it here safely!"}
		}
		table.insert(g_MTTopFreeStories, MTElonMusk)
		MTElonMuskStorySent = true
	end
end

-- triggered via TechResearched
local function MTMagneticStory()
	local MTMagneticRandom = Random(1,2)
	if MTMagneticRandom == 1 then
		local MTMagnetic1 = {
			title = T{MTText.StringIdBase + 69, "But How Do They Work?"},
			story = T{MTText.StringIdBase + 70, "     Our Martian Moxies will now be able to put magnets into their filtration chambers in order to create more oxygen. We don't fully understand how, and when a scientist explained it to us, we fell asleep about 45 minutes in. Nonetheless, they assure us that it works as intended, but that we may need to take some iron supplements to enhance the effects to desired levels."}
		}
		table.insert(g_MTEngPotentialStories, MTMagnetic1)
	else
		local MTMagnetic2 = {
			title = T{MTText.StringIdBase + 71, "Moxie Magnets Make Magic"},
			story = T{MTText.StringIdBase + 72, "     Scientists Have developed a novel magnetic attachment for the Moxie. The attachment filters out far more of the tiny metals floating in the Martian atmosphere than previously thought possible.  This new filtration technique allows the Moxie to more effectively create that life saving oxygen that we so desperately need."}
		}
		table.insert(g_MTEngPotentialStories, MTMagnetic2)
	end
end

-- triggered via TechResearched
local function MTLowGFungiStory()
	local MTLowGFungiRandom = Random(1,2)
	if MTLowGFungiRandom == 1 then
		local MTLowGFungi1 = {
			title = T{MTText.StringIdBase + 73, "People With Mushroom Allergies Beware"},
			story = T{MTText.StringIdBase + 74, "     We have recently discovered the secret to growing mushrooms on Mars. It wasn't really too complicated as Mushrooms can grow just about anywhere, but now we can farm them. If you have a mushroom allergy, we recommend taking one of the next shuttles to Earth, as a new Martian staple has been added to the menu."}
		}
		table.insert(g_MTEngPotentialStories, MTLowGFungi1)
	else
		local MTLowGFungi2 = {
			title = T{MTText.StringIdBase + 75, "Mushrooms on Mars"},
			story = T{MTText.StringIdBase + 76, "     Researchers have designed a new building that can be placed outside of a dome. It will be its own self-contained farm and will grow a specialized Martian Mushroom. It should be noted these specialized mushrooms are illegal on Earth, and should never be brought back when traveling back to the blue planet."}
		}
		table.insert(g_MTEngPotentialStories, MTLowGFungi2)
	end
end

-- triggered via TechResearched
local function MTSoilAdaptationStory()
	local MTSoilRandom = Random(1,2)
	if MTSoilRandom == 1 then
		local MTSoil1 = {
			title = T{MTText.StringIdBase + 77, "Adding Waste To The Dust Makes Soil"},
			story = T{MTText.StringIdBase + 78, "     Scientists have discovered that adding human waste to a water and dust mixture can create a viable soil for arable farming.  Botanists have immediately begun working with dome architects to create designs for the first Martian Farms that do not require electricity and might reduce our reliance on hydroponics."}
		}
		table.insert(g_MTEngPotentialStories, MTSoil1)
	else
		local MTSoil2 = {
			title = T{MTText.StringIdBase + 79, "Botanists Rejoice As Farming Becomes Viable"},
			story = T{MTText.StringIdBase + 80, "     It was once thought that the only possible way to make food on Mars would be with a significant number of hydroponic farms, but after many sol of rigorous research, it has been found that we can indeed make normal flat Farms inside our domes. Numerous botonists have betrayed their irrational fear of heights and urged the use of these new farms as soon as possible."}
		}
		table.insert(g_MTEngPotentialStories, MTSoil2)
	end
end

-- triggered via OlympicBid (START) or NewDay (ADD)
local function MTMartianOlympicsStory()
	if not MTMartianOlympicsStorySent and MTMartianOlympicsWait > 0 then
		local MTNewMartianOlympicsWait = MTMartianOlympicsWait + 1
		MTMartianOlympicsWait = MTNewMartianOlympicsWait
		if MTMartianOlympicsWait > 16 then
			local MTMartianOlympics = {
				title = T{MTText.StringIdBase + 81, "The Martian Games"},
				story = T{MTText.StringIdBase + 82, "     Following The Failed bid to host the olympics on Mars, <MTLeader> has decided to create our own games, incorporating Blackjack and Hoopers, among others. Games of Hoopers will start things off this coming Saturday in the open air gym. Also considered for the Martian Games are Dome Skiing, where contestants race down the outside of a dome on pallets, and Drone Jumping.", MTLeader = MTGetLeaderName()}
			}
			table.insert(g_MTTopPotentialStories, MTMartianOlympics)
			MTMartianOlympicsStorySent = true
		end
	end
end

local function MTMarsDayStory()
	if not MTMarsDayStorySent then
		if UICity.day > 100 then
			local MTMarsDay = {
				title = T{MTText.StringIdBase + 83, "Mars Day"},
				story = T{MTText.StringIdBase + 84, "     Today we celebrate Mars Day, a day of merriment and joy, to celebrate Humanity shooting for the stars, and finding a home away from home. We are Martians, and we are proud. Join with your friends and family in a great meal, come to the space bar for a drink, but most importantly: go to work and celebrate with your colleagues as well."}
			}
			table.insert(g_MTSocialFreeStories, MTMarsDay)
			MTMarsDayStorySent = true
		end
	end
end

local function MTFoundersFirstWordsStory()
	local UICity = UICity
	if not MTFoundersFirstWordsStorySent and CountColonistsWithTrait("Founder") > 0 then
		local MTFounderColonist = MTGetColonistWithTrait("Founder")
		local MTFounderName = MTFounderColonist.name or T{MTText.StringIdBase + 89, "random founder"}
		if IsValid(MTFounderColonist) and not MTFounderColonist.is_pinned then
			MTFounderColonist:TogglePin()
		end
		local MTFoundersFirstWords = {
			title = T{MTText.StringIdBase + 85, "First Words Spoken On Mars"},
			story = T{MTText.StringIdBase + 86, "     'Our journey began with one small step and one giant leap. Today, we take another of each, and begin to find our stride'. Powerful words from <MTFounderName> as Humanity expands for the first time to another planet.", MTFounderName = MTFounderName}
		}
		table.insert(g_MTTopPotentialStories, MTFoundersFirstWords)
		MTFoundersFirstWordsStorySent = true
	end
end

local function MTFightClubStory()
	if not MTFightClubStorySent then
		if CountColonistsWithTrait("Renegade") > 0 then
			local MTRenegadePerson = MTGetColonistWithTrait("Renegade")
			local MTRenegade = MTRenegadePerson.name or T{MTText.StringIdBase + 90, "random renegade"}
			if IsValid(MTRenegadePerson) and not MTRenegadePerson.is_pinned then
				MTRenegadePerson:TogglePin()
			end
			local MTFightClub = {
				title = T{MTText.StringIdBase + 87, "They're Fighting, Stop Fighting!"},
				story = T{MTText.StringIdBase + 88, "     Local outspoken dome inhabitant, <MTRenegade> was caught instigating several fights this weekend.  Rumor has it that he was trying to build interest in a club.  After sobering up overnight, the renegade was quoted as saying, 'What club? There is no club.'", MTRenegade = MTRenegade}
			}
			table.insert(g_MTSocialPotentialStories, MTFightClub)
			MTFightClubStorySent = true
			MTFightClub2Wait = 1
		end
	end
end

local function MTFightClub2()
	if not MTFightClub2StorySent and MTFightClub2Wait > 0 then
		local MTNewFightClub2Wait = MTFightClub2Wait + 1
		MTFightClub2Wait = MTNewFightClub2Wait
		if MTFightClub2Wait > 9 then
			local MTFightClub2 = {
				title = T{MTText.StringIdBase + 91, "Fight Club Story Retraction"},
				story = T{MTText.StringIdBase + 92, "     The Martian Tribune would like to apologise for any upset caused in publishing details of the rumored club referenced in the story 'They're fighting, stop fighting'.  In consultation with local security, an attorney on retainer, and an unnamed source, we have come to the conclusion that it would be better were we not to talk about the aforementioned 'club'."}
			}
			table.insert(g_MTSocialPotentialStories, MTFightClub2)
			MTFightClub2StorySent = true
		end
	end
end

local function MTMartianFaithStory()
	if not MTMartianFaithStorySent then
		if UICity.day > 140 then
			local MTMartianFaith = {
				title = T{MTText.StringIdBase + 93, "The Faith of Mars"},
				story = T{MTText.StringIdBase + 94, "     Religion has become a very important part of Martian life, ever since our first founders, who melded together all forms of Christiandom, Islam and Judaism into a single super faith. Today, there are a wide variety of religions on Mars: The True Humanity Society, who follow the teachings of Earth and worship her children, The Jedi, who follow the teachings of a galaxy far far away, The aforementioned Tri-Faith, which follows the teachings of each of the above Earthling faiths, and of course, our very own Red Church of Mars, which needs no explanation."}
			}
			table.insert(g_MTSocialPotentialStories, MTMartianFaith)
			MTMartianFaithStorySent = true
		end
	end
end

local function MTGetGuruGarden(colonist)
	return IsValid(colonist) and colonist.dome and (
		colonist.dome.labels.GardenNatural_Medium ~= nil or colonist.dome.labels.GardenNatural_Small ~= nil
	)
end

local function MTGuruGardenStory()
	if not MTGuruGardenStorySent then
		if CountColonistsWithTrait("Guru") > 0 then
			local MTGuruColonist = MTGetColonistWithTrait("Guru")
			if MTGetGuruGarden(MTGuruColonist) then
				if not MTGuruColonist.is_pinned then
					MTGuruColonist:TogglePin()
				end
				local MTGuruName = MTGuruColonist.name or T{MTText.StringIdBase + 97, "random guru"}
				local MTGuruGarden = {
					title = T{MTText.StringIdBase + 95, "Guru In The Garden"},
					story = T{MTText.StringIdBase + 96, "     Martian Guru <MTGuru> has informed the Martian Tribune that they will be holding frequent meditation and contemplation sesions in the dome's garden. 'The garden is the natural spot for gurus like me, it lets me reach a more intense inner core, and connect more deeply with others and with nature.'", MTGuru = MTGuruName}
				}
				table.insert(g_MTTopPotentialStories, MTGuruGarden)
				MTGuruGardenStorySent = true
			end
		end
	end
end

local function MTElPresidenteStory()
	if not MTElPresidenteStorySent and IsValid(MTLeaderColonist) then
		local MTElPresidente = {
			title = T{MTText.StringIdBase + 98, "El Presidente to Visit Mars"},
			story = T{MTText.StringIdBase + 99, "     The self-proclaimed El Presidente of Cayo de Fortuna has decided on an official visit to Mars.  He comes with hopes of meeting with <MTLeaderTitle> <MTLeader> and brokering a potential trade deal.", MTLeaderTitle = MTLeaderTitle, MTLeader = MTGetLeaderName()}
		}
		table.insert(g_MTTopFreeStories, MTElPresidente)
		MTElPresidenteStorySent = true
	end
end

local function MTMarathonExplorerStory()
	if not MTMarathonExplorerStorySent and UICity.day > 35 and UICity.labels.ExplorerRover ~= nil then
		local MTMarathonExplorer = {
			title = T{MTText.StringIdBase + 100, "A Martian Marathon"},
			story = T{MTText.StringIdBase + 101, "     Mars' first RC Explorer has now traversed a whopping 42.2 Kilometers, or 26.2 miles, completing its own personal marathon on Mars. We at the Martian Tribune support this great explorer in its marathon effort. May the discoveries continue to pour in as a result of such diligence and dedication."}
		}
		table.insert(g_MTTopPotentialStories, MTMarathonExplorer)
		MTMarathonExplorerStorySent = true
	end
end

-- comes from ColonistsArrived
local function RemoveMTDroneBreakdownStory()
	if not MTDroneBreakdownStoryRemoved and MTDroneBreakdownStorySent then
		for k, v in pairs(g_MTTopPotentialStories) do
			if v.key == "DroneBreakdown" then
				table.remove(g_MTTopPotentialStories, k)
				break
			end
		end
	end
	MTDroneBreakdownStoryRemoved = true
end

-- comes from NewDay
local function MTDroneBreakdownStory()
	if not MTDroneBreakdownStorySent and not MTDroneBreakdownStoryRemoved and CountObjects{class = "Drone"} > 2 then
		local MTDrone1 = MTGetRandomDroneName()
		local MTDrone2 = MTGetRandomDroneName()
		-- make sure they are not the same drone
		while MTDrone2 == MTDrone1 do
			MTDrone2 = MTGetRandomDroneName()
		end
		local MTDroneBreakdown = {
			key = "DroneBreakdown",
			title = T{MTText.StringIdBase + 102, "<MTDrone1> Breakdown", MTDrone1 = MTDrone1},
			story = T{MTText.StringIdBase + 103, "     <MTDrone1> suffered a minor fault to its front left wheel yesterday causing the drone to be unable to complete tasks for the sol. The lucky drone had friends, however, namely <MTDrone2> who noticed <MTDrone1> struggling and helped to repair their wheel before sol's end.", MTDrone1 = MTDrone1, MTDrone2 = MTDrone2}
		}
		table.insert(g_MTTopPotentialStories, MTDroneBreakdown)
		MTDroneBreakdownStorySent = true
	end
end

local function MTCompactPassengerStory()
	if not MTCompactPassengerStorySent and UICity.tech_status["CompactPassengerModule"].researched ~= nil then
		local MTCompactPassenger = {
			title = T{MTText.StringIdBase + 104, "Shuttle Capacity Doubled"},
			story = T{MTText.StringIdBase + 105, "     Researchers have discovered that it is possible to add up to ten more seats to our passenger shuttles, allowing up to 22 new colonists to come to Mars at once! This new discovery was made when a researcher knocked his chair over, causing him to realise that there is no up or down in space, so we could simply add more seats to the 'ceiling' of the previous design."}
		}
		table.insert(g_MTEngPotentialStories, MTCompactPassenger)
		MTCompactPassengerStorySent = true
	end
end

local function MTDroneShortageStory()
	local Drones = CountObjects{class = "Drone"}
	local Domes = CountObjects{class = "Dome"}
	if not MTDroneShortageStorySent and MTColonistsHaveArrived and Domes > 0 then
		local MTDroneRatio = Drones / Domes
		if MTDroneRatio < 12 then
			local MTDroneShortage = {
				title = T{MTText.StringIdBase + 106, "A Clinic on Inefficiency"},
				story = T{MTText.StringIdBase + 107, "     Attending a clinic is often a place to learn, unless you're <MTLeaderTitle> <MTLeader>.  Apparently it's expected that resources will move themselves and planning is just plain overrated.  <MTLeaderTitle>, we need more drones and we need them yesterday!  I only hope that everyone receives their food and other essential supplies in time.", MTLeaderTitle = MTLeaderTitle, MTLeader = MTGetLeaderName()}
			}
			table.insert(g_MTEngPotentialStories, MTDroneShortage)
			MTDroneShortageStorySent = true
		end
	end
end

local function MTPowerSupplyStory()
	local UICity = UICity
	-- if after Sol 20 and 14 days+ have passed since last story
	if UICity.day > 20 and UICity.day - MTCurrentPowerIssue >= 14 then
		local MTCurrentPowerBalance = ResourceOverviewObj.data.total_power_demand - ResourceOverviewObj.data.total_power_production
		if MTCurrentPowerBalance > 0 then	-- if production is lower than demand
			local MTCurrentPowerHoursRemaining = ResourceOverviewObj.data.total_power_storage / MTCurrentPowerBalance  -- and stored resources run out within 12 hours
			if MTCurrentPowerHoursRemaining < 12 then
				MTCurrentPowerIssue = UICity.day
				local MTPowerSupply1 = {
					title = T{MTText.StringIdBase + 108, "Word of the Day:  Power Conservation"},
					story = T{MTText.StringIdBase + 109, "     Leadership has declared it a non-issue, but the flickering lights are not your imagination: our power infrastructure is failing us and no longer meets the burgeoning demands of our colony.  Please remember to turn off all lights and electronics when not in use.  Your neighbors will thank you for it."}
				}
				local MTPowerSupply2 = {
					title = T{MTText.StringIdBase + 110, "Power Grid Depleted"},
					story = T{MTText.StringIdBase + 111, "     If it feels a little colder in your dome today than yesterday, that may be because our power grid is maxed and the <MTLeaderTitle> seems to be doing nothing about it.  Dress warmly, this isn't the first day the power's gone out and it likely won't be the last.", MTLeaderTitle = MTLeaderTitle}
				}
				local MTPowerSupplyRandom = Random(1,2)
				if MTPowerSupplyRandom == 1 then		-- send this story, else send the other
					if not MTPowerSupply1StorySent then
						table.insert(g_MTEngPotentialStories, MTPowerSupply1)
						MTPowerSupply1StorySent = true
					else
						table.insert(g_MTEngPotentialStories, MTPowerSupply2)
						MTPowerSupply2StorySent = true
					end
				elseif MTPowerSupplyRandom == 2 then
					if not MTPowerSupply2StorySent then
						table.insert(g_MTEngPotentialStories, MTPowerSupply2)
						MTPowerSupply2StorySent = true
					else
						table.insert(g_MTEngPotentialStories, MTPowerSupply1)
						MTPowerSupply1StorySent = true
					end
				end
			end
		end
	end
end

local function MTWaterSupplyStory()
	local UICity = UICity
	-- if after Sol 20 and 14 days+ have passed since last story
	if UICity.day > 20 and UICity.day - MTCurrentWaterIssue >= 14 then
		local MTCurrentWaterBalance = ResourceOverviewObj.data.total_water_demand - ResourceOverviewObj.data.total_water_production
		if MTCurrentWaterBalance > 0 then	-- if production is lower than demand
			local MTCurrentWaterHoursRemaining = ResourceOverviewObj.data.total_water_storage / MTCurrentWaterBalance  -- and stored resources run out within 12 hours
			if MTCurrentWaterHoursRemaining < 12 then
				MTCurrentWaterIssue = UICity.day
				local MTWaterSupply1 = {
					title = T{MTText.StringIdBase + 112, "Water Shortage Rumors Abound"},
					story = T{MTText.StringIdBase + 113, "     Water is on short supply these days.  <MTLeaderTitle> <MTLeader> has declared the shortage to be an outright lie, but rumors abound that plans are in the works to boost output in these coming sol.", MTLeaderTitle = MTLeaderTitle, MTLeader = MTGetLeaderName()}
				}
				local MTWaterSupply2 = {
					title = T{MTText.StringIdBase + 114, "Let It Mellow"},
					story = T{MTText.StringIdBase + 115, "     Conservation is the name of the game in our domes today as we find ourselves short on water production and storage.  In the coming days, we urge you to adopt a new philosophy if you haven't already: 'if it's yellow let it mellow, if it's brown flush it down.'  Hopefully this is a temporary situation.  We will advise you when the situation has improved."}
				}
				local MTWaterSupplyRandom = Random(1,2)
				if MTWaterSupplyRandom == 1 then		-- send this story, else send the other
					if not MTWaterSupply1StorySent then
						table.insert(g_MTEngPotentialStories, MTWaterSupply1)
						MTWaterSupply1StorySent = true
					else
						table.insert(g_MTEngPotentialStories, MTWaterSupply2)
						MTWaterSupply2StorySent = true
					end
				elseif MTWaterSupplyRandom == 2 then
					if not MTWaterSupply2StorySent then
						table.insert(g_MTEngPotentialStories, MTWaterSupply2)
						MTWaterSupply2StorySent = true
					else
						table.insert(g_MTEngPotentialStories, MTWaterSupply1)
						MTWaterSupply1StorySent = true
					end
				end
			end
		end
	end
end

local function MTAirSupplyStory()
	local UICity = UICity
	-- if after Sol 20 and 14 days+ have passed since last story
	if UICity.day > 20 and UICity.day - MTCurrentAirIssue >= 14 then
		local MTCurrentAirBalance = ResourceOverviewObj.data.total_air_demand - ResourceOverviewObj.data.total_air_production
		if MTCurrentAirBalance > 0 then
			local MTCurrentAirHoursRemaining = ResourceOverviewObj.data.total_air_storage / MTCurrentAirBalance
			if MTCurrentAirHoursRemaining < 12 then
				MTCurrentAirIssue = UICity.day
				local MTAirSupply1 = {
					title = T{MTText.StringIdBase + 116, "Oxygen Short: Time To Lay Low"},
					story = T{MTText.StringIdBase + 117, "     Oxygen production is a bit under current demand for the time being.  It's best to lie low for a few days!  Save that exercise until details have been sorted, more Moxies constructed, and for the drones to complete any necessary maintenance."}
				}
				local MTAirSupply2 = {
					title = T{MTText.StringIdBase + 118, "Oxygen Production Goals Unmet"},
					story = T{MTText.StringIdBase + 119, "     If you find yourself with chest pains in these next few days, it might be better to consult with your local engineer than your local doctor!  Our current oxygen production is just short of demand.  Expect the atmosphere to be a bit thin in the coming days and prepare for the worst."}
				}
				local MTAirSupplyRandom = Random(1,2)
				if MTAirSupplyRandom == 1 then
					if not MTAirSupply1StorySent then
						table.insert(g_MTEngPotentialStories, MTAirSupply1)
						MTAirSupply1StorySent = true
					else
						table.insert(g_MTEngPotentialStories, MTAirSupply2)
						MTAirSupply2StorySent = true
					end
				elseif MTAirSupplyRandom == 2 then
					if not MTAirSupply2StorySent then
						table.insert(g_MTEngPotentialStories, MTAirSupply2)
						MTAirSupply2StorySent = true
					else
						table.insert(g_MTEngPotentialStories, MTAirSupply1)
						MTAirSupply1StorySent = true
					end
				end
			end
		end
	end
end

-- triggered by ConstructionComplete
local function MTArcologyInuendoStory()
	local MTArcologies = UICity.labels.Arcology
	if not MTArcologyInuendoStorySent and MTArcologies ~= nil then
		local MTArcology = table.rand(MTArcologies)
		local MTArcologyDomeName =
			(IsValid(MTArcology) and MTArcology.parent_dome.name)
			or T{MTText.StringIdBase + 122, "arcology dome"}
		local MTArcologyInuendo = {
			title = T{MTText.StringIdBase + 120, "First Dome-Penetrating Structure Erected"},
			story = T{MTText.StringIdBase + 121, "     The Arcology erected in <MTArcologyDomeName> has been praised as an exquisite example of engineering, poking through the rounded dome, to a firm stance with a rounded bottom. As ever, the typical architectural tropes remain well intact, as one of the arcology residents put it, 'How are we not doing phrasing anymore?  Seriously, the entire building is one giant inuendo!'", MTArcologyDomeName = MTArcologyDomeName}
		}
		table.insert(g_MTEngPotentialStories, MTArcologyInuendo)
		MTArcologyInuendoStorySent = true
	end
end

-- triggered by ConstructionComplete
local function MTMoxieMagicStory()
	if not MTMoxieMagicStorySent then
		local MTMoxieMagic = {
			title = T{MTText.StringIdBase + 123, "Moxie: Martian Magic"},
			story = T{MTText.StringIdBase + 124, "     This morning marks a milestone in the Martian memoirs. Moxie, the magic Martian machine makes mini mistrals, managing to maximise 02 from the mainly CO2 medium of Mars. Magnificent."}
		}
		table.insert(g_MTEngPotentialStories, MTMoxieMagic)
		MTMoxieMagicStorySent = true
	end
end
		
-- triggered by NewDay
local function MTDroneGoesViralStory()
	if not MTDroneGoesViralStorySent and CountObjects{class = "Drone"} > 2 then
		local MTDrone1 = MTGetRandomDroneName()
		local MTDrone2 = MTGetRandomDroneName()
		-- make sure that they are not the same drone
		while MTDrone2 == MTDrone1 do
			MTDrone2 = MTGetRandomDroneName()
		end
		local MTDroneGoesViral = {
			title = T{MTText.StringIdBase + 125, "Video of Martian Drone Goes Viral"},
			story = T{MTText.StringIdBase + 126, "     An adorable video of <MTDrone1> picking up some metal has gone viral on Earth, resulting in many copycat videos being created. <MTDrone2>, a relative of <MTDrone1>, who reportedly took the video has said (after translation from binary) 'I do not understand why it has gone viral, <MTDrone1> was only doing their job', in response, an earthling video production expert stated 'I know it's just doing its job, but it's SOO cute!'", MTDrone1 = MTDrone1, MTDrone2 = MTDrone2}
		}
		table.insert(g_MTEngFreeStories, MTDroneGoesViral)
		MTDroneGoesViralStorySent = true
	end
end

-- triggered by NewDay
local function MTConcreteLoveStory()
	if not MTConcreteLoveStorySent and CountObjects{class = "RegolithExtractor"} > 1 then
		local MTConcreteLove = {
			title = T{MTText.StringIdBase + 127, "Concrete Extractor Loves Its Job"},
			story = T{MTText.StringIdBase + 128, "     Concrete Extractor #2 has been observed to really love its job extracting concrete for the embetterment of humanity, always putting in 100% exactly. Unlike the other extractors, Concrete Extractor #2 is programmed specifically to remember every piece of concrete it extracts, and it's programmer claims that it even develops an emotional connection with the concrete it extracts. Love is in the air, folks!  ...and the concrete."}
		}
		table.insert(g_MTEngPotentialStories, MTConcreteLove)
		MTConcreteLoveStorySent = true
	end
end

-- triggered by NewDay
local function MTOvalDomeUnnaturalStory()
	if not MTOvalDomeUnnaturalStorySent and UICity.labels.DomeOval ~= nil then
		local MTOvalUnnatural = {
			title = T{MTText.StringIdBase + 129, "Oval Dome Declared Unnatural"},
			story = T{MTText.StringIdBase + 130, "     The building of the new Oval Dome has stirred a fair share of controversy on Mars. The Flat Mars League (FML) has come forward, claiming it unnatural. 'We have always built round domes, this new oval dome is an insult to martian tradition. What's next? Square?' The new dome design allows for two spires, which scientists have described as 'an incredible breakthrough' stating that they can now throw paper airplanes from one spire to another without even striking the sides of the dome."}
		}
		table.insert(g_MTEngPotentialStories, MTOvalUnnatural)
		MTOvalDomeUnnaturalStorySent = true
	end
end

-- triggered by NewDay
local function MTPewPewStory()
	if not MTPewPewStorySent and UICity.labels.MDSLaser ~= nil then
		local MTPewPew = {
			title = T{MTText.StringIdBase + 131, "Pew Pew"},
			story = T{MTText.StringIdBase + 132, "     Several citizens have lodged official complaints about the new MDS Laser, claiming that they never know when it is firing, and that concerns them. The solution offered is to add a 'pew-pew' sound effect to the MDS lasers, thus allowing citizens the comfort of knowing their dome is securely defended."}
		}
		table.insert(g_MTEngPotentialStories, MTPewPew)
		MTPewPewStorySent = true
		MTPewPewWaitingPeriod = 1
	end
end

-- START comes from MTPewPewStory, ADD comes from NewDay
local function MTPewPewWait()
	if not MTPewPewPewStorySent and MTPewPewWaitingPeriod > 0 then
		MTPewPewWaitingPeriod = MTPewPewWaitingPeriod + 1
		if MTPewPewWaitingPeriod == 3 then
			local MTPewPewPew = {
				title = T{MTText.StringIdBase + 133, "Pew Pew Pew!"},
				story = T{MTText.StringIdBase + 134, "     In response to the complaints lodged several sol prior, pew-pew sounds have been added to all new MDS Lasers.  Drama ensues, however, as several colonists have claimed to have heard the noises generated by the lasers despite there being no meteors in sight and without the lasers firing.  When asked if there were children present playing with their electronics, they responded, 'I hadn't quite thought about that. I don't recall.'"}
			}
			table.insert(g_MTEngPotentialStories, MTPewPewPew)
			MTPewPewPewStorySent = true
		end
	end
end

-- comes from TechResearched
local function RemoveMTScratchingTheSurfaceStory()
	if MTScratchingTheSurfaceStorySent then
		for k, v in pairs(g_MTEngPotentialStories) do
			if v.key == "ScratchingTheSurface" then
				table.remove(g_MTEngPotentialStories, k)
				break
			end
		end
	end
	MTScratchingTheSurfaceStoryRemoved = true
end

--- add comes from NewDay, remove comes from TechResearched
local function MTScratchingTheSurfaceStory()
	if not MTScratchingTheSurfaceStorySent and not MTScratchingTheSurfaceStoryRemoved and UICity.day > 75 then
		local MTScratchingTheSurface = {
			key = "ScratchingTheSurface",
			title = T{MTText.StringIdBase + 135, "Barely Scratching The Surface"},
			story = T{MTText.StringIdBase + 136, "     With each day that passes we are learning more and more about the new world around us, but this doesn't mean that we've learned a single iota about the land next to us.  Our surface deposits are great, but when are we going to probe beyond the surface?  These piddly deposits will only serve our needs in the short term.  In the long term, we need to bore.  We need to go deep."}
		}
		table.insert(g_MTEngPotentialStories, MTScratchingTheSurface)
		MTScratchingTheSurfaceStorySent = true
	end
end

-- triggered via OnMsg.NewDay
local function MTShortageStories()
	local UICity = UICity
	local populatedDomesWithNoOxygen = MTGetPopulatedDomes(g_DomesWithNoOxygen)
	local populatedDomesWithNoWater = MTGetPopulatedDomes(g_DomesWithNoWater)
	local populatedDomesWithNoPower = MTGetPopulatedDomes(g_DomesWithNoPower)
	if #populatedDomesWithNoOxygen > 0 or #populatedDomesWithNoWater > 0 or #populatedDomesWithNoPower > 0 then
		if UICity.day - MTThisIncidentDay > 20 then  -- checks time since incident day so this doesn't trigger multiple times for just one shortage event
			if #populatedDomesWithNoOxygen > #populatedDomesWithNoPower then  --  i.e.  OXYGEN SHORTAGE
				local MTDomeWithoutO2 = table.rand(populatedDomesWithNoOxygen)
				local MTDomeName = MTDomeWithoutO2.name or T{MTText.StringIdBase + 147, "dome without oxygen"}
				MTThisIncidentDay = UICity.day  -- sets new incident day
				local MTDomeWithoutO2Random =
					(MTO2Shortage1StorySent and MTO2Shortage2StorySent and 0)
					or (not MTO2Shortage1StorySent and MTO2Shortage2StorySent and 1)
					or (MTO2Shortage1StorySent and not MTO2Shortage2StorySent and 2)
					or Random(1,2)  -- 2 separate oxygen shortage stories
				if MTDomeWithoutO2Random == 1 then
					local MTO2Shortage1 = {
						title = T{MTText.StringIdBase + 137, "All of <MTDomeWithoutO2Name> Holds Their Breath", MTDomeWithoutO2Name = MTDomeName},
						story = T{MTText.StringIdBase + 138, "     <MTDomeWithoutO2Name> is in dire straits as their oxygen supply was cut off from them recently.  While the <MTLeaderTitle> has already sent for the materials and drones necessary for repair, <MTDomeWithoutO2Name> citizens wonder anxiously: will it all arrive in time to matter?  For the rest of us: be prepared for a potential emergency evacuation.", MTDomeWithoutO2Name = MTDomeName, MTLeaderTitle = MTLeaderTitle}
					}
					table.insert(g_MTEngPotentialStories, MTO2Shortage1)
					MTO2Shortage1StorySent = true
				elseif MTDomeWithoutO2Random == 2 then
					local MTO2Shortage2 = {
						title = T{MTText.StringIdBase + 139, "<MTDomeWithoutO2Name> Lets Off Some Steam", MTDomeWithoutO2Name = MTDomeName},
						story = T{MTText.StringIdBase + 140, "     Without any oxygen, <MTDomeWithoutO2Name> is no longer able to sustain the population it once did.  Please make room in your own home for refugees.  Hopefully the drones are already on it, but either way, <MTDomeWithoutO2Name> will be offline for a time while under repair.", MTDomeWithoutO2Name = MTDomeName}
					}
					table.insert(g_MTEngPotentialStories, MTO2Shortage2)
					MTO2Shortage2StorySent = true
				end -- end Oxygen Shortage stories
			elseif #populatedDomesWithNoWater > #populatedDomesWithNoPower then  -- begin WATER SHORTAGE
				local MTDomeWithoutWater = table.rand(populatedDomesWithNoWater)
				local MTDomeName = MTDomeWithoutWater.name or T{MTText.StringIdBase + 145, "dome without water"}
				MTThisIncidentDay = UICity.day  -- sets new incident day
				local MTWaterDomeResident = table.rand(MTDomeWithoutWater.labels.Colonist)
				local MTResidentName =
					(MTWaterDomeResident ~= nil and MTWaterDomeResident.name)
					or _InternalTranslate({MTText.StringIdBase + 146 --[["colonist"--]]})
				local MTDomeWithoutWaterRandom = 
					(MTWaterShortage1StorySent and MTWaterShortage2StorySent and 0)
					or (not MTWaterShortage1StorySent and MTWaterShortage2StorySent and 1)
					or (MTWaterShortage1StorySent and not MTWaterShortage2StorySent and 2)
					or Random(1,2)  -- 2 separate water shortage stories
				if MTDomeWithoutWaterRandom == 1 then
					local MTWaterShortage1 = {
						title = T{MTText.StringIdBase + 141, "Drought Declared"},
						story = T{MTText.StringIdBase + 142, "     A drought has been declared in <MTDomeWithoutWaterName>.  Dehydration is setting in and the citizens are nervous.  <MTWaterDomeResident> has declared it a non-issue, professing his faith in <MTLeaderTitle> <MTLeader>'s planning and provision.", MTDomeWithoutWaterName = MTDomeName, MTWaterDomeResident = MTResidentName, MTLeaderTitle = MTLeaderTitle, MTLeader = MTGetLeaderName()}
					}
					table.insert(g_MTEngPotentialStories, MTWaterShortage1)
					MTWaterShortage1StorySent = true
				elseif MTDomeWithoutWaterRandom == 2 then
					local MTWaterShortage2 = {}
					MTWaterShortage2["title"] = T{MTText.StringIdBase + 143, "Engineers Working To Mitigate Water Shortage"}
					MTWaterShortage2["story"] = T{MTText.StringIdBase + 144, "     Water is in short supply in <MTDomeWithoutWaterName>.  While several engineers have begun working on a humidity reclamation project, even they have expressed doubt as to its viability.  This could be it for <MTDomeWithoutWaterName> as farms begin to shut down.", MTDomeWithoutWaterName = MTDomeName}
					table.insert(g_MTEngPotentialStories, MTWaterShortage2)
					MTWaterShortage2StorySent = true
				end
			end  -- end Water Shortage stories
		end  -- end IncidentDay check
	end  -- no shortages of note
end -- end function

local function MTMarsRealityTVStory()
	if not MTMarsRealityTVStorySent and CountColonistsWithTrait("Celebrity") > 0 and UICity.tech_status["LiveFromMars"].researched ~= nil then
		local MTCelebrity = MTGetColonistWithTrait("Celebrity")
		local MTCelebrityName = MTCelebrity.name or T{MTText.StringIdBase + 150, "random celebrity"}
		local MTMarsRealityTV = {
			title = T{MTText.StringIdBase + 148, "Live From Mars Renewed for Season 2"},
			story = T{MTText.StringIdBase + 149, "     The hit martian reality TV show, Planet Mars, has been renewed for a second season. <MTCelebrityName> will be the host for the second season.  <MTSponsor> has offered their full support of the endeavor, while our new director has already declared their disgust with working in the Martian environment declaring 'Dust. It's coarse, and rough, and irritating, and it just gets everywhere. EVERYWHERE!'", MTCelebrityName = MTCelebrityName, MTSponsor = MTSponsor}
		}
		table.insert(g_MTSocialPotentialStories, MTMarsRealityTV)
		MTMarsRealityTVStorySent = true
	end
end

-- triggered via OnMsg.ColonistDied
local function MTSoylentGreen()
	if not MTSoylentGreenStorySent and UICity.tech_status["SoylentGreen"].researched ~= nil then
		--local MTSoylentRandom = Random(1,1)
		--if MTSoylentRandom == 1 then
			local MTSoylentGreen1 = {
				title = T{MTText.StringIdBase + 151, "What Goes Around Comes Around"},
				story = T{MTText.StringIdBase + 152, "     As time moves on more and more colonists are born, and more and more are passing away, including just yesterday.  In other news, the newest food crop has come in! Make sure to check your nearest grocer for fresh produce and show them this article for a 0.5 percent discount!"}
			}
			table.insert(g_MTSocialPotentialStories, MTSoylentGreen1)
			MTSoylentGreenStorySent = true
		--end
	end
end

-- triggered via OnMsg.NewDay
local function MTDomelenolStory()
	if not MTDomelenolStorySent and UICity.labels.Infirmary ~= nil then
		local MTDomelenol = {
			title = T{MTText.StringIdBase + 153, "Domelenol Now Available!"},
			story = T{MTText.StringIdBase + 154, "     Got any aches and pains? Go to your local infirmary and ask for some Domelenol, the only sponsor-approved painkiller on Mars. Warning: Domelenol will not cure earthsickness, headaches, being an idiot, toothaches, alcoholism, feelings of loneliness, gambling addiction, nausea or just about anything else. Use at your own risk."}
		}
		table.insert(g_MTSocialPotentialStories, MTDomelenol)
		MTDomelenolStorySent = true
	end
end

-- triggered via OnMsg.NewDay
local function MTSpyStory()
	local Spacebars = UICity.labels.Spacebar or empty_table
	if not MTSpyStorySent and #Spacebars > 1 then
		local MTSecondSpacebarDomeName = 
			(Spacebars[2] and Spacebars[2].parent_dome.name)
			or T{MTText.StringIdBase + 157, "unbuilt spacebar dome"}
		local MTSpy = {
			title = T{MTText.StringIdBase + 155, "Spies Spotted on Mars"},
			story = T{MTText.StringIdBase + 156, "     The Martian Tribune has received information that there spies sent from Earth have been spotted on Mars. Sources say that a spy was seen in the spacebar in <MTSecondSpacebarDomeName> highly intoxicated and attempting to hit on any woman in the bar while trying to use the pickup line 'I am the greatest secret agent on Mars, baby!'  The spy's identity has yet to be confirmed.", MTSecondSpacebarDomeName = MTSecondSpacebarDomeName}
		}
		table.insert(g_MTSocialPotentialStories, MTSpy)
		MTSpyStorySent = true
	end
end

-- triggered via OnMsg.NewDay
local function MTNewLanguageStory()
	if not MTNewLanguageStorySent and UICity.day > 125 then
		local MTNewLanguage = {
			title = T{MTText.StringIdBase + 158, "New Language Develops on Mars"},
			story = T{MTText.StringIdBase + 159, "     It has been reported that the language spoken on Mars has changed so much from those spoken on earth that it is now mutually unintelligble when compared to any language on Earth and thus must be classified as its very own language. Some experts have claimed that it is not a new language, but rather a combination of Swahili and Irish.  This strikes us here at the Martian Tribune as quite odd, however, as no one speaking either of those languages has yet come to Mars."}
		}
		table.insert(g_MTSocialPotentialStories, MTNewLanguage)
		MTNewLanguageStorySent = true
	end
end

-- triggered via OnMsg.NewDay
--  put into FREE stories  -- also initiates story on Dome To Dome Messaging
local function MTVigilanteStory()
	if not MTVigilanteStorySent and CountObjects{class = "Dome"} > 2 then
		local MTVigilante = {
			title = T{MTText.StringIdBase + 160, "Vigilante Justice"},
			story = T{MTText.StringIdBase + 161, "     A rumor has begun circulating around the domes of a masked vigilante running around preventing crime. Given the name of the Red Lantern has been spotted on multiple occasions preventing petty crimes and saving lives.  Spottings include, but are not limited to; telling youth to stop throwing rocks, pushing a person out of the way of a rapidly moving drone, and stopping a theft in the local grocer."}
		}
		table.insert(g_MTSocialFreeStories, MTVigilante)
		MTVigilanteStorySent = true
	end
end

-- triggered via OnMsg.NewDay
local function MTPassportStory()
	if not MTPassportStorySent and MTColonistsHaveArrived then
		local MTPassport = {
			title = T{MTText.StringIdBase + 162, "New Martian Passport Revealed"},
			story = T{MTText.StringIdBase + 163, "     The Martian Tribune has received an advance copy of the new martian passport, designed behind closed doors in Armstrong City on Luna.  The passport is red, the front has a hologram of Mars with Phobos and Deimos behind it. Designers have stated the passport is 'completely uncopyable.' If you have yet to see the design, plenty of copies are rumored to be available from various undisclosed sources both here on Mars as well as on the Moon."}
		}
		table.insert(g_MTSocialPotentialStories, MTPassport)
		MTPassportStorySent = true
	end
end

-- triggered via OnMsg.NewDay
--  put into FREE stories
local function MTMartianMusicStory()
	if not MTMartianMusicStorySent and MTColonistsHaveArrived then
		local MTMartianMusic = {
			title = T{MTText.StringIdBase + 164, "Martian Music Voted Best in Galaxy"},
			story = T{MTText.StringIdBase + 165, "   The Martian rock group, Red Rock Rocks, has been voted best in the galaxy by an unbiased vote conducted online. The group is famous for songs such as '4th Rock from the sun', 'Red Rocks Rock', 'Dome sweet Dome', and 'Martian Madness'. The timing of such a vote is fortuitous as they have also just released their brand new album called 'Dark side of Phobos'."}
		}
		table.insert(g_MTSocialFreeStories, MTMartianMusic)
		MTMartianMusicStorySent = true
	end
end

-- triggered via OnMsg.NewDay
--  put into FREE stories
local function MTEqualityStory()
	if not MTEqualityStorySent and UICity.day > 50 and MTColonistsHaveArrived then
		local MTEquality = {
			title = T{MTText.StringIdBase + 166, "<MTLeaderTitle> Praised For Culture of Equality", MTLeaderTitle = MTLeaderTitle},
			story = T{MTText.StringIdBase + 167, "     In a recent G20 Summit, Mars has been praised for its fully representative gender-based equality. Martian men, women, and those identifying as Other all have equal and ready access to all services, job opportunities, and representation. This has been attributed to <MTSponsor> who has gone on record as not really caring about 'things like gender, as long as they get the job done.'", MTSponsor = MTSponsor}
		}
		table.insert(g_MTSocialFreeStories, MTEquality)
		MTEqualityStorySent = true
	end
end
			
-- triggered via OnMsg.NewDay
local function MTReligiousArtifactStory()
	if not MTReligiousArtifactStorySent and CountColonistsWithTrait("Saint") > 0 then
		local MTSaintColonist = MTGetColonistWithTrait("Saint")
		local MTSaint =
			(MTSaintColonist and MTSaintColonist.name)
			or T{MTText.StringIdBase + 170, "random saint"}
		local MTReligiousArtifact = {
			title = T{MTText.StringIdBase + 168, "Religious Artifact Found on Mars"},
			story = T{MTText.StringIdBase + 169, "     <MTSaint> has found what appears to be a religious artifact on Mars. The item, shaped like the Point of Origin symbol from Stargate fame, has been heralded as undeniable proof of <MTSaint>'s new religion as the one true faith. Sceptics however are reported saying '..its just a stupid, useless rock.. there are thousands of them all around! What's so special about this one?'", MTSaint = MTSaint}
		}
		table.insert(g_MTSocialPotentialStories, MTReligiousArtifact)
		MTReligiousArtifactStorySent = true
	end
end

-- triggered via OnMsg.ColonistDied (1st non-founder death)
-- editing comment: *first* birthday celebrated at first death of a martianborn colonist?!
local function MTHappyBirthdayStory()
	if not MTHappyBDayStorySent and UICity.labels.Colonist ~= nil then
		local MTBirthdayColonist = table.rand(UICity.labels.Colonist)
		local MTBirthdayName =
			(MTBirthdayColonist and MTBirthdayColonist.name)
			or T{MTText.StringIdBase + 173, "random birthday colonist"}
		local MTHappyBirthday = {
			title = T{MTText.StringIdBase + 171, "A Baby-Step For Mankind, A Huge Leap For Martianborn!"},
			story = T{MTText.StringIdBase + 172, "     Today marks yet another milestone in martian colonization: Today we celebrate the a special martianborn birthday!  Indeed, with <MTBirthdayName>'s birthday today we are reminded that this Red Planet is indeed ours! Let this serve as a sign that the Red Planet has truly become the realm of man!  It is time to sing, cheer and celebrate at this wonderful news!  Happy Birthday <MTBirthdayName>.  May your life be long and prosperous.", MTBirthdayName = MTBirthdayName}
		}
		table.insert(g_MTSocialPotentialStories, MTHappyBirthday)
		MTHappyBDayStorySent = true
	end
end

-- triggered via OnMsg.ColonistDied
local function MTFirstMartianbornDied(MTDeadColonist)
	if not MTFirstMartianbornDiedStorySent and IsValid(MTDeadColonist) then
		local MTDeadMartianName = MTDeadColonist.name or T{MTText.StringIdBase + 176, "first dead martian"}
		local MTFirstMartianbornDied = {
			title = T{MTText.StringIdBase + 174, "Petition to Rename Dome"},
			story = T{MTText.StringIdBase + 175, "     A petition has arrived at the Martian Tribune asking that a dome of ours be re-named in honor of <MTDeadMartianName>. We at the bureau also feel it would be a great way to remember the dead. If you would like to add your name to the petition, stop by the bureau before next Monday when we officially present the petition to the <MTLeaderTitle> on behalf of the martian people.", MTDeadMartianName = MTDeadMartianName, MTLeaderTitle = MTLeaderTitle}
		}
		table.insert(g_MTTopPotentialStories, MTFirstMartianbornDied)
		MTFirstMartianbornDiedStorySent = true
	end
end

local function MTLeaderVices()
	if not MTVirtueOverVicesStorySent and MTColonistsHaveArrived then
		local MTLeaderName = MTGetLeaderName()
		if IsValid(MTLeaderColonist) and (MTLeaderColonist.traits.Glutton or MTLeaderColonist.traits.Gambler or MTLeaderColonist.traits.Alcoholic) then
			local MTVirtue = {
				title = T{MTText.StringIdBase + 177, "Virtue Over Vices"},
				story = T{MTText.StringIdBase + 178, "     The stresses of colonizing a new planet have clearly taken their toll on <MTLeaderTitle> <MTLeader> as the foolishness of last night's escapades will not be long forgotten.  <MTLeaderTitle>, learn to control your vices better before they take us all down with you!  If things don't change soon, it might be time to start looking for a new leader.", MTLeaderTitle = MTLeaderTitle, MTLeader = MTLeaderName}
			}
			table.insert(g_MTTopPotentialStories, MTVirtue)
			MTVirtueOverVicesStorySent = true
		end
	end
end

-- triggered by NewDay
local function MTConnoisseurStory()
	if not MTConnoisseurStorySent and UICity.labels.Spacebar ~= nil and MTColonistsHaveArrived then
		local MTConnoisseur = {
			title = T{MTText.StringIdBase + 179, "Spacebar a hit with local Connoisseur"},
			story = T{MTText.StringIdBase + 180, "     WOOOO! Mannn, this Spacebar is great! I went... I went there, and -hic- I went there, it was great! WOOOOO! man, i love it, I don't ever want to -hic- leave... they have this great drink, made from the.. food thing, the.. potatoes, the barman called it 'poteeeen', man its great, does anywhere on mars do Chinese? I could really do with some Chinese right now. -hic-"}
		}
		table.insert(g_MTSocialPotentialStories, MTConnoisseur)
		MTConnoisseurStorySent = true
	end
end

-- triggered by NewDay
local function MTWatchWhatYouEatStory()
	local UICity = UICity
	if not MTWatchWhatYouEatStorySent and CountObjects{class = "Spacebar"} > 1 and MTColonistsHaveArrived then
		local MTRandomColonist = table.rand(UICity.labels.Colonist)
		local MTRandomColonistName =
			(MTRandomColonist and MTRandomColonist.name)
			or T{MTText.StringIdBase + 183, "random colonist"}
		local MTWatchWhatYouEat = {
			title = T{MTText.StringIdBase + 181, "Watch What You Eat"},
			story = T{MTText.StringIdBase + 182, "     A new ordinance has been passed on the number of drinks one may imbibe after yet another incident.  Five of our inebriated compatriots recently snuck off to the stockpiles overnight, exchanging the contents of the food containers randomly with polymers, machine parts, and electronics again.  Watch what you eat, folks.  As <MTRandomColonistName> put it, 'Those electronics just don't go down well'.", MTRandomColonistName = MTRandomColonistName}
		}
		table.insert(g_MTEngPotentialStories, MTWatchWhatYouEat)
		MTWatchWhatYouEatStorySent = true
	end
end

-- triggered via OnMsg.NewDay
local function MTIdiotFMLStory()
	if not MTIdiotFMLStorySent and CountColonistsWithTrait("Idiot") > 0 then
		local MTIdiotColonist = MTGetColonistWithTrait("Idiot")
		local MTIdiotName =
			(MTIdiotColonist and MTIdiotColonist.name)
			or MTIdiotColonistFallbackName
		if IsValid(MTIdiotColonist) and not MTIdiotColonist.is_pinned then
			MTIdiotColonist:TogglePin()
		end
		local MTIdiotFML = {
			title = T{MTText.StringIdBase + 184, "Flat Mars League Gains Traction"},
			story = T{MTText.StringIdBase + 185, "     <MTSponsor>'s recent announcement that cursory scans of the Martian surface are complete has prompted an interesting response from the public.  The Flat Mars League (FML) has come forward to declare that the scans provide full evidence, beyond any doubt, that Mars is indeed flat.  Their spokesman, <MTIdiotName>, has pointed to the clear squareness of the resulting map, and the fact that the horizon is so obviously flat as well.  When asked about Earth, <MTIdiotName> stated that, 'Unlike Mars, Earth has been observed to be round.'", MTSponsor = MTSponsor, MTIdiotName = MTIdiotName}
		}
		table.insert(g_MTEngPotentialStories, MTIdiotFML)
		MTIdiotFMLStorySent = true
	end
end

-- triggered via OnMsg.MTIdiotWorkplaceBreakdown from RequiresMaintenance:SetMalfunction
local function MTOopsIBrokeItAgainStory(workplace, idiot)
	if not MTOopsIBrokeItAgainStorySent then
		if IsValid(workplace) and IsValid(idiot) then
			local MTIdiotWorkplace =
				workplace.display_name
				or T{MTText.StringIdBase + 188, "idiot workplace"}
			local MTIdiotName = idiot.name or MTIdiotColonistFallbackName
			local MTOopsIBrokeItAgain = {
				title = T{MTText.StringIdBase + 186, "Oops I Broke It Again"},
				story = T{MTText.StringIdBase + 187, "     Dome dimwit <MTIdiotName> has once again managed to again find a way to get around the idiot-proof safety features of the local <MTIdiotWorkplace> with an amazing display of acrobatics, luck, and skill. Once again <MTIdiotName> found themselves holding a vital part of the building in their hand as they left work today. 'I honestly have no idea how they managed it. The building can't function without it, so we keep it behind three feet of concrete... yet, somehow, they still managed to walk off with it. I'm not even mad. It really is just plain amazing.'", MTIdiotName = MTIdiotName, MTIdiotWorkplace = MTIdiotWorkplace}
			}
			table.insert(g_MTEngPotentialStories, MTOopsIBrokeItAgain)
			MTOopsIBrokeItAgainStorySent = true
		end
	end
end

-- triggered via OnMsg.ConstructionComplete
local function MTShuttleHubStory()
	if not MTShuttleHubStorySent then
		local MTShuttleHub = {
			title = T{MTText.StringIdBase + 189, "The Wright Way"},
			story = T{MTText.StringIdBase + 190, "     As recent research turns into technological innovation the Martian Aviation Authority has announced its first inter-dome flights with their new CO2 powered flying drones. Move from dome to dome with the new luxury passanger drones, or just watch as the MAA goes about it's business transfering food and other supplies to where its most needed."}
		}
		table.insert(g_MTSocialPotentialStories, MTShuttleHub)
		MTShuttleHubStorySent = true
	end
end

-- triggered via OnMsg.ConstructionComplete
local function MTUniversityStory()
	if not MTUniversityStorySent then
		local MTUniversity = {
			title = T{MTText.StringIdBase + 191, "MRU Opens Its Doors"},
			story = T{MTText.StringIdBase + 192, "     After months of construction and planning the Martian Red University has opened its doors to Martians and colonists alike offering classes in Martian Botony, Martian Engineering, Martian Geology, Martian Medical Care, and Martian Science.  MRU is already being recognized as an accredited third level educational institute throughout the entire planet. Sign up now and become marginally less useless today!"}
		}
		table.insert(g_MTSocialPotentialStories, MTUniversity)
		MTUniversityStorySent = true
	end
end

-- triggered via OnMsg.ColonistBorn
local function MTMartianCelebrityStory(MTColonistBorn)
	if not MTMartianCelebrityStorySent then
		local MTMartianCelebrityName =
			(MTColonistBorn and MTColonistBorn.name)
			or T{MTText.StringIdBase + 195, "martian celebrity"}
		if IsValid(MTColonistBorn) and not MTColonistBorn.is_pinned then
			MTColonistBorn:TogglePin()
		end
		local MTMartianCelebrity = {
			title = T{MTText.StringIdBase + 193, "The Answer To Life Is Always 42"},
			story = T{MTText.StringIdBase + 194, "     The lucky couple came forward today to announce that after 42 hours of labor, at 24:45 Martian Standard Time, their first child, <MTMartianCelebrityName> was born.  They are said to be only slightly fatigued, but absolutely jubilant upon the sight of the most dazzling, toothless smile imaginable staring back at them. Journalists from earth are already requesting photos of the new citizen.  We have a new celebrity in our midst!", MTMartianCelebrityName = MTMartianCelebrityName}
		}
		table.insert(g_MTSocialPotentialStories, MTMartianCelebrity)
		MTMartianCelebrityStorySent = true
	end
end

-- triggered via OnMsg.ColonistDied
local function MTFirstFounderDied(MTDeadColonist)
	if not MTFirstFounderDiedStorySent and IsValid(MTDeadColonist) and MTDeadColonist.traits.Founder then
		local MTDeadFounder = MTDeadColonist.name or T{MTText.StringIdBase + 198, "dead founder"}
		local MTFirstFounder = {
			title = T{MTText.StringIdBase + 196, "First Founder Passed Away"},
			story = T{MTText.StringIdBase + 197, "     Today marks a sad day on Mars as two planets mourn in unison.  The first death on Mars, Founder <MTDeadFounder> passed away today. As one of the very first Founders to ever set foot on the Red Planet, <MTDeadFounder> will go down in history as having set the highest of standards.  They were a brave soul, who's impact can be seen all around us, and shall not be forgotten.", MTDeadFounder = MTDeadFounder}
		}
		table.insert(g_MTSocialPotentialStories, MTFirstFounder)
		MTFirstFounderDiedStorySent = true
	end
end

--triggered via OnMsg.NewDay
local function MTHippieStory()
	if not MTHippieStorySent and CountColonistsWithTrait("botanist") > 0 then
		local MTBotanistColonist = MTGetColonistWithTrait("botanist")
		local MTHippieName =
			(MTBotanistColonist and MTBotanistColonist.name)
			or T{MTText.StringIdBase + 201, "random botanist"}
		local MTHippie = {
			title = T{MTText.StringIdBase + 199, "The Grass Couldn't Be Greener"},
			story = T{MTText.StringIdBase + 200, "     Local botanist <MTHippieName> has been caught smoking what officers referred to as 'the greatest stuff on the planet,' which was found to be grown in their very own closet. Though technically not illegal on Mars, questions have been raised as to how the botanist got the plant here in the first place. Dome security declared to us that 'it's definitely home-grown, it really is pretty high quality,' unfortunately this was all the information we could gather as the officers were all quite insistent on returning to their spudtato snacks.  We will keep you updated as more news unfolds.", MTHippieName = MTHippieName}
		}
		table.insert(g_MTSocialPotentialStories, MTHippie)
		MTHippieStorySent = true
	end
end

local function MTMovingDomesStory()
	local Domes = UICity.labels.Dome or empty_table
	if not MTMovingDomesStorySent and #Domes > 2 then
		local Dome1 = table.rand(Domes)
		local Dome2 = table.rand(Domes)
		while Dome1 == Dome2 do
			Dome2 = table.rand(Domes)
		end
		local MTMovingDome1 = (Dome1 and Dome1.name) or T{MTText.StringIdBase + 204, "random dome <num>", num=1}
		local MTMovingDome2 = (Dome2 and Dome2.name) or T{MTText.StringIdBase + 204, "random dome <num>", num=2}
		local MTMovingDomes = {
			title = T{MTText.StringIdBase + 202, "The Rock Is Always Redder"},
			story = T{MTText.StringIdBase + 203, "     In a recent survey performed by the Martian Tribune a number of citizens have expressed disappointment after moving to a new dome.  One citizen in particular hit the nail on the head saying, 'I always thought that moving from <MTMovingDome1> to <MTMovingDome2> would be a huge upgrade in lifestyle, but I've have found it to be basically the same as before. I guess it's true what they say: The rock is redder on the other side.'", MTMovingDome1 = MTMovingDome1, MTMovingDome2 = MTMovingDome2}
		}
		table.insert(g_MTSocialPotentialStories, MTMovingDomes)
		MTMovingDomesStorySent = true
	end
end

local function MTRareMetalsComplaintStory()
	local UICity = UICity
	if not MTRareMetalsComplaintStorySent and UICity.labels.PreciousMetalsExtractor ~= nil then
		local MTRMExtractor = table.rand(UICity.labels.PreciousMetalsExtractor)
		if IsValid(MTRMExtractor) then
			local MTRareMetalsColonist = MTGetRandomWorker(MTRMExtractor)
			local MTRareMetalsColonistName =
				(MTRareMetalsColonist and MTRareMetalsColonist.name)
				or T{MTText.StringIdBase + 207, "random rare metals colonist"}
			local MTRareMetalsDome = 
				(MTRareMetalsColonist and MTRareMetalsColonist.dome and MTRareMetalsColonist.dome.name)
				or T{MTText.StringIdBase + 208, "random rare metals dome"}
			if IsValid(MTRareMetalsColonist) then
				local MTRareMetals = {
					title = T{MTText.StringIdBase + 205, "Sound Complaint Filed"},
					story = T{MTText.StringIdBase + 206, "     <MTRareMetalsColonist> has lodged a formal complaint against <MTLeader>'s natural resource exploitation.  In the complaint they declared the primary contributor to be the new Rare Metals Extractor near <MTRareMetalsDome>.  There was also mention of sleep being precious and the constant pounding leaving not a moment of reprieve.  <MTLeader> declared themselves unmoved by the complaint.", MTRareMetalsColonist = MTRareMetalsColonistName, MTLeader = MTGetLeaderName(), MTRareMetalsDome = MTRareMetalsDome}
				}
				table.insert(g_MTSocialPotentialStories, MTRareMetals)
				MTRareMetalsComplaintStorySent = true
			end
		end
	end
end

local function MTConcretePavingStory()
	local UICity = UICity
	if not MTConcretePavingStorySent and UICity.labels.RegolithExtractor ~= nil and MTColonistsHaveArrived then
		local MTRandomColonist = table.rand(UICity.labels.Colonist)
		local MTConcreteName =
			(MTRandomColonist and MTRandomColonist.name)
			or T{MTText.StringIdBase + 211, "random person"}
		local MTConcrete = {
			title = T{MTText.StringIdBase + 209, "Paving Over The Problem"},
			story = T{MTText.StringIdBase + 210, "     <MTConcreteName> has lodged a formal complaint with authorities today after the plans to construct yet another Concrete Extractor was announced. <MTConcreteName> declared within that they 'did not come to another planet to pave it over.'", MTConcreteName = MTConcreteName}
		}
		MTConcretePavingStorySent = true
	end
end

local function MTVeganDinerStory()
	if not MTVeganDinerStorySent and CountColonistsWithTrait("Vegan") > 3 then
		local MTVeganColonist = MTGetColonistWithTrait("Vegan")
		if IsValid(MTVeganColonist) and MTVeganColonist.dome and MTVeganColonist.dome.labels.Diner ~= nil then
			local MTVeganDinerName = MTVeganColonist.name or MTVeganColonistFallbackName
			local MTVeganDinerDome = MTVeganColonist.dome.name or T{MTText.StringIdBase + 213, "dome with vegan and diner"}
			local MTVeganDiner = {
				title = T{MTText.StringIdBase + 212, "Is this Vegan?"},
				story = T{MTText.StringIdBase + 213, "     <MTVeganDinerName> has been barred from the diner in <MTVeganDinerDome> after going in 25 different times and asking, 'Is this vegan? I'm vegan, so I can't eat anything that comes from an animal,' and being repetedly informed that everything on Mars is vegan.  Staff finally banded together and has officially banned <MTVeganDinerName> from the establishment stating 'EVERYTHING is vegan!  Now GET OUT!'", MTVeganDinerName = MTVeganDinerName, MTVeganDinerDome = MTVeganDinerDome}
			}
			table.insert(g_MTSocialPotentialStories, MTVeganDiner)
			MTVeganDinerStorySent = true
		end
	end
end

local function MTVegan1Story()
	if not MTVegan1StoryHasBeenSent and CountColonistsWithTrait("Vegan") > 0 then
		local MTVegan1Colonist = MTGetColonistWithTrait("Vegan")
		if IsValid(MTVegan1Colonist) then
			local MTVegan1Name = MTVegan1Colonist.name or MTVeganColonistFallbackName
			if MTVegan1Colonist.dome.labels.medic ~= nil then
				local MTVegan1Medic = table.rand(MTVegan1Colonist.dome.labels.medic)
				if IsValid(MTVegan1Medic) then
					local MTVegan1MedicName = MTVegan1Medic.name
					local MTVegan1 = {
						title = T{MTText.StringIdBase + 215, "Vegan Declares Mars Meat-Free Planet"},
						story = T{MTText.StringIdBase + 216, "     <MTVegan1Name> has stepped up to make their presence known today as they've declared Mars to be Vegan Atlantis.  With Earth now lost forever to the carnivores, Mars is as yet unmarred by the carnivorous and <MTVegan1Name> has vowed to do everything in their power to keep it that way.  Doesn't sound good for all the bacon lovers out there as <MTVegan1MedicName> has stepped up to back the proposition as well.  We'll have to wait and see if it sticks.", MTVegan1Name = MTVegan1Name, MTVegan1MedicName = MTVegan1MedicName}
					}
					table.insert(g_MTSocialPotentialStories, MTVegan1)
					MTVegan1StoryHasBeenSent = true
					MTVeganPurgatoryDays = 1
				end
			end
		end
	end
end

local function MTVeganPurgatory()
	if MTVeganPurgatoryDays > 0 and MTVeganPurgatoryDays < 40 and MTVegan1StoryHasBeenSent then
		local MTNewVeganPurgatoryDays = MTVeganPurgatoryDays + 1
		MTVeganPurgatoryDays = MTNewVeganPurgatoryDays
	end
end

local function MTVegan2Story()
	if not MTVeganStory2HasBeenSent and MTVeganPurgatoryDays >= 10 and CountColonistsWithTrait("Vegan") > 0 then
		local MTVegan2 = MTGetColonistWithTrait("Vegan")
		local MTVegan2Name = MTVegan2 and MTVegan2.name or MTVeganColonistFallbackName
		local MTVegan2 = {
			title = T{MTText.StringIdBase + 217, "Mars Still Meat Free"},
			story = T{MTText.StringIdBase + 218, "     <MTVegan2Name>'s ambitions have lead to the creation of a new foundation called the Vegan Martian Coalition. Their proposition of a meat-free Mars seems to be gaining momentum as 10 sol have now passed since the initial proposition and neither cattle nor hog has yet seen import.  Recognizing that opposition has been light, the <MTLeaderTitle> and <MTSponsor> have each agreed to sit down to discuss the issue more in depth.", MTVegan2Name = MTVegan2Name, MTLeaderTitle = MTLeaderTitle, MTSponsor = MTSponsor}
		}
		table.insert(g_MTSocialPotentialStories, MTVegan2)
		MTVeganStory2HasBeenSent = true
	end
end

local function MTVegan3Story()
	if not MTVegan3StorySent and MTVeganPurgatoryDays >= 22 then
		local MTVegan3 = {
			title = T{MTText.StringIdBase + 219, "Vegan Martian Coalition Gains Ground"},
			story = T{MTText.StringIdBase + 220, "     The VMC has announced Saturday to be Spudtato Day.  As the faction gains traction, so does their hold on Martian Cuisine, but perhaps this is one we can all get behind.  Let the fries flow!"}
		}
		table.insert(g_MTSocialPotentialStories, MTVegan3)
		MTVegan3StorySent = true
	end
end

local function MTVegan4Story()
	if not MTVegan4StorySent and MTVeganPurgatoryDays >= 36 then
		local MTVegan4 = {
			title = T{MTText.StringIdBase + 221, "Vegan Martian Coalition Talks Stalled"},
			story = T{MTText.StringIdBase + 222, "     Though the VMC has managed to garner the favor of our <MTLeaderTitle> <MTLeader>, <MTSponsor> has claimed to receive millions of complaints from Earthlings who once desired to travel to Mars.  Applicants have begun to withdraw their applications by the thousands citing only one word on the cancellation form: 'bacon'.  While the backlash might dampen <MTSponsor>'s support, this reporter for one is pleased with the health benefits.  We'll keep you updated as the situation continues to progress.", MTLeaderTitle = MTLeaderTitle, MTLeader = MTGetLeaderName(), MTSponsor = MTSponsor}
		}
		table.insert(g_MTSocialPotentialStories, MTVegan4)
		MTVegan4StorySent = true
	end
end

local function MTDomeDelayCheck()
	local Domes = CountObjects{ class = "Dome" }
	if MTDomeCount == nil or MTDomeCount == 0 then
		MTDomeCount = Domes
		MTDomeDelayDays = 1
	elseif MTDomeCount == Domes then
		local MTNewDomeDelayDays = MTDomeDelayDays + 1
		MTDomeDelayDays = MTNewDomeDelayDays
	else
		MTDomeDelayDays = 0
	end
	return MTDomeDelayDays
end

local function MTDomeDelay1Story()
	if not MTDomeDelay1StorySent and UICity.day > 40 then
		if MTDomeDelayCheck() >= 10 then
			local MTEarthlingColonist = MTGetColonistWithoutTrait("Martianborn")
			-- Reused in MTDomeDelay2Story, so needs to be kept
			MTEarthlingDelayName =
				(MTEarthlingColonist and MTEarthlingColonist.name)
				or T{MTText.StringIdBase + 227, "random earthling"}
			local MTEarthlingDelay1 = {
				title = T{MTText.StringIdBase + 223, "Earthling Causes Delay"},
				story = T{MTText.StringIdBase + 224, "     If you've been wondering why no new domes have been built of late, look no further than <MTEarthlingDelayName>.  Apparently they're now taking signatures for a petition to halt all mining operations, claiming them to be 'raping and pillaging Mars of its natural resources.'  The <MTLeaderTitle> has taken note of <MTEarthlingDelayName> and should be releasing a statement later this very sol.", MTEarthlingDelayName = MTEarthlingDelayName, MTLeaderTitle = MTLeaderTitle}
			}
			table.insert(g_MTSocialPotentialStories, MTEarthlingDelay1)
			MTDomeDelay1StorySent = true
			MTDomeDelay2DaysWaiting = 1
		end
	end
end

local function MTDomeDelay2Story()
	-- MTEarthlingDelayName is set in MTDomeDelay1Story()
	if not MTDomeDelay2StorySent and MTEarthlingDelayName ~= false then
		local MTEarthlingDelay2 = {
			title = T{MTText.StringIdBase + 225, "Earthling Claims To Be Misunderstood"},
			story = T{MTText.StringIdBase + 226, "     As proof that rumors travel faster than light, word of <MTEarthlingDelayName>'s attempt to halt mining operations has already reached <MTSponsor>'s ears on Earth.  While our sponsor yet to make any formal declarations, <MTEarthlingDelayName> has already gone on the record to declare that it was all a giant April Fool's Day joke.  Whether it is or not, it is not April, and this reporter is not amused.", MTEarthlingDelayName = MTEarthlingDelayName, MTSponsor = MTSponsor}
		}
		table.insert(g_MTSocialPotentialStories, MTEarthlingDelay2)
		MTDomeDelay2StorySent = true
	end
end

local function MTDomeDelay2StoryWait()
	if not MTDomeDelay2StoryInitiated and MTDomeDelay2DaysWaiting > 0 then
		if MTDomeDelay2DaysWaiting >= 5 then
			MTDomeDelay2Story()
			MTDomeDelay2StoryInitiated = true
		else
			local MTNewDomeDelay2DaysWaiting = MTDomeDelay2DaysWaiting + 1
			MTDomeDelay2DaysWaiting = MTNewDomeDelay2DaysWaiting
		end
	end
end

-- triggered by OnMsg.NewDay()
local function MTTeenagerJoyrideStory()
	if not MTTeenagerJoyrideStorySent and CountColonistsWithTrait("Youth") > 0 then
		local MTTeenager = MTGetColonistWithTrait("Youth")
		if IsValid(MTTeenager) then
			local MTTeenagerJoyrideName = MTTeenager.name or MTTeenagerColonistFallbackName
			local MTTeenagerJoyrideDome =
				(MTTeenager.dome and MTTeenager.dome.name)
				or T{MTText.StringIdBase + 230, "random teenager's dome"}
			local MTDroneHack1 = {
				title = T{MTText.StringIdBase + 228, "Teenager Takes Drone for a Joyride"},
				story = T{MTText.StringIdBase + 229, "     Last night <MTTeenagerJoyrideName> hacked the code.  Working their way into the mainframe, one would expect havoc throughout the colony this morning, but apparently they had their sights set on something a little more exciting.  <MTTeenagerJoyrideName> simply took over a local drone and went out for a little joyride, eventually to end the ride face-first into the side of <MTTeenagerJoyrideDome>, go figure.  Kids will be kids, I guess.", MTTeenagerJoyrideName = MTTeenagerJoyrideName, MTTeenagerJoyrideDome = MTTeenagerJoyrideDome}
			}
			table.insert(g_MTSocialPotentialStories, MTDroneHack1)
			MTTeenagerJoyrideStorySent = true
			-- start hack day counter
			MTDroneHackDay = UICity.day
		end
	end
end

local function MTDroneHack2Story()
	if not MTDroneHack2StorySent and CountColonistsWithTrait("Youth") > 0 then
		local MTTeenager = MTGetColonistWithTrait("Youth")
		local MTDroneHack2Name = (MTTeenager and MTTeenager.name) or MTTeenagerColonistFallbackName
		local MTDroneHack2 = {
			title = T{MTText.StringIdBase + 232, "New Sport Established On Mars"},
			story = T{MTText.StringIdBase + 233, "     Our Earthling counterparts might have their Ski Jumping, but we here on Mars have our very own Drone Jumping. After hacking a few drones last night, lead by <MTDroneHack2Name>, several teenagers went joy riding in the dunes, eventually finding what has now been dubbed Marathon Hill as the site of Mars' very first Out-Dome sport: Drone Jumping.", MTDroneHack2Name = MTDroneHack2Name}
		}
		table.insert(g_MTSocialPotentialStories, MTDroneHack2)
		MTDroneHack2StorySent = true
	end
end

local function MTDroneHack3Story()
	if not MTDroneHack3StorySent and UICity.labels.SecurityStation ~= nil and UICity.labels.Colonist ~= nil then
		local MTColonist = table.rand(UICity.labels.Colonist)
		local MTDroneHack3Name =
			(MTColonist and MTColonist.name)
			or T{MTText.StringIdBase + 236, "random drone hacker"}
		local MTDroneHack3 = {
			title = T{MTText.StringIdBase + 234, "New Martian Law Enforced"},
			story = T{MTText.StringIdBase + 235, "     <MTDroneHack3Name> was brought in to the Security Station last night on charges of Unsanctioned Drone Use.  Under the new Martian Law it is now prohibited to hack into drones for personal use.  To make things worse, <MTDroneHack3Name> is alleged to have been siphoning off Rare Metals for personal gain.  Expect formal charges in the coming days.", MTDroneHack3Name = MTDroneHack3Name}
		}
		table.insert(g_MTSocialPotentialStories, MTDroneHack3)
		MTDroneHack3StorySent = true
	end
end

local function MTDroneHackCounter()
	local UICity = UICity
	if MTDroneHackDay > 0 then
		if not MTDroneHack2StoryInitiated and (UICity.day - MTDroneHackDay == 5) then  -- release DroneHack2 5 days after Joyride/   DroneHack1
			MTDroneHack2Story()
			MTDroneHack2StoryInitiated = true
		end
		if not MTDroneHack3StoryInitiated and (UICity.day - MTDroneHackDay == 20) then  -- release DroneHack3 20 days after Joyride/DroneHack1
			MTDroneHack3Story()
			MTDroneHack3StoryInitiated = true
		end
	end
end

-- triggered by OnMsg.NewDay()
local function MTRefuseHitsTheFanStory()
	if not MTRefuseHitsFanStorySent and UICity.labels.Diner ~= nil then
		local MTDiner = table.rand(UICity.labels.Diner)
		local MTRefuseHitsFanDinerDome =
			(MTDiner and MTDiner.parent_dome and MTDiner.parent_dome.name)
			or T{MTText.StringIdBase + 239, "dome with diner"}
		local MTRefuseHitsTheFan = {
			title = T{MTText.StringIdBase + 237, "The Refuse Hits The Fan"},
			story = T{MTText.StringIdBase + 238, "     Last night a sewage pump overflowed in <MTRefuseHitsFanDinerDome> when one of the pump's propellers broke under the pressure.  After what can only be described as a dining fiasco, last night's meal of extruded bean substitute seems to have played a critical role in overloading the sewage systems. There have been dozens of reports of a foul odor filling the dome even now.  Match usage is strictly prohibited until the blockage can be cleared.", MTRefuseHitsFanDinerDome = MTRefuseHitsFanDinerDome}
		}
		table.insert(g_MTSocialPotentialStories, MTRefuseHitsTheFan)
		MTRefuseHitsFanStorySent = true
	end
end

-- if a dome has an OpenAirGym...
local function MTOlympicBidStory()
	if not MTOlympicBidStorySent and UICity.labels.OpenAirGym ~= nil then
		local MTGym = table.rand(UICity.labels.OpenAirGym)
		local MTOlympicBidGymDome =
			(MTGym and MTGym.parent_dome and MTGym.parent_dome.name)
			or T{MTText.StringIdBase + 242, "dome with open air gym"}
		local MTOlympicBid = {
			title = T{MTText.StringIdBase + 240, "Olympic Bid Rejected"},
			story = T{MTText.StringIdBase + 241, "     After the opening of our new open-air gym in <MTOlympicBidGymDome>, <MTSponsor> applied to host the Olympics on Mars, saying, 'We have the best view of Mount Olympus and a Gym, what more could one ask for?' The International Olympics Committee on Earth rejected the proposal, saying 'Wait, that was an actual bid? You don't even have a pool.' <MTSponsor> responded by saying they will start their own Interstellar Olympics.  Expect track, blackjack, marbles, and Drone Jumping to headline the experience.", MTOlympicBidGymDome = MTOlympicBidGymDome, MTSponsor = MTSponsor}
		}
		table.insert(g_MTSocialPotentialStories, MTOlympicBid)
		MTOlympicBidStorySent = true
		MTMartianOlympicsWait = 1
	end
end

-- picks random colonist to target for Pet Rock story
-- triggered OnMsg.NewDay()
local function MTPetRockStory()
	if not MTPetRockStorySent and UICity.labels.Colonist ~= nil then  -- if we have colonists
		local MTPetRockColonist = table.rand(UICity.labels.Colonist)
		local MTPetRockColonistName =
			(MTPetRockColonist and MTPetRockColonist.name)
			or T{MTText.StringIdBase + 245, "Pet Rock Owner"}
		local MTPetRock = {
			title = T{MTText.StringIdBase + 243, "Struggling Colonist Adopts Pet"},
			story = T{MTText.StringIdBase + 244, "     <MTPetRockColonistName>, like most of us, has been struggling to cope with the harsh Martian environment.  On Earth, many of us had pets to help us through the difficult days, but there are no dogs on Mars, so <MTPetRockColonistName> decided to adopt a pet rock instead.  What did they name this newfound source of comfort and snuggles?  Why, Olympus Mons, of course!  Hopefully little Oly can help them through these tough times.", MTPetRockColonistName = MTPetRockColonistName}
		}
		table.insert(g_MTSocialPotentialStories, MTPetRock)
		MTPetRockStorySent = true
	end
end

local function MTLeaderDiedStory(MTDeadColonist)
	local MTDeadLeader =
		(MTDeadColonist and MTDeadColonist.name)
		or T{MTText.StringIdBase + 250, "dead leader"}
	local MTDeadLeaderRandom = Random(1,2)
	if MTDeadLeaderRandom == 1 then
		local MTLeaderDied1 = {
			title = T{MTText.StringIdBase + 246, "Mars is in Mourning"},
			story = T{MTText.StringIdBase + 247, "     Today is a solemn day.  <MTLeaderTitle> <MTDeadLeader> no longer walks the world of the living.  Martian society would not be what it is today without the indelible touch of <MTLeaderTitle> <MTDeadLeader> in so many places.  Please take a moment today to stop by your local spacebar and lift one up in honor of the late, great <MTLeaderTitle>.  What are your best memories of the now former <MTLeaderTitle>?  Send in your letters to the editor.  Select entries will be printed in Thursday's edition.  Thank you for your service, <MTDeadLeader>.  You will be missed.", MTLeaderTitle = MTLeaderTitle, MTDeadLeader = MTDeadLeader}
		}
		table.insert(g_MTTopPotentialStories, MTLeaderDied1)
	elseif MTDeadLeaderRandom == 2 then
		local MTLeaderDied2 = {
			title = T{MTText.StringIdBase + 248, "Mars Mourns <MTLeaderTitle>'s Passing", MTLeaderTitle = MTLeaderTitle},
			story = T{MTText.StringIdBase + 249, "     <MTLeaderTitle> <MTDeadLeader> served us honorably for many a sol and their passing has not gone unnoticed.  Despite serving Mars well during their tenure, it is suspected that they never quite fully adapted to the realities of life on Mars and between the stresses of daily Martian life, serving as our <MTLeaderTitle>, and many a sleepless night, a heart attack finally took them from us.  May your slumber, <MTLeaderTitle> <MTDeadLeader>, be deep and pleasant.  You will be missed.", MTLeaderTitle = MTLeaderTitle, MTDeadLeader = MTDeadLeader}
		}
		table.insert(g_MTTopPotentialStories, MTLeaderDied2)
	end
	MTNewLeaderChosenIndex = 0
end

-- 3 days after old leader dies, new leader gets a news story
local function MTNewLeaderChosenStoryRelease(MTNewLeaderChosenIndex)
	if MTNewLeaderChosenIndex ~= false and MTNewLeaderChosenIndex == 3 then
		local MTNewLeaderStoryRandom = Random(1,3)
		local MTLeaderName = MTGetLeaderName()
		if IsValid(MTLeaderColonist) and not MTLeaderColonist.is_pinned then
			MTLeaderColonist:TogglePin()
		end
		if MTNewLeaderStoryRandom == 1 then
			local MTNewLeaderStory1 = {
				title = T{MTText.StringIdBase + 251, "A New <MTLeaderTitle> Takes the Helm", MTLeaderTitle = MTLeaderTitle},
				story = T{MTText.StringIdBase + 252, "     As <MTLeader> steps in to assume the recently vacated role of <MTLeaderTitle>, we can hope that they get their bearings in short order.  We here at the Martian Tribune will keep you apprised of any decrees and movements of the <MTLeaderTitle>.  A new day is dawning here on Mars.  The question remains, however: is that a day of dawning, or a day of darkness.  Our fate is in your hands, <MTLeaderTitle>.  Don't let us down.", MTLeader = MTLeaderName, MTLeaderTitle = MTLeaderTitle}
			}
			table.insert(g_MTTopPotentialStories, MTNewLeaderStory1)
		elseif MTNewLeaderStoryRandom == 2 then
			local MTNewLeaderStory2 = {
				title = T{MTText.StringIdBase + 253, "<MTLeader> Breathes New Life Into Colony", MTLeader = MTLeaderName},
				story = T{MTText.StringIdBase + 254, "     A new <MTLeaderTitle> has been chosen!  It is time to rejoice, for my fellow Martians, the future is bright!  <MTLeader> steps in as our new <MTLeaderTitle> today and we could not be in better hands.  With <MTLeader>'s past work here on Mars, we can expect big plans to continue to balance out the workload and supply chain even further, as well as to care for the aging and nurture the young.  Today, the Martian Tribune declares: the future is bright.  It is time to celebrate!", MTLeaderTitle = MTLeaderTitle, MTLeader = MTLeaderName}
			}
			table.insert(g_MTTopPotentialStories, MTNewLeaderStory2)
		elseif MTNewLeaderStoryRandom == 3 then
			local MTNewLeaderStory3 = {
				title = T{MTText.StringIdBase + 255, "Wrong Sibling Elevated?"},
				story = T{MTText.StringIdBase + 256, "     As we move into a new era of Martian development, we here at the Martian Tribune can't help but wonder at the agenda of our sponsor, <MTSponsor>.  Perhaps someone mixed up their paperwork, but somehow they saw fit to raise <MTLeader> to the role of <MTLeaderTitle> without recognizing that more than one person shares that last name.  The responsibilities are vast in leading such an intrepid endeavor as ours here on Mars.  Let's hope and pray (hard) that <MTLeader> is up to the challenge.", MTSponsor = MTSponsor, MTLeader = MTLeaderName, MTLeaderTitle = MTLeaderTitle}
			}
			table.insert(g_MTTopPotentialStories, MTNewLeaderStory3)
		end
		MTNewLeaderChosenIndex = false
	end
end

-- comes from New Day, only if MTNewLeaderChosenIndex isn't nil
local function MTNewLeaderChosenStory()
	if MTNewLeaderChosenIndex ~= false then  -- index resets when new leader story is inserted
		MTNewLeaderChosenIndex = MTNewLeaderChosenIndex + 1
		MTNewLeaderChosenStoryRelease(MTNewLeaderChosenIndex)
	end
end

--- if these story remains in the table after humans have arrived, remove it
local function MTNoHumansStory()
	if not MTNoHumansStoryRemoved and MTColonistsHaveArrived then
		for k, v in pairs(g_MTTopPotentialStories) do
			if v.key == "NoHumans" then
				table.remove(g_MTTopPotentialStories, k)
				MTNoHumansStoryRemoved = true
				break
			end
		end
	end
end

-- prompted via OnMsg.NewDay()
local function MTTopCheckFinances()
	-- if less than 300m funding is available
	if not MTFinancesStorySent and ResourceOverviewObj:GetFunding() < 300000000 then
		local MTFinanceStoryRandom = Random(1,2)
		if MTFinanceStoryRandom == 1 then
			local MTFinances1 = {
				title = T{MTText.StringIdBase + 289, "Sponsor Funds Depleted"},
				story = T{MTText.StringIdBase + 290, "     <MTSponsor> has confirmed for the Martian Tribune that the rapidly spreading rumor that they are now broke with no money left to spare in support of the Martian endeavor is, in fact, true.  It is up to us, the people of mars to support ourselves.  Hopefully our local administrators will work to remedy the situation and prove our worth to our sponsor once more.", MTSponsor = MTSponsor}
			}
			table.insert(g_MTTopPotentialStories, MTFinances1)
		elseif MTFinanceStoryRandom == 2 then
			local MTFinances2 = {
				title = T{MTText.StringIdBase + 291, "Sponsor Cites Insider Trading Woes"},
				story = T{MTText.StringIdBase + 292, "     <MTSponsor> has gone belly-up in the face of a massive insider trading scheme that has taken down over half of their senior management.  Who knew that colonizing Mars could be such a politically, financially and socially fraught endeavor?  We did, <MTSponsor>.  We all did.  Shame on you.", MTSponsor = MTSponsor}
			}
			table.insert(g_MTTopPotentialStories, MTFinances2)
		end
		MTFinancesStorySent = true
	end
end

--  checks for current on-planet rocket count.  Determines release of MTrockets0 and MTRockets3
--  will check each day after Sol 10
local function MTRocketCount()
	if UICity.day > 10 then
		local MTCurrentSupplyRocketCount = CountObjects{class = "SupplyRocket"}
		if not MTrockets3StorySent and MTCurrentSupplyRocketCount > 2 then
			local MTrockets3 = {
				title = T{MTText.StringIdBase + 283, "Rocket Silhouettes Mar Martian Landscape"},
				story = T{MTText.StringIdBase + 284, "    With so many rockets planetside, one would think that we have more than enough to succeed and flourish, but all those resources are languishing in the hands of <MTLeaderTitle> <MTLeader>.  Perhaps it's time to fire up that Drone Assembler, a few more Fuel Refineries, and redistribute the workload.  If things remain as they are, who knows how much longer <MTLeaderTitle> <MTLeader> will remain in office...", MTLeaderTitle = MTLeaderTitle, MTLeader = MTGetLeaderName()}
			}
			table.insert(g_MTTopPotentialStories, MTrockets3)
			MTrockets3StorySent = true
		end
		if not MTrockets0StorySent and MTCurrentSupplyRocketCount == 0 then
			local MTrockets0 = {
				title = T{MTText.StringIdBase + 285, "<MTLeaderTitle> Sets High Standard", MTLeaderTitle = MTLeaderTitle},
				story = T{MTText.StringIdBase + 286, "    With the <MTLeaderTitle>'s efficient and effective use of Earth's resupply we are well on our way to gaining a strong foothold on the Red Planet.  This begs the question: are you doing your part? As we continue to develop our resources, and our culture, on this planet each one of us plays an integral role in leading us closer and closer to the safety and security that we need.  Follow <MTLeaderTitle> <MTLeader>'s example!  How can you become more efficient and effective today?  Let us know in your letter to the editor!  Select letters will be published in Saturday's edition.", MTLeaderTitle = MTLeaderTitle, MTLeader = MTGetLeaderName()}
			}
			table.insert(g_MTTopPotentialStories, MTrockets0)
			MTrockets0StorySent = true
		end
		if not MTRocketObservationStorySent and MTCurrentSupplyRocketCount > 1 then
			local MTRecentRocket = UICity.labels.SupplyRocket[MTCurrentSupplyRocketCount]
			local MTMostRecentRocket =
				(MTRecentRocket and MTRecentRocket.name)
				or T{MTText.StringIdBase + 259, "recent rocket"}
			local MTRocketObservation = {
				title = T{MTText.StringIdBase + 257, "Drones Watch In Awe"},
				story = T{MTText.StringIdBase + 258, "     All the Drones on Mars watch in amazement as the rocket <MTMostRecentRocket> lands safely on the surface. Kicking up storm of red dust, this rocket brings us even closer to the dream of a future of Martian civilisation.", MTMostRecentRocket = MTMostRecentRocket}
			}
			table.insert(g_MTEngPotentialStories, MTRocketObservation)
			MTRocketObservationStorySent = true
		end
	end
end

-- prompted via OnMsg.NewDay()  -- if Deep Scanning is researched and 2 or fewer sensor towers release story
local function MTCheckHackThePlanet()
	local UICity = UICity
	if UICity.tech_status["DeepScanning"].researched ~= nil
		and UICity.labels.Colonist ~= nil 
		and not MTHackThePlanetStoryRemoved
	then
		local numTowers = CountObjects{class = "SensorTower"}
		if not MTHackThePlanetStorySent and numTowers <= 2 then
				local MTHackThePlanet = {
					key = "HackThePlanet",
					title = T{MTText.StringIdBase + 287, "Hack the planet!"},
					story = T{MTText.StringIdBase + 288, "    Our primary manifesto as a society is to populate the Red Planet.  Someone should remind <MTLeaderTitle> <MTLeader> about that.  They seem to think that scanning the surface and finding suitable resources and dome locations serves no particular purpose.  Have you seen our metals supply lately?  This water isn't going to last forever, you know.  We need more Sensor Towers.  When will we learn from the past?  The time is now!  This planet is ours for the taking, but only if we know what's out there!", MTLeaderTitle = MTLeaderTitle, MTLeader = MTGetLeaderName()}
				}
				table.insert(g_MTTopPotentialStories, MTHackThePlanet)
				MTHackThePlanetStorySent = true
		elseif numTowers > 2 then
			-- if more than 2 sensor towers, then story is removed
			for k,story in pairs(g_MTTopPotentialStories) do
				if story.key == "HackThePlanet" then
					table.remove(g_MTTopPotentialStories, k)
					MTHackThePlanetStoryRemoved = true
					break
				end
			end
		end
	end
end

local function MTGetFoundersLegacyBuilding(MTFoundersDome)
	local MTFoundersDomeRelaxation = T{MTText.StringIdBase + 270, "your local park"}
	if IsValid(MTFoundersDome) then
		if MTFoundersDome.labels.Spacebar ~= nil then
			MTFoundersDomeRelaxation = T{MTText.StringIdBase + 263, "Spacebar"}
		elseif MTFoundersDome.labels.OpenAirGym ~= nil then
			MTFoundersDomeRelaxation = T{MTText.StringIdBase + 264, "Open Air Gym"}
		elseif MTFoundersDome.labels.GardenStone ~= nil then
			MTFoundersDomeRelaxation = T{MTText.StringIdBase + 265, "Stone Garden"}
		elseif MTFoundersDome.labels.FountainLarge ~= nil then
			MTFoundersDomeRelaxation = T{MTText.StringIdBase + 266, "Fountain"}
		elseif MTFoundersDome.labels.GardenNatural_Medium ~= nil then
			MTFoundersDomeRelaxation = T{MTText.StringIdBase + 267, "Natural Garden"}
		elseif MTFoundersDome.labels.Apartments ~= nil then
			MTFoundersDomeRelaxation = T{MTText.StringIdBase + 268, "Apartments"}
		elseif MTFoundersDome.labels.LivingQuarters ~= nil then
			MTFoundersDomeRelaxation = T{MTText.StringIdBase + 269, "Living Quarters"}
		end
	end
	return MTFoundersDomeRelaxation
end

local function MTFoundersLegacyRelease()
	if not MTFoundersLegacyStorySent then
		local MTFoundersMourningPeriod = UICity.day - MTFoundersDeadSol
		if MTFoundersMourningPeriod >= 10 and UICity.labels.Dome ~= nil then
			local MTDome = UICity.labels.Dome[1]
			local MTFoundersLegacyDome = (MTDome and MTDome.name) or T{MTText.StringIdBase + 262, "every dome"}
			local MTFoundersLegacyBuilding = MTGetFoundersLegacyBuilding(MTDome)
			local MTFounders = {
				title = T{MTText.StringIdBase + 260, "The Founder's Legacy"},
				story = T{MTText.StringIdBase + 261, "     There are only <MTFoundersCount> people who will ever be known as Founders.  These extraordinary men and women risked their lives to venture into the Final Frontier and gain a foothold on the Red Planet.  They toiled day and night, working non-stop to ensure constant and consistent air flow, water pressure, power generation, and more.  As we go about our sol we must remember to take a moment and honor those who came before us, those who made all that we see around us possible.  We will be celebrating Founder's Sol at noon tomorrow at the <MTFoundersLegacyBuilding> in <MTFoundersLegacyDome> where we will be taking <MTFoundersCount> minutes of silence in memory of these most excellent of individuals.", MTFoundersCount = MTFoundersCount, MTFoundersLegacyBuilding = MTFoundersLegacyBuilding, MTFoundersLegacyDome = MTFoundersLegacyDome}
			}
			table.insert(g_MTTopPotentialStories, MTFounders)
			MTFoundersLegacyStorySent = true
		end
	end
end

-- triggered by OnMsg.NewDay
local function MTCheckFoundersLegacy()
	if MTColonistsHaveArrived then
		if MTFoundersDeadSol == 0 and CountColonistsWithTrait("Founder") == 0 then
			-- all founders are now dead (note that with ProjectPhoenix, this may take centuries to occur)
			MTFoundersDeadSol = UICity.day
		elseif MTFoundersDeadSol > 0 then
			MTFoundersLegacyRelease()
		end
	end
end

local function MTCheckAdultFilm()
	if not MTAdultFilmStorySent and UICity.day > 20 and CountColonistsWithTrait("Sexy") > 2 then
		local MTSexyColonist = MTGetColonistWithTrait("Sexy")
		local MTSexyColonistName =
			(MTSexyColonist and MTSexyColonist.name)
			or T{MTText.StringIdBase + 273, "sexy colonist"}
		local MTAdultFilm = {
			title = T{MTText.StringIdBase + 271, "SpaceXXX"},
			story = T{MTText.StringIdBase + 272, "     In an unexpected turn of events, <MTSexyColonistName> has officially produced the first ever Martian adult film.  Starring 11 different colonists with <MTSexyColonistName> as the lead, it has become quite a hit on earth.  The film also provides a sneak peek into Martian pipe work and our stockpiles of electronics and machine parts in the background.  <MTSponsor> has declared themselves not responsible for the social implications of such actions, but did praise the artistic vision of the Director calling it a 'unique and innovative production'.", MTSexyColonistName = MTSexyColonistName, MTSponsor = MTSponsor}
		}
		table.insert(g_MTTopPotentialStories, MTAdultFilm)
		MTAdultFilmStorySent = true
	end
end

local function MTCheckDroneRights()
	if not MTDroneRightsStorySent and CountColonistsWithTrait("Idiot") > 0 then
		local MTIdiotColonist = MTGetColonistWithTrait("Idiot")
		local MTDroneColonistName =
			(MTIdiotColonist and MTIdiotColonist.name)
			or MTIdiotColonistFallbackName
		local MTDroneRights = {
			title = T{MTText.StringIdBase + 274, "Push For Drone Rights"},
			story = T{MTText.StringIdBase + 275, "     It has been reported that a local alliance of Martians believe that because so many drones are now integral to our daily lives they now deserve the same rights as colonists. <MTDroneColonistName>,  the leader of the self-dubbed Drone Alliance for Freedom and Transparency (DAFT) has stated that 'these drones do more work than all of the humans on mars combined' when asked if this meant drones should be able to vote as well <MTDroneColonistName> responded, 'what? no. That's ridiculous. they are machines...'", MTDroneColonistName = MTDroneColonistName}
		}
		table.insert(g_MTTopPotentialStories, MTDroneRights)
		MTDroneRightsStorySent = true
	end
end

-- Section 4: story table initialization and population

local function MTLoadStoriesIntoTables()
	---- These stories are all Top Stories.  If they are contingent on certain circumstances, they will be added to the g_MTTopPotentialStories when their conditions have been met.  Top Stories that have no conditions will automatically be added to g_MTTopFreeStories from the start.
	g_MTTopPotentialStories = {}
	g_MTTopFreeStories = {}
	g_MTTopArchive = {}
	g_MTEngPotentialStories = {}
	g_MTEngFreeStories = {}
	g_MTEngArchive = {}
	g_MTSocialPotentialStories = {}
	g_MTSocialFreeStories = {}
	g_MTSocialArchive = {}

	---- Begin section defining the tables for the conditional Top Stories

	local MTNoHumans = {
		key = "NoHumans",
		title = T{MTText.StringIdBase + 281, "01101101 01100101 00100000 01110011 01100001 01100100"},
		story = T{MTText.StringIdBase + 282, "    01000100 01110010 01101111 01101110 01100101 01110011 00100000 01101100 01101111 01101110 01100101 01101100 01111001 00101100 00100000 01100010 01110010 01101001 01101110 01100111 00100000 01101000 01110101 01101101 01100001 01101110 01110011 00100000 01110000 01101100 01100101 01100001 01110011 01100101 00101110"}
	}
	table.insert(g_MTTopPotentialStories, MTNoHumans)
	
-- These stories are all preset and without conditions.  They are intended to be a part of g_MTTopFreeStories{} from the very start and are our fall-backs in case we run out of contingent stories to declare.
	
	local MTWeAreMartian = {
		title = T{MTText.StringIdBase + 293, "We Are Martian"},
		story = T{MTText.StringIdBase + 294, "     This is our world now.  The world of rare metals, electronics and universal depots.  On Earth war is waged over economics, religion, and borders.  Here we fight for survival on a primal level.  We are the Martian people.  We will not give up.  We will not give in.  We will continue to build, continue to expand and populate this planet.  No meteor storm will stop us.  We are Martian."}
	}
	table.insert(g_MTTopFreeStories, MTWeAreMartian)
	
	local MTOnThisDayin1965 = {
		title = T{MTText.StringIdBase + 295, "On This Day in 1965"},
		story = T{MTText.StringIdBase + 296, "     On July 14th in 1965 Mariner 4 was sent to space by NASA took the first ever photos of the Martian surface.  Have you taken any photos that you're particularly proud of?  Share them today at r/SurvivingMars!"}
	}
	table.insert(g_MTTopFreeStories, MTOnThisDayin1965)
	
	local MTOnThisDayin1976 = {
		title = T{MTText.StringIdBase + 297, "On This Day in 1976"},
		story = T{MTText.StringIdBase + 298, "     On July 20th in 1976 Viking 1 pulled out the landing gear and set down on Martian soil for the first time in human history.  What we have come to accomplish in such few years since then is nothing less than incredible.  What an experience it is to actually set foot on Mars and to literally, walk among the stars!"}
	}
	table.insert(g_MTTopFreeStories, MTOnThisDayin1976)
		
	local MTOnThisDayin1997 = {
		title = T{MTText.StringIdBase + 299, "On This Day in 1997"},
		story = T{MTText.StringIdBase + 300, "     On July 4th in 1997 NASA set down the very first actual rover on the Red Planet.  Shortly after the Mars Pathfinder landed, Sojourner, a solar-powered rover, rolled out and began to scan the surface.  Expected to last just 7 sol, it was finally called to a stop after 91 sol having traveled a total of just over 100 meters and sent a myriad of photos back to Earth for study."}
	}
	table.insert(g_MTTopFreeStories, MTOnThisDayin1997)
		
	local MTOnThisDayin2015 = {
		title = T{MTText.StringIdBase + 301, "On This Day in 2015"},
		story = T{MTText.StringIdBase + 302, "     On September 28th in 2015 NASA announced that the Mars Reconnaissance Orbiter had officially encountered water flowing along the Martian surface.  While it might seem like a foregone conclusion to us today, such news at the time proved quite the breakthrough, leading NASA Administrator Bolden to declare that NASA 'is firmly on a journey to Mars.'"}
	}
	table.insert(g_MTTopFreeStories, MTOnThisDayin2015)

	local MTPoliticalAmbitions = {
		title = T{MTText.StringIdBase + 303, "Political Ambitions Set Too High?"},
		story = T{MTText.StringIdBase + 304, "     A politician on Earth has stated the obvious this week by claiming that Mars is red.  The hopeful senator took it a step further by declaring that Mars is a also a communist planet, with 'nothing but red, red, red'.  After performing some reconnissance here at the Martian Tribune Headquarters, we would like to confirm that Mars is indeed red.  The claims of communism getting a foothold, however, will have to be fielded by the <MTLeaderTitle>.", MTLeaderTitle = MTLeaderTitle}
	}
	table.insert(g_MTSocialFreeStories, MTPoliticalAmbitions)

	local MTISSSovereignty = {
		title = T{MTText.StringIdBase + 305, "ISS Declares Sovereignty"},
		story = T{MTText.StringIdBase + 306, "     The International Space Station orbiting Earth has recently declared itself a free, sovereign, and independent state, capable of enacting its own laws and governance. There was some opposition from many nations on earth. However once threats of crashing the mega structure into the planet reached Earth, many Earthlings rapidly changed their mind on the matter. Mars itself has become the first entity to recognize the independent state of the ISS and will be holding a press conference on the matter in the coming days."}
	}
	table.insert(g_MTEngFreeStories, MTISSSovereignty)

	local MTMarsCheese = {
		title = T{MTText.StringIdBase + 307, "US President Confirms: Not A Scientist"},
		story = T{MTText.StringIdBase + 308, "     The current President of the United States, after staring intently at several photos of the Red Planet, proceeded to ask his scientific advisors if Mars is actually made of cheese. The researchers reminded the president that Mars is mostly made of rock, and that it is, in fact, the Moon that is made of cheese."}
	}
	table.insert(g_MTSocialFreeStories, MTMarsCheese)

	local MTDroneToys = {
		title = T{MTText.StringIdBase + 309, "Drone Toy Sales Through The Roof"},
		story = T{MTText.StringIdBase + 310, "     With all of the photos and videos sent back to Earth, the demand for the miniature, remote controlled, toy replica of the standard martian drone has been much higher than anticipated. The toy broke first week sales records all across the globe. The remote controlled mini drone, which sells for just over 400 dollars each, has been sold out in most places. With the shortage, and with Christmas so soon, it's sad to say, but some children may be dissapointed this year."}
	}
	table.insert(g_MTSocialFreeStories, MTDroneToys)

	local MTMysteriousRadio = {
		title = T{MTText.StringIdBase + 311, "Mysterious Radio Station Causes Concern"},
		story = T{MTText.StringIdBase + 312, "     The martian planet is being entertained by the great hosts at Mars Radio One, among other stations, but what has the Martian Tribune concerned is that there are no facilities to broadcast a radio station here on Mars. Come to think of it, there are no facilities to make a newspaper either... let's just let that slide then."}
	}
	table.insert(g_MTSocialFreeStories, MTMysteriousRadio)

	local MTWoodys = {
		title = T{MTText.StringIdBase + 313, "Woody's Woods to Expand to Mars"},
		story = T{MTText.StringIdBase + 314, "     Woodys Woods, a tree-felling business of Cities Skylines fame, has decided to expand its operations to Mars. This decision has come as a surprise to many people, mainly because there are no trees on Mars.  When asked about this, Woody responded, 'I'm sure we'll find something to cut down!'"}
	}
	table.insert(g_MTEngFreeStories, MTWoodys)

	local MTDroneReverse = {
		title = T{MTText.StringIdBase + 315, "Drone Reverse Engineering"},
		story = T{MTText.StringIdBase + 316, "     After many days, drones have finaly completed their reverse engineering training and can now move both forwards and backwards. This advancement will be a huge help in traversing the un-even surface of Mars."}
	}
	table.insert(g_MTEngFreeStories, MTDroneReverse)

	local MTNuclearThreat = {
		title = T{MTText.StringIdBase + 317, "Former Peaceful Organization Threatens Nuclear War"},
		story = T{MTText.StringIdBase + 318, "     An organization formerly believed to be peaceful has been uncovered as a sleeper cell that is now threatening interstellar war.  The leader of this formerly benign oceanic  movement known as Norwegians for Underdeveloped Kelp Enrichment ('NUKE') has laid claim to a former lakebed near Mount Olympus and threatened nuclear annihilation upon any civilization that settles too close to their newly founded city."}
	}
	table.insert(g_MTSocialFreeStories, MTNuclearThreat)

	local MTVikingsFirst = {
		title = T{MTText.StringIdBase + 319, "Were We Really The First?"},
		story = T{MTText.StringIdBase + 320, "     Reports are coming in that <MTSponsor> may not, in fact, be the first to have arrived on Mars. It is stated that an ancient Viking ship was found near one of our scout's landing sites that contained manuscripts stating that 'the Blue Land has been conquered in the name of Ulfric the Great.' While no other evidence of this former civilzation has been found, it is a clear reminder: we are not alone.", MTSponsor = MTSponsor}
	}
	table.insert(g_MTTopFreeStories, MTVikingsFirst)

	local MTMacburgers = {
		title = T{MTText.StringIdBase + 321, "Macburgers expands to Mars"},
		story = T{MTText.StringIdBase + 322, "     The large multinational fast food chain, Macburgers, is seeking to become the first multiplanetary company in history, with plans put forward to open a restaurant on the red planet as soon as permits allow. There is strong opposition to the plan, even within the company, mainly due to the lack of money and meat on Mars."}
	}
	table.insert(g_MTSocialFreeStories, MTMacburgers)
end

-- Section 5: Core popup logic and story selection
-- Forward declare the local variable names so that the circular dependencies can be resolved.
local MTFrontPagePopup, MTTopArchivePopup, MTTopArchivePopup2,
MTEngPopup, MTEngArchivePopup, MTEngArchivePopup2,
MTSocialPopup, MTSocialArchivePopup, MTSocialArchivePopup2

--  main popup screen, accessed by clicking on the notification icon
--  the "pull" doesn't remove another story from the main story tables, but only accesses the story variable.  This distinction is done so that we only remove one story from the pool of potentials for each new edition.
MTFrontPagePopup = function()
	MTTopFPStory = MTGetTopStory()
	MTEngStory = MTGetEngStory()
	MTSocialStory = MTGetSocialStory()

	CreateRealTimeThread(function()
		local params = {  --MTEngHeadline = MTEngStory.title, MTSocialHeadline = MTSocialStory.title
			title = T{MTText.StringIdBase + 22, "The Martian Tribune:  Today's Headlines"},
			text = T{MTText.StringIdBase + 23, "Top Story:  <MTFrontPageStoryTitle> <newline><newline> <MTFrontPageStory><newline><newline><newline> Other Headlines:<newline>     Engineering Story:  <MTEngHeadline><newline>     Social Story:  <MTSocialHeadline><newline>", MTFrontPageStoryTitle = MTTopFPStory.title, MTFrontPageStory = MTTopFPStory.story, MTEngHeadline = MTEngStory.title, MTSocialHeadline = MTSocialStory.title}, -- Front Page text
			choice1 = T{MTText.StringIdBase + 24, "View Top Story Archives"},
			choice2 = T{MTText.StringIdBase + 25, "View Engineering Story"},
			choice3 = T{MTText.StringIdBase + 26, "View Social Story"},
			choice4 = T{MTText.StringIdBase + 27, "Close"},
			image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			MTArchiveIndex = #g_MTTopArchive  -- index starts at the most recent (probably current) story
			MTTopArchivePopup()  -- opens Top Story popup
		elseif choice == 2 then
			MTEngPopup()  -- opens Engineering popup
		elseif choice == 3 then
			MTSocialPopup()  -- opens Social popup
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end

-- there are 2 Archive Popup's per section.  This is so that we can easily rotate between them as we probe the archives for the next set of stories
MTTopArchivePopup = function()
	local MTTopArchive1 = MTGetTopArchives(MTArchiveIndex)
	local MTTopArchive2 = MTGetTopArchives(MTArchiveIndex - 1)
	if MTTopArchive1 == MTTopArchive2 then
		MTTopArchive2 = MTArchiveDepleted2
	end

	CreateRealTimeThread(function()
		local params = {
			title = T{MTText.StringIdBase + 28, "The Martian Tribune:  Top Story Archives"},
			text = T{MTText.StringIdBase + 29, "Recent Top Stories:  <newline><newline><MTTopArchive1Title> <newline><newline>     <MTTopArchive1Story><newline><newline><newline> <MTTopArchive2Title><newline><newline>     <MTTopArchive2Story><newline>", MTTopArchive1Title = MTTopArchive1.title, MTTopArchive1Story = MTTopArchive1.story, MTTopArchive2Title = MTTopArchive2.title, MTTopArchive2Story = MTTopArchive2.story}, -- Top Story Archives Text
			choice1 = T{MTText.StringIdBase + 30, "Flip to Next Page of Archived Top Stories"}, -- sends to MTTopArchivePopup2 which is identical
			choice2 = T{MTText.StringIdBase + 31, "Return to Front Page"},
			choice3 = T{MTText.StringIdBase + 27, "Close"},
			image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			local MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTTopArchivePopup2()  -- opens Top Story popup
		elseif choice == 2 then
			MTFrontPagePopup()
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end

MTTopArchivePopup2 = function()
	local MTTopArchive1 = MTGetTopArchives(MTArchiveIndex)
	local MTTopArchive2 = MTGetTopArchives(MTArchiveIndex - 1)
	if MTTopArchive1 == MTTopArchive2 then
		MTTopArchive2 = MTArchiveDepleted2
	end

	CreateRealTimeThread(function()
		local params = {
			title = T{MTText.StringIdBase + 28, "The Martian Tribune:  Top Story Archives"},
			text = T{MTText.StringIdBase + 29, "Recent Top Stories:  <newline><newline><MTTopArchive1Title> <newline><newline>     <MTTopArchive1Story><newline><newline><newline> <MTTopArchive2Title><newline><newline>     <MTTopArchive2Story><newline>", MTTopArchive1Title = MTTopArchive1.title, MTTopArchive1Story = MTTopArchive1.story, MTTopArchive2Title = MTTopArchive2.title, MTTopArchive2Story = MTTopArchive2.story}, -- Top Story Archives Text
			choice1 = T{MTText.StringIdBase + 30, "Flip to Next Page of Archived Top Stories"}, -- sends to MTTopArchivePopup which is identical
			choice2 = T{MTText.StringIdBase + 31, "Return to Front Page"},
			choice3 = T{MTText.StringIdBase + 27, "Close"},
			image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			local MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTTopArchivePopup()  -- opens Top Story popup
		elseif choice == 2 then
			MTFrontPagePopup()
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end

--  Engineering popup screen, accessed only via the FrontPagePopup
MTEngPopup = function()
	MTTopFPStory = MTGetTopStory()
	MTEngStory = MTGetEngStory()
	MTSocialStory = MTGetSocialStory()

	CreateRealTimeThread(function()
		local params = {  --MTSocialHeadline = MTSocialStory.title
			title = T{MTText.StringIdBase + 32, "The Martian Tribune:  Interstellar Engineering"},
			text = T{MTText.StringIdBase + 33, "Top Engineering Story:  <MTEngHeadlineTitle> <newline><newline> <MTEngHeadlineStory><newline><newline><newline> Other Headlines:<newline>     Front Page Story:  <MTFrontPageStoryTitle><newline>     Social Story:  <MTSocialHeadline><newline>", MTFrontPageStoryTitle = MTTopFPStory.title, MTFrontPageStory = MTTopFPStory.story, MTEngHeadlineTitle = MTEngStory.title, MTEngHeadlineStory = MTEngStory.story, MTSocialHeadline = MTSocialStory.title}, -- Eng popup text
			choice1 = T{MTText.StringIdBase + 34, "View Engineering Archives"},
			choice2 = T{MTText.StringIdBase + 35, "View Current Social Story"},
			choice3 = T{MTText.StringIdBase + 31, "Return to Front Page"},
			choice4 = T{MTText.StringIdBase + 27, "Close"},
			image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			MTArchiveIndex = #g_MTEngArchive  -- index starts at the most recent (probably current) story
			MTEngArchivePopup()  -- opens Engineering archive popup
		elseif choice == 2 then
			MTSocialPopup()  -- opens Social popup
		elseif choice == 3 then
			MTFrontPagePopup()  -- opens Top Story popup popup
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end

MTEngArchivePopup = function()
	local MTEngArchive1 = MTGetEngArchives(MTArchiveIndex)
	local MTEngArchive2 = MTGetEngArchives(MTArchiveIndex - 1)
	if MTEngArchive1 == MTEngArchive2 then
		MTEngArchive2 = MTArchiveDepleted2
	end

	CreateRealTimeThread(function()
		local params = {
			title = T{MTText.StringIdBase + 36, "The Martian Tribune:  Interstellar Engineering Archives"},
			text = T{MTText.StringIdBase + 37, "Recent Engineering Stories:   <newline><newline><MTEngArchive1Title> <newline><newline>     <MTEngArchive1Story><newline><newline><newline> <MTEngArchive2Title><newline><newline>     <MTEngArchive2Story><newline>", MTEngArchive1Title = MTEngArchive1.title, MTEngArchive1Story = MTEngArchive1.story, MTEngArchive2Title = MTEngArchive2.title, MTEngArchive2Story = MTEngArchive2.story}, -- eng Story Archives Text
			choice1 = T{MTText.StringIdBase + 38, "View Next Page of Engineering Archives"}, -- sends to MTEngArchivePopup2 which is identical, allowing for a continuous flip between popups
			choice2 = T{MTText.StringIdBase + 31, "Return to Front Page"},
			choice3 = T{MTText.StringIdBase + 27, "Close"},
			image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			local MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTEngArchivePopup2()  -- opens Top Story popup
		elseif choice == 2 then
			MTFrontPagePopup()
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end

MTEngArchivePopup2 = function()
	local MTEngArchive1 = MTGetEngArchives(MTArchiveIndex)
	local MTEngArchive2 = MTGetEngArchives(MTArchiveIndex - 1)
	if MTEngArchive1 == MTEngArchive2 then
		MTEngArchive2 = MTArchiveDepleted2
	end

	CreateRealTimeThread(function()
		local params = {
			title = T{MTText.StringIdBase + 36, "The Martian Tribune:  Interstellar Engineering Archives"},
			text = T{MTText.StringIdBase + 37, "Recent Engineering Stories:   <newline><newline><MTEngArchive1Title> <newline><newline>     <MTEngArchive1Story><newline><newline><newline> <MTEngArchive2Title><newline><newline>     <MTEngArchive2Story><newline>", MTEngArchive1Title = MTEngArchive1.title, MTEngArchive1Story = MTEngArchive1.story, MTEngArchive2Title = MTEngArchive2.title, MTEngArchive2Story = MTEngArchive2.story}, -- eng Story Archives Text
			choice1 = T{MTText.StringIdBase + 38, "View Next Page of Engineering Archives"}, -- sends to MTEngArchivePopup2 which is identical, allowing for a continuous flip between popups
			choice2 = T{MTText.StringIdBase + 31, "Return to Front Page"},
			choice3 = T{MTText.StringIdBase + 27, "Close"},
			image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			local MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTEngArchivePopup()  -- opens Top Story popup
		elseif choice == 2 then
			MTFrontPagePopup()
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end

MTSocialPopup = function()
	MTTopFPStory = MTGetTopStory()
	MTEngStory = MTGetEngStory()
	MTSocialStory = MTGetSocialStory()

	CreateRealTimeThread(function()
		local params = {
			title = T{MTText.StringIdBase + 39, "The Martian Tribune:  Red Planet Socialites Headlines"},
			text = T{MTText.StringIdBase + 40, "Top Social Story:  <MTSocialHeadline> <newline><newline> <MTSocialHeadlineStory><newline><newline><newline> Other Headlines:<newline>     Engineering Story:  <MTEngHeadlineTitle><newline>     Front Page Story:  <MTFrontPageStoryTitle><newline>", MTFrontPageStoryTitle = MTTopFPStory.title, MTEngHeadlineTitle = MTEngStory.title, MTSocialHeadlineStory = MTSocialStory.story, MTSocialHeadline = MTSocialStory.title}, -- Front Page text
			choice1 = T{MTText.StringIdBase + 41, "View Social Archives"},
			choice2 = T{MTText.StringIdBase + 42, "View Current Engineering Story"},
			choice3 = T{MTText.StringIdBase + 31, "Return to Front Page"},
			choice4 = T{MTText.StringIdBase + 27, "Close"},
			image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			MTArchiveIndex = #g_MTSocialArchive  -- index starts at the most recent (probably current) story
			MTSocialArchivePopup()  -- opens Top Story popup
		elseif choice == 2 then
			MTEngPopup()  -- opens Engineering popup
		elseif choice == 3 then
			MTFrontPagePopup()  -- opens Social popup
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end

MTSocialArchivePopup = function()
	local MTSocialArchive1 = MTGetSocialArchives(MTArchiveIndex)
	local MTSocialArchive2 = MTGetSocialArchives(MTArchiveIndex - 1)
	if MTSocialArchive1 == MTSocialArchive2 then
		MTSocialArchive2 = MTArchiveDepleted2
	end

	CreateRealTimeThread(function()
		local params = {
			title = T{MTText.StringIdBase + 43, "The Martian Tribune:  Red Planet Socialites Archives"},
			text = T{MTText.StringIdBase + 44, "Recent Social Stories:  <newline><newline><MTSocialArchive1Title> <newline><newline>     <MTSocialArchive1Story><newline><newline><newline> <MTSocialArchive2Title><newline><newline>     <MTSocialArchive2Story><newline>", MTSocialArchive1Title = MTSocialArchive1.title, MTSocialArchive1Story = MTSocialArchive1.story, MTSocialArchive2Title = MTSocialArchive2.title, MTSocialArchive2Story = MTSocialArchive2.story}, -- social Story Archives Text
			choice1 = T{MTText.StringIdBase + 45, "View Next Page of Social Archives"}, -- sends to MTSocialArchivePopup2 which is identical, allowing for a continuous flip between popups
			choice2 = T{MTText.StringIdBase + 31, "Return to Front Page"},
			choice3 = T{MTText.StringIdBase + 27, "Close"},
			image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			local MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTSocialArchivePopup2()  -- opens Top Story popup
		elseif choice == 2 then
			MTFrontPagePopup()
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end

MTSocialArchivePopup2 = function()
	local MTSocialArchive1 = MTGetSocialArchives(MTArchiveIndex)
	local MTSocialArchive2 = MTGetSocialArchives(MTArchiveIndex - 1)
	if MTSocialArchive1 == MTSocialArchive2 then
		MTSocialArchive2 = MTArchiveDepleted2
	end

	CreateRealTimeThread(function()
		local params = {
			title = T{MTText.StringIdBase + 43, "The Martian Tribune:  Red Planet Socialites Archives"},
			text = T{MTText.StringIdBase + 44, "Recent Social Stories:  <newline><newline><MTSocialArchive1Title> <newline><newline>     <MTSocialArchive1Story><newline><newline><newline> <MTSocialArchive2Title><newline><newline>     <MTSocialArchive2Story><newline>", MTSocialArchive1Title = MTSocialArchive1.title, MTSocialArchive1Story = MTSocialArchive1.story, MTSocialArchive2Title = MTSocialArchive2.title, MTSocialArchive2Story = MTSocialArchive2.story}, -- social Story Archives Text
			choice1 = T{MTText.StringIdBase + 45, "View Next Page of Social Archives"}, -- sends to MTSocialArchivePopup which is identical, allowing for a continuous flip between popups
			choice2 = T{MTText.StringIdBase + 31, "Return to Front Page"},
			choice3 = T{MTText.StringIdBase + 27, "Close"},
			image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			local MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTSocialArchivePopup()  -- opens social archive 1 popup
		elseif choice == 2 then
			MTFrontPagePopup()
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end

-- This is the Notification for a new release
local function MTNotification()
--  this_mod_dir stores the number of characters to walk back in order to get into the main mod directory
--  with the debug.getinfo(1, "S"), it's said that sometimes a 2 works, if the 1 does not
	local MTSol = UICity.day
	AddCustomOnScreenNotification("MartianTribune",
		T{MTText.StringIdBase + 1000, "The Martian Tribune"},
		T{MTText.StringIdBase + 1001, "Sol <MTSol> AMC", MTSol=MTSol},
		MT_mod_dir.."UI/MT_Notification_Icon.tga",  --  Here, we concatenate to import the custom notification icon
		MTFrontPagePopup,  -- this function gets called OnClick of this notification icon
		{MTSol = MTSol,
		expiration = 150000,
		priority = "Normal",}
	)
end

-- Populate the stories for this edition.
local function MTGetNewStories()
	MTSetTopStory()
	MTSetEngStory()
	MTSetSocialStory()
end

-- Check the list of possible stories for any new ones that should be added to the list of
-- potential stories to draw from for the next edition.
local function MTCheckStories()
	MTFoundersFirstWordsStory()
	MTRocketCount()
	MTTopCheckFinances()
	MTCheckHackThePlanet()
	MTCheckFoundersLegacy()
	MTCheckAdultFilm()
	MTCheckDroneRights()
	MTNewLeaderChosenStory()
	MTPetRockStory()
	MTOlympicBidStory()
	MTRefuseHitsTheFanStory()
	MTTeenagerJoyrideStory()
	MTDroneHackCounter()
	MTDomeDelay1Story()
	MTDomeDelay2StoryWait()
	MTVegan1Story()
	MTVeganPurgatory()
	MTVegan2Story()
	MTVegan3Story()
	MTVegan4Story()
	MTVeganDinerStory()
	MTRareMetalsComplaintStory()
	MTConcretePavingStory()
	MTHippieStory()
	MTMovingDomesStory()
	MTIdiotFMLStory()
	MTWatchWhatYouEatStory()
	MTConnoisseurStory()
	MTLeaderVices()
	MTReligiousArtifactStory()
	MTEqualityStory()
	MTPassportStory()
	MTMartianMusicStory()
	MTVigilanteStory()
	MTNewLanguageStory()
	MTSpyStory()
	MTDomelenolStory()
	MTMarsRealityTVStory()
	MTShortageStories()
	MTScratchingTheSurfaceStory()
	MTPewPewStory()
	MTOvalDomeUnnaturalStory()
	MTConcreteLoveStory()
	MTDroneGoesViralStory()
	MTAirSupplyStory()
	MTWaterSupplyStory()
	MTPowerSupplyStory()
	MTDroneShortageStory()
	MTCompactPassengerStory()
	MTDroneBreakdownStory()
	MTMarathonExplorerStory()
	MTElPresidenteStory()
	MTGuruGardenStory()
	MTMartianFaithStory()
	MTFightClub2()
	MTFightClubStory()
	MTMartianOlympicsStory()
	MTMarsDayStory()
end

-- Called by OnMsg.NewDay to check whether to release any new stories.
local function MTReleaseNewEdition()
	-- if (UICity.hour % 3 == 0) == true and MTNewStoryPushed ~= UICity.hour then
	if (UICity.day % 3 == 0) == true and MTNewStoryPushed < UICity.day then
		MTGetNewStories()  -- pushes new stories into the queue
		MTNotification()  -- loads primary mod notification
		MTNewStoryPushed = UICity.day  -- keeps this from triggering a 2nd time on the same day
	end
end

-- Called when loading a saved game, to resolve any issues between the game data and the
-- list of potential stories that can be shown. Used particularly when the mod is first
-- added to an already-existing save.
local function MTCheckStoriesToRemove()
	local UICity = UICity
	if UICity.tech_status["DeepScanning"].researched ~= nil then
		RemoveMTScratchingTheSurfaceStory()
	end
	if UICity.labels.Colonist ~= nil then
		RemoveMTDroneBreakdownStory()
	end
end


-- Section 6:  OnMsg functions
function OnMsg.ConstructionComplete(building)
	if building.encyclopedia_id == "MartianUniversity" then
		MTUniversityStory()
	elseif building.encyclopedia_id == "ShuttleHub" then
		MTShuttleHubStory()
	elseif building.encyclopedia_id == "Moxie" then
		MTMoxieMagicStory()
	elseif building.encyclopedia_id == "Arcology" then
		MTArcologyInuendoStory()
	end
end

function OnMsg.ColonistBorn(colonist, event)
	if colonist.traits.Celebrity then
		MTMartianCelebrityStory(colonist)
	end
	-- Just in case this could happen due to Project Phoenix...
	if colonist.traits.ColonyLeader then
		colonist:RemoveTrait("ColonyLeader")
	end
	MTFutureExpansionStory()
end

function OnMsg.ColonyApprovalPassed()
	MTColonyApproved = true
end

function OnMsg.ColonistArrived(colonist)
	if not MTColonistsHaveArrived then
		-- first founder getting off the rocket.
		MTFoundersCount = 0
	end
	-- Set arrived = true
	MTColonistsHaveArrived = true
	-- Increment count of founders landed (in case someone had researched larger passenger capacity before sending founders). Also stop counting once the Colony Approval stage is over, so that researching Project Phoenix doesn't result in a Founder Count of hundreds.
	if IsValid(colonist) and colonist.traits.Founder and not MTColonyApproved then
		local newCount = MTFoundersCount + 1
		MTFoundersCount = newCount
	end
	RemoveMTDroneBreakdownStory()
	MTElonMuskStory()
end

function OnMsg.ColonistDied(colonist, reason)
	local MTDeadColonist = colonist
	if IsValid(MTDeadColonist) and MTDeadColonist == MTLeaderColonist then
		MTLeaderDiedStory(MTDeadColonist)
		MTDeadColonist:RemoveTrait("ColonyLeader")
		MTLeaderColonist = false
		-- Trigger selection of a new leader
		MTGetLeaderName()
	end
	if MTDeadColonist.traits.Founder then
		MTFirstFounderDied(MTDeadColonist)
	end
	if MTDeadColonist.traits.Martianborn then
		MTFirstMartianbornDied(MTDeadColonist)
	end
	if not MTDeadColonist.traits.Founder then
		MTHappyBirthdayStory()
	end
	MTSoylentGreen()
end

function OnMsg.TechResearched(tech_id, city, first_time)
	if tech_id == "DeepScanning" then
		MTScratchingTheSurfaceStory("remove")
	elseif tech_id == "SoilAdaptation" then
		MTSoilAdaptationStory()
	elseif tech_id == "LowGFungi" then
		MTLowGFungiStory()
	elseif tech_id == "MagneticFiltering" then
		MTMagneticStory()
	elseif tech_id == "HygroscopicVaporators" then
		MTHygroscopicVaporatorsStory()
	elseif tech_id == "WaterReclamation" then
		MTWaterReclamationStory()
	elseif tech_id == "FuelCompression" then
		MTFuelCompressionStory()
	elseif tech_id == "DecommissionProtocol" then
		MTDecomissionStory()
	elseif tech_id == "LowGHydrosynthsis" then
		MTLowGHydroStory()
	end
end

-- every 2 hours a new edition gets pushed    Should be NewDay() on release, with editions every 3 days
-- function OnMsg.NewHour()
function OnMsg.NewDay()
	MTCheckStories()
	MTReleaseNewEdition()
end

function OnMsg.NewMapLoaded()
	SetupMissionSponsor()
	if not MTLeaderTitle then
		MTLeaderTitle = MTGetLeaderTitle(MTMissionSponsor.name)
	end
	MTUpdateLeaderTrait()
	if not g_MTTopPotentialStories then
		MTLoadStoriesIntoTables()
	end
end

function OnMsg.LoadGame(data)
	SetupMissionSponsor()
	-- If Leader Title is not already set, generate it.
	if not MTLeaderTitle then
		MTLeaderTitle = MTGetLeaderTitle(MTMissionSponsor.name)
	elseif type(MTLeaderTitle) ~= "userdata" then
		MTLeaderTitle = false
		MTLeaderTitle = MTGetLeaderTitle(MTMissionSponsor.name)
	end
	MTUpdateLeaderTrait()

	-- Check for any flags that should be set that haven't been
	if not MTColonistsHaveArrived and UICity.labels.Colonist ~= nil then
		MTColonistsHaveArrived = true
	end

	if not MTColonyApproved and UICity.labels.Colonist ~= nil and g_ColonyNotViableUntil < 0 then
		MTColonyApproved = true
	end

	if IsValid(MTLeaderColonist) then
		if not MTLeaderColonist.traits.ColonyLeader then
			MTLeaderColonist:AddTrait("ColonyLeader")
		end
	end

	-- If this is the first time this mod is used with the loaded game, the story tables will
	-- not have been created yet and g_MTTopPotentialStories will be false instead of a table.
	-- In that case, we need to initialize the story tables for the first time.
	if not g_MTTopPotentialStories then
		MTLoadStoriesIntoTables()
	end

	-- Check whether there are any stories that should have already been removed that haven't been, e.g. due to loading into an existing game.
	MTCheckStoriesToRemove()
end

-- Hook into the SetMalfunction call to send a custom message for a workplace breakdown
-- that can be used to identify when an Idiot has caused a malfunction.
local originalSetMalfunction = RequiresMaintenance.SetMalfunction
function RequiresMaintenance:SetMalfunction(...)
	-- Note: The original RequiresMaintenance:SetMalfunction function states that if
	-- self.maintenance_phase == false this is a direct call to break this building.
	-- So check that
	--   a) The building is one that needs maintenance (won't be broken if not)
	--   b) self.maintenance_phase == false (is a direct call to break this item)
	--   c) This item is a Workplace
	-- If all 3 conditions are met prior to running the original function, this is likely
	-- to be a breakdown due to an Idiot worker.
	local MTMayBeIdiotBreakdown = self:DoesRequireMaintenance() and self.maintenance_phase == false and self:IsKindOf("Workplace")

	-- Call the original function to actually *set* the maintenance requirements (we
	-- don't want to lose the original functionality)
	originalSetMalfunction(self, ...)

	-- Now check the workplace for an Idiot worker, and if found send a message we can
	-- listen for stating that an idiot broke the building.
	if MTMayBeIdiotBreakdown then
		local MTWorkers = MTGetWorkers(self)
		if MTWorkers ~= nil and #MTWorkers > 0 then
			local MTIdiotWorker = MTGetColonistWithTrait("Idiot", MTWorkers)
			if IsValid(MTIdiotWorker) then
				-- Treat this as a breakdown at workplace 'self' caused by MTIdiotWorker.
				Msg("MTIdiotWorkplaceBreakdown", self, MTIdiotWorker)
			end
		end
	end
end

function OnMsg.MTIdiotWorkplaceBreakdown(workplace, idiot)
	MTOopsIBrokeItAgainStory(workplace, idiot)
end
