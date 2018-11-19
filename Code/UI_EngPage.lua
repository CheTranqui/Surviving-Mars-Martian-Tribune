
--  Engineering popup screen, accessed only via the FrontPagePopup
function OnMsg.MartianTribuneShowEngPage()
	local MartianTribune = MartianTribune
	local EngArchive = MartianTribune.EngArchive or empty_table
	local TopFPStory = MartianTribune.TopFPStory
	local EngStory = MartianTribune.EngStory
	local SocialStory = MartianTribune.SocialStory

	local MartianTribuneMod = MartianTribuneMod
	local StoryImages = MartianTribuneMod.StoryImages
	local mod_dir = MartianTribuneMod.mod_dir

	CreateRealTimeThread(function()
		local params = {  --MTSocialHeadline = MTSocialStory.title
			title = T{9013519, "The Martian Tribune:  Interstellar Engineering"},
			text = T{9013520, "Top Engineering Story:  <MTEngHeadlineTitle> <newline><newline> <MTEngHeadlineStory><newline><newline><newline> Other Headlines:<newline>     Front Page Story:  <MTFrontPageStoryTitle><newline>     Social Story:  <MTSocialHeadline><newline>", MTFrontPageStoryTitle = TopFPStory.title, MTFrontPageStory = TopFPStory.story, MTEngHeadlineTitle = EngStory.title, MTEngHeadlineStory = EngStory.story, MTSocialHeadline = SocialStory.title}, -- Eng popup text
			choice1 = T{9013521, "View Engineering Archives"},
			choice2 = T{9013522, "View Current Social Story"},
			choice3 = T{9013518, "Return to Front Page"},
			choice4 = T{9013514, "Close"},
			image = StoryImages[EngStory.key] or mod_dir.."UI/Newspaper_Message_Image.png",
			start_minimized = false,
			no_ccc_button = true,
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			Msg("MartianTribuneShowEngArchive", #EngArchive)  -- opens Engineering archive popup
		elseif choice == 2 then
			Msg("MartianTribuneShowSocialPage")  -- opens Social popup
		elseif choice == 3 then
			Msg("MartianTribuneShowFrontPage")  -- opens Top Story popup popup
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end
