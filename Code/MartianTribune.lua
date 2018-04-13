function OnMsg.NewMapLoaded()
	lcPrint("NewMapLoaded triggered")
	MTInitializeStoryTables()
	MTLoadStoriesIntoTables()
end

-- every 2 hours a new edition gets pushed
function OnMsg.NewHour()
	lcPrint("NewHour triggered")
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
	lcPrint("MTGetSponsor accessed")
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
	lcPrint("MTGetLeaderTitle accessed")
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
	MTCurrentLeader = "Random Person"
	return MTCurrentLeader
end

function MTGetNewStories()  -- on "push", these functions pull a new story from the 3 main story tables (g_MTTopPotentialStories, etc).  The "pull" is done in the popups.
	MTSetTopStory("push")
	MTSetEngStory("push")
	MTSetSocialStory("push")
	lcPrint("MTGetNewStories - new stories pushed")
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
	CreateRealTimeThread(function()
        params = {  --MTEngHeadline = MTEngStory.title, MTSocialHeadline = MTSocialStory.title
			title = T{"The Martian Tribune:  Today's Headlines"},
            text = T{"Top Story:  <MTFrontPageStoryTitle> <newline><newline> <MTFrontPageStory><newline><newline><newline> Other Headlines:<newline>     Engineering:  <MTEngHeadline><newline>     Social:  <MTSocialHeadline><newline>", MTFrontPageStoryTitle = MTTopFPStory.title, MTFrontPageStory = MTTopFPStory.story, MTEngHeadline = MTEngStory.title, MTSocialHeadline = MTSocialStory.title, MTLeaderTitle, MTLeader, MTSponsor}, -- Front Page text
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
	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Top Story Archives"},
            text = T{"Recent Top Stories:  <newline><MTTopArchive1Title> <newline><newline>     <MTTopArchive1Story><newline><newline><newline> <MTTopArchive2Title><newline><newline>     <MTTopArchive2Story><newline>", MTTopArchive1Title = MTTopArchive1.title, MTTopArchive1Story = MTTopArchive1.story, MTTopArchive2Title = MTTopArchive2.title, MTTopArchive2Story = MTTopArchive2.story, MTLeaderTitle, MTLeader, MTSponsor}, -- Top Story Archives Text
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
	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Top Story Archives"},
            text = T{"Recent Top Stories:  <newline><MTTopArchive1Title> <newline><newline>     <MTTopArchive1Story><newline><newline><newline> <MTTopArchive2Title><newline><newline>     <MTTopArchive2Story><newline>", MTTopArchive1Title = MTTopArchive1.title, MTTopArchive1Story = MTTopArchive1.story, MTTopArchive2Title = MTTopArchive2.title, MTTopArchive2Story = MTTopArchive2.story, MTLeaderTitle, MTLeader, MTSponsor}, -- Top Story Archives Text
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
	CreateRealTimeThread(function()
        params = {  --MTSocialHeadline = MTSocialStory.title
			title = T{"The Martian Tribune:  Interstellar Engineering"},
            text = T{"Top Engineering Story:  <MTEngHeadlineTitle> <newline><newline> <MTEngHeadlineStory><newline><newline><newline> Other Headlines:<newline>     Front Page Story:  <MTFrontPageStoryTitle><newline>     Social:  <MTSocialHeadline><newline>", MTFrontPageStoryTitle = MTTopFPStory.title, MTFrontPageStory = MTTopFPStory.story, MTEngHeadlineTitle = MTEngStory.title, MTEngHeadlineStory = MTEngStory.story, MTSocialHeadline = MTSocialStory.title, MTLeaderTitle, MTLeader, MTSponsor}, -- Front Page text
            choice1 = T{"View Interstellar Engineering Archives"},
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
	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Interstellar Engineering Archives"},
            text = T{"Recent Engineering Stories:   <MTEngArchive1Title> <newline><newline>     <MTEngArchive1Story><newline><newline><newline> <MTEngArchive2Title><newline><newline>     <MTEngArchive2Story><newline>", MTEngArchive1Title = MTEngArchive1.title, MTEngArchive1Story = MTEngArchive1.story, MTEngArchive2Title = MTEngArchive2.title, MTEngArchive2Story = MTEngArchive2.story, MTLeaderTitle, MTLeader, MTSponsor}, -- eng Story Archives Text
            choice1 = T{"View Next Page of Interstellar Engineering Archives"}, -- sends to MTEngArchivePopup2 which is identical, allowing for a continuous flip between popups
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
	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Interstellar Engineering Archives"},
            text = T{"Recent Engineering Stories:   <MTEngArchive1Title> <newline><newline>     <MTEngArchive1Story><newline><newline><newline> <MTEngArchive2Title><newline><newline>     <MTEngArchive2Story><newline>", MTEngArchive1Title = MTEngArchive1.title, MTEngArchive1Story = MTEngArchive1.story, MTEngArchive2Title = MTEngArchive2.title, MTEngArchive2Story = MTEngArchive2.story, MTLeaderTitle, MTLeader, MTSponsor}, -- eng Story Archives Text
            choice1 = T{"View Next Page of Interstellar Engineering Archives"}, -- sends to MTEngArchivePopup2 which is identical, allowing for a continuous flip between popups
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
	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Red Planet Socialite Headlines"},
            text = T{"Top Social Story:  <MTSocialHeadline> <newline><newline> <MTSocialHeadlineStory><newline><newline><newline> Other Headlines:<newline>     Engineering Story:  <MTEngHeadlineTitle><newline>     Front Page Story:  <MTFrontPageStoryTitle><newline>", MTFrontPageStoryTitle = MTTopFPStory.title, MTEngHeadlineTitle = MTEngStory.title, MTSocialHeadlineStory = MTSocialStory.story, MTSocialHeadline = MTSocialStory.title, MTLeaderTitle, MTLeader, MTSponsor}, -- Front Page text
            choice1 = T{"View Red Planet Socialite Archives"},
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
	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Red Planet Socialite Archives"},
            text = T{"Recent Social Stories:   <MTSocialArchive1Title> <newline><newline>     <MTSocialArchive1Story><newline><newline><newline> <MTSocialArchive2Title><newline><newline>     <MTSocialArchive2Story><newline>", MTSocialArchive1Title = MTSocialArchive1.title, MTSocialArchive1Story = MTSocialArchive1.story, MTSocialArchive2Title = MTSocialArchive2.title, MTSocialArchive2Story = MTSocialArchive2.story, MTLeaderTitle, MTLeader, MTSponsor}, -- social Story Archives Text
            choice1 = T{"View Next Page of Red Planet Socialite Archives"}, -- sends to MTSocialArchivePopup2 which is identical, allowing for a continuous flip between popups
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
	CreateRealTimeThread(function()
        params = {
			title = T{"The Martian Tribune:  Red Planet Socialite Archives"},
            text = T{"Recent Social Stories:   <MTSocialArchive1Title> <newline><newline>     <MTSocialArchive1Story><newline><newline><newline> <MTSocialArchive2Title><newline><newline>     <MTSocialArchive2Story><newline>", MTSocialArchive1Title = MTSocialArchive1.title, MTSocialArchive1Story = MTSocialArchive1.story, MTSocialArchive2Title = MTSocialArchive2.title, MTSocialArchive2Story = MTSocialArchive2.story, MTLeaderTitle, MTLeader, MTSponsor}, -- social Story Archives Text
            choice1 = T{"View Next Page of Red Planet Socialite Archives"}, -- sends to MTSocialArchivePopup which is identical, allowing for a continuous flip between popups
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
	lcPrint("MTGetTopArchives started")
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
	lcPrint("MTGetEngArchives started")
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
	lcPrint("MTGetSocialArchives started")
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
			MTTempSocialArchive = g_MTSocialArchive[MTArchiveIndexNum]  -- else send EngArchive's old story
		end
	end
	return MTTempSocialArchive
end

function MTSetTopStory(MTPushPull)
	lcPrint("MTSetTopStory accessed")
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
	lcPrint("MTSetEngStory accessed")
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
	lcPrint("MTSetSocialStory accessed")
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
	lcPrint("MTGetNewTopStory accessed")
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
	lcPrint("MTGetNewEngStory accessed")
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
	lcPrint("MTGetNewSocialStory accessed")
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
	lcPrint("MTGetNewSocialStory completed")
	return MTSocialCurrentStory  -- declare the current story
end

------------- begin the story and variable section

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

	-- initializing the tables related to the Top Stories.  This is done here so that we can rest assured that the tables already exist before we attempt to populate them in the next function below.

	
	MTNoHumans = {}
	MTrockets3 = {}
	MTrockets0 = {}
	MTHackThePlanet = {}
	MTFinances1 = {}
	MTFinances2 = {}
	MTFinances3 = {}
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

	MTTopArchiveDepleted["title"] = T{"The Top Story Archives have been depleted."}
	MTTopArchiveDepleted["story"] = T{" "}

	MTEngArchiveDepleted["title"] = T{"The Engineering Story Archives have been depleted."}
	MTEngArchiveDepleted["story"] = T{" "}

	MTSocialArchiveDepleted["title"] = T{"The Social Story Archives have been depleted."}
	MTSocialArchiveDepleted["story"] = T{" "}

	MTArchiveDepleted2["title"] = T{" "}
	MTArchiveDepleted2["story"] = T{" "}

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
	MTFinances1["story"] = T{"    When we came to this planet we thought that we were leaving modern financial woes behind us, but as it turns out poor colony management has led to an unforeseen long-term dependence upon our sponsor, "..MTSponsor..", and may very well lead to our collapse.  No supplies are incoming from Earth any time soon.  Just one unfortunate meteor storm and our domes could become oversized oxygen geysers.  Let's hope that "..MTLeaderTitle.." "..MTLeader.." has a plan, but who am I kidding but myself if I think that..."}
	table.insert(g_MTTopPotentialStories, MTFinances1)

	MTFinances2["title"] = T{"Sponsor Funds Depleted"}
	MTFinances2["story"] = T{"     "..MTSponsor.." has confirmed for the Martian Tribune that the rapidly spreading rumor that they are now broke with no money left to spare in support of the Martian endeavor is, in fact, true.  It is up to us, the people of mars to support ourselves.  Hopefully our local administrators will work to remedy the situation and prove our worth to our sponsor once more."}
	table.insert(g_MTTopPotentialStories, MTFinances2)

	MTFinances3["title"] = T{"Sponsor Cites Insider Trading Woes"}
	MTFinances3["story"] = T{"     "..MTSponsor.." has gone belly-up in the face of a massive insider trading scheme that has taken down over half of their senior management.  Who knew that colonizing Mars could be such a politically, financially and socially fraught endeavor?  We did, "..MTSponsor..".  We all did.  Shame on you."}



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
end