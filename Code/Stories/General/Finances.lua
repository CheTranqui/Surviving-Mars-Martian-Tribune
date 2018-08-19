local Key1 = "Finances1"
local Key2 = "Finances2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local ResourceOverviewObj = ResourceOverviewObj

	-- if less than 300m funding is available
	if not Sent[Key1]
		and not Sent[Key2]
		and ResourceOverviewObj:GetFunding() < 300000000
	then
		local AddStory = MartianTribuneMod.Functions.AddTopPotentialStory
		local Sponsor = MartianTribune.Sponsor
		local random_num = Random(1,2)

		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013776, "Sponsor Funds Depleted"},
				story = T{9013777, "     <MTSponsor> has confirmed for the Martian Tribune that the rapidly spreading rumor that they are now broke with no money left to spare in support of the Martian endeavor is, in fact, true.  It is up to us, the people of mars to support ourselves.  Hopefully our local administrators will work to remedy the situation and prove our worth to our sponsor once more.", MTSponsor = Sponsor}
			})
		elseif random_num == 2 then
			AddStory({
				key = Key2,
				title = T{9013778, "Sponsor Cites Insider Trading Woes"},
				story = T{9013779, "     <MTSponsor> has gone belly-up in the face of a massive insider trading scheme that has taken down over half of their senior management.  Who knew that colonizing Mars could be such a politically, financially and socially fraught endeavor?  We did, <MTSponsor>.  We all did.  Shame on you.", MTSponsor = Sponsor}
			})
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end