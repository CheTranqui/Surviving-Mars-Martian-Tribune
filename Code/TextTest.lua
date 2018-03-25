-- function OnMsg.NewDay()
function OnMsg.RocketLanded(rocket)
	AddCustomOnScreenNotification(MartianTribune,
		T{"The Martian Tribune"},
		T{"Sol <MTSol> AMC"},
		"UI/Icons/Notifications/Mystery_Log.tga",
		MTPopup,
		{MTSol = UICity.day,
		expiration = 150000,
		priority = "Normal",	}
	)
end

function GetMTLeaderStoryTitle()
	local MTLeaderStoryTitle = "Supreme Leader Bad."
	return MTLeaderStoryTitle
	
end

function GetMTLeaderStoryText()
	local MTLeaderStoryText = "No really.  Absolutely turrible."	
	return MTLeaderStoryText
end


function GetMTSocialStoryTitle()
	MTSocialStoryOneTitle = "RandomSocialStoryTitle"
	return MTSocialStoryOneTitle
end	

function GetMTSocialStoryText()
	MTSocialStoryOneText = "RandomSocialStoryText"
	return MTSocialStoryOneText
end	

function MTPopup()
	CreateRealTimeThread(function()
		MTLeaderStoryTitle = GetMTLeaderStoryTitle()
		MTSocialStoryTitle = GetMTSocialStoryTitle()
		params =
		{
			title = T{"The Martian Tribune"},
			text = T{"Story of the Day:  <MTLeaderStoryTitle>", MTLeaderStoryTitle = GetMTLeaderStoryTitle()}, 
			choice1 = T{"Read <MTLeaderStoryTitle>",  MTLeaderStoryTitle = GetMTLeaderStoryTitle()},
			choice1_hint1 = "Show <MTLeaderStoryTitle>",  MTLeaderStoryTitle = GetMTLeaderStoryTitle(),
            choice1_rollover = "Read the story entitled <MTLeaderStoryTitle>",  MTLeaderStoryTitle = GetMTLeaderStoryTitle(),
            choice1_rollover_title = "MTLeaderStoryTitle",
			choice2 = T{"Read <MTSocialStoryOneTitle>"},
			choice2_hint1 = "This will display <MTSocialStoryOneTitle>",
            choice2_rollover = "Read the story entitled <MTSocialStoryOneTitle>",
            choice2_rollover_title = "<MTSocialStoryOneTitle>",
			choice3 = T{"Close"},
			image = "UI/Messages/space.tga",
		}
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			MTLeaderStoryPopup()
		elseif choice == 2 then
			MTSocialStoryOnePopup()
		else choice == 3 then
		end
	end)
end

function MTLeaderStoryPopup()
	CreateRealTimeThread(function()
		params =
		{
			title = T{"<MTLeaderStoryTitle>",  MTLeaderStoryTitle = GetMTLeaderStoryTitle()},
			text = T{"<MTLeaderStoryText>", MTLeaderStoryText = GetMTLeaderStoryText()}, 
			choice1 = T{"Return to front page"},
			choice2 = T{"Close"},
			image = "UI/Messages/space.tga",
		}
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			MTPopup()
		end
	end)
end

function MTSocialStoryOnePopup()
	CreateRealTimeThread(function()
		params =
		{
			title = T{"User chose option 2!"},
			text = T{"Choice 2 was executed."}, 
			choice1 = T{"Close"},
			image = "UI/Messages/space.tga",
		}
		local choice = WaitPopupNotification(false, params)
	end)
end

-- function MTStoryCheck()
-- 	if MTLeaderStoryTitle == nil then
		-- MTLeaderStoryChoose()
-- end
		

-- function OnMsg.AnomalyAnalyzed()
-- 	MTLeaderStoryPool = MTLeaderStoryPool + " anomoly"
-- end

-- function MTLeaderStoryChoose()
-- 	if (UICity.day > 3 and UICity.day < 7) then
-- 		MTLeaderStoryHopeful()
-- 	else
-- 		MTLeaderStoryDire()
-- end

-- function MTLeaderStoryAnomoly()
-- 	MTLeaderStoryTitle = "Scientific advances continue!",
-- 	MTLeaderStoryText = "The SUPREMELEADER's decrees have proven fruitful as our explorers have located and successfully assimilated new knowledge from their work on the martian surface!",
-- 	MTStoryCheck()
-- end

-- function MTLeaderStoryHopeful()
-- 	MTLeaderStoryTitle = "SUPREMELEADER hope!  WHOO!"
-- 	MTLeaderStoryText = "Yeah.  Hope and stuff."
-- 	MTStoryCheck()
-- end

-- function MTLeaderStoryDire()
-- 	MTLeaderStoryTitle = "SUPREMELEADER dire!  RAWR!"
-- 	MTLeaderStoryText = "Grrrr.  Turrible.  Ugh."
-- 	MTStoryCheck()
-- end