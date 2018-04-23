-- script organization is as follows:
-- Section 1 = OnMsg functions to trigger various events and to change particular variables.  OnMsg.Newday() is the most important one
-- Section 2 = the core functioning logic that controls popups
-- Section 3 = functions designed to insert or remove stories to/from the various story tables
-- Section 4 = story table initialization and population

--  Section 1:  OnMsg functions
function OnMsg.NewMapLoaded()
	if g_MTTopPotentialStories == nil then
		MTInitializeStoryTables()
		MTLoadStoriesIntoTables()
	end
end

function OnMsg.NewDay()
	MTCheckStories()
end

function MTCheckStories()
	if g_MTTopPotentialStories == nil then
		MTInitializeStoryTables()
		MTLoadStoriesIntoTables()
	end
	MTRocketCount()
	MTTopCheckFinances()
	MTCheckHackThePlanet()
	MTCheckFoundersLegacy()
	MTCheckAdultFilm()
	MTCheckDroneRights()
	MTNewLeaderChosenStory("add")
	MTPetRockStory()
	MTOlympicBidStory()
	MTRefuseHitsTheFanStory()
	MTTeenagerJoyrideStory()
	MTDroneHackCounter("add")
	MTDomeDelay1Story()
	MTDomeDelay2StoryWait("add")
	MTVegan1Story()
	MTVeganPurgatory("add")
	MTVegan2Story()
	MTVegan3Story()
	MTVegan4Story()
	MTVeganDinerStory()
	MTRareMetalsComplaintStory()
	MTConcretePavingStory()
	MTHippieStory()
	MTOopsIBrokeItAgainStory()
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
	MTScratchingTheSurfaceStory("add")
	MTPewPewStory()
	MTOvalDomeUnnaturalStory()
	MTConcreteLoveStory()
	MTDroneGoesViralStory()
end

-- every 2 hours a new edition gets pushed    Should be NewDay() on release, with editions every 3 days
function OnMsg.NewHour()
--	lcPrint("newhour")
	if (UICity.hour % 2 == 0) == true then
		if MTNewStoryPushed ~= true then
			MTGetNewStories()  -- pushes new stories into the queue
			MTNotification()  -- loads primary mod notification
			MTNewStoryPushed = true  -- keeps this from triggering a 2nd time on the same day
		end
	else
		MTNewStoryPushed = nil  -- keeps stories/notification from being sent out after the 1st has gone
	end

end


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
	if MTColonistBorn == nil then
		MTColonistBorn = {}
	end
	MTColonistBorn = colonist
	if MTColonistBorn.traits.Celebrity then
		MTMartianCelebrityStory(MTColonistBorn)
		MTGetMartianCelebrityName(MTColonistBorn)
	end
end

function OnMsg.ColonistArrived()
	MTColonistsArrivedCheck("true")
end

function OnMsg.ColonistDied(colonist, reason)
	MTDeadColonist = colonist
	if MTDeadColonist ~= nil then
		if MTDeadColonist == MTLeaderColonist then
			MTLeaderDiedStory(MTDeadColonist)
			MTLeader = nil
			MTLeaderColonist = nil
			MTGetLeader()
		end
	end
	if MTDeadColonist.traits.Founder then
		MTFirstFounderDied(MTDeadColonist)
	end
	if MTDeadColonist.traits.Martianborn then
		MTFirstMartianbornDied(MTDeadColonist)
	end
	if MTDeadColonist.traits.Founder ~= true then
		MTHappyBirthdayStory()
	end
	MTSoylentGreen()
end

function OnMsg.TechResearched(tech_id, city, first_time)
	if tech_id == "DeepScanning" then
		MTScratchingTheSurfaceStory("remove")
	end
end

-- Section 2:  Core popup logic, story selection and core variable definitions (sponsors/leaders)
function MTNotification()
--  this_mod_dir stores the number of characters to walk back in order to get into the main mod directory
--  with the debug.getinfo(1, "S"), it's said that sometimes a 2 works, if the 1 does not
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	AddCustomOnScreenNotification("MartianTribune",
		T{"The Martian Tribune"},
		T{"Sol <MTSol> AMC"},
		MT_mod_dir.."UI/MT_Notification_Icon.tga",  --  Here, we concatenate to import the custom notification icon
		MTFrontPagePopup,  -- this function gets called OnClick of this notification icon
		{MTSol = UICity.day,
		expiration = 150000,
		priority = "Normal",}
	)
end

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

function MTGetSponsor(getsponsorname)
	MTSponsors = {}
	MTSponsors["IMM"] = "International Mars Mission"
	MTSponsors["BlueSun"] = "Blue Sun Corporation"
	MTSponsors["CSNA"] = "China"
	MTSponsors["ISRO"] = "India"
	MTSponsors["ESA"] = "Europe"
	MTSponsors["SpaceY"] = "SpaceY"
	MTSponsors["NewArk"] = "Church of the New Ark"
	MTSponsors["Roscosmos"] = "Russia"
	MTSponsors["paradox"] = "Paradox"
	MTSponsors["stargatecommand"] = "Stargate Command"
	MTSponsors["Trinova"] = "Trinova"
	if MTSponsors[getsponsorname] == nil then
		return "Mission Sponsor"
	else
		return MTSponsors[getsponsorname]
	end
end
		
function MTGetLeaderTitle(sponsorname)
	if MTLeaderTitle == nil then
		MTtitles = {}
		MTtitles["IMM"] = "CEO"
		MTtitles["BlueSun"] = "CFO"
		MTtitles["CSNA"] = "President"
		MTtitles["ISRO"] = "Prime Minister"
		MTtitles["ESA"] = "President"
		MTtitles["SpaceY"] = "Chairman"
		MTtitles["NewArk"] = "Oracle"
		MTtitles["Roscosmos"] = "President"
		MTtitles["paradox"] = "CFO"
		MTtitles["stargatecommand"] = "Major General"
		MTtitles["Trinova"] = "COO"
		if name == "IMM" or name == "BlueSun" or name == "SpaceY" or name == "paradox" then
			MTBusinessTitleRandom = Random(1,3)  -- randomize these corps to get one of the 3 following leader types
			if MTBusinessTitleRandom == 1 then
				MTNewLeaderTitle = "Chairman"
			elseif MTBusinessTitleRandom == 2 then
				MTNewLeaderTitle = "CFO"
			elseif MTBusinessTitleRandom == 3 then
				MTNewLeaderTitle = "CEO"
			end
		return MTNewLeaderTitle  -- if one of the above 4, randomly pick one of the 3 and return that
		elseif MTtitles[name] == nil then
			MTNewLeaderTitle = "President"  -- if unaccounted for, they get a "President"
		return MTNewLeaderTitle
		else
		return MTtitles[name] -- if it wasn't those 4, and wasn't unaccounted for, then return the name provided
		end
	else
		return MTLeaderTitle
	end
end

function MTGetLeader()
	if MTLeader == nil or MTLeader == "Silent Leader" then  -- this only happens on New Game or when current leader dies
		MTGetLeaderTable = MTLeaderSetTraitSearch()  -- which rare traits are in the colony?
		MTLeaderColonist = {}
		MTGetLeaderTableRandom = 0
		if (#MTGetLeaderTable > 0) then  -- pick a trait to single out
			MTGetLeaderTableRandom = Random(1, #MTGetLeaderTable)
			MTGetLeaderTrait = MTGetLeaderTable[MTGetLeaderTableRandom]
			for k, colonist in ipairs (UICity.labels.Colonist) do
				if colonist.traits[MTGetLeaderTrait] then
					MTLeaderColonist = colonist  -- colonist with said trait is chosen
					MTLeader = MTLeaderColonist.name
					break
				end
			end
		else
			if UICity.labels.Colonist ~= nil then
				MTGetLeaderTableRandom = Random(1,#UICity.labels.Colonist)  -- if none with rare traits,
				MTLeaderColonist = UICity.labels.Colonist[MTGetLeaderTableRandom] -- random colonist is chosen
				MTLeader = MTLeaderColonist.name
			else
				MTLeader = "Silent Leader"
			end
		end
	end  -- if we have a leader already chosen and alive, then they stay leader
	return MTLeader
end

function MTLeaderSetTraitSearch()  -- populates table with rare traits that are present
	if MTGetLeaderTable == nil then
		MTGetLeaderTable = {}
	end
	if (CountColonistsWithTrait("Genius") > 0) then  
		table.insert(MTGetLeaderTable, "Genius")
	end
	if (CountColonistsWithTrait("Celebrity") > 0) then
		table.insert(MTGetLeaderTable, "Celebrity")
	end
	if (CountColonistsWithTrait("Empath") > 0) then
		table.insert(MTGetLeaderTable, "Empath")
	end
	if (CountColonistsWithTrait("Guru") > 0) then
		table.insert(MTGetLeaderTable, "Guru")
	end
	if (CountColonistsWithTrait("Saint") > 0) then
		table.insert(MTGetLeaderTable, "Saint")
	end
	return MTGetLeaderTable
end

function MTGetNewStories()  -- on "push", these functions pull a new story from the 3 main story tables (g_MTTopPotentialStories, etc).  The "pull" is done in the popups.
--	lcPrint("MTGetNewStories")
	MTSetTopStory("push")
	MTSetEngStory("push")
	MTSetSocialStory("push")
end

--  main popup screen, accessed by clicking on the notification icon
--  the "pull" doesn't remove another story from the main story tables, but only accesses the story variable.  This distinction is done so that we only remove one story from the pool of potentials for each new edition.
function MTFrontPagePopup()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTTopFPStory = MTSetTopStory("pull")
	MTEngStory = MTSetEngStory("pull")
	MTSocialStory = MTSetSocialStory("pull")
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)  -- redefining all text variables to insure proper insertion
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTFoundersLegacyDome = MTGetFoundersLegacyDome("check")
	MTFoundersLegacyBuilding = MTGetFoundersLegacyBuilding("check")
	MTSexyColonistName = MTGetSexyColonist("check")
	MTDroneColonistName = MTGetIdiotColonist("check")
	MTDeadLeader = MTLeaderDiedNameCheck()
	MTPetRockColonistName = MTGetPetRockColonist("check")
	MTRandomColonistName = MTGetRandomColonist("name")
	MTDeadMartianName = MTGetDeadMartian("check")
	MTDomeWithoutO2 = MTGetDomeWithoutO2("check")

	CreateRealTimeThread(function()
        params = {  --MTEngHeadline = MTEngStory.title, MTSocialHeadline = MTSocialStory.title
			title = T{"The Martian Tribune:  Today's Headlines"},
            text = T{"Top Story:  <MTFrontPageStoryTitle> <newline><newline> <MTFrontPageStory><newline><newline><newline> Other Headlines:<newline>     Engineering Story:  <MTEngHeadline><newline>     Social Story:  <MTSocialHeadline><newline>", MTFrontPageStoryTitle = MTTopFPStory.title, MTFrontPageStory = MTTopFPStory.story, MTEngHeadline = MTEngStory.title, MTSocialHeadline = MTSocialStory.title, MTLeaderTitle, MTLeader, MTSponsor, MTFoundersLegacyBuilding, MTFoundersLegacyDome, MTSexyColonistName, MTDroneColonistName, MTDeadLeader, MTPetRockColonistName, MTRandomColonistName, MTDeadMartianName, MTDomeWithoutO2}, -- Front Page text
            choice1 = T{"View Top Story Archives"},
            choice2 = T{"View Engineering Story"},
			choice3 = T{"View Social Story"},
			choice4 = T{"Close"},
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
function MTTopArchivePopup()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTTopArchive1 = MTGetTopArchives(MTArchiveIndex)
	MTTopArchive2 = MTGetTopArchives(MTArchiveIndex - 1)
	if MTTopArchive1 == MTTopArchive2 then
		MTTopArchive2 = MTArchiveDepleted2
	end
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTFoundersLegacyDome = MTGetFoundersLegacyDome("check")
	MTFoundersLegacyBuilding = MTGetFoundersLegacyBuilding("check")
	MTSexyColonistName = MTGetSexyColonist("check")
	MTDroneColonistName = MTGetIdiotColonist("check")
	MTDeadLeader = MTLeaderDiedNameCheck()
	MTRandomColonistName = MTGetRandomColonist("name")
	MTDeadMartianName = MTGetDeadMartian("check")

	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Top Story Archives"},
            text = T{"Recent Top Stories:  <newline><newline><MTTopArchive1Title> <newline><newline>     <MTTopArchive1Story><newline><newline><newline> <MTTopArchive2Title><newline><newline>     <MTTopArchive2Story><newline>", MTTopArchive1Title = MTTopArchive1.title, MTTopArchive1Story = MTTopArchive1.story, MTTopArchive2Title = MTTopArchive2.title, MTTopArchive2Story = MTTopArchive2.story, MTLeaderTitle, MTLeader, MTSponsor, MTFoundersLegacyDome, MTFoundersLegacyBuilding, MTSexyColonistName, MTDroneColonistName, MTDeadLeader, MTRandomColonistName, MTDeadMartianName}, -- Top Story Archives Text
            choice1 = T{"Flip to Next Page of Archived Top Stories"}, -- sends to MTTopArchivePopup2 which is identical
            choice2 = T{"Return to Front Page"},
			choice3 = T{"Close"},
            image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
        } -- params
        local choice = WaitPopupNotification(false, params)
        if choice == 1 then
			MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTTopArchivePopup2()  -- opens Top Story popup
		elseif choice == 2 then
			MTFrontPagePopup()
        end -- if statement
    end ) -- end CreateRealTimeThread
end -- function end

function MTTopArchivePopup2()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTTopArchive1 = MTGetTopArchives(MTArchiveIndex)
	MTTopArchive2 = MTGetTopArchives(MTArchiveIndex - 1)
	if MTTopArchive1 == MTTopArchive2 then
		MTTopArchive2 = MTArchiveDepleted2
	end
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTFoundersLegacyDome = MTGetFoundersLegacyDome("check")
	MTFoundersLegacyBuilding = MTGetFoundersLegacyBuilding("check")
	MTSexyColonistName = MTGetSexyColonist("check")
	MTDroneColonistName = MTGetIdiotColonist("check")
	MTDeadLeader = MTLeaderDiedNameCheck()
	MTRandomColonistName = MTGetRandomColonist("name")
	MTDeadMartianName = MTGetDeadMartian("check")

	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Top Story Archives"},
            text = T{"Recent Top Stories:  <newline><newline><MTTopArchive1Title> <newline><newline>     <MTTopArchive1Story><newline><newline><newline> <MTTopArchive2Title><newline><newline>     <MTTopArchive2Story><newline>", MTTopArchive1Title = MTTopArchive1.title, MTTopArchive1Story = MTTopArchive1.story, MTTopArchive2Title = MTTopArchive2.title, MTTopArchive2Story = MTTopArchive2.story, MTLeaderTitle, MTLeader, MTSponsor, MTFoundersLegacyDome, MTFoundersLegacyBuilding, MTSexyColonistName, MTDroneColonistName, MTDeadLeader, MTRandomColonistName, MTDeadMartianName}, -- Top Story Archives Text
            choice1 = T{"Flip to Next Page of Archived Top Stories"}, -- sends to MTTopArchivePopup which is identical
            choice2 = T{"Return to Front Page"},
			choice3 = T{"Close"},
            image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
        } -- params
        local choice = WaitPopupNotification(false, params)
        if choice == 1 then
			MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTTopArchivePopup()  -- opens Top Story popup
		elseif choice == 2 then
			MTFrontPagePopup()
        end -- if statement
    end ) -- end CreateRealTimeThread
end -- function end

--  Engineering popup screen, accessed only via the FrontPagePopup
function MTEngPopup()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTTopFPStory = MTSetTopStory("pull")
	MTEngStory = MTSetEngStory("pull")
	MTSocialStory = MTSetSocialStory("pull")
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)  -- redefining all text variables to insure proper insertion
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTSexyColonistName = MTGetSexyColonist("check")
	MTDroneColonistName = MTGetIdiotColonist("check")
	MTDeadLeader = MTLeaderDiedNameCheck()
	MTIdiotWorkplace = MTGetIdiotWorkplace("check")
	MTIdiotName = MTGetIdiotColonist("check")
	MTRandomColonistName = MTGetRandomColonist("name")
	MTDomeWithoutO2 = MTGetDomeWithoutO2("check")
	MTDrone1 = MTGetRandomDrone()
	MTDrone2 = MTGetRandomDrone()
	MTArcologyDomeName = MTGetArcologyDome("check")
	MTMostRecentRocket = MTGetMostRecentRocket()

	CreateRealTimeThread(function()
        params = {  --MTSocialHeadline = MTSocialStory.title
			title = T{"The Martian Tribune:  Interstellar Engineering"},
            text = T{"Top Engineering Story:  <MTEngHeadlineTitle> <newline><newline> <MTEngHeadlineStory><newline><newline><newline> Other Headlines:<newline>     Front Page Story:  <MTFrontPageStoryTitle><newline>     Social Story:  <MTSocialHeadline><newline>", MTFrontPageStoryTitle = MTTopFPStory.title, MTFrontPageStory = MTTopFPStory.story, MTEngHeadlineTitle = MTEngStory.title, MTEngHeadlineStory = MTEngStory.story, MTSocialHeadline = MTSocialStory.title, MTLeaderTitle, MTLeader, MTSponsor, MTSexyColonistName, MTDroneColonistName, MTDeadLeader, MTIdiotWorkplace, MTIdiotName, MTRandomColonistName, MTDomeWithoutO2, MTDrone1, MTDrone2, MTArcologyDomeName, MTMostRecentRocket}, -- Eng popup text
            choice1 = T{"View Engineering Archives"},
            choice2 = T{"View Current Social Story"},
			choice3 = T{"Return to Front Page"},
			choice4 = T{"Close"},
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

function MTEngArchivePopup()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTEngArchive1 = MTGetEngArchives(MTArchiveIndex)
	MTEngArchive2 = MTGetEngArchives(MTArchiveIndex - 1)
	if MTEngArchive1 == MTEngArchive2 then
		MTEngArchive2 = MTArchiveDepleted2
	end
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTIdiotWorkplace = MTGetIdiotWorkplace("check")
	MTIdiotName = MTGetIdiotColonist("check")
	MTRandomColonistName = MTGetRandomColonist("name")
	MTDomeWithoutO2 = MTGetDomeWithoutO2("check")
	MTDrone1 = MTGetRandomDrone()
	MTDrone2 = MTGetRandomDrone()
	MTArcologyDomeName = MTGetArcologyDome("check")
	MTMostRecentRocket = MTGetMostRecentRocket()

	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Interstellar Engineering Archives"},
            text = T{"Recent Engineering Stories:   <newline><newline><MTEngArchive1Title> <newline><newline>     <MTEngArchive1Story><newline><newline><newline> <MTEngArchive2Title><newline><newline>     <MTEngArchive2Story><newline>", MTEngArchive1Title = MTEngArchive1.title, MTEngArchive1Story = MTEngArchive1.story, MTEngArchive2Title = MTEngArchive2.title, MTEngArchive2Story = MTEngArchive2.story, MTLeaderTitle, MTLeader, MTSponsor, MTIdiotWorkplace, MTIdiotName, MTRandomColonistName, MTDomeWithoutO2, MTDrone1, MTDrone2, MTArcologyDomeName, MTMostRecentRocket}, -- eng Story Archives Text
            choice1 = T{"View Next Page of Engineering Archives"}, -- sends to MTEngArchivePopup2 which is identical, allowing for a continuous flip between popups
            choice2 = T{"Return to Front Page"},
			choice3 = T{"Close"},
            image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
        } -- params
        local choice = WaitPopupNotification(false, params)
        if choice == 1 then
			MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTEngArchivePopup2()  -- opens Top Story popup
		elseif choice == 2 then
			MTFrontPagePopup()
        end -- if statement
    end ) -- end CreateRealTimeThread
end -- function end

function MTEngArchivePopup2()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTEngArchive1 = MTGetEngArchives(MTArchiveIndex)
	MTEngArchive2 = MTGetEngArchives(MTArchiveIndex - 1)
	if MTEngArchive1 == MTEngArchive2 then
		MTEngArchive2 = MTArchiveDepleted2
	end
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTIdiotWorkplace = MTGetIdiotWorkplace("check")
	MTIdiotName = MTGetIdiotColonist("check")
	MTRandomColonistName = MTGetRandomColonist("name")
	MTDomeWithoutO2 = MTGetDomeWithoutO2("check")
	MTDrone1 = MTGetRandomDrone()
	MTDrone2 = MTGetRandomDrone()
	MTArcologyDomeName = MTGetArcologyDome("check")
	MTMostRecentRocket = MTGetMostRecentRocket()

	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Interstellar Engineering Archives"},
            text = T{"Recent Engineering Stories:   <newline><newline><MTEngArchive1Title> <newline><newline>     <MTEngArchive1Story><newline><newline><newline> <MTEngArchive2Title><newline><newline>     <MTEngArchive2Story><newline>", MTEngArchive1Title = MTEngArchive1.title, MTEngArchive1Story = MTEngArchive1.story, MTEngArchive2Title = MTEngArchive2.title, MTEngArchive2Story = MTEngArchive2.story, MTLeaderTitle, MTLeader, MTSponsor, MTIdiotWorkplace, MTIdiotName, MTRandomColonistName, MTDomeWithoutO2, MTDrone1, MTDrone2, MTArcologyDomeName, MTMostRecentRocket}, -- eng Story Archives Text
            choice1 = T{"View Next Page of Engineering Archives"}, -- sends to MTEngArchivePopup2 which is identical, allowing for a continuous flip between popups
            choice2 = T{"Return to Front Page"},
			choice3 = T{"Close"},
            image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
        } -- params
        local choice = WaitPopupNotification(false, params)
        if choice == 1 then
			MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTEngArchivePopup()  -- opens Top Story popup
		elseif choice == 2 then
			MTFrontPagePopup()
        end -- if statement
    end ) -- end CreateRealTimeThread
end -- function end

function MTSocialPopup()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTTopFPStory = MTSetTopStory("pull")
	MTEngStory = MTSetEngStory("pull")
	MTSocialStory = MTSetSocialStory("pull")
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)  -- redefining all text variables to insure proper insertion
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTSexyColonistName = MTGetSexyColonist("check")
	MTDroneColonistName = MTGetIdiotColonist("check")
	MTDeadLeader = MTLeaderDiedNameCheck()
	MTPetRockColonistName = MTGetPetRockColonist("check")
	MTOlympicBidGymDome = MTGetOlympicBidGymDome()
	MTRefuseHitsFanDinerDome = MTGetRefuseHitsTheFanDinerDome()
	MTTeenagerJoyrideName = MTGetTeenagerJoyrideName("check")
	MTTeenagerJoyrideDome = MTGetTeenagerJoyrideDome("check")
	MTDroneHack2Name = MTGetTeenagerJoyrideName("check")
	MTDroneHack3Name = MTGetDroneHack3Name("check")
	MTEarthlingDelayName = MTGetEarthlingDelayName("set")
	MTVeganDinerName = MTGetVeganDinerName("check")
	MTVeganDinerDome = MTGetVeganDinerDome()
	MTConcreteName = MTGetConcreteColonist("check")
	MTRareMetalsColonist = MTGetRareMetalsColonist("check")
	MTRareMetalsDome = MTGetRareMetalsDome("check")
	MTMovingDome1 = MTGetMovingDomes("1")
	MTMovingDome2 = MTGetMovingDomes("2")
	MTHippieName = MTGetHippie("check")
	MTDeadFounder = MTGetDeadFounder()
	MTMartianCelebrityName = MTGetMartianCelebrityName("check")
	MTRandomColonistName = MTGetRandomColonist("name")
	MTBirthdayName = MTGetBirthdayName("check")
	MTSaint = MTReligiousSaint("check")
	MTCelebrity = MTGetCelebrity("check")
	MTDomeWithoutO2 = MTGetDomeWithoutO2("check")

	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Red Planet Socialites Headlines"},
            text = T{"Top Social Story:  <MTSocialHeadline> <newline><newline> <MTSocialHeadlineStory><newline><newline><newline> Other Headlines:<newline>     Engineering Story:  <MTEngHeadlineTitle><newline>     Front Page Story:  <MTFrontPageStoryTitle><newline>", MTFrontPageStoryTitle = MTTopFPStory.title, MTEngHeadlineTitle = MTEngStory.title, MTSocialHeadlineStory = MTSocialStory.story, MTSocialHeadline = MTSocialStory.title, MTLeaderTitle, MTLeader, MTSponsor, MTSexyColonistName, MTDroneColonistName, MTDeadLeader, MTPetRockColonistName, MTOlympicBidGymDome, MTRefuseHitsFanDinerDome, MTTeenagerJoyrideName, MTTeenagerJoyrideDome, MTDroneHack2Name, MTDroneHack3Name, MTEarthlingDelayName, MTVeganDinerName, MTVeganDinerDome, MTConcreteName, MTRareMetalsColonist, MTRareMetalsDome, MTMovingDome1, MTMovingDome2, MTHippieName, MTDeadFounder, MTMartianCelebrityName, MTRandomColonistName, MTBirthdayName, MTSaint, MTCelebrity, MTDomeWithoutO2}, -- Front Page text
            choice1 = T{"View Social Archives"},
            choice2 = T{"View Current Engineering Story"},
			choice3 = T{"Return to Front Page"},
			choice4 = T{"Close"},
            image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
        } -- params
        local choice = WaitPopupNotification(false, params)
        if choice == 1 then
			MTArchiveIndex = #g_MTTopArchive  -- index starts at the most recent (probably current) story
			MTSocialArchivePopup()  -- opens Top Story popup
		elseif choice == 2 then
			MTEngPopup()  -- opens Engineering popup
		elseif choice == 3 then
			MTFrontPagePopup()  -- opens Social popup
        end -- if statement
    end ) -- end CreateRealTimeThread
end -- function end

function MTSocialArchivePopup()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTSocialArchive1 = MTGetSocialArchives(MTArchiveIndex)
	MTSocialArchive2 = MTGetSocialArchives(MTArchiveIndex - 1)
	if MTSocialArchive1 == MTSocialArchive2 then
		MTSocialArchive2 = MTArchiveDepleted2
	end
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTPetRockColonistName = MTGetPetRockColonist("check")
	MTOlympicBidGymDome = MTGetOlympicBidGymDome()
	MTRefuseHitsFanDinerDome = MTGetRefuseHitsTheFanDinerDome()
	MTTeenagerJoyrideName = MTGetTeenagerJoyrideName("check")
	MTTeenagerJoyrideDome = MTGetTeenagerJoyrideDome("check")
	MTDroneHack2Name = MTGetTeenagerJoyrideName("check")
	MTDroneHack3Name = MTGetDroneHack3Name("check")
	MTEarthlingDelayName = MTGetEarthlingDelayName("set")
	MTVeganDinerName = MTGetVeganDinerName("check")
	MTVeganDinerDome = MTGetVeganDinerDome()
	MTConcreteName = MTGetConcreteColonist("check")
	MTRareMetalsColonist = MTGetRareMetalsColonist("check")
	MTRareMetalsDome = MTGetRareMetalsDome("check")
	MTMovingDome1 = MTGetMovingDomes("1")
	MTMovingDome2 = MTGetMovingDomes("2")
	MTHippieName = MTGetHippie("check")
	MTDeadFounder = MTGetDeadFounder()
	MTMartianCelebrityName = MTGetMartianCelebrityName("check")
	MTRandomColonistName = MTGetRandomColonist("name")
	MTBirthdayName = MTGetBirthdayName("check")
	MTSaint = MTReligiousSaint("check")
	MTCelebrity = MTGetCelebrity("check")

	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Red Planet Socialites Archives"},
            text = T{"Recent Social Stories:  <newline><newline><MTSocialArchive1Title> <newline><newline>     <MTSocialArchive1Story><newline><newline><newline> <MTSocialArchive2Title><newline><newline>     <MTSocialArchive2Story><newline>", MTSocialArchive1Title = MTSocialArchive1.title, MTSocialArchive1Story = MTSocialArchive1.story, MTSocialArchive2Title = MTSocialArchive2.title, MTSocialArchive2Story = MTSocialArchive2.story, MTLeaderTitle, MTLeader, MTSponsor, MTPetRockColonistName, MTOlympicBidGymDome, MTRefuseHitsFanDinerDome, MTTeenagerJoyrideName, MTTeenagerJoyrideDome, MTDroneHack2Name, MTDroneHack3Name, MTEarthlingDelayName, MTVeganDinerName, MTVeganDinerDome, MTConcreteName, MTRareMetalsColonist, MTRareMetalsDome, MTMovingDome1, MTMovingDome2, MTHippieName, MTDeadFounder, MTMartianCelebrityName, MTRandomColonistName, MTBirthdayName, MTSaint, MTCelebrity}, -- social Story Archives Text
            choice1 = T{"View Next Page of Social Archives"}, -- sends to MTSocialArchivePopup2 which is identical, allowing for a continuous flip between popups
            choice2 = T{"Return to Front Page"},
			choice3 = T{"Close"},
            image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
        } -- params
        local choice = WaitPopupNotification(false, params)
        if choice == 1 then
			MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTSocialArchivePopup2()  -- opens Top Story popup
		elseif choice == 2 then
			MTFrontPagePopup()
        end -- if statement
    end ) -- end CreateRealTimeThread
end -- function end

function MTSocialArchivePopup2()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTSocialArchive1 = MTGetSocialArchives(MTArchiveIndex)
	MTSocialArchive2 = MTGetSocialArchives(MTArchiveIndex - 1)
	if MTSocialArchive1 == MTSocialArchive2 then
		MTSocialArchive2 = MTArchiveDepleted2
	end
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTPetRockColonistName = MTGetPetRockColonist("check")
	MTOlympicBidGymDome = MTGetOlympicBidGymDome()
	MTRefuseHitsFanDinerDome = MTGetRefuseHitsTheFanDinerDome()
	MTTeenagerJoyrideName = MTGetTeenagerJoyrideName("check")
	MTTeenagerJoyrideDome = MTGetTeenagerJoyrideDome("check")
	MTDroneHack2Name = MTGetTeenagerJoyrideName("check")
	MTDroneHack3Name = MTGetDroneHack3Name("check")
	MTEarthlingDelayName = MTGetEarthlingDelayName("set")
	MTVeganDinerName = MTGetVeganDinerName("check")
	MTVeganDinerDome = MTGetVeganDinerDome()
	MTConcreteName = MTGetConcreteColonist("check")
	MTRareMetalsColonist = MTGetRareMetalsColonist("check")
	MTRareMetalsDome = MTGetRareMetalsDome("check")
	MTMovingDome1 = MTGetMovingDomes("1")
	MTMovingDome2 = MTGetMovingDomes("2")
	MTHippieName = MTGetHippie("check")
	MTDeadFounder = MTGetDeadFounder()
	MTMartianCelebrityName = MTGetMartianCelebrityName("check")
	MTRandomColonistName = MTGetRandomColonist("name")
	MTBirthdayName = MTGetBirthdayName("check")
	MTSaint = MTReligiousSaint("check")
	MTCelebrity = MTGetCelebrity("check")

	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Red Planet Socialites Archives"},
            text = T{"Recent Social Stories:  <newline><newline><MTSocialArchive1Title> <newline><newline>     <MTSocialArchive1Story><newline><newline><newline> <MTSocialArchive2Title><newline><newline>     <MTSocialArchive2Story><newline>", MTSocialArchive1Title = MTSocialArchive1.title, MTSocialArchive1Story = MTSocialArchive1.story, MTSocialArchive2Title = MTSocialArchive2.title, MTSocialArchive2Story = MTSocialArchive2.story, MTLeaderTitle, MTLeader, MTSponsor, MTPetRockColonistName, MTOlympicBidGymDome, MTRefuseHitsFanDinerDome, MTTeenagerJoyrideName, MTTeenagerJoyrideDome, MTDroneHack2Name, MTDroneHack3Name, MTEarthlingDelayName, MTVeganDinerName, MTVeganDinerDome, MTConcreteName, MTRareMetalsColonist, MTRareMetalsDome, MTMovingDome1, MTMovingDome2, MTHippieName, MTDeadFounder, MTMartianCelebrityName, MTRandomColonistName, MTBirthdayName, MTSaint, MTCelebrity}, -- social Story Archives Text
            choice1 = T{"View Next Page of Social Archives"}, -- sends to MTSocialArchivePopup which is identical, allowing for a continuous flip between popups
            choice2 = T{"Return to Front Page"},
			choice3 = T{"Close"},
            image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
        } -- params
        local choice = WaitPopupNotification(false, params)
        if choice == 1 then
			MTNewArchiveIndex = MTArchiveIndex - 2
			MTArchiveIndex = MTNewArchiveIndex
			MTSocialArchivePopup()  -- opens social archive 1 popup
		elseif choice == 2 then
			MTFrontPagePopup()
        end -- if statement
    end ) -- end CreateRealTimeThread
end -- function end

--  access g_MTTopArchive and extract the archived story
function MTGetTopArchives(MTArchiveIndexNum)
	if MTTempTopArchive == nil then
			MTTempTopArchive = {}
	end
	if g_MTTopArchive == nil then
		g_MTTopArchive = {}
		MTTempTopArchive = MTTopArchiveDepleted  -- if table or specific story are nil, return preset empty story
	else
		if g_MTTopArchive[MTArchiveIndexNum] == nil then
			MTTempTopArchive = MTTopArchiveDepleted
		else
			MTTempTopArchive = g_MTTopArchive[MTArchiveIndexNum]
		end
	end
	return MTTempTopArchive
end

--  access g_MTEngArchive and extract the archived story
function MTGetEngArchives(MTArchiveIndexNum)
	if MTTempEngArchive == nil then
			MTTempEngArchive = {}
	end
	if g_MTEngArchive == nil then
		g_MTEngArchive = {}
		MTTempEngArchive = MTEngArchiveDepleted  -- if archive empty, send default message
	else
		if g_MTEngArchive[MTArchiveIndexNum] == nil then
			MTTempEngArchive = MTEngArchiveDepleted
		else
			MTTempEngArchive = g_MTEngArchive[MTArchiveIndexNum]  -- else send EngArchive's old story
		end
	end
	return MTTempEngArchive
end

--  access g_MTSocialArchive and extract the archived story
function MTGetSocialArchives(MTArchiveIndexNum)
	if MTTempSocialArchive == nil then
			MTTempSocialArchive = {}
	end
	if g_MTSocialArchive == nil then
		g_MTSocialArchive = {}
		MTTempSocialArchive = MTSocialArchiveDepleted  -- if archive empty, send default message
	else
		if g_MTSocialArchive[MTArchiveIndexNum] == nil then
			MTTempSocialArchive = MTSocialArchiveDepleted
		else
			MTTempSocialArchive = g_MTSocialArchive[MTArchiveIndexNum]  -- else send SocArchive's old story
		end
	end
	return MTTempSocialArchive
end

function MTSetTopStory(MTPushPull)
	if MTNewTopStory == nil then
		MTNewTopStory = {}
	end
	if MTPushPull == "push" then  -- push request comes from new story day
		MTNewTopStory = MTGetNewTopStory()  -- this pushes a new story out of the tables of potential and free stories
	else
		return MTNewTopStory  -- this, then responds to the "pull" request from the popup
	end
end

function MTSetEngStory(MTPushPull)
	if MTNewEngStory == nil then
		MTNewEngStory = {}
	end
	if MTPushPull == "push" then  -- push request comes from new story day
		MTNewEngStory = MTGetNewEngStory()  -- this pushes a new story out of the tables of potential and free stories
	else
		return MTNewEngStory  -- this, then responds to the "pull" request from the popup
	end
end

function MTSetSocialStory(MTPushPull)
	if MTNewSocialStory == nil then
		MTNewSocialStory = {}
	end
	if MTPushPull == "push" then  -- push request comes from new story day
		MTNewSocialStory = MTGetNewSocialStory()  -- this pushes a new story out of the tables of potential and free stories
	else
		return MTNewSocialStory  -- this, then responds to the "pull" request from the popup
	end
end

function MTGetNewTopStory()
    if MTTopCurrentStory == nil then
		MTTopCurrentStory = {}
	end
	-- Assume there will be no news.
	MTTopCurrentStory = MTNoNews
	MTTopStoryRandom = nil		
	if #g_MTTopPotentialStories > 0 then  -- if potential stories are available
		MTTopStoryRandom = Random(1,#g_MTTopPotentialStories)  -- pick a random number out of the total available
		MTTopCurrentStory = g_MTTopPotentialStories[MTTopStoryRandom]	-- claim it as current
		table.remove(g_MTTopPotentialStories, MTTopStoryRandom)	-- pull it out of the potential list
		table.insert(g_MTTopArchive, MTTopCurrentStory)  -- adds it to the Top Story Archives
	elseif #g_MTTopFreeStories > 0 then
		MTTopStoryRandom = Random(1,#g_MTTopFreeStories) -- if no potential stories are available, pick from the free ones
		MTTopCurrentStory = g_MTTopFreeStories[MTTopStoryRandom]   -- claim this as the current story
		table.remove(g_MTTopFreeStories, MTTopStoryRandom)   --  pull it from the FreeStories list
		table.insert(g_MTTopArchive, MTTopCurrentStory)  -- adds it to the Top Story Archives
	end
	return MTTopCurrentStory  -- declare the current story
end

function MTGetNewEngStory()
    if MTEngCurrentStory == nil then
		MTEngCurrentStory = {}
	end
	-- Assume there will be no news.
	MTEngCurrentStory = MTNoNews
	MTEngStoryRandom = nil		
	if #g_MTEngPotentialStories > 0 then  -- if potential stories are available
		MTEngStoryRandom = Random(1,#g_MTEngPotentialStories)  -- pick a random number out of the total available
		MTEngCurrentStory = g_MTEngPotentialStories[MTEngStoryRandom]	-- claim it as current
		table.remove(g_MTEngPotentialStories, MTEngStoryRandom)	-- pull it out of the potential list
		table.insert(g_MTEngArchive, MTEngCurrentStory)  -- adds it to the Top Story Archives
	elseif #g_MTEngFreeStories > 0 then
		MTEngStoryRandom = Random(1,#g_MTEngFreeStories) -- if no potential stories are available, pick from the free ones
		MTEngCurrentStory = g_MTEngFreeStories[MTEngStoryRandom]   -- claim this as the current story
		table.remove(g_MTEngFreeStories, MTEngStoryRandom)   --  pull it from the FreeStories list
		table.insert(g_MTEngArchive, MTEngCurrentStory)  -- adds it to the Top Story Archives
	end
	return MTEngCurrentStory  -- declare the current story
end

function MTGetNewSocialStory()
	if MTSocialCurrentStory == nil then
		MTSocialCurrentStory = {}
	end
	-- Assume there will be no news.
	MTSocialCurrentStory = MTNoNews
	MTSocialStoryRandom = nil		
	if #g_MTSocialPotentialStories > 0 then  -- if potential stories are available
		MTSocialStoryRandom = Random(1,#g_MTSocialPotentialStories)  -- pick a random number out of the total available
		MTSocialCurrentStory = g_MTSocialPotentialStories[MTSocialStoryRandom]	-- claim it as current
		table.remove(g_MTSocialPotentialStories, MTSocialStoryRandom)	-- pull it out of the potential list
		table.insert(g_MTSocialArchive, MTSocialCurrentStory)  -- adds it to the Top Story Archives
	elseif #g_MTSocialFreeStories > 0 then
		MTSocialStoryRandom = Random(1,#g_MTSocialFreeStories) -- if no potential stories are available, pick from the free ones
		MTSocialCurrentStory = g_MTSocialFreeStories[MTSocialStoryRandom]   -- claim this as the current story
		table.remove(g_MTSocialFreeStories, MTSocialStoryRandom)   --  pull it from the FreeStories list
		table.insert(g_MTSocialArchive, MTSocialCurrentStory)  -- adds it to the Top Story Archives
	end
	return MTSocialCurrentStory  -- declare the current story
end

-- Section 3:  functions governing insert/remove of stories into their respective tables
------------- starting with story release functions.  ---- variables start at MTInitializeStoryTables()
--------------
--------------
--------------
--------------
--------------
--------------
--------------
--------------
--------------
--------------
--------------
--------------
--------------

-- triggered by ConstructionComplete
function MTArcologyInuendoStory()
	if MTArcologyInuendoStorySent ~= "true" then
		MTArcologyDomeName = MTGetArcologyDome("set")
		MTArcologyInuendo = {}
		MTArcologyInuendo["title"] = T{"First Dome-Penetrating Structure Erected"}
		MTArcologyInuendo["story"] = T{"     The Arcology erected in "..MTArcologyDomeName.." has been praised as an exquisite example of engineering, poking through the rounded dome, to a firm stance with a rounded bottom. As ever, the typical architectural tropes remain well intact, as one of the arcology residents put it, 'Seriously, the entire building is one giant inuendo!'"}
		table.insert(g_MTEngPotentialStories, MTArcologyInuendo)
		MTArcologyInuendoStorySent = "true"
	end
end


function MTGetArcologyDome(setorcheck)
	if setorcheck == "set" then
		if UICity.labels.Arcology ~= nil then
			MTTempArcologyDome = UICity.labels.Arcology[1].parent_dome.name
		end
	else
		if MTTempArcologyDome == nil then
			MTTempArcologyDome = "arcology dome"
		end
	return MTTempArcologyDome
	end
end

-- triggered by ConstructionComplete
function MTMoxieMagicStory()
	if MTMoxieMagicStorySent ~= "true" then
		MTMoxieMagic = {}
		MTMoxieMagic["title"] = T{"Moxie: Martian Magic"}
		MTMoxieMagic["story"] = T{"     This morning marks a milestone in the Martian memoirs. Moxie, the magic Martian machine makes mini mistrals, managing to maximise 02 from the mainly CO2 medium of Mars. Magnificent."}
		table.insert(g_MTEngPotentialStories, MTMoxieMagic)
		MTMoxieMagicStorySent = "true"
	end
end
		
-- triggered by NewDay
function MTDroneGoesViralStory()
	if MTDroneGoesViralStorySent ~= "true" then
		if #GetObjects{class = "Drone"} > 2 then
			MTDrone1 = MTGetRandomDrone()
			MTDrone2 = MTGetRandomDrone()
			MTDroneGoesViral = {}
			MTDroneGoesViral["title"] = T{"Video of Martian Drone Goes Viral"}
			MTDroneGoesViral["story"] = T{"     An adorable video of "..MTDrone1.." picking up some metal has gone viral on Earth, resulting in many copycat videos being created. "..MTDrone2.." a relative of "..MTDrone1..", who reportedly took the video has said (after translation from binary) 'I do not understand why it has gone viral, "..MTDrone1.." was only doing their job', in response, an earthling video production expert stated 'I know it's just doing its job, but it's SOO cute!'"}
			table.insert(g_MTEngFreeStories, MTDroneGoesViral)
			MTDroneGoesViralStorySent = "true"
		end
	end
end

function MTGetRandomDrone()
	if #GetObjects{class = "Drone"} > 2 then
		MTDroneRandom = Random(1,#GetObjects{class = "Drone"})
		MTMyRandomDrone = GetObjects{class = "Drone"}[MTDroneRandom].name
	else
		MTMyRandomDrone = "Drone #7"
	end
	return MTMyRandomDrone
end

-- triggered by NewDay
function MTConcreteLoveStory()
	if MTConcreteLoveStorySent ~= "true" then
		if #GetObjects{class = "RegolithExtractor"} > 2 then
			MTConcreteLove["title"] = T{"Concrete Extractor Loves Its Job"}
			MTConcreteLove["story"] = T{"     Concrete Extractor #2 has been observed to really love its job extracting concrete for the embetterment of humanity, always putting in 100% exactly. Unlike the other extractors, Concrete Extractor #2 is programmed specifically to remember every piece of concrete it extracts, and it's programmer claims that it even develops an emotional connection with the concrete it extracts. Love is in the air, folks!  ...and the concrete."}
			table.insert(g_MTEngPotentialStories, MTConcreteLove)
			MTConcreteLoveStorySent = "true"
		end
	end
end

-- triggered by NewDay
function MTOvalDomeUnnaturalStory()
	if MTOvalDomeUnnaturalStorySent ~= "true" then
		if #GetObjects{class = "DomeOval"} > 0 then
			MTOvalUnnatural["title"] = T{"Oval Dome Declared Unnatural"}
			MTOvalUnnatural["story"] = T{"     The building of the new Oval Dome has stirred a fair share of controversy on Mars. The Flat Mars League (FML) has come forward, claiming it unnatural. 'We have always built round domes, this new oval dome is an insult to martian tradition. Whats next? Square?' The new dome design allows for two spires, which scientists have described as 'an incredible breakthrough' stating that they can now throw paper airplanes from one spire to another without even striking the sides of the dome."}
			table.insert(g_MTEngPotentialStories, MTOvalUnnatural)
			MTOvalDomeUnnaturalStorySent = "true"
		end
	end
end

-- triggered by NewDay
function MTPewPewStory()
	if MTPewPewStorySent ~= "true" then
		if #GetObjects{class = "MDSLaser"} > 0 then
			MTPewPew = {}
			MTPewPew["title"] = T{"Pew Pew"}
			MTPewPew["story"] = T{"     Several citizens have lodged official complaints about the new MDS Laser, claiming that they never know when it is firing, and that concerns them. The solution offered is to add a 'pew-pew' sound effect to the MDS lasers, thus allowing citizens the comfort of knowing their dome is securely defended."}
			table.insert(g_MTEngPotentialStories, MTPewPew)
			MTPewPewStorySent = "true"
			MTPewPewWait("start")
		end
	end
end

-- START comes from MTPewPewStory, ADD comes from NewDay
function MTPewPewWait(startoradd)
	if MTPewPewPewStorySent ~= "true" then
		if startoradd == "add" then
			if MTPewPewWaitingPeriod ~= nil then
				MTNewPewPewWait = MTPewPewWaitingPeriod + 1
				MTPewPewWaitingPeriod = MTNewPewPewWait
				if MTPewPewWaitingPeriod == 3 then
					MTPewPewPew = {}
					MTPewPewPew["title"] = T{"Pew Pew Pew!"}
					MTPewPewPew["story"] = T{"     In response to the complaints lodged several sol prior, pew-pew sounds have been added to all new MDS Lasers.  Drama ensues, however, as several colonists have claimed to have heard the noises generated by the lasers despite there being no meteors in sight and without the lasers firing.  When asked if there were children present playing with their electronics, they responded, 'I hadn't quite thought about that. I don't recall.'"}
					table.insert(g_MTEngPotentialStories, MTPewPewPew)
					MTPewPewPewStorySent = "true"
				end
			end
		elseif startoradd == "start" then
			MTPewPewWaitingPeriod = 0
		end
	end
end

--- add comes from NewDay, remove comes from TechResearched
function MTScratchingTheSurfaceStory(addorremove)
	if MTScratchingTheSurfaceStorySent == "true" then
		if addorremove == "remove" then
			if MTScratchingTheSurface ~= nil then
				for k, v in (g_MTEngPotentialStories) do
					if v == MTScratchingTheSurface then
						table.remove(g_MTEngPotentialStories, k)
						break
					end
				end
			end
			MTScratchingTheSurfaceStoryRemoved = "true"
		end
	else
		if addorremove == "add" then
			if MTScratchingTheSurfaceStoryRemoved ~= "true" then
				if UICity.day > 75 then
					MTScratchingTheSurface = {}
					MTScratchingTheSurface["title"] = T{"Barely Scratching The Surface"}
					MTScratchingTheSurface["story"] = T{"     With each day that passes we are learning more and more about the new world around us, but we this doesn't mean that we've learned a single iota about the land next to us.  Our surface deposits are great, but when are we going to probe beyond the surface?  These piddly deposits will only serve our needs in the short term.  In the long term, we need to bore.  We need to go deep."}
					table.insert(g_MTEngPotentialStories, MTScratchingTheSurface)
					MTScratchingTheSurfaceStorySent = "true"
				end
			end
		end
	end
end

-- triggered via OnMsg.NewDay
function MTShortageStories()
	if MTThisIncidentDay == nil then
		MTThisIncidentDay = 0
	end    -- any dome missing something
	if #g_DomesWithNoOxygen > 0 or #g_DomesWithNoWater > 0 or #g_DomesWithNoPower > 0 then
		if UICity.day - MTThisIncidentDay < 20 then  -- checks time since incident day so this doesn't trigger multiple times for just one shortage event
			if #g_DomesWithNoOxygen > #g_DomesWithNoPower then  --  i.e.  OXYGEN SHORTAGE
				if #g_DomesWithNoOxygen[1].labels.Colonist > 0 then  -- and colonists live there
					MTThisIncidentDay = UICity.day  -- sets new incident day
					MTDomeWithoutO2 = MTGetDomeWithoutO2("set")
					MTDomeWithoutO2Random = Random(1,2)  -- 2 separate oxygen shortage stories
					if MTDomeWithoutO2Random == 1 then
						if MT02Shortage1StorySent ~= "true" then
							MTO2Shortage1["title"] = T{"All of "..MTDomeWithoutO2.." Holds Their Breath"}
							MTO2Shortage1["story"] = T{"     "..MTDomeWithoutO2.." is in dire straits as their oxygen supply was cut off from them recently.  While the "..MTLeaderTitle.." has already sent for the materials and drones necessary for repair, "..MTDomeWithoutO2.." citizens wonder anxiously: will it all arrive in time to matter?  For the rest of us: be prepared for a potential emergency evacuation."}
							table.insert(g_MTEngPotentialStories, MTO2Shortage1)
							MT02Shortage1StorySent = "true"
						end
					elseif MTDomeWithoutO2Random == 2 then
						if MT02Shortage2StorySent ~= "true" then
							MTO2Shortage2["title"] = T{" "..MTDomeWithoutO2.." Lets Off Some Steam"}
							MTO2Shortage2["story"] = T{"     Without any oxygen, "..MTDomeWithoutO2.." is no longer able to sustain the population it once did.  Please make room in your own home for refugees.  Hopefully the drones are already on it, but either way, "..MTDomeWithoutO2.." will be offline for a time while under repair."}
							table.insert(g_MTEngPotentialStories, MTO2Shortage2)
							MT02Shortage2StorySent = "true"
						end
					end
				end -- end Oxygen Shortage stories
			elseif #g_DomesWithNoWater > #g_DomesWithNoPower then  -- begin WATER SHORTAGE
				if #g_DomesWithNoWater[1].labels.Colonist > 0 then  -- and colonists live there
					MTThisIncidentDay = UICity.day  -- sets new incident day
					MTDomeWithoutWater = MTGetDomeWithoutWater("set")
					MTWaterDomeResident = MTGetDomeWithoutWater("colonist")
					MTDomeWithoutWaterRandom = Random(1,2)  -- 2 separate water shortage stories
					if MTDomeWithoutWaterRandom == 1 then
						if MTWaterShortage1StorySent ~= "true" then
							MTWaterShortage1 = {}
							MTWaterShortage1["title"] = T{"Draught Declared"}
							MTWaterShortage1["story"] = T{"     A draught has been declared in "..MTDomeWithoutWater..".  Dehydration is setting in and the citizens are nervous.  "..MTWaterDomeResident.." has declared it a non-issue, professing his faith in "..MTLeaderTitle.." "..MTLeader.."’s planning and provision."}
							table.insert(g_MTEngPotentialStories, MTWaterShortage1)
							MTWaterShortage1StorySent = "true"
						end
					elseif MTDomeWithoutWaterRandom == 2 then
						if MTWaterShortage2StorySent ~= "true" then
							MTWaterShortage2 = {}
							MTWaterShortage2["title"] = T{"Engineers Working To Mitigate Water Shortage"}
							MTWaterShortage2["story"] = T{"     Water is in short supply in "..MTDomeWithoutWater..".  While several engineers have begun working on a humidity reclamation project, even they have expressed doubt as to its viability.  This could be it for "..MTDomeWithoutWater.." as farms begin to shut down."}
							table.insert(g_MTEngPotentialStories, MTWaterShortage2)
							MTWaterShortage2StorySent = "true"
						end
					end
				end
			end  -- end Water Shortage stories
		end  -- end IncidentDay check
	end  -- no shortages of note
end -- end function
			

function MTGetDomeWithoutWater(setcheckorcolonist)
	if setcheckorcolonist == "set" then
		MTWaterLessDome = {}
		MTWaterLessDome = g_DomesWithNoWater[1]
		MTWaterLessDomeName = MTWaterLessDome.name
		return MTWaterLessDomeName
	elseif setcheckorcolonist == "check" then
		if MTWaterLessDome ~= nil then
			MTWaterLessDomeName = MTWaterLessDome.name
		else
			MTWaterLessDomeName = "dome without water"
		end
		return MTWaterLessDomeName
	elseif setcheckorcolonist == "colonist" then
		MTWaterDomeRandom = Random(1,#g_DomesWithNoWater[1].labels.Colonist)
		MTRandomWaterDomeColonist = g_DomesWithNoWater[1].labels.Colonist[MTWaterDomeRandom].name
		return MTRandomWaterDomeColonist
	end
end

function MTGetDomeWithoutO2(setorcheck)
	if setorcheck == "set" then
		MTOxygenLessDome = {}
		MTOxygenLessDome = g_DomesWithNoOxygen[1]
		MTOxygenLessDomeName = MTOxygenLessDome.name
	else
		if MTOxygenLessDome ~= nil then
			MTOxygenLessDomeName = MTOxygenLessDome.name
		else
			MTOxygenLessDomeName = "dome without oxygen"
		end
	end
	return MTOxygenLessDomeName
end
			

function MTMarsRealityTVStory()
	if MTMarsRealityTVStorySent ~= "true" then
		if CountColonistsWithTrait("Celebrity") > 0 then
			if tech_status["LiveFromMars"].researched then
				MTGetCelebrity("set")
				MTCelebrity = MTGetCelebrity("check")
				MTMarsRealityTV["title"] = T{"Live From Mars Renewed for Season 2"}
				MTMarsRealityTV["story"] = T{"     The hit martian reality TV show, Planet Mars, has been renewed for a second season. "..MTCelebrity.." will be the host for the second season.  "..MTSponsor.." has offered their full support of the endeavor, while our new director has already declared their disgust with working in the Martian environment declaring 'Dust. It's coarse, and rough, and irritating, and it just gets everywhere. EVERYWHERE!'"}
				table.insert(g_MTSocialPotentialStories, MTMarsRealityTV)
				MTMarsRealityTVStorySent = "true"
			end
		end
	end
end

function MTGetCelebrity(setcheckorcolonist)
	if setcheckorcolonist == "set" then
		for k, colonist in ipairs (UICity.labels.Colonist) do
			if colonist.traits["Celebrity"] then
				if MTCelebrityColonist == nil then
					MTCelebrityColonist = {}
				end
				MTCelebrityColonist = colonist
				MTCelebrityColonistName = MTCelebrityColonist.name
				break
			end
		end
		if MTCelebrityColonist ~= nil then
			return "yes"
		else
			return "no"
		end
	elseif setcheckorcolonist == "check" then
		if MTCelebrityColonist ~= nil then
			MTCelebrityColonistName = MTCelebrityColonist.name
		else
			MTCelebrityColonistName = "random celebrity"
		end
		return MTCelebrityColonistName
	elseif setcheckorcolonist == "colonist" then
		return MTCelebrityColonist
	end
end

-- triggered via OnMsg.ColonistDied
function MTSoylentGreen()
	if MTSoylentGreenStorySent ~= "true" then
		if tech_status["SoylentGreen"].researched ~= nil then
			MTSoylentRandom = Random(1,1)
			if MTSoylentRandom == 1 then
				MTSoylentGreen1 = {}
				MTSoylentGreen1["title"] = T{"What Goes Around Comes Around"}
				MTSoylentGreen1["story"] = T{"     As time moves on more and more colonists are born, and more and more are passing away, including just yesterday.  In other news, the newest food crop has come in! Make sure to check your nearest grocer for fresh produce and show them this article for a 0.5 percent discount!"}
				table.insert(g_MTSocialPotentialStories, MTSoylentGreen1)
				MTSoylentGreenStorySent = "true"
			end
		end
	end
end

-- triggered via OnMsg.NewDay
function MTDomelenolStory()
	if MTDomelenolStorySent ~= "true" then
		if #GetObjects{class = "Infirmary"} > 0 then
			MTDomelenol["title"] = T{"Domelenol Now Available!"}
			MTDomelenol["story"] = T{"     Got any aches and pains? Go to your local infirmary and ask for some Domelenol, the only sponsor-approved painkiller on Mars. Warning: Domelenol will not cure earthsickness, headaches, being an idiot, toothaches, alcoholism, feelings of loneliness, gambling addiction, nausea or just about anything else. Use at your own risk."}
			table.insert(g_MTSocialPotentialStories, MTDomelenol)
			MTDomelenolStorySent = "true"
		end
	end
end

-- triggered via OnMsg.NewDay
function MTSpyStory()
	if MTSpyStorySent ~= "true" then
		if #GetObjects{class = "Spacebar"} > 1 then
			MTSecondSpacebarDomeName = MTGetSecondSpacebarDome()
			MTSpy = {}
			MTSpy["title"] = T{"Spies Spotted on Mars"}
			MTSpy["story"] = T{"     The Martian Tribune has received information that there spies sent from Earth have been spotted on Mars. Sources say that a spy was seen in the spacebar in "..MTSecondSpacebarDomeName.." highly intoxicated and attempting to hit on any woman in the bar while trying to use the pickup line 'I am the greatest secret agent on Mars, baby!'  The spy's identity has yet to be confirmed."}
			table.insert(g_MTSocialPotentialStories, MTSpy)
			MTSpyStorySent = "true"
		end
	end
end

function MTGetSecondSpacebarDome()
	if #GetObjects{class = "Spacebar"} > 1 then
		MTSecondSpacebarDomeName = UICity.labels.Spacebar[1].parent_dome.name
	else
		MTSecondSpacebarDomeName = "unbuilt spacebar dome"
	end
	return MTSecondSpacebarDomeName
end

-- triggered via OnMsg.NewDay
function MTNewLanguageStory()
	if MTNewLanguageStorySent ~= "true" then
		if UICity.day > 125 then
			MTNewLanguage = {}
			MTNewLanguage["title"] = T{"New Language Develops on Mars"}
			MTNewLanguage["story"] = T{"     It has been reported that the language spoken on Mars has changed so much from those spoken on earth that it is now mutually unintelligble when compared to any language on Earth and thus must be classified as its very own language. Some experts have claimed that it is not a new language, but rather a combination of Swahili and Irish.  This strikes us here at the Martian Tribune as quite odd, however, as no one speaking either of those languages has yet come to Mars."}
			table.insert(g_MTSocialPotentialStories, MTNewLanguage)
			MTNewLanguageStorySent = "true"
		end
	end
end

-- triggered via OnMsg.NewDay
--  put into FREE stories
function MTVigilanteStory()
	if MTVigilanteStorySent ~= "true" then
		if #GetObjects{class = "Dome"} > 2 then
			MTVigilante = {}
			MTVigilante["title"] = T{"Vigilante Justice"}
			MTVigilante["story"] = T{"     A rumor has begun circulating around the domes of a masked vigilante running around preventing crime. Given the name of the Red Lantern has been spotted on multiple occasions preventing petty crimes and saving lives.  Spottings include, but are not limited to; telling youth to stop throwing rocks, pushing a person out of the way of a rapidly moving drone, and stopping a theft in the local grocer."}
			table.insert(g_MTSocialFreeStories, MTVigilante)
			MTVigilanteStorySent = "true"
		end
	end
end

-- triggered via OnMsg.NewDay
function MTPassportStory()
	if MTPassportStorySent ~= "true" then
		if MTColonistsArrivedCheck("check") then
			MTPassport = {}
			MTPassport["title"] = T{"New Martian Passport Revealed"}
			MTPassport["story"] = T{"     The Martian Tribune has received an advanced copy of the new martian passport, designed in Armstrong city on Luna, the passport is red, the front has a hologram of Mars with Phobos and Deimos behind it. Designers have stated the passport is 'completely uncopyable.' If you have yet to see the design, plenty of copies a rumored to be available from various undisclosed sources both here on Mars as well as on the Moon."}
			table.insert(g_MTSocialPotentialStories, MTPassport)
			MTPassportStorySent = "true"
		end
	end
end

-- triggered via OnMsg.NewDay
--  put into FREE stories
function MTMartianMusicStory()
	if MTMartianMusicStorySent ~= "true" then
		if MTColonistsArrivedCheck("check") then
			MTMartianMusic["title"] = T{"Martian Music Voted Best in Galaxy"}
			MTMartianMusic["story"] = T{"   The Martian rock group, Red Rock Rocks, has been voted best in the galaxy by an unbiased vote conducted online. The group is famous for songs such as '4th Rock from the sun', 'Red Rocks Rock', 'Dome sweet Dome', and 'Martian Madness'. The timing of such a vote is fortuitous as they have also just released their brand new album called 'Dark side of Phobos'."}
			table.insert(g_MTSocialFreeStories, MTMartianMusicStorySent)
			MTMartianMusicStorySent = "true"
		end
	end
end

-- triggered via OnMsg.NewDay
--  put into FREE stories
function MTEqualityStory()
	if MTEqualityStorySent ~= "true" then
		if UICity.day > 50 then
			if MTColonistsArrivedCheck("check") then
				MTEquality = {}
				MTEquality["title"] = T{" "..MTLeaderTitle.." Praised For Culture of Equality"}
				MTEquality["story"] = T{"     In a recent G20 Summit, Mars has been praised for its fully representative gender-based equality. Martian men, women, and those identifying as Other all have equal and ready access to all services, job opportunities, and representation. This has been attributed to "..MTSponsor.." who has gone on record as not really caring about 'things like gender, as long as they get the job done.'"}
				table.insert(g_MTSocialFreeStories, MTEquality)
				MTEqualityStorySent = "true"
			end
		end
	end
end
			
-- triggered via OnMsg.NewDay
function MTReligiousArtifactStory()
	if MTReligiousArtifactStorySent ~= "true" then
		if MTReligiousSaint("set") == "yes" then
			MTSaint = MTReligiousSaint("check")
			MTReligiousArtifact = {}
			MTReligiousArtifact["title"] = T{"Religious Artifact Found on Mars"}
			MTReligiousArtifact["story"] = T{"     "..MTSaint.." has found what appears to be a religious artifact on Mars. The item, shaped like the Point of Origin symbol from Stargate fame, has been heralded as undenyable proof of "..MTSaint.."'s new religion as the one true faith. Sceptics however are reported saying '..its just a stupid, useless rock.. there are thousands of them all around! What's so special about this one?'"}
			table.insert(g_MTSocialPotentialStories, MTReligiousArtifact)
			MTReligiousArtifactStorySent = "true"
		end
	end
end

function MTReligiousSaint(setcheckorcolonist)
		if setcheckorcolonist == "set" then
		for k, colonist in ipairs (UICity.labels.Colonist) do
			if colonist.traits["Saint"] then
				if MTSaintColonist == nil then
					MTSaintColonist = {}
				end
				MTSaintColonist = colonist
				MTSaintColonistName = MTSaintColonist.name
				break
			end
		end
		if MTSaintColonist ~= nil then
			return "yes"
		else
			return "no"
		end
	elseif setcheckorcolonist == "check" then
		if MTSaintColonist ~= nil then
			MTSaintColonistName = MTSaintColonist.name
		else
			MTSaintColonistName = "random saint"
		end
		return MTSaintColonistName
	elseif setcheckorcolonist == "colonist" then
		return MTSaintColonist
	end
end

-- triggered via OnMsg.ColonistDied (1st non-founder death)
function MTHappyBirthdayStory()
	if MTHappyBDayStorySent ~= "true" then
		MTBirthdayName = MTGetBirthdayName("set")
		MTHappyBirthday = {}
		MTHappyBirthday["title"] = T{"A New Milestone Has Been Achieved!"}
		MTHappyBirthday["story"] = T{"Today marks yet another first as it pertains to martian colonization: Today we celebrate the first birthday on Mars!  "..MTBirthdayName.." is celebrating their birthday today! Let us all sing and cheer for them, and for many more to come!"}
		table.insert(g_MTSocialPotentialStories, MTHappyBirthday)
		MTHappyBDayStorySent = "true"
	end
end

function MTGetBirthdayName(setorcheck)
	if setorcheck == "set" then
		MTBirthdayColonistName = MTGetRandomColonist("name")
		MTBDayColonistName = MTBirthdayColonistName
	else
		if MTBirthdayColonistName == nil then
			MTBDayColonistName = "random birthday colonist"
		else
			MTBDayColonistName = MTBirthdayColonistName
		end
	end
	return MTBDayColonistName
end
			

-- triggered via OnMsg.ColonistDied
function MTFirstMartianbornDied(MTDeadColonist)
	if MTFirstMartianbornDiedStorySent ~= "true" then
		MTDeadMartian = MTDeadColonist
		MTGetDeadMartian(MTDeadMartian)  -- sends the colonist into the MTGetDeadMartian function
		MTDeadMartianName = MTGetDeadMartian("check")
		MTFirstMartianbornDied = {}
		MTFirstMartianbornDied["title"] = T{"Petition to Rename Dome"}
		MTFirstMartianbornDied["story"] = T{"     A petition has arrived at the Martian Tribune asking that a dome of ours be re-named in honor of "..MTDeadMartianName..". We at the bureau also feel it would be a great way to remember the dead. If you would like to add your name to the petition, stop by the bureau before next Monday when we officially present the petition to the "..MTLeaderTitle.." on behalf of the martian people."}
		table.insert(g_MTTopPotentialStories, MTFirstMartianbornDied)
		MTFirstMartianbornDiedStorySent = "true"
	end
end

function MTGetDeadMartian(MTDeadMartianorcheck)
	if MTDeadMartianorcheck == "check" then
		if MTFirstDeadMartian == nil then
			MTFirstDeadMartianName = "first dead martian"
		end
	else
		if MTFirstDeadMartian == nil then
			MTFirstDeadMartian = {}
		end
		MTFirstDeadMartian = MTDeadMartianorcheck
		MTFirstDeadMartianName = MTFirstDeadMartian.name
	end
end
	

function MTLeaderVices()
	if MTVirtueOverVicesStorySent ~= "true" then
		if MTLeaderColonist.traits.Glutton or MTLeaderColonist.traits.Gambler or MTLeaderColonist.traits.Alcoholic then
			MTVirtue = {}
			MTVirtue["title"] = T{"Virtue Over Vices"}
			MTVirtue["story"] = T{"     The stresses of colonizing a new planet have clearly taken their toll on "..MTLeaderTitle.." "..MTLeader.." as the foolishness of last night’s escapades will not be long forgotten.  "..MTLeaderTitle..", learn to control your vices better before they take us all down with you!  If things don’t change soon, it might be time to start looking for a new leader."}
			table.insert(g_MTTopPotentialStories, MTVirtue)
			MTVirtueOverVicesStorySent = "true"
		end
	end
end

-- triggered by NewDay
function MTConnoisseurStory()
	if MTConnoisseurStorySent ~= "true" then
		if #GetObjects{class = "Spacebar"} > 0 then
			MTConnoisseur = {}
			MTConnoisseur["title"] = T{"Spacebar a hit with local Connoisseur"}
			MTConnoisseur["story"] = T{"     WOOOO! Mannn, this Spacebar is great! I went... I went there, and -hic- I went there, it was great! WOOOOO! man, i love it, I don't ever want to -hic- leave... they have this great drink, made from the.. food thing, the.. potatoes, the barman called it 'poteeeen', man its great, does anywhere on mars do Chinese? I could really do with some Chinese right now. -hic-"}
			table.insert(g_MTSocialPotentialStories, MTConnoisseur)
			MTConnoisseurStorySent = "true"
		end
	end
end

-- triggered by NewDay
function MTWatchWhatYouEatStory()
	if MTWatchWhatYouEatStorySent ~= "true" then
		if #GetObjects{class = "Spacebar"} > 1 then
			MTRandomColonistName = MTGetRandomColonist("name")
			MTWatchWhatYouEat = {}
			MTWatchWhatYouEat["title"] = T{"Watch What You Eat"}
			MTWatchWhatYouEat["story"] = T{"     A new ordinance has been passed on the number of drinks one may imbibe after yet another incident.  Five of our inibriated compatriots recently snuck off to the stockpiles overnight, exchanging the contents of the food containers randomly with the polymers, machine parts, and electronics again.  Watch what you eat, folks.  As "..MTRandomColonistName.." put it, 'Those electronics just don't go down well'."}
			table.insert(g_MTEngPotentialStories, MTWatchWhatYouEat)
			MTWatchWhatYouEatStorySent = "true"
		end
	end
end

function MTGetRandomColonist(colonistorname)
	if MTColonistsArrivedCheck("check") == "true" then
		if MTRandomColonistPerson == nil then
			MTRandomColonistPerson = {}
		end
		MTRandomColonistPerson = Random(1,#UICity.labels.Colonist)
		if colonistorname == "colonist" then
			return MTRandomColonistPerson
		elseif colonistorname == "name" then
			return MTRandomColonistPerson.name
		end
	end
end

-- triggered via OnMsg.NewDay
function MTIdiotFMLStory()
	if MTIdiotFMLStorySent ~= "true" then
		if CountColonistsWithTrait("Idiot") > 0 then
			MTGetIdiotColonist("set")
			MTIdiotName = MTGetIdiotColonist("check")
			MTIdiotColonist = MTGetIdiotColonist("colonist")
			MTIdiotColonist:TogglePin()
			MTIdiotFML = {}
			MTIdiotFML["title"] = T{"Flat Mars League Gains Traction"}
			MTIdiotFML["story"] = T{"     "..MTSponsor.."'s recent announcement that cursory scans of the Martian surface are complete has prompted an interesting response from the public.  The Flat Mars League (FML) has come forward to declare that the scans provide full evidence, beyond any doubt, that Mars is indeed flat.  Their spokesman, "..MTIdiotName..", has pointed to the clear squareness of the resulting map, and the fact that the horizon is so obviously flat as well.  When asked about Earth, "..MTIdiotName.." stated that, 'Unlike Mars, Earth has been observed to be round.'"}
			table.insert(g_MTEngPotentialStories, MTIdiotFML)
			MTIdiotFMLStorySent = "true"
		end
	end
end

-- triggered via OnMsg.NewDay
function MTOopsIBrokeItAgainStory()
	if MTOopsIBrokeItAgainStorySent ~= "true" then
		if CountColonistsWithTrait("Idiot") > 0 then
			MTGetIdiotColonist("set")
			MTIdiotWorkplaceBuilding = MTGetIdiotWorkplace("set")
			if MTIdiotWorkplaceBuilding.maintenance_place == "demand" then
				MTIdiotWorkplace = MTGetIdiotWorkplace("check")
				MTIdiotName = MTGetIdiotColonist("check")
				MTOopsIBrokeItAgain = {}
				MTOopsIBrokeItAgain["title"] = T{"Oops I Broke It Again"}
				MTOopsIBrokeItAgain["title"] = T{"     Dome dimwit "..MTIdiotName.." has once again managed to again find a way to get around the idiot-proof safety features of the local  "..MTIdiotWorkplace.." with an amazing display of acrobatics, luck, and skill. Once again "..MTIdiotName.." found themselves holding a vital part of the building in their hand as they left work today. 'I honestly have no idea how they managed it. The building can't function without it, so we keep it behind three feet of concrete... yet, somehow, they still managed to walk off with it. I'm not even mad. It really is just plain amazing.'"}
				table.insert(g_MTEngPotentialStories, MTOopsIBrokeItAgain)
				MTOopsIBrokeItAgainStorySent = "true"
			end
		end
	end
end

function MTGetIdiotWorkplace(setorcheck)
	if setorcheck == "check" then
		if MTIdiotWorkplaceBuilding == nil then
			return "idiot workplace"
		else
			return MTIdiotWorkplaceBuilding.encyclopedia_id
		end
	elseif setorcheck == "set" then
		MTIdiotPerson = MTGetIdiotColonist("colonist")
		MTIdiotWorkplaceBuilding = MTIdiotPerson.workplace
		return MTIdiotWorkplaceBuilding
	end
end

-- triggered via OnMsg.ConstructionComplete
function MTShuttleHubStory()
	if MTShuttleHubStorySent ~= "true" then
		MTShuttleHub = {}
		MTShuttleHub["title"] = T{"The Wright Way"}
		MTShuttleHub["story"] = T{"     As recent research turns into technological innovation the Martian Aviation Authority has announced its first inter-dome flights with their new CO2 powerd flying drones. Move from dome to dome with the new luxury passanger drones, or just watch as the MAA goes about it's business transfering food and other supplies to where its most needed."}
		table.insert(g_MTSocialPotentialStories, MTShuttleHub)
		MTShuttleHubStorySent = "true"
	end
end

-- triggered via OnMsg.ConstructionComplete
function MTUniversityStory()
	if MTUniversityStorySent ~= "true" then
		MTUniversity = {}
		MTUniversity["title"] = T{"MRU Opens Its Doors"}
		MTUniversity["story"] = T{"     After months of construction and planning the Martian Red University has opened its doors to Martians and colonists alike offering classes in Martian Botony, Martian Engineering, Martian Geology, Martian Medical Care, and Martian Science.  MRU is already being recognized as an accredited third level educational institute throughout the entire planet. Sign up now and become marginally less useless today!"}
		MTUniversityStorySent = "true"
	end
end

-- triggered via OnMsg.ColonistBorn
function MTMartianCelebrityStory(MTColonistBorn)
	if MTMartianCelebrityStorySent ~= "true" then
		MTMartianCelebrityName = MTGetMartianCelebrityName("set")
		MTColonistBorn:TogglePin()
		MTMartianCelebrity = {}
		MTMartianCelebrity["title"] = T{"The Answer To Life Is Always 42"}
		MTMartianCelebrity["story"] = T{"     The lucky couple came forward today to announce that after 42 hours of labor, at 24:45 Martian Standard Time, their first child, "..MTMartianCelebrityName.." was born.  They are said to be only slightly fatigued, but absolutely jubilant upon the sight of the most dazzling, toothless smile imaginable staring back at them. Journalists from earth are already requesting photos of the new citizen.  We have a new celebrity in our midst!"}
		table.insert(g_MTSocialPotentialStories, MTMartianCelebrity)
		MTMartianCelebrityStorySent = "true"
	end
end

function MTGetMartianCelebrityName(setorcheck)
	if setorcheck == "check" then
		if MTMartianCelebrity == nil then
			MTMartianCelebrityName = "martian celebrity"
		end
	elseif setorcheck == "set" then
		if MTMartianCelebrity ~= nil or MTMartianCelebrityName == "martian celebrity" then
			MTMartianCelebrityName = colonistorcheck.name
		end
	end
	return MTMartianCelebrityName
end

-- triggered via OnMsg.ColonistDied
function MTFirstFounderDied(MTDeadColonist)
	if MTFirstFounderDiedStorySent ~= "true" then
		MTDeadFounderColonist = MTDeadColonist
		MTDeadFounder = MTDeadFounderColonist.name
		MTFirstFounder = {}
		MTFirstFounder["title"] = T{"First Founder Passed Away"}
		MTFirstFounder["story"] = T{"     Today marks a sad day on Mars as two planets mourn in unison.  The first death on Mars, Founder "..MTDeadFounder.." passed away today. As one of the very first Founders to ever set foot on the Red Planet, "..MTDeadFounder.." will go down in history as having set the highest of standards.  They were a brave soul, who's impact can be seen all around us, and shall not be forgotten."}
		table.insert(g_MTSocialPotentialStories, MTFirstFounder)
		MTFirstFounderDiedStorySent = "true"
	end
end

function MTGetDeadFounder()
	if MTDeadFounder == nil then
		MTDeadFounder = "dead founder"
	end
	return MTDeadFounder
end

--triggered via OnMsg.NewDay
function MTHippieStory()
	if MTHippieStorySent ~= "true" then
		if MTGetHippie("set") ~= "no botanist" then
			MTHippieName = MTGetHippie("check")
			MTHippie = {}
			MTHippie["title"] = T{"The Grass Couldn't Be Greener"}
			MTHippie["story"] = T{"     Local botanist "..MTHippieName.." has been caught smoking what officers referred to as 'the greatest stuff on the planet,' which was found to be grown in their very own closet. Though technically not illegal on Mars, questions have been raised as to how the botanist got the plant here in the first place. Dome security declared to us that 'it's definitely home-grown, it really is pretty high quality,' unfortunately this was all the information we could gather as the officers were all quite insistent on returning to their spudtato snacks.  We will keep you updated as more news unfolds."}
			table.insert(g_MTSocialPotentialStories, MTHippie)
			MTHippieStorySent = "true"
		end
	end
end

function MTGetHippie(setorcheck)
	if setorcheck == "set" then
		for k, colonist in ipairs (UICity.labels.Colonist) do
			if colonist.specialist == "botanist" then
				if MTBotanistColonist == nil then
					MTBotanistColonist = {}
				end
				MTBotanistColonist = colonist
				MTBotanistColonistName = MTBotanistColonist.name
				break
			end
		end
		if MTBotanistColonist == nil then
			MTBotanistColonistName = "no botanist"
		end
	else
		if MTBotanistColonistName == nil then
			MTBotanistColonistName = "random botanist"
		end
	end
	return MTBotanistColonistName
end



function MTMovingDomesStory()
	if MTMovingDomesStorySent ~= "true" then
		if #GetObjects{class = "Dome"} > 2 then
			MTGetMovingDomes("set")
			MTMovingDome1 = MTGetMovingDomes("1")
			MTMovingDome2 = MTGetMovingDomes("2")
			MTMovingDomes = {}
			MTMovingDomes["title"] = T{"The Rock Is Always Redder"}
			MTMovingDomes["story"] = T{"     In a recent survey performed by the Martian Tribune a number of citizens have expressed disappointment after moving to a new dome.  One citizen in particular hit the nail on the head saying, 'I always thought that moving from "..MTMovingDome1.." to "..MTMovingDome2.." would be a huge upgrade in lifestyle, but I've have found it to be basically the same as before. I guess it's true what they say: The rock is redder on the other side.'"}
			table.insert(g_MTSocialPotentialStories, MTMovingDomes)
			MTMovingDomesStorySent = "true"
		end
	end
end

function MTGetMovingDomes(dome)
	if dome == "set" then
		MTTempMovingDome1 = UICity.labels.Domes[1].name
		MTTempMovingDome2 = UICity.labels.Domes[2].name
	elseif dome == "1" then
		if MTTempMovingDome1 == nil then
			MTTempMovingDome1 = "random dome 1"
		end
		return MTTempMovingDome1
	elseif dome == "2" then
		if MTTempMovingDome2 == nil then
			MTTempMovingDome2 = "random dome 2"
		end
		return MTTempMovingDome2
	end
end

function MTRareMetalsComplaintStory()
	if MTRareMetalsComplaintStorySent ~= "true" then
		if #GetObjects{class = "PreciousMetalsExtractor"} > 0 then
			MTRareMetalsDome = MTGetRareMetalsDome("set")
			if MTRareMetalsDome ~= "random rare metals dome" then
				MTRareMetalsColonist = MTGetRareMetalsColonist("set")
				if MTRareMetalsColonist ~= "random rare metals colonist" then
					MTRareMetals = {}
					MTRareMetals["title"] = T{"Sound Complaint Filed"}
					MTRareMetals["story"] = T{"     "..MTRareMetalsColonist.." has lodged a formal complaint against "..MTLeader.."'s natural resource exploitation.  In the complaint they declared the primary contributor to be the new Rare Metals Extractor near "..MTRareMetalsDome..".  There was also mention of sleep being precious and the constant pounding leaving not a moment of reprieve.  "..MTLeader.." declared themselves unmoved by the complaint."}
					table.insert(g_MTSocialPotentialStories, MTRareMetals)
					MTRareMetalsComplaintStorySent = "true"
				end
			end
		end
	end
end

function MTGetRareMetalsColonist(setorcheck)
	if setorcheck == "set" then
		MTRMWDome = MTGetRareMetalsDome("getdome")
		if MTRMColonist == nil then
			MTRMColonist = {}
		end
		MTGetRandomRMColonist = Random(1,#MTRMWDome.labels.Colonist)
		MTRMColonist = MTRMWDome.labels.Colonist[MTGetRandomRMColonist]
		MTRMColonistName = MTRMColonist.name
	else
		if MTRMColonistName == nil then
			MTRMColonistName = "random rare metals colonist"
		end
	end
	return MTRMColonistName
end

function MTGetRareMetalsDome(setorcheck)
	if setorcheck == "set" then
		if UICity.labels.PreciousMetalsExtractor ~= nil then
			if MTRMWorkerDome == nil then
				MTRMWorkerDome = {}
			end
			MTRMWorkerDome = UICity.labels.PreciousMetalsExtractor[1].workers[1][1].dome
			MTRMWorkerDomeName = MTRMWorkerDome.name
			return MTRMWorkerDomeName
		end
	elseif setorcheck == "check" then
		if MTRMWorkerDomeName == nil then
			MTRMWorkerDomeName = "random rare metals dome"
		end
		return MTRMWorkerDomeName
	elseif setorcheck == "getdome" then
		if MTRMWorkerDome == nil then
			MTRMWorkerDome = {}
		end
		return MTRMWorkerDome
	end
end

function MTConcretePavingStory()
	if MTConcretePavingStorySent ~= "true" then
		if #GetObjects{class = "RegolithExtractor"} > 0 then
			if UICity.labels.Colonist ~= nil then
				MTConcreteName = MTGetConcreteColonist("set")
				MTConcrete = {}
				MTConcrete["title"] = T{"Paving Over The Problem"}
				MTConcrete["story"] = T{"     "..MTConcreteName.." has lodged a formal complaint with authorities today after the plans to construct yet another Concrete Extractor was announced. "..MTConcreteName.." declared within that they 'did not come to another planet to pave it over.'"}
				MTConcretePavingStorySent = "true"
			end
		end
	end
end

function MTGetConcreteColonist(setorcheck)
	if setorcheck == "set" then
		if UICity.labels.Colonist ~= nil then
			MTGetColonistRandom = Random(1,#UICity.labels.Colonist)  -- if none with rare traits,
			MTConcretePavingColonist = UICity.labels.Colonist[MTGetColonistRandom] -- random colonist is chosen
			MTConcretePavingName = MTConcretePavingColonist.name
		end
	else
		if MTConcretePavingName == nil then
			MTConcretePavingName = "random person"
		end
	end
	return MTConcretePavingName
end

function MTVeganDinerStory()
	if MTVeganDinerStorySent ~= "true" then
		if CountColonistsWithTrait("Vegan") > 3 then
			MTVeganDinerName = MTGetVeganDinerName("set")
			if MTVeganColonist.dome.labels.Diner ~= nil then
				MTVeganDinerDome = MTGetVeganDinerDome()
				MTVeganDiner = {}
				MTVeganDiner["title"] = T{"Is this Vegan?"}
				MTVeganDiner["story"] = T{"     "..MTVeganDinerName.." has been barred from the diner in "..MTVeganDinerDome.." after going in 25 different times and asking, 'Is this vegan? I'm vegan, so I can't eat anything that comes from an animal,' and being repetedly informed that everything on Mars is vegan, staff finally banded together and has officially banned "..MTVeganDinerName.." from the establishment stating 'EVERYTHING is vegan!  Now GET OUT!'"}
				table.insert(g_MTSocialPotentialStories, MTVeganDiner)
				MTVeganDinerStorySent = "true"
			end
		end
	end
end

function MTGetVeganDinerDome()
	if MTGetVeganDinerName("check") ~= "random vegan" then
		if MTVeganColonist ~= nil then
			MTVDDome = MTVeganColonist.dome.name
		else
			MTVDDome = "dome with vegan and diner"
		end
	else
		MTVDDome = "dome with vegan and diner"
	end
	return MTVDDome
end

function MTGetVeganDinerName(setorcheck)
	if setorcheck == "set" then
		for k, colonist in ipairs (UICity.labels.Colonist) do
			if colonist.traits["Vegan"] then
				if MTVeganDinerColonist == nil then
					MTVeganDinerColonist = {}
				end
				MTVeganColonist = colonist
				MTVeganColonistName = MTVeganColonist.name
				break
			end
		end
	else
		MTVeganColonistName = "random vegan"
	end
	return MTVeganColonistName
end

function MTVegan1Story()
	if MTVegan1StorySent("check") ~= "true" then
		if CountColonistsWithTrait("Vegan") > 0 then
			MTVegan1Name = MTGetVegan("set")
			MTVegan1MedicName = MTGetVegan1MedicName()
			if MTVegan1MedicName ~= "random medic" then
				MTVegan1 = {}
				MTVegan1["title"] = T{"Vegan Declares Mars Meat-Free Planet"}
				MTVegan1["story"] = T{"     "..MTVegan1Name.." has stepped up to make their presence known today as they've declared Mars to be Vegan Atlantis.  With Earth now lost forever to the carnivores, Mars is as yet unmarred by the carnivorous and "..MTVegan1Name.." has vowed to do everything in their power to keep it that way.  Doesn't sound good for all the bacon lovers out there as "..MTVegan1MedicName.." has stepped up to back the proposition as well.  We'll have to wait and see if it sticks."}
				table.insert(g_MTSocialPotentialStories, MTVegan1)
				MTVegan1StorySent("set")
				MTVeganPurgatoryDays = 0
				MTVeganPurgatory("set")
			end
		end
	end
end

function MTVegan1StorySent(setorcheck)
	if setorcheck == "set" then
		MTVegan1StoryHasBeenSent = "true"
	else
		if MTVegan1StoryHasBeenSent == nil then
			MTVegan1StoryHasBeenSent = "false"
		end
		return MTVegan1StoryHasBeenSent
	end
end

function MTGetVegan1MedicName()
	MTVegan1Colonist = MTGetVegan("getcolonist")
	if MTVegan1Colonist.dome.labels.medic ~= nil then
		MTVegan1MedicColonist = MTVegan1Colonist.dome.labels.medic[1]
		MTVegan1MedicColonistName = MTVegan1MedicColonist.name
	else
		MTVegan1MedicColonistName = "random medic"
	end
	return MTVegan1MedicColonistName
end

function MTGetVegan(setorcheck)
	if setorcheck == "set" then
		for k, colonist in ipairs (UICity.labels.Colonist) do
			if colonist.traits["Vegan"] then
				MTVeganColonist = colonist
				MTVeganColonistName = MTVeganColonist.name
				break
			end
		end
		return MTVeganColonistName
	elseif setorcheck == "check" then
		if MTVeganColonistName == nil then
			MTVeganColonistName = "random vegan"
		end
		return MTVeganColonistName
	elseif setorcheck == "getcolonist" then
		if MTVeganColonist == nil then
			MTVeganColonist = {}
		end
		return MTVeganColonist
	end
end

function MTVeganPurgatory(setaddcheck)
	if MTVeganPurgatoryDays < 40 then
		if setaddcheck == "set" then
			MTVeganPurgatoryDays = 0
		end
		if setaddcheck == "add" then
			if MTVegan1StorySent("check") == "true" then
				MTNewVeganPurgatoryDays = MTVeganPurgatoryDays + 1
				MTVeganPurgatoryDays = MTNewVeganPurgatoryDays
			end
		end
		if setaddcheck == "check" then
			return MTVeganPurgatoryDays
		end
	end
end

function MTVegan2Story()
	if MTVegan2StorySent("check") ~= "true" then
		if MTVeganPurgatory("check") == 10 then
			if CountColonistsWithTrait("Vegan") > 0 then
				MTVegan2Name = MTGetVegan("check")
				if MTVegan2Name == "random vegan" then
					MTVegan2Name = MTGetVegan("set")
				end
				MTVegan2 = {}
				MTVegan2["title"] = T{"Mars Still Meat Free"}
				MTVegan2["story"] = T{"     "..MTVegan2Name.."'s ambitions have lead to the creation of a new foundation called the Vegan Martian Coalition. Their proposition of a meat-free Mars seems to be gaining momentum as 10 sol have now passed since the initial proposition and neither cattle nor hog has yet seen import.  Recognizing that opposition has been light, the "..MTLeaderTitle.." and "..MTSponsor.." have each agreed to sit down to discuss the issue more in depth."}
				table.insert(g_MTSocialPotentialStories, MTVegan2)
				MTVegan2StorySent("set")
			end
		end
	end
end

function MTVegan2StorySent(setorcheck)
	if setorcheck == "set" then
		MTVeganStory2HasBeenSent = "true"
	else
		if MTVeganStory2HasBeenSent == nil then
			MTVeganStory2HasBeenSent = "false"
		end
		return MTVeganStory2HasBeenSent
	end
end

function MTVegan3Story()
	if MTVegan3StorySent ~= "true" then
		if MTVeganPurgatory("check") == 22 then
			MTVegan3 = {}
			MTVegan3["title"] = T{"Vegan Martian Coalition Gains Ground"}
			MTVegan3["story"] = T{"     The VMC has announced Saturday to be Spudtato Day.  As the faction gains traction, so does their hold on Martian Cuisine, but perhaps this is one we can all get behind.  Let the fries flow!"}
			table.insert(g_MTSocialPotentialStories, MTVegan3)
			MTVegan2StorySent = "true"
		end
	end
end

function MTVegan4Story()
	if MTVegan4StorySent ~= "true" then
		if MTVeganPurgatory("check") == 36 then
			MTVegan4 = {}
			MTVegan4["title"] = T{"Vegan Martian Coalition Talks Stalled"}
			MTVegan4["story"] = T{"     Though the VMC has managed to garner the favor of our "..MTLeaderTitle.." "..MTLeader..", "..MTSponsor.." has claimed to receive millions of complaints from Earthlings who once desired to travel to Mars.  Applicants have begun to withdraw their applications by the thousands citing only one word on the cancellation form: 'bacon'.  While the backlash might dampen "..MTSponsor.."'s support, this reporter for one is pleased with the health benefits.  We'll keep you updated as the situation continues to progress."}
			table.insert(g_MTSocialPotentialStories, MTVegan4)
			MTVegan4StorySent = "true"
		end
	end
end


function MTDomeDelay1Story()
	if MTDomeDelay1StorySent ~= "true" then
		if UICity.day > 40 then
			if MTDomeDelayCheck() == 10 then
				MTEarthlingDelayName = MTGetEarthlingDelayName("set")
				MTEarthlingDelay1 = {}
				MTEarthlingDelay1["title"] = T{"Earthling Causes Delay"}
				MTEarthlingDelay1["story"] = T{"     If you've been wondering why no new domes have been built of late, look no further than "..MTEarthlingDelayName..".  Apparently they're now taking signatures for a petition to halt all mining operations, claiming them to be 'raping and pillaging Mars of its natural resources.'  The "..MTLeaderTitle.." has taken note of "..MTEarthlingDelayName.." and should be releasing a statement later this very sol."}
				table.insert(g_MTSocialPotentialStories, MTEarthlingDelay1)
				MTDomeDelay1StorySent = "true"
				MTDomeDelay2StoryWait("set")
			end
		end
	end
end

function MTDomeDelay2StoryWait(setoradd)
	if MTDomeDelay2StoryInitiated ~= "true" then
		if setoradd == "set" then
			MTDomeDelay2DaysWaiting = 0
		else
			if MTDomeDelay2DaysWaiting ~= nil then
				if MTDomeDelay2DaysWaiting == 3 then
					MTDomeDelay2Story()
					MTDomeDelay2StoryInitiated = "true"
				else
					MTNewDomeDelay2DaysWaiting = MTDomeDelay2DaysWaiting + 1
					MTDomeDelay2DaysWaiting = MTNewDomeDelay2DaysWaiting
				end
			end
		end
	end
end

function MTDomeDelay2Story()
	if MTDomeDelay2StorySent ~= "true" then
		MTEarthlingDelayName = MTGetEarthlingDelayName("check")
		if MTEarthlingDelayName ~= nil and MTEarthlingDelayName ~= "random earthling" then
			MTEarthlingDelay2 = {}
			MTEarthlingDelay2["title"] = T{"Earthling Claims To Be Misunderstood"}
			MTEarthlingDelay2["story"] = T{"     As proof that rumors travel faster than light, word of "..MTEarthlingDelayName.."'s attempt to halt mining operations has already reached "..MTSponsor.."'s ears on Earth.  While our sponsor yet to make any formal declarations, "..MTEarthlingDelayName.." has already gone on the record to declare that it was all a giant April Fool's Day joke.  Whether it is or not, it is not April, and this reporter is not amused."}
			table.insert(g_MTSocialPotentialStories, MTEarthlingDelay2)
			MTDomeDelay2StorySent = "true"
		end
	end
end

function MTGetEarthlingDelayName(setorcheck)
	if setorcheck == "set" then
		for k, colonist in ipairs (UICity.labels.Colonist) do
			if not colonist.traits["Martianborn"] then
				if MTEarthlingColonist == nil then
					MTEarthlingColonist = {}
				end
				MTEarthlingColonist = colonist
				MTEarthlingName = MTEarthlingColonist.name
				break
			end
		end
	else
		if MTEarthlingName == nil then
			MTEarthlingName = "random earthling"
		end
	end
	return MTEarthlingName
end

function MTGetCurrentDomeCount()
	if UICity.labels.Domes ~= nil then
		MTCurrentDomeCount = #UICity.labels.Domes
	end
	return MTCurrentDomeCount
end

function MTDomeDelayCheck()
	if MTDomeCount == nil then
		MTDomeCount = MTGetCurrentDomeCount()
		MTDomeDelayDays = 0
	else
		if MTDomeDelayDays == nil then
			MTDomeDelayDays = 0
		end
		if MTDomeCount == MTGetCurrentDomeCount() then
			MTNewDomeDelayDays = MTDomeDelayDays + 1
			MTDomeDelayDays = MTNewDomeDelayDays
		else
			MTDomeDelayDays = 0
		end
	end
	return MTDomeDelayDays
end

-- triggered by OnMsg.NewDay()
function MTTeenagerJoyrideStory()
	if MTTeenagerJoyrideStorySent ~= "true" then
		if CountColonistsWithTrait("Youth") > 0 then
			MTTeenagerJoyrideName = MTGetTeenagerJoyrideName("set")
			MTTeenagerJoyrideDome = MTGetTeenagerJoyrideDome("set")
			MTDroneHack1 = {}
			MTDroneHack1["title"] = T{"Teenager Takes Drone for a Joyride"}
			MTDroneHack1["story"] = T{"     Last night "..MTTeenagerJoyrideName.." hacked the code.  Working their way into the mainframe, one would expect havoc throughout the colony this morning, but apparently they had their sights set on something a little more exciting.    "..MTTeenagerJoyrideName.." simply took over a local drone and went out for a little joyride, eventually to end the ride face-first into the side of "..MTTeenagerJoyrideDome..", go figure.  Kids will be kids, I guess."}
			table.insert(g_MTSocialPotentialStories, MTDroneHack1)
			MTTeenagerJoyrideStorySent = "true"
			MTDroneHackCounter("start")
		end
	end
end

function MTGetTeenagerJoyrideDome(setorcheck)
	if setorcheck == "set" then
		if MTTeenagerColonist == nil then
			MTTeenagerDomeName = "random teenager's dome"
		else
			MTTeenagerDomeName = MTTeenagerColonist.dome.name
		end
	else
		if MTTeenagerDomeName == nil then
			MTTeenagerDomeName = "random teenager's dome"
		end
	end
	return MTTeenagerDomeName
end

function MTGetTeenagerJoyrideName(setorcheck)
	if setorcheck == "set" then
		if MTTeenagerColonist == nil then
			MTTeenagerColonist = {}
		end
		for k, colonist in ipairs (UICity.labels.Colonist) do
			if colonist.traits["Youth"] then
				MTTeenagerColonist = colonist
				MTTempTeenagerName = MTTeenagerColonist.name
				break
			end
		end
	else
		if MTTempTeenagerName == nil then
			MTTempTeenagerName = "random teenager"
		end
	end
	return MTTempTeenagerName
end

function MTDroneHackCounter(startoradd)
	if startoradd == "start" then
		MTDroneHackDay = UICity.day
	else
		if MTDroneHack2StoryInitiated ~= "true" then
			if UICity.day - MTDroneHackDay == 5 then  -- release DroneHack2 5 days after Joyride/DroneHack1
				MTDroneHack2Story()
				MTDroneHack2StoryInitiated = "true"
			end
		end
		if MTDroneHack3StoryInitiated ~= "true" then
			if UICity.day - MTDroneHackDay == 20 then  -- release DroneHack3 20 days after Joyride/DroneHack1
				MTDroneHack3Story()
				MTDroneHack3StoryInitiated = "true"
			end
		end
	end
end

function MTDroneHack2Story()
	if MTDroneHack2StorySent ~= "true" then
		if CountColonistsWithTrait("Youth") > 0 then
			MTDroneHack2Name = MTGetTeenagerJoyrideName("set")
			MTDroneHack2 = {}
			MTDroneHack2["title"] = T{"New Sport Established On Mars"}
			MTDroneHack2["story"] = T{"     Our Earthling counterparts might have their Ski Jumping, but we here on Mars have our very own Drone Jumping. After hacking a few drones last night, lead by "..MTDroneHack2Name..", several teenagers went joy riding in the dunes, eventually finding what has now been dubbed Marathon Hill as the site of Mars' very first Out-Dome sport: Drone Jumping."}
			table.insert(g_MTSocialPotentialStories, MTDroneHack2)
			MTDroneHack2StorySent = "true"
		end
	end
end

function MTDroneHack3Story()
	if MTDroneHack3StorySent ~= "true" then
		if UICity.labels.SecurityStation ~= nil then
			MTDroneHack3Name = MTGetDroneHack3Name("set")
			MTDroneHack3 = {}
			MTDroneHack3["title"] = T{"New Martian Law Enforced"}
			MTDroneHack3["story"] = T{"     "..MTDroneHack3Name.." was brought in to the Security Station last night on charges of Unsanctioned Drone Use.  Under the new Martian Law it is now prohibited to hack into drones for personal use.  To make things worse, "..MTDroneHack3Name.." is alleged to have been siphoning off Rare Metals for personal gain.  Expect formal charges in the coming days."}
			table.insert(g_MTSocialPotentialStories, MTDroneHack3)
			MTDroneHack3StorySent = "true"
		end
	end
end

function MTGetDroneHack3Name(setorcheck)
	if setorcheck == "set" then
		if MTDH3Colonist == nil then
			MTDH3Colonist = {}
		end
		MTGetHackerRandom = 0
		if UICity.labels.SecurityStation ~= nil then
			if UICity.labels.Colonist ~= nil then
				MTGetHackerRandom = Random(1,#UICity.labels.Colonist) 
				MTDH3Colonist = UICity.labels.Colonist[MTGetHackerRandom] -- random colonist is chosen
				MTDH3ColonistName = MTDH3Colonist.name
			end
		end
	else
		MTDH3ColonistName = "random drone hacker"
	end
	return MTDH3ColonistName
end


-- triggered by OnMsg.NewDay()
function MTRefuseHitsTheFanStory()
	if MTRefuseHitsFanStorySent ~= "true" then
		if UICity.labels.Diner[1] ~= nil then
			MTRefuseHitsFanDinerDome = MTGetRefuseHitsTheFanDinerDome()
			MTRefuseHitsTheFan = {}
			MTRefuseHitsTheFan["title"] = T{"The Refuse Hits The Fan"}
			MTRefuseHitsTheFan["story"] = T{"     Last night a sewage pump overflowed in "..MTRefuseHitsFanDinerDome.." when one of the pump's propellers broke under the pressure.  After what can only be described as a dining fiasco, last night's meal of extruded bean substitute seems to have played a critical role in overloading the sewage systems. There have been dozens of reports of a foul oder filling the dome even now.  Match usage is strictly prohibited until the blockage can be cleared. It will be a rough few days for everyone but there should be no lasting impact once the odor gets washed out of everyone's clothing once and for all."}
			table.insert(g_MTSocialPotentialStories, MTRefuseHitsTheFan)
			MTRefuseHitsFanStorySent = "true"
		end
	end
end

function MTGetRefuseHitsTheFanDinerDome()
	if #GetObjects{class = "Diner"} > 0 then
		MTTempDinerDome = UICity.labels.Diner[1].parent_dome.name
	else
		MTTempDinerDome = "dome with diner"
	end
	return MTTempDinerDome
end


-- if a dome has an OpenAirGym...
function MTOlympicBidStory()
	if MTOlympicBidStorySent ~= "true" then
		if #GetObjects{class = "OpenAirGym"} > 0 then
			MTOlympicBidGymDome = MTGetOlympicBidGymDome()
			MTOlympicBid = {}
			MTOlympicBid["title"] = T{"Olympic Bid Rejected"}
			MTOlympicBid["story"] = T{"     After the opening of our new open-air gym in "..MTOlympicBidGymDome..", "..MTSponsor.." applied to host the Olympics on Mars, saying, 'We have the best view of Mount Olympus and a Gym, what more could one ask for?' The International Olympics Committee on Earth rejected the proposal, saying 'Wait, that was an actual bid? You don't even have a pool.' "..MTSponsor.." responded by saying they will start their own Interstellar Olympics.  Expect track, blackjack, marbles, and Drone Jumping to headline the experience."}
			table.insert(g_MTSocialPotentialStories, MTOlympicBid)
			MTOlympicBidStorySent = "true"
		end
	end
end

-- first dome that has an open air gym
function MTGetOlympicBidGymDome()
	if #GetObjects{class = "OpenAirGym"} > 0 then
		MTTempGymDome = UICity.labels.OpenAirGym[1].parent_dome.name
	else
		MTTempGymDome = "dome with open air gym"
	end
	return MTTempGymDome
end

-- picks random colonist to target for Pet Rock story
-- triggered OnMsg.NewDay()
function MTPetRockStory()
	if MTPetRockStorySent ~= "true" then
		if UICity.labels.Colonist ~= nil then  -- if we have colonists
			MTPetRockColonistName = MTGetPetRockColonist("set")
			MTPetRock = {}
			MTPetRock["title"] = T{"Struggling Colonist Adopts Pet"}
			MTPetRock["story"] = T{"     "..MTPetRockColonistName..", like most of us, has been struggling to cope with the harsh Martian environment.  On Earth, many of us had pets to help us through the difficult days, but there are no dogs on Mars, so "..MTPetRockColonistName.." decided to adopt a pet rock instead.  What did they name this newfound source of comfort and snuggles?  Why, Olympus Mons, of course!  Hopefully little Oly can help them through these tough times."}
			table.insert(g_MTSocialPotentialStories, MTPetRock)
			MTPetRockStorySent = "true"
		end
	end
end

function MTGetPetRockColonist(setorcheck)
	if MTPetRockColonist == nil then
		MTPetRockColonist = {}
		MTPetRockColonistInterimName = "Pet Rock Owner"
	end
	if setorcheck == "set" then
		MTPetRockColonistRandom = Random(1,#UICity.labels.Colonist)  -- randomize
		MTPetRockColonist = UICity.labels.Colonist[MTPetRockColonistRandom]
		MTPetRockColonistInterimName = MTPetRockColonist.name
	else
		if MTPetRockColonistInterimName == nil then
			MTPetRockColonistInterimName = "Pet Rock Owner"
		end
	end
	return MTPetRockColonistInterimName
end


function MTLeaderDiedStory(MTDeadColonist)
	MTDeadLeader = MTDeadColonist.name
	MTDeadLeaderRandom = Random(1,2)
	if MTLeaderDied1 == nil then
		MTLeaderDied1 = {}
	end
	if MTLeaderDied2 == nil then
		MTLeaderDied2 = {}
	end
	if MTDeadLeaderRandom == 1 then
		MTLeaderDied1["title"] = T{"Mars is in Mourning"}
		MTLeaderDied1["story"] = T{"     Today is a solemn day.  "..MTLeaderTitle.." "..MTDeadLeader.." no longer walks the world of the living.  Martian society would not be what it is today without the indelible touch of "..MTLeaderTitle.." "..MTDeadLeader.." in so many places.  Please take a moment today to stop by your local spacebar and lift one up in honor of the late, great "..MTLeaderTitle..".  What are your best memories of the now former "..MTLeaderTitle.."?  Send in your letters to the editor.  Select entries will be printed in Thursday's edition.  Thank you for your service, "..MTLeaderTitle..".  You will be missed."}
		table.insert(g_MTTopPotentialStories, MTLeaderDied1)
	elseif MTDeadLeaderRandom == 2 then
		MTLeaderDied2["title"] = T{"Mars Mourns "..MTLeaderTitle.."'s Passing"}
		MTLeaderDied2["story"] = T{"     "..MTLeaderTitle.." "..MTDeadLeader.." served us honorably for many a sol and their passing has not gone unnoticed.  Despite serving Mars well during their tenure, it is suspected that they never quite fully adapted to the realities of life on Mars and between the stresses of daily Martian life, serving as our "..MTLeaderTitle..", and many a sleepless night, a heart attack finally took them from us.  May your slumber, "..MTLeaderTitle.." "..MTDeadLeader..", be deep and pleasant.  You will be missed."}
		table.insert(g_MTTopPotentialStories, MTLeaderDied2)
	end
	MTNewLeaderChosenStory("start")
end

function MTLeaderDiedNameCheck()
	if MTDeadLeader == nil then
		MTDeadLeader = "dead leader"
	end
	return MTDeadLeader
end

function MTNewLeaderChosenStory(startadd)
	if startadd == "start" then   -- only comes from the death notice of an old leader
		MTNewLeaderChosenIndex = 0
		MTNewLeaderChosenStoryRelease(MTNewLeaderChosenIndex)
	elseif startadd == "add" then  -- comes from New Day, only if MTNewLeaderChosenIndex isn't nil
		if MTNewLeaderChosenIndex ~= nil then  -- index resets when new leader story is inserted
			MTNewLeaderChosenNewIndex = MTNewLeaderChosenIndex + 1
			MTNewLeaderChosenIndex = MTNewLeaderChosenNewIndex  
			MTNewLeaderChosenStoryRelease(MTNewLeaderChosenIndex)
		end
	end
end

-- 3 days after old leader dies, new leader gets a news story
function MTNewLeaderChosenStoryRelease(MTNewLeaderChosenIndex)
	if MTNewLeaderChosenIndex == 3 then
		MTNewLeaderStoryRandom = Random(1,3)
		if MTNewLeaderStoryRandom == 1 then
			MTNewLeaderStory1 = {}
			MTNewLeaderStory1["title"] = T{"A New "..MTLeaderTitle.." Takes the Helm"}
			MTNewLeaderStory1["story"] = T{"As "..MTLeader.." steps in to assume the recently vacated role of "..MTLeaderTitle..", we can hope that they get their bearings in short order.  We here at the Martian Tribune will keep you apprised of any decrees and movements of the "..MTLeaderTitle..".  A new day is dawning here on Mars.  The question remains, however: is that a day of dawning, or a day of darkness.  Our fate is in your hands, "..MTLeaderTitle..".  Don't let us down."}
			table.insert(g_MTTopPotentialStories, MTNewLeaderStory1)
		elseif MTNewLeaderStoryRandom == 2 then
			MTNewLeaderStory2 = {}
			MTNewLeaderStory2["title"] = T{" "..MTLeader.." Breathes New Life Into Colony"}
			MTNewLeaderStory2["story"] = T{"A new "..MTLeaderTitle.." has been chosen!  It is time to rejoice, for my fellow Martians, the future is bright!  "..MTLeader.." steps in as our new "..MTLeaderTitle.." today and we could not be in better hands.  With "..MTLeader.."'s past work here on Mars, we can expect big plans to continue to balance out the workload and supply chain even further, as well as to care for the aging and nurture the young.  Today, the Martian Tribune declares: the future is bright.  It is time to celebrate!"}
			table.insert(g_MTTopPotentialStories, MTNewLeaderStory2)
		elseif MTNewLeaderStoryRandom == 3 then
			MTNewLeaderStory3 = {}
			MTNewLeaderStory3["title"] = T{"Wrong Sibling Elevated?"}
			MTNewLeaderStory3["story"] = T{"As we move into a new era of Martian development, we here at the Martian Tribune can’t help but wonder at the agenda of our sponsor, "..MTSponsor..".  Perhaps someone mixed up their paperwork, but somehow they saw fit to raise "..MTLeader.." to the role of "..MTLeaderTitle.." without recognizing that more than one person shares that last name.  The responsibilities are vast in leading such an intrepid endeavor as ours here on Mars.  Let's hope and pray (hard) that "..MTLeader.." is up to the challenge."}
			table.insert(g_MTTopPotentialStories, MTNewLeaderStory3)
		end
		MTNewLeaderChosenIndex = nil
		MTNewLeaderChosenNewIndex = nil
	end
end

--- if these story remains in the table after humans have arrived, remove it
function MTNoHumansStory()
	if MTNoHumansStoryRemoved ~= "true" then
		if MTColonistsArrivedCheck("check") ~= nil then
			for k, v in (g_MTTopPotentialStories) do
				if v == MTNoHumans then
				table.remove(g_MTTopPotentialStories, k)
				MTNoHumansStoryRemoved = "true"
				break
				end
			end
		end
	end
end

--  A variable to check.  true after colonists have arrived
function MTColonistsArrivedCheck(MTColonistCheckOrTrue)
	if MTColonistCheckOrTrue == "true" then
		MTColonistsHaveArrived = "true"
	elseif MTColonistCheckOrTrue == "check" then
		return MTColonistsHaveArrived
	end
end

-- prompted via OnMsg.NewDay()
function MTTopCheckFinances()
	if MTFinancesStorySent ~= "true" then
		if ResourceOverviewObj:GetFunding() < 300000000 then  -- if less than 300m funding is available
			MTSendFinancesStory = "true"
		end
		if MTSendFinancesStory == "true" then
			MTFinanceStoryRandom = Random(1,2)
			if MTFinanceStoryRandom == 1 then
				table.insert(g_MTTopPotentialStories, MTFinances1)
			elseif MTFinanceStoryRandom == 2 then
				table.insert(g_MTTopPotentialStories, MTFinances2)
			end
		MTFinancesStorySent = "true"
		end
	end
end


--  checks for current on-planet rocket count.  Determines release of MTrockets0 and MTRockets3
--  will check each day after Sol 10
function MTRocketCount()
	if UICity.day > 10 then
		MTcurrentSupplyRocketCount = #GetObjects{class = "SupplyRocket"}
		if MTrockets3StorySent ~= "true" then
			if MTcurrentSupplyRocketCount > 2 then
				table.insert(g_MTTopPotentialStories, MTrockets3)
				MTrockets3StorySent = "true"
			end
		end
		if MTrockets0StorySent ~= "true" then
			if MTcurrentSupplyRocketCount == 0 then
				table.insert(g_MTTopPotentialStories, MTrockets0)
				MTrockets0StorySent = "true"
			end
		end
		if MTRocketObservationStorySent ~= "true" then
			if MTCurrentSupplyRocketCount > 1 then
				MTMostRecentRocket = MTGetMostRecentRocket()
				MTRocketObservation = {}
				MTRocketObservation["title"] = T{"Drones Watch In Awe"}
				MTRocketObservation["story"] = T{"     All the Drones on Mars watch in amazement as the rocket "..MTMostRecentRocket.." lands safely on the surface. Kicking up storm of red dust, this rocket brings us even closer to the dream of a future of Martian civilisation."}
				table.insert(g_MTEngPotentialStories, MTRocketObservation)
				MTRocketObservationStorySent = "true"
			end
		end
	end
end

function MTGetMostRecentRocket()
	if #GetObjects{class = "SupplyRocket"} > 1 then
		MTRecentRocket = GetObjects{class = "SupplyRocket"}[#GetObjects{class = "SupplyRocket"}].name
	else
		if MTRecentRocket == nil then
			MTRecentRocket = "recent rocket"
		end
	end
	return MTRecentRocket
end

-- prompted via OnMsg.NewDay()  -- if Deep Scanning is researched and 2 or fewer sensor towers release story
function MTCheckHackThePlanet()
	if UICity:IsTechResearched("DeepScanning") ~= nil then
		if MTHackThePlanetStorySent ~= "true" then
			if #GetObjects{class = "SensorTower"} < 3 then
				table.insert(g_MTTopPotentialStories, MTHackThePlanet)
				MTHackThePlanetStorySent = "true"
			end
		else  -- if more than 2 sensor towers, then story is removed
			if MTHackThePlanetStoryRemoved ~= "true" then  
				if #GetObjects{class = "SensorTower"} > 2 then
					table.remove(g_MTTopPotentialStories, MTHackThePlanet)
					MTHackThePlanetStoryRemoved = "true"
				end
			end
		end
	end
end

-- triggered by OnMsg.NewDay
function MTCheckFoundersLegacy()
	if MTColonistsArrivedCheck("check") == "true" then
		if MTFoundersDeadSolSet ~= "true" then
			if CountColonistsWithTrait("Founder") == 0 then
				MTFoundersDeadSol = UICity.day
				MTFoundersDeadSolSet = "true"
			end
		else
			MTFoundersMourningPeriod = UICity.day - MTFoundersDeadSol
			MTFoundersLegacyRelease(MTFoundersMourningPeriod)
		end
	end
end

 function MTFoundersLegacyRelease(MTFoundersMourningPeriod)
	if MTFoundersLegacyStorySent ~= "true" then
		if MTFoundersMourningPeriod == 10 then
			MTFoundersLegacyDome = MTGetFoundersLegacyDome("set")
			MTFoundersLegacyBuilding = MTGetFoundersLegacyBuilding("set")
			MTFounders = {}
			MTFounders["title"] = T{"The Founder's Legacy"}
			MTFounders["story"] = T{"     There are only 12 people who will ever be known as Founders.  These extraordinary men and women risked their lives to venture into the Final Frontier and gain a foothold on the Red Planet.  They toiled day and night, working non-stop to ensure constant and consistent air flow, water pressure, power generation, and more.  As we go about our sol we must remember to take a moment and honor those who came before us, those who made all that we see around us possible.  We will be celebrating Founder's Sol at noon tomorrow at the "..MTFoundersLegacyBuilding.." in "..MTFoundersLegacyDome.." where we will be taking 12 minutes of silence in memory of these most excellent of individuals."}
			table.insert(g_MTTopPotentialStories, MTFounders)
			MTFoundersLegacyStorySent = "true"
		end
	end
end

function MTGetFoundersLegacyDome(setorcheck)
	if setorcheck == "set" then
		if UICity.labels.Domes[1] ~= nil then
			MTFoundersDomeName = UICity.labels.Domes[1].name
		else
			MTFoundersDomeName = "every dome"
		end
	else
		MTFoundersDomeName = "every dome"
	end
	return MTFoundersDomeName
end

function MTGetFoundersLegacyBuilding(setorcheck)
	if setorcheck == "set" then
		if UICity.labels.Domes[1] ~= nil then
			MTFoundersDome = UICity.labels.Domes[1]
			if MTFoundersDome.labels.Spacebar ~= nil then
				MTFoundersDomeRelaxation = "Spacebar"
			else
				if MTFoundersDome.labels.OpenAirGym ~= nil then
					MTFoundersDomeRelaxation = "Open Air Gym"
				else
					if MTFoundersDome.labels.GardenStone ~= nil then
						MTFoundersDomeRelaxation = "Stone Garden"
					else
						if MTFoundersDome.labels.FountainLarge ~= nil then
							MTFoundersDomeRelaxation = "Fountain"
						else
							if MTFoundersDome.labels.GardenNatural_Medium ~= nil then
								MTFoundersDomeRelaxation = "Natural Garden"
							else
								if MTFoundersDome.labels.Apartments ~= nil then
									MTFoundersDomeRelaxation = "Apartments"
								else
									if MTFoundersDome.labels.LivingQuarters ~= nil then
										MTFoundersDomeRelaxation = "Living Quarters"
									end
								end
							end
						end
					end
				end
			end
		else
			MTFoundersDomeRelaxation = "your local park"
		end
	else
		MTFoundersDomeRelaxation = "your local park"
	end
	return MTFoundersDomeRelaxation
end

function MTCheckAdultFilm()
	if MTAdultFilmStorySent ~= "true" then
		if UICity.day > 20 then
			if CountColonistsWithTrait("Sexy") > 2 then
				MTSexyColonistName = MTGetSexyColonist("set")
				MTSponsor = MTGetSponsor(GetMissionSponsor().name)
				MTAdultFilm = {}
				MTAdultFilm["title"] = T{"SpaceXXX"}
				MTAdultFilm["story"] = T{"     In an unexpected turn of events, "..MTSexyColonistName.." has officially produced the first ever Martian adult film.  Starring 11 different colonists with "..MTSexyColonistName.." as the lead, it has become quite a hit on earth.  The film also provides a sneak peek into Martian pipe work and our stockpiles of electronics and machine parts in the background.  "..MTSponsor.." has declared themselves not responsible for the social implications of such actions, but did praise the artistic vision of the Director calling it a 'unique and innovative production'."}
				table.insert(g_MTTopPotentialStories, MTAdultFilm)
				MTAdultFilmStorySent = "true"
			end
		end
	end
end

function MTGetSexyColonist(status)
	if MTSexyColonist == nil then
		MTSexyColonist = {}
	end
	MTSexyColonistName = "sexy colonist"
	if status == "set" then
		for k, colonist in ipairs (UICity.labels.Colonist or empty_table) do
			if colonist.traits["Sexy"] then
				MTSexyColonist = colonist
				MTSexyColonist:TogglePin()
				MTSexyColonistName = MTSexyColonist.name
				MTSexyColonistSelected = "true"
				break
			end
		end
	end
	return MTSexyColonistName
end

function MTCheckDroneRights()
	if MTDroneRightsStorySent ~= "true" then
		if CountColonistsWithTrait("Idiot") > 0 then
			MTDroneColonistName = MTGetIdiotColonist("set")
			MTDroneRights = {}
			MTDroneRights["title"] = T{"Push For Drone Rights"}
			MTDroneRights["story"] = T{"It has been reported that a local alliance of Martians believe that because so many drones are now integral to our daily lives they now deserve the same rights as colonists. "..MTDroneColonistName..",  the leader of the self-dubbed Drone Alliance for Freedom and Transparency (DAFT) has stated that 'these drones do more work then all of the humans on mars combined' when asked if this meant drones should be able to vote as well "..MTDroneColonistName.." responded, 'what? no. That's ridiculous. they are machines...'"}
			table.insert(g_MTTopPotentialStories, MTDroneRights)
			MTDroneRightsStorySent = "true"
		end
	end
end

function MTGetIdiotColonist(status)
	if MTIdiotColonist == nil then
		MTIdiotColonist = {}
	end
	if status == "set" then
		for k, colonist in ipairs (UICity.labels.Colonist or empty_table) do
			if colonist.traits["Idiot"] then
				MTIdiotColonist = colonist
				MTIdiotColonistName = MTIdiotColonist.name
				MTIdiotColonistSelected = "true"
				break
			end
		end
	elseif status == "colonist" then
		if MTIdiotColonist ~= nil then
			return MTIdiotColonist
		end
	else
		if 	MTIdiotColonistName == nil then
			MTIdiotColonistName = "idiot colonist"
		end
		return MTIdiotColonistName
	end
end


-- Section 4: story table initialization and population
function MTInitializeStoryTables() -- loading all the story titles and stories when Mods get loaded so that they're always available globally
	
	MTNoNews = {}
	MTTopArchiveDepleted = {}
	MTArchiveDepleted2 = {}
	g_MTTopPotentialStories = {}
	g_MTTopFreeStories = {}
	g_MTTopArchive = {}
	MTTopCurrentStory = {}
	MTNewTopStory = {}
	MTTempTopArchive = {}
	MTTopArchive1 = {}
	MTTopArchive2 = {}

	MTEngArchiveDepleted = {}
	g_MTEngPotentialStories = {}
	g_MTEngFreeStories = {}
	g_MTEngArchive = {}
	MTEngCurrentStory = {}
	MTNewEngStory = {}
	MTTempEngArchive = {}
	MTEngArchive1 = {}
	MTEngArchive2 = {}

	MTSocialArchiveDepleted = {}
	g_MTSocialPotentialStories = {}
	g_MTSocialFreeStories = {}
	g_MTSocialArchive = {}
	MTSocialCurrentStory = {}
	MTNewSocialStory = {}
	MTTempSocialArchive = {}
	MTSocialArchive1 = {}
	MTSocialArchive2 = {}

	-- these tables are specifically to support story release functions
	MTColonistDied = {}
	MTFoundersDome = {}

	-- initializing the tables related to the Top Stories.  This is done here so that we can rest assured that the tables already exist before we attempt to populate them in the next function below.

	MTNoHumans = {}
	MTrockets3 = {}
	MTrockets0 = {}
	MTHackThePlanet = {}
	MTFinances1 = {}
	MTFinances2 = {}
	MTFinances3 = {}

	--SocialFree
	MTPoliticalAmbitions = {}
	MTMarsCheese = {}
	MTDroneToys = {}
	MTMartianMusic = {}
	MTMysteriousRadio = {}
	--EngFree
	MTISSSovereignty = {}
	MTWoodys = {}
	--TopFree
	MTWeAreMartian = {}
	MTOnThisDayin1965 = {}
	MTOnThisDayin1976 = {}
	MTOnThisDayin1997 = {}
	MTOnThisDayin2015 = {}
end

function MTLoadStoriesIntoTables()
---- it is necessary to define these variables before the stories get loaded so that the variables may be referenced from within

	MTLeader = MTGetLeader()
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTArchiveIndex = 1


	---- These stories are all Top Stories.  If they are contingent on certain circumstances, they will be added to the g_MTTopPotentialStories when their conditions have been met.  Top Stories that have no conditions will automatically be added to g_MTTopFreeStories from the start.

	---- Begin section defining the tables for the conditional Top Stories

	MTNoNews["title"] = T{"No news of interest at this point in time."}
	MTNoNews["story"] = T{" "}

	MTTopArchiveDepleted["title"] = T{"<newline>     The Top Story Archives have been depleted."}
	MTTopArchiveDepleted["story"] = T{" "}

	MTEngArchiveDepleted["title"] = T{"<newline>     The Engineering Story Archives have been depleted."}
	MTEngArchiveDepleted["story"] = T{" "}

	MTSocialArchiveDepleted["title"] = T{"<newline>     The Social Story Archives have been depleted."}
	MTSocialArchiveDepleted["story"] = T{" "}

	MTArchiveDepleted2["title"] = T{" "}
	MTArchiveDepleted2["story"] = T{" "}

	MTNoHumans["title"] = T{"01101101 01100101 00100000 01110011 01100001 01100100"}
	MTNoHumans["story"] = T{"    01000100 01110010 01101111 01101110 01100101 01110011 00100000 01101100 01101111 01101110 01100101 01101100 01111001 00101100 00100000 01100010 01110010 01101001 01101110 01100111 00100000 01101000 01110101 01101101 01100001 01101110 01110011 00100000 01110000 01101100 01100101 01100001 01110011 01100101 00101110"}
	table.insert(g_MTTopPotentialStories, MTNoHumans)

	MTrockets3["title"] = T{"Rocket Silhouettes Mar Martian Landscape"}
	MTrockets3["story"] = T{"    With so many rockets planetside, one would think that we have more than enough to succeed and flourish, but all those resources are languishing in the hands of "..MTLeaderTitle.." "..MTLeader..".  Perhaps it's time to fire up that Drone Assembler, a few more Fuel Refineries, and redistribute the workload.  If things remain as they are, who knows how much longer "..MTLeaderTitle.." "..MTLeader.." will remain in office..."}

	MTrockets0["title"] = T{" "..MTLeaderTitle.." Sets High Standard"}
	MTrockets0["story"] = T{"    With the "..MTLeaderTitle.."'s efficient and effective use of Earth's resupply we are well on our way to gaining a strong foothold on the Red Planet.  This begs the question: are you doing your part? As we continue to develop our resources, and our culture, on this planet each one of us plays an integral role in leading us closer and closer to the safety and security that we need.  Follow "..MTLeaderTitle.." "..MTLeader.."'s example!  How can you become more efficient and effective today?  Let us know in your letter to the editor!  Select letters will be published in Saturday's edition."}

	MTHackThePlanet["title"] = T{"Hack the planet!"}
	MTHackThePlanet["story"] = T{"    Our primary manifesto as a society is to populate the Red Planet.  Someone should remind "..MTLeaderTitle.." "..MTLeader.." about that.  They seem to think that scanning the surface and finding suitable resources and dome locations serves no particular purpose.  Have you seen our metals supply lately?  This water isn't going to last forever, you know.  We need more Sensor Towers.  When will we learn from the past?  The time is now!  This planet is ours for the taking, but only if we know what's out there!"}
	
	MTFinances1["title"] = T{"Sponsor Funds Depleted"}
	MTFinances1["story"] = T{"     "..MTSponsor.." has confirmed for the Martian Tribune that the rapidly spreading rumor that they are now broke with no money left to spare in support of the Martian endeavor is, in fact, true.  It is up to us, the people of mars to support ourselves.  Hopefully our local administrators will work to remedy the situation and prove our worth to our sponsor once more."}

	MTFinances2["title"] = T{"Sponsor Cites Insider Trading Woes"}
	MTFinances2["story"] = T{"     "..MTSponsor.." has gone belly-up in the face of a massive insider trading scheme that has taken down over half of their senior management.  Who knew that colonizing Mars could be such a politically, financially and socially fraught endeavor?  We did, "..MTSponsor..".  We all did.  Shame on you."}
	


-- These stories are all preset and without conditions.  They are intended to be a part of g_MTTopFreeStories{} from the very start and are our fall-backs in case we run out of contingent stories to declare.
		
	MTWeAreMartian["title"] = T{"We Are Martian"}
	MTWeAreMartian["story"] = T{"     This is our world now.  The world of rare metals, electronics and universal depots.  On Earth war is waged over economics, religion, and borders.  Here we fight for survival on a primal level.  We are the Martian people.  We will not give up.  We will not give in.  We will continue to build, continue to expand and populate this planet.  No meteor storm will stop us.  We are Martian."}
	table.insert(g_MTTopFreeStories, MTWeAreMartian)
		
	MTOnThisDayin1965["title"] = T{"On This Day in 1965"}
	MTOnThisDayin1965["story"] = T{"     On July 14th in 1965 Mariner 4 was sent to space by NASA took the first ever photos of the Martian surface.  Have you taken any photos that you're particularly proud of?  Share them today at r/SurvivingMars!"}
	table.insert(g_MTTopFreeStories, MTOnThisDayin1965)
--		
	MTOnThisDayin1976["title"] = T{"On This Day in 1976"}
	MTOnThisDayin1976["story"] = T{"     On July 20th in 1976 Viking 1 pulled out the landing gear and set down on Martian soil for the first time in human history.  What we have come to accomplish in such few years since then is nothing less than incredible.  What an experience it is to actually set foot on Mars and to literally, walk among the stars!"}
	table.insert(g_MTTopFreeStories, MTOnThisDayin1976)
		
	MTOnThisDayin1997["title"] = T{"On This Day in 1997"}
	MTOnThisDayin1997["story"] = T{"     On July 4th in 1997 NASA set down the very first actual rover on the Red Planet.  Shortly after the Mars Pathfinder landed, Sojourner, a solar-powered rover, rolled out and began to scan the surface.  Expected to last just 7 sol, it was finally called to a stop after 91 sol having traveled a total of just over 100 meters and sent a myriad of photos back to Earth for study."}
	table.insert(g_MTTopFreeStories, MTOnThisDayin1997)
		
	MTOnThisDayin2015["title"] = T{"On This Day in 2015"}
	MTOnThisDayin2015["story"] = T{"     On September 28th in 2015 NASA announced that the Mars Reconnaissance Orbiter had officially encountered water flowing along the Martian surface.  While it might seem like a foregone conclusion to us today, such news at the time proved quite the breakthrough, leading NASA Administrator Bolden to declare that NASA 'is firmly on a journey to Mars.'"}
	table.insert(g_MTTopFreeStories, MTOnThisDayin2015)

	MTPoliticalAmbitions["title"] = T{"Political Ambitions Set Too High?"}
	MTPoliticalAmbitions["story"] = T{"     A politician on Earth has stated the obvious this week by claiming that Mars is red.  The hopeful senator took it a step further by declaring that Mars is a also a communist planet, with 'nothing but red, red, red'.  After performing some reconnissance here at the Martian Tribune Headquarters, we would like to confirm that Mars is indeed red.  The claims of communism getting a foothold, however, will have to be fielded by the "..MTLeaderTitle.."."}
	table.insert(g_MTSocialFreeStories, MTPoliticalAmbitions)

	MTISSSovereignty["title"] = T{"ISS Declares Sovereignty"}
	MTISSSovereignty["story"] = T{"     The International Space Station orbiting Earth has recently declared itself a free, sovereign, and independent state, capable of enacting its own laws and governance. There was some opposition from many nations on earth. However once threats of crashing the mega structure into the planet reached Earth, many Earthlings rapidly changed their mind on the matter. Mars itself has become the first entity to recognize the independent state of the ISS and will be holding a press conference on the matter in the coming days."}
	table.insert(g_MTEngFreeStories, MTISSSovereignty)

	MTMarsCheese["title"] = T{"US President Confirms: Not A Scientist"}
	MTMarsCheese["story"] = T{"     The current president of the United States, after staring intently at several photos of the Red Planet, prceeded to ask his scientific advisors if Mars is actually made of cheese. The researchers reminded the president that Mars is mostly made of rock, and that it is, in fact, the Moon that is made of cheese."}
	table.insert(g_MTSocialFreeStories, MTMarsCheese)

	MTDroneToys["title"] = T{"Drone Toy Sales Through The Roof"}
	MTDroneToys["story"] = T{"     With all of the photos and videos sent back to Earth, the popularity of the miniature toy replica of a standard martian drone are much higher then anticipated with the toy breaking first week sales records on all across the globe. The remote controlled mini drone, which sells at over 400 dollars each, has been sold out in most places. With the shortage, and with christmas so soon, it's sad to say, but some children may be dissapointed this year."}
	table.insert(g_MTSocialFreeStories, MTDroneToys)

	MTMysteriousRadio["title"] = T{"Mysterious Radio Station Causes Concern"}
	MTMysteriousRadio["story"] = T{"     The martian planet is being entertained by the great hosts at Mars Radio One, among other stations, but what has the Martian Tribune concerned is that there are no facilities to broadcast a radio station here on Mars. Come to think of it, there are no facilities to make a newspaper either... let's just let that slide then."}
	table.insert(g_MTSocialFreeStories, MTMysteriousRadio)

	MTWoodys["title"] = T{"Woody's Woods to Expand to Mars"}
	MTWoodys["story"] = T{"Woodys Woods, a tree-felling business of Cities Skylines fame, has decided to expand its operations to Mars. This Decision has come as a surprise to many people, mainly because there are no trees on Mars.  When asked about this, Woody responded, 'I'm sure we'll find something to cut down!'"}
	table.insert(g_MTEngFreeStories, MTWoodys)

end

function MTDelVar()  -- clears out all variables for testing purposes
	g_MTTopFreeStories = nil
	g_MTTopPotentialStories = nil
	g_MTTopArchive = nil
	MTWeAreMartian = nil
	MTrockets0 = nil
	MTrockets3 = nil
	MTOnThisDayin1965 = nil
	MTOnThisDayin1976 = nil
	MTOnThisDayin1997 = nil
	MTOnThisDayin2015 = nil
	MTNoHumans = nil
	MTHackThePlanet = nil
	MTFinances1 = nil
	MTFinances2 = nil
	MTFinances3 = nil
	MTSponsor = nil
	MTLeader = nil
	MTLeaderTitle = nil
	MTTopStoryRandom = nil
	MTTopCurrentStory = nil
	MTEngArchiveDepleted = nil
	g_MTEngPotentialStories = nil
	g_MTEngFreeStories = nil
	g_MTEngArchive = nil
	MTEngCurrentStory = nil
	MTNewEngStory = nil
	MTTempEngArchive = nil
	MTEngArchive1 = nil
	MTEngArchive2 = nil
	MTSocialArchiveDepleted = nil
	g_MTSocialPotentialStories = nil
	g_MTSocialFreeStories = nil
	g_MTSocialArchive = nil
	MTSocialCurrentStory = nil
	MTNewSocialStory = nil
	MTTempSocialArchive = nil
	MTSocialArchive1 = nil
	MTSocialArchive2 = nil
	MTColonistDied = nil
	MTFoundersDome = nil
	MTFoundersDeadCount = nil
	MTFoundersLegacyDome = nil
	MTFoundersLegacyBuilding = nil
	MTFounders = nil
	MTFoundersDomeRelaxation = nil
	MTFoundersDomeName = nil
	MTFoundersDeadSolSet = nil
	MTFoundersMourningPeriod = nil
	MTFoundersDeadSol = nil
	MTFoundersLegacyStorySent = nil
	MTNoHumansStoryRemoved = nil
	MTFinancesStorySent = nil
	MTrockets3StorySent = nil
	MTrockets0StorySent = nil
	MTHackThePlanetStorySent = nil
	MTHackThePlanetStoryRemoved = nil
	MTAdultFilm = nil
	MTAdultFilmStorySent = nil
	MTSexyColonistName = nil
	MTSexyColonist = nil
	MTIdiotColonist = nil
	MTIdiotColonistName = nil
	MTDroneColonistName = nil
	MTDroneRightsStorySent = nil
	MTLeaderColonist = nil
	MTGetLeaderTrait = nil
	MTGetLeaderTableRandom = nil
	MTGetLeaderTable = nil
	MTDeadLeader = nil
	MTDeadLeaderRandom = nil
	MTDeadColonist = nil
	MTNewLeaderStory1 = nil
	MTNewLeaderStory2 = nil
	MTNewLeaderStory3 = nil
	MTNewLeaderStoryRandom = nil
	MTNewLeaderChosenIndex = nil
	MTNewLeaderChosenNewIndex = nil
	MTLeaderDied1 = nil
	MTLeaderDied2 = nil
	MTPetRockStorySent = nil
	MTPetRockColonistName = nil
	MTPetRockColonistInterimName = nil
	MTPetRock = nil
	MTPoliticalAmbitions = nil
	MTTeenagerColonist = nil
	MTTempTeenagerName = nil
	MTTeenagerDomeName = nil
	MTTeenagerJoyrideName = nil
	MTTeenagerJoyrideDome = nil
	MTTeenagerJoyrideStorySent = nil
	MTDH3ColonistName = nil
	MTDH3Colonist = nil
	MTDroneHack3StorySent = nil
	MTDroneHackDays = nil
	MTDroneHack2StoryInitiated = nil
	MTDroneHack2StorySent = nil
	MTVeganColonist = nil
	MTVeganColonistName = nil
	MTVegan1MedicColonist = nil
	MTVegan1MedicColonistName = nil
	MTVegan1StoryHasBeenSent = nil
	MTVeganPurgatoryDays = nil
	MTNewVeganPurgatoryDays = nil
	MTVeganStory2HasBeenSent = nil
	MTVeganColonist = nil
	MTVDDome = nil
	MTVeganDinerColonist = nil
	MTVeganColonistName = nil
	MTRMWorkerDome = nil
	MTRMWorkerDomeName = nil
	MTRMColonist = nil
	MTRMColonistName = nil
	MTGetColonistRandom = nil
	MTBotanistColonist = nil
	MTBotanistColonistName = nil
	MTHippieStorySent = nil
	MTDomeDelay2StoryInitiated = nil
	MTMovingDomesStorySent = nil
	MTRareMetalsComplaintStorySent = nil
	MTConcretePavingStorySent = nil
	MTVeganDinerStorySent = nil
	MTVegan3StorySent = nil
	MTVegan4StorySent = nil
	MTDomeDelay1StorySent = nil
	MTDomeDelay2StorySent = nil
	MTNoNews = nil
	MTTopArchiveDepleted = nil
	MTSocialArchiveDepleted = nil
	MTEngArchiveDepleted = nil
	MTArchiveDepleted2 = nil


end