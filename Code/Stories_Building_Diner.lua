local TraitId = "Vegan"
local Key1 = "RefuseHitsTheFan"
local Key2 = "VeganDiner"

local function CheckStory1()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent
	local UICity = UICity

	if not Sent[Key1] and ColonistsHaveArrived and UICity.labels.Diner ~= nil then
		local AddSocialStory = MartianTribuneMod.Functions.AddSocialFreeStory
		local Diner = table.rand(UICity.labels.Diner)
		local DomeName =
			(Diner and Diner.parent_dome and Diner.parent_dome.name)
			or T{9013726, "dome with diner"}
	
		AddSocialStory({
			key = Key1,
			title = T{9013724, "The Refuse Hits The Fan"},
			story = T{9013725, "     Last night a sewage pump overflowed in <MTRefuseHitsFanDinerDome> when one of the pump's propellers broke under the pressure.  After what can only be described as a dining fiasco, last night's meal of extruded bean substitute seems to have played a critical role in overloading the sewage systems. There have been dozens of reports of a foul odor filling the dome even now.  Match usage is strictly prohibited until the blockage can be cleared.", MTRefuseHitsFanDinerDome = DomeName}
		})
	end
end

local function CheckStory2()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key2] and ColonistsHaveArrived and CountColonistsWithTrait(TraitId) > 3 then
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local Colonist = GetColonistWithTrait(TraitId)
	
		if IsValidColonist(Colonist) and Colonist.dome and Colonist.dome.labels.Diner ~= nil then
			local AddSocialStory = MartianTribuneMod.Functions.AddSocialFreeStory
			local VeganColonistFallbackName = MartianTribuneMod.Name.VeganColonist
			local ColonistName = Colonist.name or VeganColonistFallbackName
			local DomeName = Colonist.dome.name or T{9013701, "dome with vegan and diner"}

			AddSocialStory({
				key = Key2,
				title = T{9013699, "Is this Vegan?"},
				story = T{9013700, "     <MTVeganDinerName> has been barred from the diner in <MTVeganDinerDome> after going in 25 different times and asking, \"Is this vegan? I'm vegan, so I can't eat anything that comes from an animal\", and being repetedly informed that everything on Mars is vegan.  Staff finally banded together and has officially banned <MTVeganDinerName> from the establishment stating \"EVERYTHING is vegan!  Now GET OUT!\"", MTVeganDinerName = ColonistName, MTVeganDinerDome = DomeName},
			})
		end
	end
end

local dinerInit = Diner.GameInit
function Diner.GameInit(...)
	if dinerInit then
		dinerInit(...)
	end
	CheckStory1()
	CheckStory2()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory1()
	CheckStory2()
end