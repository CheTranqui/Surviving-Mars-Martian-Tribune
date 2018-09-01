local Key1 = "MartianFaith"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and UICity.day > 140 then
		local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
		AddStory({
			key = Key1,
			title = T{9013580, "The Faith of Mars"},
			story = T{9013581, "     Religion has become a very important part of Martian life, ever since our first founders, who melded together all forms of Christiandom, Islam and Judaism into a single super faith. Today, there are a wide variety of religions on Mars: The True Humanity Society, who follow the teachings of Earth and worship her children, The Jedi, who follow the teachings of a galaxy far far away, The aforementioned Tri-Faith, which follows the teachings of each of the above Earthling faiths, and of course, our very own Red Church of Mars, which needs no explanation."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end