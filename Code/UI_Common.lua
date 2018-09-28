
MartianTribuneMod.News.NoNews = {
	key = "NoNews",
	title = T{9013764, "No news of interest at this point in time."},
	story = " "
}

MartianTribuneMod.News.ArchiveDepleted2 = {
	key = "ArchiveDepleted2",
	title = " ",
	story = " "
}

-- Returns the story with the given index if it exists, or returns the depleted story if the index is invalid
MartianTribuneMod.Functions.GetArchiveStory = function(index, archive, depleted)
	if #archive > 0 and index > 0 and index <= #archive then
		return archive[index]
	end
	return depleted
end
