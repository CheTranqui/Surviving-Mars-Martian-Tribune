
-- This function is used to collect together the additional changes to be made to a story when it actually gets published. For example, setting the day that the story was shown, or pinning a colonist that the story relates to. It's used for all 3 of top stories, social stories, and engineering stories.
local function SetStoryPublished(story, archive)
	story.publishedDay = UICity.day -- sets shown Sol
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

	if IsValidColonist(story.colonist) and not story.colonist.is_pinned then
		story.colonist:TogglePin()
	end
	MartianTribune.Published[story.key] = UICity.day
	archive[#archive + 1] = story
	return story
end

-- Select a story from potential or free lists if one is available
local function ChooseStory(archive, urgentList, potentialList, freeList)
	local random_num, story
	if urgentList and #urgentList > 0 then
		-- publish urgent stories in order of generation
		story = SetStoryPublished(urgentList[1], archive)
		table.remove(urgentList, 1)
	elseif potentialList and #potentialList > 0 then
		random_num = Random(1, #potentialList)
		story = SetStoryPublished(potentialList[random_num], archive)
		table.remove(potentialList, random_num)
	elseif freeList and #freeList > 0 then
		random_num = Random(1, #freeList)
		story = SetStoryPublished(freeList[random_num], archive)
		table.remove(freeList, random_num)
	else
		story = MartianTribuneMod.News.NoNews
	end
	return story
end

-- Set the current release's stories to publish.
local function ChooseStories()
	local MartianTribune = MartianTribune
	local TopArchive = MartianTribune.TopArchive
	local TopUrgentStories = MartianTribune.TopUrgentStories
	local TopPotentialStories = MartianTribune.TopPotentialStories
	local TopFreeStories = MartianTribune.TopFreeStories
	local EngArchive = MartianTribune.EngArchive
	local EngUrgentStories = MartianTribune.EngUrgentStories
	local EngPotentialStories = MartianTribune.EngPotentialStories
	local EngFreeStories = MartianTribune.EngFreeStories
	local SocialArchive = MartianTribune.SocialArchive
	local SocialUrgentStories = MartianTribune.SocialUrgentStories
	local SocialPotentialStories = MartianTribune.SocialPotentialStories
	local SocialFreeStories = MartianTribune.SocialFreeStories

	MartianTribune.TopFPStory = ChooseStory(TopArchive, TopUrgentStories, TopPotentialStories, TopFreeStories)
	MartianTribune.EngStory = ChooseStory(EngArchive, EngUrgentStories, EngPotentialStories, EngFreeStories)
	MartianTribune.SocialStory = ChooseStory(SocialArchive, SocialUrgentStories, SocialPotentialStories, SocialFreeStories)
end

-- This is the Notification for a new release
local function ShowNotification()
	local mod_dir = MartianTribuneMod.mod_dir
	local Sol = UICity.day
	AddCustomOnScreenNotification("MartianTribune",
		T{9014487, "The Martian Tribune"},
		T{9014488, "Sol <MTSol> AMC", MTSol=Sol},
		mod_dir.."UI/MT_Notification_Icon.tga",  --  Here, we concatenate to import the custom notification icon
		function() Msg("MartianTribuneShowFrontPage") end,  -- this function gets called OnClick of this notification icon
		{
			MTSol = Sol,
			expiration = 150000,
			priority = "Normal",
		}
	)
end

-- Normal Release.
function OnMsg.MartianTribuneRelease()
	ChooseStories()
	ShowNotification()
end

-- Used to restore the notification when loading a save game (don't want to choose stories again).
function OnMsg.MartianTribuneShowNotification()
	ShowNotification()
end