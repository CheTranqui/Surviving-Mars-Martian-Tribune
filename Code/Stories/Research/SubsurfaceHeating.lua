local TechId = "SubsurfaceHeating"
local Key1 = "SubsurfaceHeatingTech1"
local Key2 = "SubsurfaceHeatingTech2"

local function CheckStory()
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Sent[Key2] and UICity.tech_status[TechId].researched ~= nil then
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local random_num = Random(1,2)

		if random_num == 1 then
			AddStory({
				key = Key1,
				title = T{9013822, "Underground Radiators"},
				story = T{9013823, "     The newest discovery in surviving the cold has become synonymous with the Martian underground scene, as the new \"subsurface heaters\" become quickly idolised and called saviours of the underground. A strange move, but with the ability to heat up an area the size of a small dome, the underground radiators could indeed save your life."}
			})
		else
			AddStory({
				key = Key2,
				title = T{9013824, "Please do not use Subsurface Heaters to make Hot Tubs"},
				story = T{9013825, "     The Martian Tribune would like to advise its readers that the newly discovered subsurface heaters are not to be used to make your own personal hot tub, no matter how awesome it would be. It is a serious waste of Martian resources."}
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