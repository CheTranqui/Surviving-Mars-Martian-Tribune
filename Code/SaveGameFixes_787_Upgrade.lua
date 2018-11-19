local FixNo = 787

MartianTribuneMod.SaveGameFixes[FixNo].Upgrade = function(oldData)
	local MartianTribune = MartianTribune
	if MartianTribune.VersionNumber < FixNo then
		for i=1,#MartianTribune.TopFreeStories do
			local story = MartianTribune.TopFreeStories[i]
			if story.key == "WarmerWeather" and not story.canPublish then
				local MartianTribuneMod = MartianTribuneMod
				local IsColdWaveActive = MartianTribuneMod.Functions.IsColdWaveActive
				local IsColdWavePredicted = MartianTribuneMod.Functions.IsColdWavePredicted

				story.canPublish = function()
					return not IsColdWaveActive() and not IsColdWavePredicted()
				end
			end
			MartianTribune.TopFreeStories[i] = story
		end

		MartianTribune.VersionNumber = FixNo
	end
end
