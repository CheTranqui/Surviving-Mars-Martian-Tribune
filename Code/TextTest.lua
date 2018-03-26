function GetMTLeaderTitle()
	sponsorDoubleCheck = GetMissionSponsor().name
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
--		
	if sponsorDoubleCheck == "IMM" then
		MTLdrTtl = "Chairman"
	elseif sponsorDoubleCheck == "BlueSun" then
		MTLdrTtl = "CFO"
	elseif sponsorDoubleCheck == "SpaceY" then
		MTLdrTtl = "CEO"
	elseif sponsorDoubleCheck == "paradox" then
			MTLdrTtl = "CFO"
	elseif sponsorDoubleCheck == "ISRO" then
		MTLdrTtl = "Prime Minister"
	elseif sponsorDoubleCheck == "NewArk" then
		MTLdrTtl = "Oracle"
	elseif sponsorDoubleCheck == "stargatecommand" then
		MTLdrTtl = "Major General"
	else MTLdrTtl = "President"
	end
	return MTLdrTtl
end

-- function OnMsg.NewDay()
function OnMsg.RocketLanded(rocket)
	local this_mod_dir = debug.getinfo(1, "S").source:sub(2, -18)
	AddCustomOnScreenNotification(MartianTribune,
		T{"The Martian Tribune"},
		T{"Sol <MTSol> AMC"},
		this_mod_dir.."UI/MT_Notification_Icon.tga",
		MTPopup,
		{MTSol = UICity.day,
		expiration = 150000,
		priority = "Normal",}
	)
end

function GetMTLeaderStoryTitle()
	local MTLdrStryTtl = "Supreme Leader Bad."
	return MTLdrStryTtl
end

function GetMTLeaderStoryText()
	local MTLdrStryTxt = "No really.  Absolutely turrible."	
	return MTLdrStryTxt
end

function MTPopup()
	CreateRealTimeThread(function()
		params =
		{
			title = T{"The Martian Tribune"},
			text = T{"Story of the Day:  <MTLeaderStoryTitle> <MTLeaderTitle> ", MTLeaderStoryTitle = GetMTLeaderStoryTitle(), MTLeaderTitle = GetMTLeaderTitle()},
			choice1 = T{"Read <MTLeaderStoryTitle>", MTLeaderStoryTitle = GetMTLeaderStoryTitle()},
			choice1_hint1 = "Show <MTLeaderStoryTitle>", MTLeaderStoryTitle = GetMTLeaderStoryTitle(),
            choice1_rollover = "Read the story entitled <MTLeaderStoryTitle>", MTLeaderStoryTitle = GetMTLeaderStoryTitle(),
            choice1_rollover_title = "<MTLeaderStoryTitle>", MTLeaderStoryTitle = GetMTLeaderStoryTitle(),
			choice2 = T{"Read SocialStory"},
			choice2_hint1 = "This will display SocialStory",
            choice2_rollover = "Read the story entitled SocialStory",
            choice2_rollover_title = "SocialStory",
			choice3 = T{"Close"},
			image = "UI/Messages/space.tga",
		}
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			MTLeaderStoryPopup()
		elseif choice == 2 then
			MTSocialStoryOnePopup()
		end
	end)
end

function MTLeaderStoryPopup()
	CreateRealTimeThread(function()
		params =
		{
			title = T{"<MTLeaderStoryTitle>", MTLeaderStoryTitle = GetMTLeaderStoryTitle()},
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