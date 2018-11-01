local Key1 = "NoHumans"
local VikingsKey1 = "VikingsFirst"
local VikingsKey2 = "AtlantisFound"
local AgingKey1 = "AgingGracefully"
local AgingKey2 = "WarmerWeather"

local function AddTopPotentialStories()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local Removed = MartianTribune.Removed
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local AddTopStory = MartianTribuneMod.Functions.AddTopPotentialStory

	if not Sent[Key1] and not Removed[Key1] and not MartianTribune.ColonistsHaveArrived then
		AddTopStory({
			key = Key1,
			title = T{9013768, "01101101 01100101 00100000 01110011 01100001 01100100"},
			story = T{9013769, "    01000100 01110010 01101111 01101110 01100101 01110011 00100000 01101100 01101111 01101110 01100101 01101100 01111001 00101100 00100000 01100010 01110010 01101001 01101110 01100111 00100000 01101000 01110101 01101101 01100001 01101110 01110011 00100000 01110000 01101100 01100101 01100001 01110011 01100101 00101110"}
		})
	end
end

local function AddTopFreeStories()
	local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory
	local Sponsor = MartianTribune.Sponsor

	AddTopStory({
		key = "WeAreMartian",
		title = T{9013780, "We Are Martian"},
		story = T{9013781, "     This is our world now.  The world of rare metals, electronics and universal depots.  On Earth war is waged over economics, religion, and borders.  Here we fight for survival on a primal level.  We are the Martian people.  We will not give up.  We will not give in.  We will continue to build, continue to expand and populate this planet.  No meteor storm will stop us.  We are Martian."}
	})

	AddTopStory({
		key = "OnThisDayIn1965",
		title = T{9013782, "On This Day in 1965"},
		story = T{9013783, "     On July 14th in 1965 Mariner 4 was sent to space by NASA took the first ever photos of the Martian surface.  Have you taken any photos that you're particularly proud of?  Share them today at r/SurvivingMars!"}
	})

	AddTopStory({
		key = "OnThisDayIn1976",
		title = T{9013784, "On This Day in 1976"},
		story = T{9013785, "     On July 20th in 1976 Viking 1 pulled out the landing gear and set down on Martian soil for the first time in human history.  What we have come to accomplish in such few years since then is nothing less than incredible.  What an experience it is to actually set foot on Mars and to literally, walk among the stars!"}
	})

	AddTopStory({
		key = "OnThisDayIn1997",
		title = T{9013786, "On This Day in 1997"},
		story = T{9013787, "     On July 4th in 1997 NASA set down the very first actual rover on the Red Planet.  Shortly after the Mars Pathfinder landed, Sojourner, a solar-powered rover, rolled out and began to scan the surface.  Expected to last just 7 sol, it was finally called to a stop after 91 sol having traveled a total of just over 100 meters and sent a myriad of photos back to Earth for study."}
	})

	AddTopStory({
		key = "OnThisDayIn2015",
		title = T{9013788, "On This Day in 2015"},
		story = T{9013789, "     On September 28th in 2015 NASA announced that the Mars Reconnaissance Orbiter had officially encountered water flowing along the Martian surface.  While it might seem like a foregone conclusion to us today, such news at the time proved quite the breakthrough, leading NASA Administrator Bolden to declare that NASA \"is firmly on a journey to Mars.\""}
	})

	AddTopStory({
		key = VikingsKey1,
		title = T{9013806, "Were We Really The First?"},
		story = T{9013807, "     Reports are coming in that <MTSponsor> may not, in fact, be the first to have arrived on Mars. It is stated that an ancient Viking ship was found near one of our scout's landing sites that contained manuscripts stating that \"the Blue Land has been conquered in the name of Ulfric the Great.\" While no other evidence of this former civilzation has been found, it is a clear reminder: we are not alone.", MTSponsor = Sponsor}
	})

	AddTopStory({
		key = "OlympusMons",
		title = T{9013853, "In The Shadow Of Olympus Mons"},
		story = T{9013854, "     With a height of nearly 25km, Olympus Mons is approximately 2.5 times as tall as its less impressive Earthen counterpart, Mount Everest. At this time of the year, as the sun drops below the peak of Olympus Mons, its shadow covers much of the surface and night comes early. Olympus Mons is located at 18N, 133W."}
	})

	AddTopStory({
		key = "MarsMariana",
		title = T{9013886, "Mars' Own Mariana Trench"},
		story = T{9013887, "     Formed long ago by a crack in the crust of the Red Planet, Valles Marineris is the deepest known canyon in the Milky Way. Found at 13S, 65W, this enormous canyon measures nearly 4000km long and reaches a depth of 7km at one point. This is yet another long standing record that now officially belongs to Mars."}
	})

	AddTopStory({
		key = "ExplorationContinues",
		title = T{9013888, "Earthling Martian Exploration: The Mars 2020 Mission"},
		story = T{9013889, "     Despite the success of our budding colonization of Mars, NASA continued its diligent work towards the Mars 2020 mission. Launching from Cape Canaveral in the late summer of 2020 the new rover incorporated, a spectrometer, radar equipment, drilling and storage, and several other advanced imaging devices, along with a new test unit, the \"MOXIE\", a 300 watt device that they were testing to generate on the Red Planet for the very first time.."}
	})

	AddTopStory({
		key = "SoundOfMars",
		title = T{9013900, "The Sound Of Mars"},
		story = T{9013901, "     The 1999 Mars Polar Lander was the only rover that was sent with a microphone equipped. Due to the crash landing that December, we've been unable to gather data from it. Despite this, simulations have been made with the requisite 1% of Earth's pressurization. The recordings are surprisingly easy to pick up by the human ear, if sounding a bit quieter than expected."}
	})

	AddTopStory({
		key = AgingKey1,
		title = T{9013902, "Aging Gracefully Is A Thing"},
		story = T{9013903, "     I’m sure you’ve noticed the longer workdays and wondered how long until winter was finally over… that’s all due to the greater distance Mars is from the Sun than what you might be used to on Earth. A Sol (short for ‘solar day’) is nearly 44 minutes longer here than on Earth, and it takes a wild 687 Earth days for it to orbit the sun (668 Sol). Thankfully, since the axial tilt of Mars is also similar to that of Earth (24.5 degrees vs Earth’s 23.5), we still get each of the distinct seasons. On the upside, while your birthday might only happen half as often here, you’re also only half the age!"}
	})

	AddTopStory({
		key = "MarsName",
		title = T{9013906, "How Mars Got Its Name"},
		story = T{9013907, "     The Romans left an indelible impact upon Earthen history, such a great impact that they even determined the name of various elements of our solar system. Even without telescopes they identified each of the brightest five planets, alongside the Moon and the Sun, of course. Each of these planets was then named after gods, the most important of which was the god of war, Mars, who rode into battle on a chariot pulled by the horses Phobos and Deimos (meaning ‘fear’ and ‘panic’). May the foreboding names of our new planet and moons not be indicative of our imminent future."}
	})
end

local function AddEngFreeStories()
	local AddEngStory = MartianTribuneMod.Functions.AddEngFreeStory

	AddEngStory({
		key = "ISSSovereignty",
		title = T{9013792, "ISS Declares Sovereignty"},
		story = T{9013793, "     The International Space Station orbiting Earth has recently declared itself a free, sovereign, and independent state, capable of enacting its own laws and governance. There was some opposition from many nations on earth. However once threats of crashing the mega structure into the planet reached Earth, many Earthlings rapidly changed their mind on the matter. Mars itself has become the first entity to recognize the independent state of the ISS and will be holding a press conference on the matter in the coming days."}
	})

	AddEngStory({
		key = "Woodys",
		title = T{9013800, "Woody's Woods to Expand to Mars"},
		story = T{9013801, "     Woodys Woods, a tree-felling business of Cities Skylines fame, has decided to expand its operations to Mars. This decision has come as a surprise to many people, mainly because there are no trees on Mars.  When asked about this, Woody responded, \"I'm sure we'll find something to cut down!\""}
	})

	AddEngStory({
		key = "DroneReverse",
		title = T{9013802, "Drone Reverse Engineering"},
		story = T{9013803, "     After many days, drones have finaly completed their reverse engineering training and can now move both forwards and backwards. This advancement will be a huge help in traversing the un-even surface of Mars."}
	})
end

local function AddSocialFreeStories()
	local AddSocialStory = MartianTribuneMod.Functions.AddSocialFreeStory
	local LeaderTitle = MartianTribune.LeaderTitle

	AddSocialStory({
		key = "PoliticalAmbitions",
		title = T{9013790, "Political Ambitions Set Too High?"},
		story = T{9013791, "     A politician on Earth has stated the obvious this week by claiming that Mars is red.  The hopeful senator took it a step further by declaring that Mars is a also a communist planet, with \"nothing but red, red, red\".  After performing some reconnissance here at the Martian Tribune Headquarters, we would like to confirm that Mars is indeed red.  The claims of communism getting a foothold, however, will have to be fielded by the <MTLeaderTitle>.", MTLeaderTitle = LeaderTitle}
	})

	AddSocialStory({
		key = "MarsCheese",
		title = T{9013794, "US President Confirms: Not A Scientist"},
		story = T{9013795, "     The current President of the United States, after staring intently at several photos of the Red Planet, proceeded to ask his scientific advisors if Mars is actually made of cheese. The researchers reminded the president that Mars is mostly made of rock, and that it is, in fact, the Moon that is made of cheese."}
	})

	AddSocialStory({
		key = "DroneToys",
		title = T{9013796, "Drone Toy Sales Through The Roof"},
		story = T{9013797, "     With all of the photos and videos sent back to Earth, the demand for the miniature, remote controlled, toy replica of the standard martian drone has been much higher than anticipated. The toy broke first week sales records all across the globe. The remote controlled mini drone, which sells for just over 400 dollars each, has been sold out in most places. With the shortage, and with Christmas so soon, it's sad to say, but some children may be dissapointed this year."}
	})

	AddSocialStory({
		key = "MysteriousRadio",
		title = T{9013798, "Mysterious Radio Station Causes Concern"},
		story = T{9013799, "     The Martian planet is being entertained by the great hosts at Mars Radio One, among other stations, but what has the Martian Tribune concerned is that there are no facilities to broadcast a radio station here on Mars. Come to think of it, there are no facilities to make a newspaper either... let's just let that slide then."}
	})

	AddSocialStory({
		key = "NuclearThreat",
		title = T{9013804, "Former Peaceful Organization Threatens Nuclear War"},
		story = T{9013805, "     An organization formerly believed to be peaceful has been uncovered as a sleeper cell that is now threatening interstellar war.  The leader of this formerly benign oceanic  movement known as Norwegians for Underdeveloped Kelp Enrichment ('NUKE') has laid claim to a former lakebed near Mount Olympus and threatened nuclear annihilation upon any civilization that settles too close to their newly founded city."}
	})

	AddSocialStory({
		key = "Macburgers",
		title = T{9013808, "Macburgers expands to Mars"},
		story = T{9013809, "     The large multinational fast food chain, Macburgers, is seeking to become the first multiplanetary company in history, with plans put forward to open a restaurant on the red planet as soon as permits allow. There is strong opposition to the plan, even within the company, mainly due to the lack of money and meat on Mars."}
	})
end


local function CheckRemoveStories()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	if not Published[Key1] and MartianTribune.ColonistsHaveArrived then
		MartianTribuneMod.Functions.RemoveTopPotentialStory(Key1)
	end
end

local function CheckChainStories()
	local MartianTribune = MartianTribune
	local Published = MartianTribune.Published
	local Sent = MartianTribune.Sent
	local AddTopStory = MartianTribuneMod.Functions.AddTopFreeStory

	if Published[VikingsKey1] and not Sent[VikingsKey2] then
		AddTopStory({
			key = VikingsKey2,
			title = T{9013851, "Atlantis has been found!"},
			story = T{9013852, "     The long lost city of Atlantis, thought to be nothing but rumor and legend, has been found, and it is where no-one expected to find it - around 15KM below the surface of Mars. The legend of the Lost City that sunk beneath the blue sea may well have been mistranslated from ancient Viking manuscripts, who meant to say it sunk beneath the dust of the red planet. In retrospect, that was an easy mistake to make."}
		})
	end

	if Published[AgingKey1]
		and not Sent[AgingKey2]
		and UICity
		and UICity.day >= (Published[AgingKey1] + 10)
	then
		AddTopStory({
			key = AgingKey2,
			title = T{9013904, "Midday Highs and Overnight Lows"},
			story = T{9013905, "     This week may very well be the best yet temperature-wise. Expect to see midday highs right around 20 degrees Celsius for most of the week, but don’t count on it staying there as the moment that the Sun recedes lows will plummet, with the overnight low expected to be approximately -70C. Let’s just hope that the dust storms and meteor showers give us a chance to enjoy this warmer, more predictable weather!"}
		})
	end
end

function OnMsg.ColonistArrived()
	CheckRemoveStories()
end

function OnMsg.MartianTribuneCheckStories()
	CheckRemoveStories()
	CheckChainStories()
end

function OnMsg.MartianTribuneInitializeStories()
	AddTopPotentialStories()
	AddTopFreeStories()
	AddEngFreeStories()
	AddSocialFreeStories()
end
