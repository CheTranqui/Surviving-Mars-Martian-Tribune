
-- Note: The story titles here should not get "edited" to match any changes made after version 774, as the save game data that is being migrated will still contain the old version of the story titles.
local StoryKeysByTitle = {
	-- Essentials: These are the stories in story chains.
	[_InternalTranslate(T{9013727, "Olympic Bid Rejected"})] = "OlympicsBid1",
	[_InternalTranslate(T{9013568, "The Martian Games"})] = "OlympicsBid2",
	[_InternalTranslate(T{9013574, "They're Fighting, Stop Fighting!"})] = "FightClub1",
	[_InternalTranslate(T{9013578, "Fight Club Story Retraction"})] = "FightClub2",
	[_InternalTranslate(T{9013618, "Pew Pew"})] = "PewPew",
	[_InternalTranslate(T{9013620, "Pew Pew Pew!"})] = "PewPewPew",
	[_InternalTranslate(T{9013702, "Vegan Declares Mars Meat-Free Planet"})] = "Vegan1",
	[_InternalTranslate(T{9013704, "Mars Still Meat Free"})] = "Vegan2",
	[_InternalTranslate(T{9013706, "Vegan Martian Coalition Gains Ground"})] = "Vegan3",
	[_InternalTranslate(T{9013708, "Vegan Martian Coalition Talks Stalled"})] = "Vegan4",
	[_InternalTranslate(T{9013710, "Earthling Causes Delay"})] = "DomeDelay1",
	[_InternalTranslate(T{9013712, "Earthling Claims To Be Misunderstood"})] = "DomeDelay2",
	[_InternalTranslate(T{9013715, "Teenager Takes Drone for a Joyride"})] = "DroneHack1",
	[_InternalTranslate(T{9013719, "New Sport Established On Mars"})] = "DroneHack2",
	[_InternalTranslate(T{9013721, "New Martian Law Enforced"})] = "DroneHack3",
	-- Other stories
	[_InternalTranslate(T{9013533, "Fuel of the Future"})] = "LowGHydroTech1",
	[_InternalTranslate(T{9013535, "Drones Imbued With the Secrets of Hydrosynthesis"})] = "LowGHydroTech2",
	[_InternalTranslate(T{9013537, "Drones Reminded That Structure Shells Look Silly"})] = "DecommissionTech1",
	[_InternalTranslate(T{9013539, "Decommissioning Buildings Necessary for Colonial Advancement"})] = "DecommissionTech2",
	[_InternalTranslate(T{9013541, "Rockets Now Made More Spacious"})] = "FuelCompressionTech1",
	[_InternalTranslate(T{9013543, "Looser Safety Restrictions Means More Room For Cargo"})] = "FuelCompressionTech2",
	[_InternalTranslate(T{9013545, "Water Recovery Explained"})] = "WaterReclamationTech1",
	[_InternalTranslate(T{9013547, "New Spire Does NOT Contain Swimming Pool"})] = "WaterReclamationTech2",
	[_InternalTranslate(T{9013550, "Painting Water Vaporators"})] = "HygroscopicVaporatorsTech1",
	[_InternalTranslate(T{9013552, "Successful Martian Colony Brings Hope"})] = "FutureExpansion",
	[_InternalTranslate(T{9013554, "It's a bird!  It's a plane! It's..."})] = "ElonMusk",
	[_InternalTranslate(T{9013556, "But How Do They Work?"})] = "MagneticMoxieTech1",
	[_InternalTranslate(T{9013558, "Moxie Magnets Make Magic"})] = "MagneticMoxieTech2",
	[_InternalTranslate(T{9013560, "People With Mushroom Allergies Beware"})] = "LowGFungiTech1",
	[_InternalTranslate(T{9013562, "Mushrooms on Mars"})] = "LowGFungiTech2",
	[_InternalTranslate(T{9013564, "Adding Waste To The Dust Makes Soil"})] = "SoilAdaptationTech1",
	[_InternalTranslate(T{9013566, "Botanists Rejoice As Farming Becomes Viable"})] = "SoilAdaptationTech2",
	[_InternalTranslate(T{9013570, "Mars Day"})] = "MarsDay",
	[_InternalTranslate(T{9013572, "First Words Spoken On Mars"})] = "FoundersFirstWords",
	[_InternalTranslate(T{9013580, "The Faith of Mars"})] = "MartianFaith",
	[_InternalTranslate(T{9013582, "Guru In The Garden"})] = "GuruGarden",
	[_InternalTranslate(T{9013585, "El Presidente to Visit Mars"})] = "ElPresidente",
	[_InternalTranslate(T{9013587, "A Martian Marathon"})] = "MarathonExplorer",
	[_InternalTranslate(T{9013591, "Shuttle Capacity Doubled"})] = "CompactPassengerTech1",
	[_InternalTranslate(T{9013593, "A Clinic on Inefficiency"})] = "DroneShortage",
	[_InternalTranslate(T{9013595, "Word of the Day:  Power Conservation"})] = "PowerSupply1",
	[_InternalTranslate(T{9013597, "Power Grid Depleted"})] = "PowerSupply2",
	[_InternalTranslate(T{9013599, "Water Shortage Rumors Abound"})] = "WaterSupply1",
	[_InternalTranslate(T{9013601, "Let It Mellow"})] = "WaterSupply2",
	[_InternalTranslate(T{9013603, "Oxygen Short: Time To Lay Low"})] = "AirSupply1",
	[_InternalTranslate(T{9013605, "Oxygen Production Goals Unmet"})] = "AirSupply2",
	[_InternalTranslate(T{9013607, "First Dome-Penetrating Structure Erected"})] = "ArcologyInuendo",
	[_InternalTranslate(T{9013610, "Moxie: Martian Magic"})] = "MoxieMagic",
	[_InternalTranslate(T{9013612, "Video of Martian Drone Goes Viral"})] = "DroneGoesViral",
	[_InternalTranslate(T{9013614, "Concrete Extractor Loves Its Job"})] = "ConcreteLove",
	[_InternalTranslate(T{9013616, "Oval Dome Declared Unnatural"})] = "OvalDome",
	[_InternalTranslate(T{9013622, "Barely Scratching The Surface"})] = "ScratchingTheSurface",
	[_InternalTranslate(T{9013628, "Drought Declared"})] = "WaterShortage1",
	[_InternalTranslate(T{9013630, "Engineers Working To Mitigate Water Shortage"})] = "WaterShortage2",
	[_InternalTranslate(T{9013635, "Live From Mars Renewed for Season 2"})] = "MarsRealityTV",
	[_InternalTranslate(T{9013638, "What Goes Around Comes Around"})] = "SoylentGreen",
	[_InternalTranslate(T{9013640, "Domelenol Now Available!"})] = "Domelenol",
	[_InternalTranslate(T{9013642, "Spies Spotted on Mars"})] = "Spy",
	[_InternalTranslate(T{9013645, "New Language Develops on Mars"})] = "NewLanguage",
	[_InternalTranslate(T{9013647, "Vigilante Justice"})] = "Vigilante",
	[_InternalTranslate(T{9013649, "New Martian Passport Revealed"})] = "Passport",
	[_InternalTranslate(T{9013651, "Martian Music Voted Best in Galaxy"})] = "MartianMusic",
	[_InternalTranslate(T{9013655, "Religious Artifact Found on Mars"})] = "ReligiousArtifact",
	-- There's two possible versions of the HappyBirthday story...
	[_InternalTranslate(T{9013658, "A New Milestone Has Been Achieved!"})] = "HappyBirthday",
	[_InternalTranslate(T{9013658, "A Baby-Step For Mankind, A Huge Leap For Martianborn!"})] = "HappyBirthday",
	[_InternalTranslate(T{9013661, "Petition to Rename Dome"})] = "FirstMartianbornDied",
	[_InternalTranslate(T{9013664, "Virtue Over Vices"})] = "VirtueOverVices",
	[_InternalTranslate(T{9013666, "Spacebar a hit with local Connoisseur"})] = "Connoisseur",
	[_InternalTranslate(T{9013668, "Watch What You Eat"})] = "WatchWhatYouEat",
	[_InternalTranslate(T{9013671, "Flat Mars League Gains Traction"})] = "IdiotFML",
	[_InternalTranslate(T{9013673, "Oops I Broke It Again"})] = "OopsIBrokeItAgain",
	[_InternalTranslate(T{9013676, "The Wright Way"})] = "ShuttleHub",
	[_InternalTranslate(T{9013678, "MRU Opens Its Doors"})] = "University",
	[_InternalTranslate(T{9013680, "The Answer To Life Is Always 42"})] = "MartianCelebrity",
	[_InternalTranslate(T{9013683, "First Founder Passed Away"})] = "FirstFounderDied",
	[_InternalTranslate(T{9013686, "The Grass Couldn't Be Greener"})] = "Hippie",
	[_InternalTranslate(T{9013689, "The Rock Is Always Redder"})] = "MovingDomes",
	[_InternalTranslate(T{9013692, "Sound Complaint Filed"})] = "SoundComplaint",
	[_InternalTranslate(T{9013696, "Paving Over The Problem"})] = "ConcretePaving",
	[_InternalTranslate(T{9013699, "Is this Vegan?"})] = "VeganDiner",
	[_InternalTranslate(T{9013724, "The Refuse Hits The Fan"})] = "RefuseHitsTheFan",
	[_InternalTranslate(T{9013730, "Struggling Colonist Adopts Pet"})] = "PetRock",
	[_InternalTranslate(T{9013733, "Mars is in Mourning"})] = "LeaderDied1",
	[_InternalTranslate(T{9013742, "Wrong Sibling Elevated?"})] = "NewLeader3",
	[_InternalTranslate(T{9013776, "Sponsor Funds Depleted"})] = "Finances1",
	[_InternalTranslate(T{9013778, "Sponsor Cites Insider Trading Woes"})] = "Finances2",
	[_InternalTranslate(T{9013770, "Rocket Silhouettes Mar Martian Landscape"})] = "Rockets3",
	[_InternalTranslate(T{9013744, "Drones Watch In Awe"})] = "RocketObservation",
	[_InternalTranslate(T{9013774, "Hack the planet!"})] = "HackThePlanet",
	[_InternalTranslate(T{9013747, "The Founder's Legacy"})] = "FoundersLegacy",
	[_InternalTranslate(T{9013758, "SpaceXXX"})] = "AdultFilm",
	[_InternalTranslate(T{9013761, "Push For Drone Rights"})] = "DroneRights",
	[_InternalTranslate(T{9013768, "01101101 01100101 00100000 01110011 01100001 01100100"})] = "NoHumans",
	[_InternalTranslate(T{9013780, "We Are Martian"})] = "WeAreMartian",
	[_InternalTranslate(T{9013782, "On This Day in 1965"})] = "OnThisDayIn1965",
	[_InternalTranslate(T{9013784, "On This Day in 1976"})] = "OnThisDayIn1976",
	[_InternalTranslate(T{9013786, "On This Day in 1997"})] = "OnThisDayIn1997",
	[_InternalTranslate(T{9013788, "On This Day in 2015"})] = "OnThisDayIn2015",
	[_InternalTranslate(T{9013790, "Political Ambitions Set Too High?"})] = "PoliticalAmbitions",
	[_InternalTranslate(T{9013792, "ISS Declares Sovereignty"})] = "ISSSovereignty",
	[_InternalTranslate(T{9013794, "US President Confirms: Not A Scientist"})] = "MarsCheese",
	[_InternalTranslate(T{9013796, "Drone Toy Sales Through The Roof"})] = "DroneToys",
	[_InternalTranslate(T{9013798, "Mysterious Radio Station Causes Concern"})] = "MysteriousRadio",
	[_InternalTranslate(T{9013800, "Woody's Woods to Expand to Mars"})] = "Woodys",
	[_InternalTranslate(T{9013802, "Drone Reverse Engineering"})] = "DroneReverse",
	[_InternalTranslate(T{9013804, "Former Peaceful Organization Threatens Nuclear War"})] = "NuclearThreat",
	[_InternalTranslate(T{9013806, "Were We Really The First?"})] = "VikingsFirst",
	[_InternalTranslate(T{9013808, "Macburgers expands to Mars"})] = "Macburgers"
};

-- Not included stories due to the presence of variables in the title (checked below):
---- "DroneBreakdown" => Random drone name.
---- "O2Shortage1" => Random dome name.
---- "O2Shortage2" => Random dome name.
---- "Equality" => Leader title.
---- "LeaderDied2" => Leader title.
---- "NewLeader1" => Leader title.
---- "NewLeader2" => Leader name.
---- "Rockets0" => Leader title.

-- Fixup to go from Martian Tribune version 774 => 775+, ensuring that any story in a story chain
-- has a 'key' value set.
-- (Other stories that may be missing keys are not currently searched for)
MartianTribuneMod.SaveGameFixes[775].SetStoryKey = function(story)
	local MartianTribune = MartianTribune
	if (not MartianTribune.VersionNumber or MartianTribune.VersionNumber < 775)
		and not story.key
	then
		local CompareTranslationStrings = MartianTribuneMod.Functions.CompareTranslationStrings
		local LeaderTitle = MartianTribune.LeaderTitle
		local string = string
		local title = _InternalTranslate(story.title)
		local key = StoryKeysByTitle[title]
		if key then
			story.key = key
		elseif CompareTranslationStrings(story.title, T{9013738, "A New <MTLeaderTitle> Takes the Helm", MTLeaderTitle = LeaderTitle})
			or string.ends_with(title, " Takes the Helm")
		then
			story.key = key
		elseif CompareTranslationStrings(story.title, T{9013735, "Mars Mourns <MTLeaderTitle>'s Passing", MTLeaderTitle = LeaderTitle})
			or (string.starts_with(title, "Mars Mourns ") and string.ends_with(title, " Passing"))
		then
			story.key = "LeaderDied2"
		elseif CompareTranslationStrings(story.title, T{9013653, "<MTLeaderTitle> Praised For Culture of Equality", LeaderTitle = LeaderTitle})
			or string.ends_with(title, " Praised For Culture of Equality")
		then
			story.key = "Equality"
		elseif CompareTranslationStrings(story.title, T{9013772, "<MTLeaderTitle> Sets High Standard", MTLeaderTitle = LeaderTitle})
			or string.ends_with(title, " Sets High Standard")
		then
			story.key = "Rockets0"
		elseif string.ends_with(title, " Breathes New Life Into Colony") then
			story.key = "NewLeader2"
		elseif string.ends_with(title, " Breakdown") then
			story.key = "DroneBreakdown"
		elseif string.ends_with(title, " Holds Their Breath") then
			story.key = "O2Shortage1"
		elseif string.ends_with(title, " Lets Off Some Steam") then
			story.key = "O2Shortage2"
		else
			print("SaveGameFixes[775].SetStoryKey: Could not find key for story, title:", title, ", content:", _InternalTranslate(story.story))
		end

	end

	if story.key then
		MartianTribune.Sent[story.key] = true
	end

	return story
end
