local TechId = "FuelCompression"
local Key1 = "FuelCompressionTech1"
local Key2 = "FuelCompressionTech2"

local function CheckStory()
	local Sent = MartianTribune.Sent
    
    if not Sent[Key1]
		and not Sent[Key2]
		and UICity.tech_status[TechId].researched ~= nil
	then
        local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local random_num = Random(1,2)
		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013541, "Rockets Now Made More Spacious"},
				story = T{9013542, "     Scientists have discovered a way to fit up to 10,000kg more junk food and supplies in each rocket sent to Mars. By squeezing the fuel into a smaller tank, they have created more cargo space. \"It's amazing we didn't think of this earlier, just make the fuel tank smaller.  It might pertain to rockets, but it is definitely not rocket science\"."}
			})
		else
			local Sponsor = MartianTribune.Sponsor
			AddStory({
				key = Key2,
				title = T{9013543, "Looser Safety Restrictions Means More Room For Cargo"},
				story = T{9013544, "     Claiming to employ new, improved Kerbal construction methods, <MTSponsor> has taken the liberty of removing nearly all of the safety features from our Mars-bound rockets, replacing them instead with a healthy supply of MK16 Parachutes.  This one, relatively minor change allows us to fit 10,000kg more cargo in the Ship and should keep colonists safe in their travels regardless.  Hopefully.", MTSponsor = Sponsor}
			})
		end
	end
end

function OnMsg.TechResearched(tech_id, city, first_time)
	if tech_id == TechId then
		CheckStory()
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end