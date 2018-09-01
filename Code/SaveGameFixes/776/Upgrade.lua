local function SetPublishedToDay(archive)
	for i = 1, #(archive or empty_list) do
		local story = archive[i]
		if story.key then
			MartianTribune.Published[story.key] = story.publishedDay
		end
	end
end

-- This is more for our existing stories that may have been running on 775 prior to inserting the Drag Race
-- story into the DroneHack chain.
MartianTribuneMod.SaveGameFixes[776].Upgrade = function(oldData)
	local MartianTribune = MartianTribune
	if MartianTribune.VersionNumber < 776 then
		local Published = MartianTribune.Published
		local Sent = MartianTribune.Sent
		local MartianTribuneMod = MartianTribuneMod
		local FindStoryInListByKey = MartianTribuneMod.Functions.FindStoryInListByKey
		local DroneHack3Key = "DroneHack3"
		local DroneHack3NewKey = "DroneHack4"
		local index, DroneHack3Story
		
		if Published[DroneHack3Key] then
			local SocialArchive = MartianTribune.SocialArchive
			index, DroneHack3Story = FindStoryInListByKey(SocialArchive, DroneHack3Key)
			Published[DroneHack3Key] = nil
			Published[DroneHack3NewKey] = true
		elseif Sent[DroneHack3Key] then
			local SocialPotentialStories = MartianTribune.SocialPotentialStories
			index, DroneHack3Story = FindStoryInListByKey(SocialPotentialStories, DroneHack3Key)
		end

		if DroneHack3Story then
			Sent[DroneHack3Key] = nil
			Sent[DroneHack3NewKey] = true
			DroneHack3Story.key = DroneHack3NewKey
		end

		-- Make sure the Urgent stories categories have been created.
		if not MartianTribune.TopUrgentStories then
			MartianTribune.TopUrgentStories = { name = "Top Urgent Stories" }
		end
		if not MartianTribune.EngUrgentStories then
			MartianTribune.EngUrgentStories = { name = "Engineering Urgent Stories" }
		end
		if not MartianTribune.SocialUrgentStories then
			MartianTribune.SocialUrgentStories = { name = "Social Urgent Stories" }
		end

		SetPublishedToDay(MartianTribune.TopArchive)
		SetPublishedToDay(MartianTribune.EngArchive)
		SetPublishedToDay(MartianTribune.SocialArchive)
		
		MartianTribune.VersionNumber = 776
	end
end