
--  main popup screen, accessed by clicking on the notification icon.
function OnMsg.MartianTribuneShowFrontPage()
	local MartianTribuneMod = MartianTribuneMod
	local TopArchive = MartianTribune.TopArchive or empty_table
	local TopFPStory = MartianTribune.TopFPStory
	local EngStory = MartianTribune.EngStory
	local SocialStory = MartianTribune.SocialStory
	local mod_dir = MartianTribuneMod.mod_dir

	CreateRealTimeThread(function()
		local params = {
			title = T{9013509, "The Martian Tribune:  Today's Headlines"},
			text = T{9013510, "Top Story:  <MTFrontPageStoryTitle> <newline><newline> <MTFrontPageStory><newline><newline><newline> Other Headlines:<newline>     Engineering Story:  <MTEngHeadline><newline>     Social Story:  <MTSocialHeadline><newline>", MTFrontPageStoryTitle = TopFPStory.title, MTFrontPageStory = TopFPStory.story, MTEngHeadline = EngStory.title, MTSocialHeadline = SocialStory.title}, -- Front Page text
			choice1 = T{9013511, "View Top Story Archives"},
			choice2 = T{9013512, "View Engineering Story"},
			choice3 = T{9013513, "View Social Story"},
			choice4 = T{9013514, "Close"},
			image = mod_dir.."UI/Newspaper_Message_Image.tga",
			start_minimized = false,
			no_ccc_button = true
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			Msg("MartianTribuneShowTopArchive", #TopArchive)  -- opens Top Story popup
		elseif choice == 2 then
			Msg("MartianTribuneShowEngPage")  -- opens Engineering popup
		elseif choice == 3 then
			Msg("MartianTribuneShowSocialPage")  -- opens Social popup
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end