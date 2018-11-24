local Key1 = "AgingGracefully"
local Key2 = "WarmerWeather"

local function CheckStory1()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived

	if not Sent[Key1] and ColonistsHaveArrived then
		local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory

		AddTopStory({
			key = Key1,
			title = T{9013902, "Aging Gracefully Is A Thing"},
			story = T{9013903, "     I’m sure you’ve noticed the longer workdays and wondered how long until winter was finally over… that’s all due to the greater distance Mars is from the Sun than what you might be used to on Earth. A Sol (short for ‘solar day’) is nearly 44 minutes longer here than on Earth, and it takes a wild 687 Earth days for it to orbit the sun (668 Sol). Thankfully, since the axial tilt of Mars is also similar to that of Earth (24.5 degrees vs Earth’s 23.5), we still get each of the distinct seasons. On the upside, while your birthday might only happen half as often here, you’re also only half the age!"}
		})
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent
	
	if Published[Key1]
		and not Sent[Key2]
		and UICity
		and UICity.day >= (Published[Key1] + 10)
	then
		local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory
		local MartianTribuneMod = MartianTribuneMod
		local IsColdWaveActive = MartianTribuneMod.Functions.IsColdWaveActive
		local IsColdWavePredicted = MartianTribuneMod.Functions.IsColdWavePredicted

		AddTopStory({
			key = Key2,
			title = T{9013904, "Midday Highs and Overnight Lows"},
			story = T{9013905, "     This week may very well be the best yet temperature-wise. Expect to see midday highs right around 20 degrees Celsius for most of the week, but don’t count on it staying there as the moment that the Sun recedes lows will plummet, with the overnight low expected to be approximately -70C. Let’s just hope that the dust storms and meteor showers give us a chance to enjoy this warmer, more predictable weather!"},
			canPublish = function()
				return not IsColdWaveActive() and not IsColdWavePredicted()
			end
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
	CheckStory2()
end