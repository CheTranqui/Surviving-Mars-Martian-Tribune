local SocialArchiveDepleted = {
	key = "SocialArchiveDepleted",
	title = T{9013767, "<newline>     The Social Story Archives have been depleted."},
	story = " "
}

function OnMsg.MartianTribuneShowSocialArchive(index)
	local SocialArchive = MartianTribune.SocialArchive or empty_table
	local MartianTribuneMod = MartianTribuneMod
	local mod_dir = MartianTribuneMod.mod_dir
	local GetArchiveStory = MartianTribuneMod.Functions.GetArchiveStory
	local ArchiveDepleted2 = MartianTribuneMod.News.ArchiveDepleted2

	local SocialArchive1 = GetArchiveStory(index, SocialArchive, SocialArchiveDepleted)
	local SocialArchive2 = GetArchiveStory(index - 1, SocialArchive, SocialArchiveDepleted)
	if SocialArchive1 == SocialArchive2 then
		SocialArchive2 = ArchiveDepleted2
	end

	CreateRealTimeThread(function()
		local params = {
			title = T{9013530, "The Martian Tribune:  Red Planet Socialites Archives"},
			text = T{9013531, "Recent Social Stories:  <newline><newline><MTSocialArchive1Title> <newline><newline>     <MTSocialArchive1Story><newline><newline><newline> <MTSocialArchive2Title><newline><newline>     <MTSocialArchive2Story><newline>", MTSocialArchive1Title = SocialArchive1.title, MTSocialArchive1Story = SocialArchive1.story, MTSocialArchive2Title = SocialArchive2.title, MTSocialArchive2Story = SocialArchive2.story}, -- social Story Archives Text
			choice1 = T{9013532, "View Next Page of Social Archives"}, -- sends to SocialArchivePopup
			choice2 = T{9013814, "View Previous Page of Social Archives"},
			choice3 = T{9013518, "Return to Front Page"},
			choice4 = T{9013514, "Close"},
			image = mod_dir.."UI/Newspaper_Message_Image.tga",
			start_minimized = false,
		} -- params
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			Msg("MartianTribuneShowSocialArchive", index - 2)  -- reopens Social Story Archives popup
		elseif choice == 2 then
			Msg("MartianTribuneShowSocialArchive", Min(index + 2, #SocialArchive))
		elseif choice == 3 then
			Msg("MartianTribuneShowFrontPage")
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end
