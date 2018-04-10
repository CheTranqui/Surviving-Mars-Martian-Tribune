
function OnMsg.NewDay()
	if g_MTPotentialMainStories == nil then
		MTInitializeStoryTables()
		MTLoadStoriesIntoTables()
	end
end

function OnMsg.NewHour()
	if (UICity.hour % 2 == 0) == true then
		if MTNewStoryPushed ~= true then
			MTGetNewStories()  -- pushes new stories into the queue
			MTNotification()  -- loads primary mod notification
			MTNewStoryPushed = true  -- keeps this from triggering a 2nd time on the same day
		end
	else
		MTNewStoryPushed = nil  -- only happens on days that the IF portion doesn't trigger.  Resets this variable so that new stories get pushed the next time around
	end
end
--	MTMainCheckRocketCount()  -- these are all checking contingencies and adding potential stories to their relative Potential lists
--	MTMainCheckHackThePlanet()
--	MTMainCheckFinances()
--	MTMainCheckFounders()
--	MTMainCheckAdultFilm()
--	MTMainCheckNoHumans()

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

function MTGetSponsor(name)
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
	if MTSponsors[name] == nil then
		return "Mission Sponsor"
	else
		return MTSponsors[name]
	end
end
		
function MTGetLeaderTitle(name)
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
	end
end

function MTGetLeader()
	MTCurrentLeader = "Random Person"
	return MTCurrentLeader
end

function MTGetNewStories()  -- calls for each individual section to probe for its own set of stories
	MTSetTopStory("push")
--	MTGetFrontPageEngStory()
--	MTGetFrontPageSocialStory()
end

function MTFrontPagePopup()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTTopFPStory = MTSetTopStory("pull")
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Today's Headlines"},
            text = T{"Top Story:  <MTFrontPageStoryTitle> <newline><newline> <MTFrontPageStory><newline><newline><newline> Other Headlines:<newline>     Eng:  <MTEngHeadline><newline>     Social:  <MTSocialHeadline><newline>", MTFrontPageStoryTitle = MTTopFPStory.title, MTFrontPageStory = MTTopFPStory.story, MTEngHeadline = "", MTSocialHeadline = "", MTLeaderTitle, MTLeader, MTSponsor}, -- Front Page text
            choice1 = T{"View Top Story Archives"},
            choice2 = T{"View Engineering Story"},
			choice3 = T{"View Social Story"},
			choice4 = T{"Close"},
            image = MT_mod_dir.."UI/Newspaper_Message_Image.tga",
        } -- params
        local choice = WaitPopupNotification(false, params)
        if choice == 1 then
			MTArchiveIndex = #g_MTTopArchive - 1  -- index starts at max-1 because the last story is current
			MTTopArchivePopup()  -- opens Top Story popup
--		elseif choice == 2 then
--			MTEngPopup()  -- opens Engineering popup
--		elseif choice == 3 then
--			MTSocialPopup()  -- opens Social popup
        end -- if statement
    end ) -- end CreateRealTimeThread
end -- function end

function MTTopArchivePopup()
	MT_mod_dir = Mods["lf1iELO"]:GetModRootPath()
	MTTopArchive1 = MTGetTopArchives(MTArchiveIndex)
	MTTopArchive2 = MTGetTopArchives(MTArchiveIndex - 1)
	if MTTopArchive1 == MTTopArchive2 then
		MTTopArchive2.title = " "
		MTTopArchive2.story = " "
	end
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Top Story Archives"},
            text = T{"Recent Top Stories:  <newline><MTTopArchive1Title> <newline><newline>     <MTTopArchive1Story><newline><newline><newline> <MTTopArchive2Title><newline><newline>     <MTTopArchive2Story><newline>", MTTopArchive1Title = MTTopArchive1.title, MTTopArchive1Story = MTTopArchive1.story, MTTopArchive2Title = MTTopArchive2.title, MTTopArchive2Story = MTTopArchive2.story}, -- Top Story Archives Text
            choice1 = T{"Flip to Next Page of Archived Top Stories"}, -- sends to MTTopArchivePopup2 which is identical, allowing for a continuous flip between popups
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
		MTTopArchive2.title = " "
		MTTopArchive2.story = " "
	end
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTLeader = MTGetLeader()
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Top Story Archives"},
            text = T{"Recent Top Stories:  <newline><MTTopArchive1Title> <newline><newline>     <MTTopArchive1Story><newline><newline><newline> <MTTopArchive2Title><newline><newline>     <MTTopArchive2Story><newline>", MTTopArchive1Title = MTTopArchive1.title, MTTopArchive1Story = MTTopArchive1.story, MTTopArchive2Title = MTTopArchive2.title, MTTopArchive2Story = MTTopArchive2.story}, -- Top Story Archives Text
            choice1 = T{"Flip to Next Page of Archived Top Stories"}, -- sends to MTTopArchivePopup2 which is identical, allowing for a continuous flip between popups
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

function MTGetTopArchives(MTArchiveIndexNum)
	if g_MTTopArchive == nil then
		g_MTTopArchive = {}
		if MTTempTopArchive == nil then
			MTTempTopArchive = {}
		end
		MTTempTopArchive.title = T{"The Top Story Archives have been depleted."}
		MTTempTopArchive.story = " "
		return MTTempTopArchive
	else
		if g_MTTopArchive[MTArchiveIndexNum] == nil then
			if MTTempTopArchive == nil then
				MTTempTopArchive = {}
			end
			MTTempTopArchive.title = T{"The Top Story Archives have been depleted."}
			MTTempTopArchive.story = " "
			return MTTempTopArchive
		else
			return g_MTTopArchive[MTArchiveIndexNum]
		end
	end
end

function MTSetTopStory(MTPushPull)
	if MTNewTopStory == nil then
		MTNewTopStory = {}
	end
	if MTPushPull == "push" then
		MTNewTopStory = MTGetNewTopStory()
	else
		if MTNewTopStory.title == nil then
			MTNewTopStory.title = "No news of interest at this point in time."
			MTNewTopStory.story = " "
			return MTNewTopStory
		else
			return MTNewTopStory
		end
	end
end

function MTGetNewTopStory()
	MTTopCurrentStory = {}
	MTTopStoryRandom = nil		
	MTTopStoryRandomTotal = nil
	if #g_MTTopPotentialStories > 0 then  -- if potential stories are available
		MTTopStoryRandomTotal = #g_MTTopPotentialStories   -- then pick a random number out of the total available
		MTTopStoryRandom = Random(1, MTTopStoryRandomTotal)
		MTTopCurrentStory = g_MTTopPotentialStories[MTTopStoryRandom]	-- claim it as current
		table.remove(g_MTTopPotentialStories, MTTopStoryRandom)	-- pull it out of the potential list
		table.insert(g_MTTopArchive, MTTopCurrentStory)  -- adds it to the Top Story Archives
		return MTTopCurrentStory  -- declare the current story
	else
		MTTopStoryRandomTotal = #g_MTTopFreeStories  --  if no potential stories are available, pick from the free ones
		MTTopStoryRandom = Random(1, MTTopStoryRandomTotal)  -- do the same as above
		MTTopCurrentStory = g_MTTopFreeStories[MTTopStoryRandom]   -- claim this as the current story
		table.remove(g_MTTopFreeStories, MTTopStoryRandom)   --  pull it from the FreeStories list
		table.insert(g_MTTopArchive, MTTopCurrentStory)  -- adds it to the Top Story Archives
		return MTTopCurrentStory
	end
end

--function MTGetFrontPageEngStory()
--	if (City.day % 6) == 0 then
--		MTGetEngFreeStories()
--	else
--		MTGetEngStories()
--	end
--end
--
--function MTGetFrontPageSocialStory()
--	if (UICity.day % 9) == 0 then
--		MTGetSocialFreeStories()
--	else
--		MTGetSocialStories()
--	end
--end
--
---- Top Stories with Titles and stories, generated via messages and status checks.
---- If triggered, story gets insert into "g_MTTopPotentialStories" table.
--
--
--function MTMainCheckNoHumans()
--	if MTNoHumansUsed ~= true then
--		if MTColonistsHaveArrived ~= true then
--			table.insert(g_MTTopPotentialStories, MTNoHumans)
--			MTNoHumansUsed = true
--		end
--	end
--end
--
--function MTMainCheckAdultFilm()
--	if MTAdultFilmUsed ~= true then
--		for _, v in (UICity.labels.Colonist) do
--			for k, _ in (UICity.labels.Colonist[v].traits)
--				if k == 'Sexy' then
--					MTAdultFilmSexyColonist = UICity.labels.Colonist[v]
--					break
--					table.insert(g_MTTopPotentialStories, MTAdultFilm)
--					MTAdultFilmUsed = true
--				end
--			end
--			break
--		end
--	end
--end
--
--				
--
--function MTMainCheckRocketCount()
--	MTcurrentSupplyRocketCount = #GetObjects{class = "SupplyRocket"}
--	if MTrockets3 == false then
--		if MTcurrentSupplyRocketCount > 2 then
--			table.insert(g_MTTopPotentialStories, MTrockets3)
--			MTrockets3 = true
--		end
--	end
--	if MTrockets0 == false then
--		if MTcurrentSupplyRocketCount == 0 then
--			table.insert(g_MTTopPotentialStories, MTrockets0)
--			MTrockets0 = true
--		end
--	end		
--end
--
--function MTMainCheckFinances()
--	if MTFinances ~= true and MTFinances2 ~= true and MTFinances3 ~= true then
--		if ResourceOverviewObj:GetFunding() < 300000000 then
--			if ResourceOverviewObj.data.PreciousMetals < 100 then
--				if UICity.labels.SupplyRocket[1] ~= "FlyToMars" and
--				UICity.labels.SupplyRocket[2] ~= "FlyToMars" and
--				UICity.labels.SupplyRocket[3] ~= "FlyToMars" and
--				UICity.labels.SupplyRocket[4] ~= "FlyToMars" and
--				UICity.labels.SupplyRocket[5] ~= "FlyToMars" and
--				UICity.labels.SupplyRocket[6] ~= "FlyToMars" then
--				MTFinanceStoryRandom = Random(3)
--					if MTFinanceStoryRandom == 1 then
--						table.insert(g_MTTopPotentialStories, MTFinances1)
--						MTFinances1 = true
--					elseif MTFinanceStoryRandom == 2 then
--						table.insert(g_MTTopPotentialStories, MTFinances2)
--						MTFinances2 = true
--					elseif MTFinanceStoryRandom == 3 then
--						table.insert(g_MTTopPotentialStories, MTFinances3)
--						MTFinances3 = true
--					end
--				end
--			end
--		end
--	end
--end
--
--function MTMainCheckHackThePlanet()
--	if UICity:IsTechResearched("DeepScanning") ~= nil then
--		MTSensorTowerCount = #GetObjects{class = "SensorTower"}
--		if MTSensorTowerCount < 2 then
--			table.insert(g_MTTopPotentialStories, MTHackThePlanet)
--		end
--	else
--		table.remove(g_MTTopPotentialStories, MTHackThePlanet)
--	end
--end
--
--function MTMainCheckFounders()
--	if MTFoundersAllDead == true then
--		if MTFoundersWaitCount > 9 then
--			table.insert(g_MTTopPotentialStories, MTFounders)
--			MTFoundersAllDead = false
--		else
--			if MTFoundersWaitCount == nil then
--				MTFoundersWaitStart = UICity.day
--			else
--				MTNewFoundersWaitCount = UICity.day - MTFoundersWaitStart
--			end
--		end
--		MTMainCheckFoundersDome()
--	end	
--
--function MTMainCheckFoundersDome()
--	for k, v in (UICity.labels.Domes) do
--		if v == "DomeBasic" then
--			MTBiggestDome = k
--		end
--	end
--	for k, v in (UICity.labels.Domes) do
--		if v == "DomeMedium" then
--			MTBiggestDome = k
--		end
--	end
--	for k, v in (UICity.labels.Domes) do
--		if v == "DomeOval" then
--			MTBiggestDome = k
--		end
--	end
--	for k, v in (UICity.labels.Domes) do
--		if v == "DomeMega" then
--			MTBiggestDome = k
--		end
--	end
--	if MTBiggestDome.labels.Spacebar ~= nil then
--		MTBiggestDomeRelaxation = "Spacebar"
--	else
--		if MTBiggestDome.labels.OpenAirGym ~= nil then
--			MTBiggestDomeRelaxation = "Open Air Gym"
--		else
--			if MTBiggestDome.labels.GardenStone ~= nil then
--				MTBiggestDomeRelaxation = "Stone Garden"
--			else
--				if MTBiggestDome.labels.FountainLarge ~= nil then
--					MTBiggestDomeRelaxation = "Fountain"
--				else
--					if MTBiggestDome.labels.GardenNatural_Medium ~= nil then
--						MTBiggestDomeRelaxation = "Natural Garden"
--					else
--						if MTBiggestDome.labels.Apartments ~= nil then
--							MTBiggestDomeRelaxation = "Apartments"
--						else
--							if MTBiggestDome.labels.LivingQuarters ~= nil then
--								MTBiggestDomeRelaxation = "Living Quarters"
--							end
--						end
--					end
--				end
--			end
--		end
--	end
--end
--
--function OnMsg.ColonistDied(colonist, reason)
--	if MTFoundersDead == nil then
--		MTFoundersDead = 0
--	end
--	if MTFoundersAllDead == nil then
--		for k, v in (colonist.traits) do
--			if k == "Founder" then
--				newMTFoundersDead = MTFoundersDead +1
--				MTFoundersDead = newMTFoundersDead
--			end
--			if MTFoundersDead == 12 then
--				MTFoundersAllDead = true
--			end
--		end
--	end
--end
--
--function OnMsg.ColonistArrived()
--	MTColonistsHaveArrived = true
--end
--

function MTInitializeStoryTables() -- loading all the story titles and stories when Mods get loaded so that they're always available globally
	g_MTTopPotentialStories = {}
	g_MTTopFreeStories = {}
	g_MTTopArchive = {}
	MTNewTopStory = {}
	MTTempTopArchive = {}
	MTTopArchive1 = {}
	MTTopArchive2 = {}

---- These stories are all MTMain stories and contingent on certain circumstances.  They are added to
---- g_MTPotentialMainStories from within their respective functions.
	MTNoHumans = {}
	MTrockets3 = {}
	MTrockets0 = {}
	MTHackThePlanet = {}
	MTFinances1 = {}
	MTFinances2 = {}
	MTFinances3 = {}
	MTFounders = {}
	MTAdultFilm = {}
	MTWeAreMartian = {}
	MTOnThisDayin1965 = {}
	MTOnThisDayin1976 = {}
	MTOnThisDayin1997 = {}
	MTOnThisDayin2015 = {}
	MTDroneRights = {}
end

function MTLoadStoriesIntoTables()
	MTLeader = MTGetLeader()
	MTLeaderTitle = MTGetLeaderTitle(GetMissionSponsor().name)
	MTSponsor = MTGetSponsor(GetMissionSponsor().name)
	MTArchiveIndex = 1

	MTNoHumans["title"] = T{"01101101 01100101 00100000 01110011 01100001 01100100"}
	MTNoHumans["story"] = T{"    01000100 01110010 01101111 01101110 01100101 01110011 00100000 01101100 01101111 01101110 01100101 01101100 01111001 00101100 00100000 01100010 01110010 01101001 01101110 01100111 00100000 01101000 01110101 01101101 01100001 01101110 01110011 00100000 01110000 01101100 01100101 01100001 01110011 01100101 00101110"}
	table.insert(g_MTTopPotentialStories, MTNoHumans)

	MTrockets3["title"] = T{"Rocket Silhouettes Mar Martian Landscape"}
	MTrockets3["story"] = T{"    With so many rockets planetside, one would think that we have more than enough to succeed and flourish, but all those resources are languishing in the hands of "..MTLeaderTitle.." "..MTLeader..".  Perhaps it's time to fire up that Drone Assembler, a few more Fuel Refineries, and redistribute the workload.  If things remain as they are, who knows how much longer "..MTLeaderTitle.." "..MTLeader.." will remain in office..."}
	table.insert(g_MTTopPotentialStories, MTrockets3)

	MTrockets0["title"] = T{" "..MTLeaderTitle.." Sets High Standard"}
	MTrockets0["story"] = T{"    With the "..MTLeaderTitle.."'s efficient and effective use of Earth's resupply we are well on our way to gaining a strong foothold on the Red Planet.  This begs the question: are you doing your part? As we continue to develop our resources, and our culture, on this planet each one of us plays an integral role in leading us closer and closer to the safety and security that we need.  Follow "..MTLeaderTitle.." "..MTLeader.."'s example!  How can you become more efficient and effective today?  Let us know in your letter to the editor!  Select letters will be published in Saturday's edition."}
	table.insert(g_MTTopPotentialStories, MTrockets0)

	MTHackThePlanet["title"] = T{"Hack the planet!"}
	MTHackThePlanet["story"] = T{"    Our primary manifesto as a society is to populate the Red Planet.  Someone should remind "..MTLeaderTitle.." "..MTLeader.." about that.  They seem to think that scanning the surface and finding suitable resources and dome locations serves no particular purpose.  Have you seen our metals supply lately?  This water isn't going to last forever, you know.  We need more Sensor Towers.  When will we learn from the past?  The time is now!  This planet is ours for the taking, but only if we know what's out there!"}
	table.insert(g_MTTopPotentialStories, MTHackThePlanet)
	
	MTFinances1["title"] = T{"Financial Collapse Imminent"}
	MTFinances1["story"] = T{"    When we came to this planet we thought that we were leaving modern financial woes behind us, but as it turns out poor colony management has led to an unforeseen long-term dependence upon our sponsor, "..MTSponsor..", and may very well lead to our collapse.  No supplies are incoming from Earth any time soon.  Just one unfortunate meteor storm and our domes could become oversized oxygen geysers.  Let’s hope that "..MTLeaderTitle.." "..MTLeader.." has a plan, but who am I kidding but myself if I think that..."}
--
--	MTFinances2["title"] = T{"Sponsor Funds Depleted"}
--	MTFinances2["story"] = T{"     "..MTSponsor.." has confirmed for the Martian Tribune that the rapidly spreading rumor that they are now broke with no money left to spare in support of the Martian endeavor is, in fact, true.  Its up to us, the people of mars to support ourselves.  Hopefully our local administrators will work to remedy the situation and prove our worth to our sponsor once more."}
--		
--	MTFinances3["title"] = T{"Sponsor Cites Insider Trading Woes"}
--	MTFinances3["story"] = T{"     "..MTSponsor.." has gone belly-up in the face of a massive insider trading scheme that has taken down over half of their senior management.  Who knew that colonizing Mars could be such a politically, financially and socially fraught endeavor?  We did, "..MTSponsor..".  We all did.  Shame on you."}
		
--	table.insert(MTFounders["title"] = T{"The Founder's Legacy"})
--	table.insert(MTFounders["story"] = T{"There are only 12 people who will ever be known as Founders.  These extraordinary men and women risked their lives to venture into the Final Frontier and gain a foothold on the Red Planet.  They toiled day and night, working non-stop to ensure constant and consistent air flow, water pressure, power generation, and more.  While we go about our sol today we must remember to take a moment and honor those who came before us, those who made all that we see around us today possible.  Founder’s Day will be celebrated in the <MTFoundersRelaxationBuilding> in <MTFoundersLargestDome> later this afternoon where we will be taking 12 minutes of silence in memory of these most excellent of individuals.", MTFoundersRelaxationBuilding = MTBiggestDomeRelaxation, MTFoundersLargestDome = MTBiggestDome})
--		
--	table.insert(MTAdultFilm["title"] = T{"SpaceXXX"})
--	table.insert(MTAdultFilm["story"] = T{"In an unexpected turn of events, <MTSexyColonist> has taken it upon themselves to produce the first ever Martian adult film.  Starring 11 different colonists with <MTSexyColonist> as the lead, it has become quite a hit on earth.  The film also provides a sneak peek into Martian pipe work and stockpiles of electronics and machine parts in the background.  <MTSponsor> has declared themselves not responsible for the social decisions of colonists and praised the artistic vision of the Director.", MTSexyColonist = MTAdultFilmSexyColonist, MTSponsor = MTSpnsr})
-- These stories are all preset and without conditions.  They are automatically a part of MTMainFreeStories{} from the very start
		
	MTWeAreMartian["title"] = T{"We Are Martian"}
	MTWeAreMartian["story"] = T{"     This is our world now.  The world of rare metals, electronics and universal depots.  On Earth war is waged over economics, religion, and borders.  Here we fight for survival on a primal level.  We are the Martian people.  We will not give up.  We will not give in.  We will continue to build, continue to expand and populate this planet.  No meteor storm will stop us.  We are Martian."}
	g_MTTopFreeStories[1] = MTWeAreMartian
		
	MTOnThisDayin1965["title"] = T{"On This Day in 1965"}
	MTOnThisDayin1965["story"] = T{"     On July 14th in 1965 Mariner 4 was sent to space by NASA took the first ever photos of the Martian surface.  Have you taken any photos that you're particularly proud of?  Share them today at r/SurvivingMars!"}
	g_MTTopFreeStories[2] = MTOnThisDayin1965
--		
	MTOnThisDayin1976["title"] = T{"On This Day in 1976"}
	MTOnThisDayin1976["story"] = T{"     On July 20th in 1976 Viking 1 pulled out the landing gear and set down on Martian soil for the first time in human history.  What we have come to accomplish in such few years since then is nothing less than incredible.  What an experience it is to actually set foot on Mars and to literally, walk among the stars!"}
	g_MTTopFreeStories[3] = MTOnThisDayin1976
--		
--	MTOnThisDayin1997["title"] = T{"On This Day in 1997"}
--	MTOnThisDayin1997["story"] = T{"     On July 4th in 1997 NASA set down the very first actual rover on the Red Planet.  Shortly after the Mars Pathfinder landed, Sojourner, a solar-powered rover, rolled out and began to scan the surface.  Expected to last just 7 sol, it was finally called to a stop after 91 sol having traveled a total of just over 100 meters and sent a myriad of photos back to Earth for study."}
--	g_MTTopFreeStories[4] = MTOnThisDayin1997
--		
--	MTOnThisDayin2015["title"] = T{"On This Day in 2015"}
--	MTOnThisDayin2015["story"] = T{"     On September 28th in 2015 NASA announced that the Mars Reconnaissance Orbiter had officially encountered water flowing along the Martian surface.  While it might seem like a foregone conclusion to us today, such news at the time proved quite the breakthrough, leading NASA Administrator Bolden to declare that NASA 'is firmly on a journey to Mars.'"}
--	g_MTTopFreeStories[5] = MTOnThisDayin2015
--
--	MTDroneRights["title"] = T{"Push For Drone Rights"}
--	MTDroneRights["story"] = T{"It has been reported that a local alliance of Martians believe that because so many drones are now integral to our daily lives they now deserve the same rights as colonists. "..MTDroneColonist..",  the leader of the self-dubbed Drone Alliance for Freedom and Transparency (DAFT) has stated that -these drones do more work then all of the humans on mars combined- when asked if this meant drones should be able to vote as well "..MTDroneColonist.." responded, 'what? no. That's ridiculous. They are machines...'"}
--	g_MTTopFreeStories[6] = MTDroneRights
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
	MTSponsor = nil
	MTLeader = nil
	MTLeaderTitle = nil
	MTTopStoryRandom = nil
	MTTopStoryRandomTotal = nil
	MTTopCurrentStory = nil
	MTAdultFilm = nil
end