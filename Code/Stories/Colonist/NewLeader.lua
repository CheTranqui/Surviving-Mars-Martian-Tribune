local Key1 = "NewLeader1"
local Key2 = "NewLeader2"
local Key3 = "NewLeader3"
local Key4 = "FounderNewLeader"

-- 3 days after old leader dies, new leader gets a news story
local function CheckStory1()
	local MartianTribune = MartianTribune
	local LeaderDeadSol = MartianTribune.Count.LeaderDeadSol

	if LeaderDeadSol ~= nil and UICity.day > (LeaderDeadSol + 3) then
		local random_num = Random(1,3)
		local LeaderName = MartianTribune.LeaderName
		local LeaderTitle = MartianTribune.LeaderTitle
		local AddStory = MartianTribuneMod.Functions.AddTopUrgentStory

		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013738, "A New <MTLeaderTitle> Takes the Helm", MTLeaderTitle = LeaderTitle},
				story = T{9013739, "     As <MTLeader> steps in to assume the recently vacated role of <MTLeaderTitle>, we can hope that they get their bearings in short order.  We here at the Martian Tribune will keep you apprised of any decrees and movements of the <MTLeaderTitle>.  A new day is dawning here on Mars.  The question remains, however: is that a day of dawning, or a day of darkness.  Our fate is in your hands, <MTLeaderTitle>.  Don't let us down.", MTLeader = LeaderName, MTLeaderTitle = LeaderTitle}
			})
		elseif random_num == 2 then
			AddStory({
				key = Key2,
				title = T{9013740, "<MTLeader> Breathes New Life Into Colony", MTLeader = MTLeaderName},
				story = T{9013741, "     A new <MTLeaderTitle> has been chosen!  It is time to rejoice, for my fellow Martians, the future is bright!  <MTLeader> steps in as our new <MTLeaderTitle> today and we could not be in better hands.  With <MTLeader>'s past work here on Mars, we can expect big plans to continue to balance out the workload and supply chain even further, as well as to care for the aging and nurture the young.  Today, the Martian Tribune declares: the future is bright.  It is time to celebrate!", MTLeaderTitle = LeaderTitle, MTLeader = LeaderName}
			})
		elseif random_num == 3 then
			local Sponsor = MartianTribune.Sponsor
			AddStory({
				key = Key3,
				title = T{9013742, "Wrong Sibling Elevated?"},
				story = T{9013743, "     As we move into a new era of Martian development, we here at the Martian Tribune can't help but wonder at the agenda of our sponsor, <MTSponsor>.  Perhaps someone mixed up their paperwork, but somehow they saw fit to raise <MTLeader> to the role of <MTLeaderTitle> without recognizing that more than one person shares that last name.  The responsibilities are vast in leading such an intrepid endeavor as ours here on Mars.  Let's hope and pray (hard) that <MTLeader> is up to the challenge.", MTSponsor = Sponsor, MTLeader = LeaderName, MTLeaderTitle = LeaderTitle}
			})
		end
		MartianTribune.Count.LeaderDeadSol = nil
	end
end

-- First leader chosen (on Founders' landing).
local function CheckStory2()
	local MartianTribune = MartianTribune
	local LeaderDeadSol = MartianTribune.Count.LeaderDeadSol
	local LeaderColonist = MartianTribune.LeaderColonist
	local Sent = MartianTribune.Sent
	local MartianTribuneMod = MartianTribuneMod
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

	if not Sent[Key4]
		and LeaderDeadSol == nil
		and IsValidColonist(LeaderColonist)
	then
		local LeaderTitle = MartianTribune.LeaderTitle
		local LeaderName = LeaderColonist.name
		local NumFounders = MartianTribune.Count.NumFounders
		local Sponsor = MartianTribune.Sponsor
		local AddStory = MartianTribuneMod.Functions.AddTopUrgentStory

		AddStory({
			key = Key4,
			title = T{9013815, "<MTLeaderTitle> Chosen for New Colony", MTLeaderTitle = LeaderTitle},
			story = T{9013816, "     <MTLeader> has been chosen from the <MTFoundersCount> brave founders as <MTLeaderTitle> to nurture and guide the initial development of the newly populated colony on Mars. The challenges that <MTLeader> will have to face in the coming Sols will be many, but <MTSponsor> has declared that they have complete confidence in <MTLeader>'s ability to meet those challenges.", MTLeaderTitle = LeaderTitle, MTLeader = LeaderName, MTFoundersCount = NumFounders, MTSponsor = Sponsor},
			colonist = LeaderColonist
		})
	end
end

function OnMsg.MartianTribuneFoundingLeader()
	CheckStory2()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
end