local EngArchiveDepleted = {
	key = "EngArchiveDepleted",
	title = T{9013766, "<newline>     The Engineering Story Archives have been depleted."},
	story = " "
}

function OnMsg.MartianTribuneShowEngArchive(index)
	local EngArchive = MartianTribune.EngArchive or empty_table
	local MartianTribuneMod = MartianTribuneMod
	local mod_dir = MartianTribuneMod.mod_dir
	local GetArchiveStory = MartianTribuneMod.Functions.GetArchiveStory
	local ArchiveDepleted2 = MartianTribuneMod.News.ArchiveDepleted2

	local EngArchive1 = GetArchiveStory(index, EngArchive, EngArchiveDepleted)
	local EngArchive2 = GetArchiveStory(index - 1, EngArchive, EngArchiveDepleted)
	if EngArchive1 == EngArchive2 then
		EngArchive2 = ArchiveDepleted2
	end

	CreateRealTimeThread(function()
		local params = {
			title = T{9013523, "The Martian Tribune:  Interstellar Engineering Archives"},
			text = T{9013524, "Recent Engineering Stories:   <newline><newline><MTEngArchive1Title> <newline><newline>     <MTEngArchive1Story><newline><newline><newline> <MTEngArchive2Title><newline><newline>     <MTEngArchive2Story><newline>", MTEngArchive1Title = EngArchive1.title, MTEngArchive1Story = EngArchive1.story, MTEngArchive2Title = EngArchive2.title, MTEngArchive2Story = EngArchive2.story}, -- eng Story Archives Text
			choice1 = T{9013525, "View Next Page of Engineering Archives"}, -- sends to MTEngArchivePopup
			choice2 = T{9013813, "View Previous Page of Engineering Archives"},
			choice3 = T{9013518, "Return to Front Page"},
			choice4 = T{9013514, "Close"},
			image = mod_dir.."UI/Newspaper_Message_Image.tga",
			start_minimized = false,
			no_ccc_button = true,
			disabled = { false, false, false, false }
		} -- params
		if (index <= 1) then
			params.disabled[1] = true
		end
		if (index >= #EngArchive) then
			params.disabled[2] = true
		end
		local choice = WaitPopupNotification(false, params)
		if choice == 1 then
			Msg("MartianTribuneShowEngArchive", Max(index - 2, 1))  -- reopens Engineering Story Archive popup
		elseif choice == 2 then
			Msg("MartianTribuneShowEngArchive", Min(index + 2, #EngArchive))
		elseif choice == 3 then
			Msg("MartianTribuneShowFrontPage")
		end -- if statement
	end ) -- end CreateRealTimeThread
end -- function end