local TechId = "DeepScanning"
local Key1 = "ScratchingTheSurface"
local Key2 = "HackThePlanet"

local function CheckStory1()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune
	local Removed = MartianTribune.Removed
	local Sent = MartianTribune.Sent
	local UICity = UICity
	
	if not Sent[Key1]
		and not Removed[Key1]
		and UICity.tech_status[TechId].researched == nil
		and UICity.day > 75
	then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		AddStory({
			key = Key1,
			title = T{9013622, "Barely Scratching The Surface"},
			story = T{9013623, "     With each day that passes we are learning more and more about the new world around us, but this doesn't mean that we've learned a single iota about the land next to us.  Our surface deposits are great, but when are we going to probe beyond the surface?  These piddly deposits will only serve our needs in the short term.  In the long term, we need to bore.  We need to go deep."}
		})
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune
	local Removed = MartianTribune.Removed
	local Sent = MartianTribune.Sent

	if not Sent[Key2]
		and not Removed[Key2]
		and ColonistsHaveArrived
		and UICity.tech_status[TechId].researched ~= nil
		and CountObjects{class = "SensorTower"} <= 2
	then
		local LeaderName = MartianTribune.LeaderName
		local LeaderTitle = MartianTribune.LeaderTitle
		local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory

		AddStory({
			key = Key2,
			title = T{9013774, "Hack the planet!"},
			story = T{9013775, "    Our primary manifesto as a society is to populate the Red Planet.  Someone should remind <MTLeaderTitle> <MTLeader> about that.  They seem to think that scanning the surface and finding suitable resources and dome locations serves no particular purpose.  Have you seen our metals supply lately?  This water isn't going to last forever, you know.  We need more Sensor Towers.  When will we learn from the past?  The time is now!  This planet is ours for the taking, but only if we know what's out there!", MTLeaderTitle = LeaderTitle, MTLeader = LeaderName}
		})
	end
end

local function CheckRemoveStory1()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Removed = MartianTribune.Removed
	
	if not Published[Key1] and not Removed[Key1] and UICity.tech_status[TechId].researched ~= nil then
		MartianTribuneMod.Functions.RemoveEngPotentialStory(Key1)
	end
end

local function CheckRemoveStory2()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Removed = MartianTribune.Removed

	if not Published[Key2] and not Removed[Key2] and CountObjects{class = "SensorTower"} > 2 then
		MartianTribuneMod.Functions.RemoveTopPotentialStory(Key2)
	end
end

local sensorTowerInit = SensorTower.GameInit
function SensorTower.GameInit(...)
	if sensorTowerInit ~= nil then
		sensorTowerInit(...)
	end
	CheckRemoveStory2()
end

function OnMsg.TechResearched(tech_id, city, first_time)
	if tech_id == TechId then
		CheckRemoveStory1()
		CheckRemoveStory2()
		-- Story1 can't be generated once the tech is researched, so don't check it.
		CheckStory2()
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckRemoveStory1()
	CheckRemoveStory2()
	CheckStory1()
	CheckStory2()
end