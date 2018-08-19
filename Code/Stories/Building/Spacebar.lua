local EntityId = "Spacebar"
local Key1 = "Connoisseur"
local Key2 = "Spy"
local Key3 = "WatchWhatYouEat"

local function CheckStory1()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived and UICity.labels.Spacebar ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		AddStory({
			key = Key1,
			title = T{9013666, "Spacebar a hit with local Connoisseur"},
			story = T{9013667, "     WOOOO! Mannn, this Spacebar is great! I went... I went there, and -hic- I went there, it was great! WOOOOO! man, i love it, I don't ever want to -hic- leave... they have this great drink, made from the.. food thing, the.. potatoes, the barman called it 'poteeeen', man its great, does anywhere on mars do Chinese? I could really do with some Chinese right now. -hic-"}
		})
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local Spacebars = UICity.labels.Spacebar or empty_table

	if not Sent[Key2] and ColonistsHaveArrived and #Spacebars > 1 then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local DomeName = (Spacebars[2] and Spacebars[2].parent_dome.name)
			or T{9013644, "unbuilt spacebar dome"}

		AddStory({
			key = Key2,
			title = T{9013642, "Spies Spotted on Mars"},
			story = T{9013643, "     The Martian Tribune has received information that there spies sent from Earth have been spotted on Mars. Sources say that a spy was seen in the spacebar in <MTSecondSpacebarDomeName> highly intoxicated and attempting to hit on any woman in the bar while trying to use the pickup line 'I am the greatest secret agent on Mars, baby!'  The spy's identity has yet to be confirmed.", MTSecondSpacebarDomeName = DomeName}
		})
	end
end

local function CheckStory3()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key3] and ColonistsHaveArrived and CountObjects{class = "Spacebar"} > 1 then
		local Colonist = table.rand(UICity.labels.Colonist)
		local Name = (Colonist and Colonist.name) or T{9013670, "random colonist"}
		local MartianTribuneMod = MartianTribuneMod
		-- local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory

		AddStory({
			key = Key3,
			title = T{9013668, "Watch What You Eat"},
			story = T{9013669, "     A new ordinance has been passed on the number of drinks one may imbibe after yet another incident.  Five of our inebriated compatriots recently snuck off to the stockpiles overnight, exchanging the contents of the food containers randomly with polymers, machine parts, and electronics again.  Watch what you eat, folks.  As <MTRandomColonistName> put it, 'Those electronics just don't go down well'.", MTRandomColonistName = Name},
			-- colonist = IsValidColonist(Colonist) and Colonist or nil
		})
	end
end

local spacebarInit = Spacebar.GameInit
function Spacebar.GameInit(...)
	if spacebarInit then
		spacebarInit(...)
	end
	CheckStory1()
	CheckStory2()
	CheckStory3()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
	CheckStory2()
	CheckStory3()
end