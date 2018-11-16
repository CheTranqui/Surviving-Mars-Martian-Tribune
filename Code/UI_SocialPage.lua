function OnMsg.MartianTribuneShowSocialPage()
	local MartianTribuneMod = MartianTribuneMod
	local SocialArchive = MartianTribune.SocialArchive or empty_table
	local TopFPStory = MartianTribune.TopFPStory
	local EngStory = MartianTribune.EngStory
	local SocialStory = MartianTribune.SocialStory
	local mod_dir = MartianTribuneMod.mod_dir

	CreateRealTimeThread(function()
		local params = {
			title = T{9013526, "The Martian Tribune:  Red Planet Socialites Headlines"},
			text = T{9013527, "Top Social Story:  <MTSocialHeadline> <newline><newline> <MTSocialHeadlineStory><newline><newline><newline> Other Headlines:<newline>     Engineering Story:  <MTEngHeadlineTitle><newline>     Front Page Story:  <MTFrontPageStoryTitle><newline>", MTFrontPageStoryTitle = TopFPStory.title, MTEngHeadlineTitle = EngStory.title, MTSocialHeadlineStory = SocialStory.story, MTSocialHeadline = SocialStory.title}, -- Front Page text
			choice1 = T{9013528, "View Social Archives"},
			choice2 = T{9013529, "View Current Engineering Story"},
			choice3 = T{9013518, "Return to Front Page"},
			choice4 = T{9013514, "Close"},
			image = mod_dir.."UI/Newspaper_Message_Image.tga",
			start_minimized = false,
			no_ccc_button = true,
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			Msg("MartianTribuneShowSocialArchive", #SocialArchive)  -- opens Social Story Archives popup
		elseif choice == 2 then
			Msg("MartianTribuneShowEngPage")  -- opens Engineering popup
		elseif choice == 3 then
			Msg("MartianTribuneShowFrontPage")  -- opens Top Story popup
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end
