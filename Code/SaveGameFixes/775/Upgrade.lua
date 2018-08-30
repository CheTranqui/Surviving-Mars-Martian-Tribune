-- Run through an existing list of stories, and apply fixes/data-migrations for known issues.
local function UpdateStoredStories(list, newList, published, oldData)
	local SaveGameFixes = MartianTribuneMod.SaveGameFixes[775]
	local VersionNumber = MartianTribune.VersionNumber

	-- Have to go from the end of the list up if there is a possibility of story removal.
	for i = #list, 1, -1 do
		-- There was one old story that was accidentally saved as a boolean
		local story = list[i]
		if not story or not story.title or not story.story then
			print("Removing story:", story)
			table.remove(list, i)
		else
			if not story.key and not VersionNumber or VersionNumber < 775 then
				story = SaveGameFixes.SetStoryKey(story)
			end
			if published and not story.publishedDay then
				story = SaveGameFixes.SetMissingPublishedDay(story, oldData)
			elseif not published and not story.key then
				-- we didn't identify which story it was, and it is not already published, so delete it. It will be generated again when the story triggers are met anyway.
				table.remove(list, i)
			end
		end
	end
	if not published then
		-- is a potential/free story list, fix any chains that have multiple stories from the
		-- chain still available in the list.
		SaveGameFixes.FixUnpublishedStoryChains(list)
	end
	-- Transfer to new storage
	for i = 1, #list do
		newList[i] = list[i]
	end
end

MartianTribuneMod.SaveGameFixes[775].Upgrade = function(oldData)
	if not oldData.g_MTTopArchive then
		-- already upgraded
		MartianTribune.VersionNumber = 775
		return
	end

	local SaveGameFixes = MartianTribuneMod.SaveGameFixes[775]

	-- Make sure that there are no invalid stories in the lists.
	SaveGameFixes.TransferInitialGlobals(oldData)
	UpdateStoredStories(oldData.g_MTTopPotentialStories, MartianTribune.TopPotentialStories, false, oldData)
	UpdateStoredStories(oldData.g_MTTopFreeStories, MartianTribune.TopFreeStories, false, oldData)
	UpdateStoredStories(oldData.g_MTTopArchive, MartianTribune.TopArchive, true, oldData)
	UpdateStoredStories(oldData.g_MTEngPotentialStories, MartianTribune.EngPotentialStories, false, oldData)
	UpdateStoredStories(oldData.g_MTEngFreeStories, MartianTribune.EngFreeStories, false, oldData)
	UpdateStoredStories(oldData.g_MTEngArchive, MartianTribune.EngArchive, true, oldData)
	UpdateStoredStories(oldData.g_MTSocialPotentialStories, MartianTribune.SocialPotentialStories, false, oldData)
	UpdateStoredStories(oldData.g_MTSocialFreeStories, MartianTribune.SocialFreeStories, false, oldData)
	UpdateStoredStories(oldData.g_MTSocialArchive, MartianTribune.SocialArchive, true, oldData)

	SaveGameFixes.FixDomeDelayColonist(oldData)
	SaveGameFixes.FinalizeGlobals(oldData)

	MartianTribune.VersionNumber = 775
end