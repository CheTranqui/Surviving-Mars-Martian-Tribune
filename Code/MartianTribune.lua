-- function OnMsg.NewDay()
function OnMsg.RocketLanded(rocket)
--  this_mod_dir stores the number of characters to walk back in order to get into the main mod directory
--  with the debug.getinfo(1, "S"), it's said that sometimes a 2 works, if the 1 does not
	local this_mod_dir = debug.getinfo(1, "S").source:sub(2, -24)
	AddCustomOnScreenNotification(MartianTribune,
		T{"The Martian Tribune"},
		T{"Sol <MTSol> AMC"},
		this_mod_dir.."UI/MT_Notification_Icon.tga",  --  Here, we concatenate to import the custom notification icon
		MTPopup,  -- this calls the function OnClick of this notification icon
		{MTSol = UICity.day,
		expiration = 150000,
		priority = "Normal",}
	)
end

function GetMTLeaderTitle()
	if sponsorDoubleCheck == nil then  -- if we've already done this, just go to the "return"
		sponsorDoubleCheck = GetMissionSponsor().name --otherwise, get the name
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
		if sponsorDoubleCheck == "IMM" or sponsorDoubleCheck == "BlueSun" or sponsorDoubleCheck == "SpaceY" or sponsorDoubleCheck == "paradox" then
			MTBusinessTitleRandom = Random(1,3)  -- randomize these corps to get one of the 3 following leader types
				if MTBusinessTitleRandom == 1 then
					MTLdrTtl = "Chairman"
				elseif MTBusinessTitleRandom == 2 then
					MTLdrTtl = "CFO"
				elseif MTBusinessTitleRandom == 3 then
					MTLdrTtl = "CEO"
				end
		elseif sponsorDoubleCheck == "ISRO" then  -- each of these get a fixed leader type
			MTLdrTtl = "Prime Minister"
		elseif sponsorDoubleCheck == "NewArk" then
			MTLdrTtl = "Oracle"
		elseif sponsorDoubleCheck == "stargatecommand" then
			MTLdrTtl = "Major General"
		else MTLdrTtl = "President"  -- if unaccounted for, they get a "President"
		end
	end
	return MTLdrTtl  -- unique variable to this function, not used elsewhere
end



function GetMTLeaderStoryTitle()
	local MTLdrStryTtl = "Supreme Leader Bad."  --unique local variable
	return MTLdrStryTtl
end

function GetMTLeaderStoryText()
	local MTLdrStryTxt = "No really.  Absolutely turrible."	
	return MTLdrStryTxt
end

function MTPopup()
	CreateRealTimeThread(function()
-- to declare a variable inside a text, that text should equal something local.
-- If it isn't something local, then the text-variable has to be declared equal to a function that returns what we need, thus what you see below.
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
			MTLeaderStoryPopup()  -- leads to the full text of the specific MTLeader story itself
		elseif choice == 2 then
			MTSocialStoryOnePopup()  -- leads to the full text of the social story
		end
	end)
end

function MTLeaderStoryPopup()
	CreateRealTimeThread(function()
		params =
		{
			title = T{"<MTLeaderStoryTitle>", MTLeaderStoryTitle = GetMTLeaderStoryTitle()},  -- Title of leader story
			text = T{"<MTLeaderStoryText>", MTLeaderStoryText = GetMTLeaderStoryText()},  -- full text of leader story
			choice1 = T{"Return to front page"},  -- text for 1st choice (this popup needs to be developed further)
			choice2 = T{"Close"},	-- text for 2nd choice
			image = "UI/Messages/space.tga", --image
		}
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			MTPopup()  -- closes this popup and opens the main popup again
		end  -- lack of action for choice2 means that there is no choice2 - escape to close, or pick choice1
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