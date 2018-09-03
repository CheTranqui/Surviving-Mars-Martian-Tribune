local TechId = "SubsurfaceHeating"
local Key1 = "SubsurfaceHeatingTech1"
local Key2 = "SubsurfaceHeatingTech2"

local function CheckStory()
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Sent[Key2] and UICity.tech_status[TechId].researched ~= nil then
		local AddEngStory = MartianTribuneMod.Functions.AddEngFreeStory
		local random_num = Random(1,2)

		if random_num == 1 then
			AddEngStory({
				key = Key1,
				title = T{9013822, "Local Warming: It's a Thing"},
				story = T{9013823, "     The newest discovery in surviving the cold has become synonymous with the Martian underground scene, as the new \"subsurface heaters\" become quickly idolised and declared our molten saviours by many. Global warming of Mars might still be elusive, but at least we can now count on some artificial local warming."}
			})
		else
			AddEngStory({
				key = Key2,
				title = T{9013824, "The Subsurface Heaters Are Not Hot Tubs"},
				story = T{9013825, "     The Martian Tribune would like to advise its readers that the newly discovered subsurface heaters are not to be used as your own personal hot tub, no matter how awesome it might be, it would be a serious waste of Martian resources."}
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