-- Fixup to go from Martian Tribune version 774 => 775+, adding publishedDay to published stories.
MartianTribuneMod.SaveGameFixes[775].SetMissingPublishedDay = function(story, oldData)
	if story.publishedDay == nil then
		local currentDay = UICity.day
		-- special handling for story chains.
		if story.key == "OlympicsBid1" and oldData.MTMartianOlympicsWait > 0 then
			story.publishedDay = currentDay - oldData.MTMartianOlympicsWait
		elseif story.key == "FightClub1" and oldData.MTFightClub2Wait > 0 then
			story.publishedDay = currentDay - oldData.MTFightClub2Wait
		elseif story.key == "PewPew" and oldData.MTPewPewWaitingPeriod > 0 then
			story.publishedDay = currentDay - oldData.MTPewPewWaitingPeriod
		elseif story.key == "Vegan1" and oldData.MTVeganPurgatoryDays > 0 then
			story.publishedDay = currentDay - oldData.MTVeganPurgatoryDays
		elseif story.key == "Vegan2" and oldData.MTVeganPurgatoryDays > 0 then
			story.publishedDay = currentDay - oldData.MTVeganPurgatoryDays + 10
		elseif story.key == "Vegan3" and oldData.MTVeganPurgatoryDays > 0 then
			story.publishedDay = currentDay - oldData.MTVeganPurgatoryDays + 22
		elseif story.key == "DomeDelay1" and oldData.MTDomeDelay2DaysWaiting > 0 then
			story.publishedDay = currentDay - oldData.MTDomeDelay2DaysWaiting
		elseif story.key == "DroneHack1" and oldData.MTDroneHackDay > 0 then
			story.publishedDay = currentDay - oldData.MTDroneHackDay
		elseif story.key == "DroneHack2" and oldData.MTDroneHackDay > 0 then
			story.publishedDay = currentDay - oldData.MTDroneHackDay + 5
		else
			-- default to current day, as accuracy for past stories is not required unless it is
			-- part of a story chain
			story.publishedDay = currentDay
		end
	end
	if story.key then
		MartianTribune.Published[story.key] = story.publishedDay
	end
	return story
end
