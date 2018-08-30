local Key1 = "NoHumans"
local VikingsKey1 = "VikingsFirst"
local VikingsKey2 = "AtlantisFound"

local function AddTopPotentialStories()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local Removed = MartianTribune.Removed
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory

	if not Sent[Key1] and not Removed[Key1] and not MartianTribune.ColonistsHaveArrived then
		AddStory({
			key = Key1,
			title = T{9013768, "01101101 01100101 00100000 01110011 01100001 01100100"},
			story = T{9013769, "    01000100 01110010 01101111 01101110 01100101 01110011 00100000 01101100 01101111 01101110 01100101 01101100 01111001 00101100 00100000 01100010 01110010 01101001 01101110 01100111 00100000 01101000 01110101 01101101 01100001 01101110 01110011 00100000 01110000 01101100 01100101 01100001 01110011 01100101 00101110"}
		})
	end
end

local function AddTopFreeStories()
	local AddStory = MartianTribuneMod.Functions.AddTopFreeStory
	local Sponsor = MartianTribune.Sponsor

	AddStory({
		key = "WeAreMartian",
		title = T{9013780, "We Are Martian"},
		story = T{9013781, "     This is our world now.  The world of rare metals, electronics and universal depots.  On Earth war is waged over economics, religion, and borders.  Here we fight for survival on a primal level.  We are the Martian people.  We will not give up.  We will not give in.  We will continue to build, continue to expand and populate this planet.  No meteor storm will stop us.  We are Martian."}
	})

	AddStory({
		key = "OnThisDayIn1965",
		title = T{9013782, "On This Day in 1965"},
		story = T{9013783, "     On July 14th in 1965 Mariner 4 was sent to space by NASA took the first ever photos of the Martian surface.  Have you taken any photos that you're particularly proud of?  Share them today at r/SurvivingMars!"}
	})

	AddStory({
		key = "OnThisDayIn1976",
		title = T{9013784, "On This Day in 1976"},
		story = T{9013785, "     On July 20th in 1976 Viking 1 pulled out the landing gear and set down on Martian soil for the first time in human history.  What we have come to accomplish in such few years since then is nothing less than incredible.  What an experience it is to actually set foot on Mars and to literally, walk among the stars!"}
	})

	AddStory({
		key = "OnThisDayIn1997",
		title = T{9013786, "On This Day in 1997"},
		story = T{9013787, "     On July 4th in 1997 NASA set down the very first actual rover on the Red Planet.  Shortly after the Mars Pathfinder landed, Sojourner, a solar-powered rover, rolled out and began to scan the surface.  Expected to last just 7 sol, it was finally called to a stop after 91 sol having traveled a total of just over 100 meters and sent a myriad of photos back to Earth for study."}
	})

	AddStory({
		key = "OnThisDayIn2015",
		title = T{9013788, "On This Day in 2015"},
		story = T{9013789, "     On September 28th in 2015 NASA announced that the Mars Reconnaissance Orbiter had officially encountered water flowing along the Martian surface.  While it might seem like a foregone conclusion to us today, such news at the time proved quite the breakthrough, leading NASA Administrator Bolden to declare that NASA \"is firmly on a journey to Mars.\""}
	})

	AddStory({
		key = VikingsKey1,
		title = T{9013806, "Were We Really The First?"},
		story = T{9013807, "     Reports are coming in that <MTSponsor> may not, in fact, be the first to have arrived on Mars. It is stated that an ancient Viking ship was found near one of our scout's landing sites that contained manuscripts stating that \"the Blue Land has been conquered in the name of Ulfric the Great.\" While no other evidence of this former civilzation has been found, it is a clear reminder: we are not alone.", MTSponsor = Sponsor}
	})
end

local function AddEngFreeStories()
	local AddStory = MartianTribuneMod.Functions.AddEngFreeStory

	AddStory({
		key = "ISSSovereignty",
		title = T{9013792, "ISS Declares Sovereignty"},
		story = T{9013793, "     The International Space Station orbiting Earth has recently declared itself a free, sovereign, and independent state, capable of enacting its own laws and governance. There was some opposition from many nations on earth. However once threats of crashing the mega structure into the planet reached Earth, many Earthlings rapidly changed their mind on the matter. Mars itself has become the first entity to recognize the independent state of the ISS and will be holding a press conference on the matter in the coming days."}
	})

	AddStory({
		key = "Woodys",
		title = T{9013800, "Woody's Woods to Expand to Mars"},
		story = T{9013801, "     Woodys Woods, a tree-felling business of Cities Skylines fame, has decided to expand its operations to Mars. This decision has come as a surprise to many people, mainly because there are no trees on Mars.  When asked about this, Woody responded, \"I'm sure we'll find something to cut down!\""}
	})

	AddStory({
		key = "DroneReverse",
		title = T{9013802, "Drone Reverse Engineering"},
		story = T{9013803, "     After many days, drones have finaly completed their reverse engineering training and can now move both forwards and backwards. This advancement will be a huge help in traversing the un-even surface of Mars."}
	})
end

local function AddSocialFreeStories()
	local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
	local LeaderTitle = MartianTribune.LeaderTitle

	AddStory({
		key = "PoliticalAmbitions",
		title = T{9013790, "Political Ambitions Set Too High?"},
		story = T{9013791, "     A politician on Earth has stated the obvious this week by claiming that Mars is red.  The hopeful senator took it a step further by declaring that Mars is a also a communist planet, with \"nothing but red, red, red\".  After performing some reconnissance here at the Martian Tribune Headquarters, we would like to confirm that Mars is indeed red.  The claims of communism getting a foothold, however, will have to be fielded by the <MTLeaderTitle>.", MTLeaderTitle = LeaderTitle}
	})

	AddStory({
		key = "MarsCheese",
		title = T{9013794, "US President Confirms: Not A Scientist"},
		story = T{9013795, "     The current President of the United States, after staring intently at several photos of the Red Planet, proceeded to ask his scientific advisors if Mars is actually made of cheese. The researchers reminded the president that Mars is mostly made of rock, and that it is, in fact, the Moon that is made of cheese."}
	})

	AddStory({
		key = "DroneToys",
		title = T{9013796, "Drone Toy Sales Through The Roof"},
		story = T{9013797, "     With all of the photos and videos sent back to Earth, the demand for the miniature, remote controlled, toy replica of the standard martian drone has been much higher than anticipated. The toy broke first week sales records all across the globe. The remote controlled mini drone, which sells for just over 400 dollars each, has been sold out in most places. With the shortage, and with Christmas so soon, it's sad to say, but some children may be dissapointed this year."}
	})

	AddStory({
		key = "MysteriousRadio",
		title = T{9013798, "Mysterious Radio Station Causes Concern"},
		story = T{9013799, "     The martian planet is being entertained by the great hosts at Mars Radio One, among other stations, but what has the Martian Tribune concerned is that there are no facilities to broadcast a radio station here on Mars. Come to think of it, there are no facilities to make a newspaper either... let's just let that slide then."}
	})

	AddStory({
		key = "NuclearThreat",
		title = T{9013804, "Former Peaceful Organization Threatens Nuclear War"},
		story = T{9013805, "     An organization formerly believed to be peaceful has been uncovered as a sleeper cell that is now threatening interstellar war.  The leader of this formerly benign oceanic  movement known as Norwegians for Underdeveloped Kelp Enrichment ('NUKE') has laid claim to a former lakebed near Mount Olympus and threatened nuclear annihilation upon any civilization that settles too close to their newly founded city."}
	})

	AddStory({
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

	if Published[VikingsKey1] and not Sent[VikingsKey2] then
		local AddStory = MartianTribuneMod.Functions.AddTopFreeStory
		AddStory({
			key = VikingsKey2,
			title = T{9013870, "Atlantis has been found!"},
			story = T{9013871, "     The long lost city of Atlantis, thought to be nothing but rumor and legend, has been found, and it is where no-one expected to find it - around 15KM below the surface of Mars. The legend of the city that sunk beneath the blue sea may well have been mistranslated from ancient Viking manuscripts, who meant to say it sunk beneath the dust of the red planet. In retrospect, that was an easy mistake to make."}
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