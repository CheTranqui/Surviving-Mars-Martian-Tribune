local TopArchiveDepleted = {
	key = "TopArchiveDepleted",
	title = T{9013765, "<newline>     The Top Story Archives have been depleted."},
	story = " "
}

function OnMsg.MartianTribuneShowTopArchive(index)
	local TopArchive = MartianTribune.TopArchive or empty_table
	local MartianTribuneMod = MartianTribuneMod
	local mod_dir = MartianTribuneMod.mod_dir
	local GetArchiveStory = MartianTribuneMod.Functions.GetArchiveStory
	local ArchiveDepleted2 = MartianTribuneMod.News.ArchiveDepleted2

	local TopArchive1 = GetArchiveStory(index, TopArchive, TopArchiveDepleted)
	local TopArchive2 = GetArchiveStory(index - 1, TopArchive, TopArchiveDepleted)
	if TopArchive1 == TopArchive2 then
		TopArchive2 = ArchiveDepleted2
	end

	CreateRealTimeThread(function()
		local params = {
			title = T{9013515, "The Martian Tribune:  Top Story Archives"},
			text = T{9013516, "Recent Top Stories:  <newline><newline><MTTopArchive1Title> <newline><newline>     <MTTopArchive1Story><newline><newline><newline> <MTTopArchive2Title><newline><newline>     <MTTopArchive2Story><newline>", MTTopArchive1Title = TopArchive1.title, MTTopArchive1Story = TopArchive1.story, MTTopArchive2Title = TopArchive2.title, MTTopArchive2Story = TopArchive2.story}, -- Top Story Archives Text
			choice1 = T{9013517, "Flip to Next Page of Archived Top Stories"}, -- sends to MTTopArchivePopup
			choice2 = T{9013812, "Flip to Previous Page of Archived Top Stories"},
			choice3 = T{9013518, "Return to Front Page"},
			choice4 = T{9013514, "Close"},
			image = mod_dir.."UI/Newspaper_Message_Image.png",
			start_minimized = false,
			no_ccc_button = true,
			disabled = { false, false, false, false }
		} -- params
		if (index <= 1) then
			params.disabled[1] = true
		end
		if (index >= #TopArchive) then
			params.disabled[2] = true
		end
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			Msg("MartianTribuneShowTopArchive", Max(index - 2, 1))  -- reopens Top Story Archive popup
		elseif choice == 2 then
			Msg("MartianTribuneShowTopArchive", Min(index + 2, #TopArchive))
		elseif choice == 3 then
			Msg("MartianTribuneShowFrontPage")
		end -- if statement
	end ) -- end CreateRealTimeThread
end