local Key1 = "OlympicsBid1"
local Key2 = "OlympicsBid2"

local function CheckStory1()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local GymList = UICity.labels.OpenAirGym or empty_table

	if not Sent[Key1] and ColonistsHaveArrived and #GymList > 0 then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local Sponsor = MartianTribune.Sponsor
		local Gym = table.rand(GymList)
		local OlympicBidGymDome =
			(Gym and Gym.parent_dome and Gym.parent_dome.name)
			or T{9013729, "dome with open air gym"}

		AddStory({
			key = Key1,
			title = T{9013727, "Olympic Bid Rejected"},
			story = T{9013728, "     After the opening of our new open-air gym in <MTOlympicBidGymDome>, <MTSponsor> applied to host the Olympics on Mars, saying, 'We have the best view of Mount Olympus and a Gym, what more could one ask for?' The International Olympics Committee on Earth rejected the proposal, saying 'Wait, that was an actual bid? You don't even have a pool.' <MTSponsor> responded by saying they will start their own Interstellar Olympics.  Expect track, blackjack, marbles, and Drone Jumping to headline the experience.", MTOlympicBidGymDome = OlympicBidGymDome, MTSponsor = Sponsor}
		})
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent

	if Published[Key1] and not Sent[Key2] then
		local SocialArchive = MartianTribune.SocialArchive
		local FindStoryInListByKey = MartianTribuneMod.Functions.FindStoryInListByKey
		local index, OlympicBid1 = FindStoryInListByKey(SocialArchive, Key1)

		if OlympicBid1 and UICity.day > (OlympicBid1.publishedDay + 16) then
			local LeaderName = MartianTribune.LeaderName
			local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
			AddStory({
				key = Key2,
				title = T{9013568, "The Martian Games"},
				story = T{9013569, "     Following The Failed bid to host the olympics on Mars, <MTLeader> has decided to create our own games, incorporating Blackjack and Hoopers, among others. Games of Hoopers will start things off this coming Saturday in the open air gym. Also considered for the Martian Games are Dome Skiing, where contestants race down the outside of a dome on pallets, and Drone Jumping.", MTLeader = LeaderName}
			})
		end
	end
end

local gymInit = OpenAirGym.GameInit
function OpenAirGym.GameInit(...)
	if gymInit then
		gymInit(...)
	end
	CheckStory1()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
	CheckStory2()
end