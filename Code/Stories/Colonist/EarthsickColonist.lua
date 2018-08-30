local Effect = "StatusEffect_Earthsick"
local Key1 = "Earthsick1"

local function CheckStory(colonist)
	local Sent = MartianTribune.Sent
	local MartianTribuneMod = MartianTribuneMod
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

	if not Sent[Key1]
		and IsValidColonist(colonist)
		and colonist.status_effects
		and colonist.status_effects[Effect]
	then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local Name = colonist.name

		if Name then
			AddStory({
				key = Key1,
				title = T{"<EarthsickColonist> misses home", EarthsickColonist = Name},
				story = T{"     <EarthsickColonist> has told us here at the Martian Tribune that they really miss home. Despite our best efforts to remind them that this is home, <EarthsickColonist> has still said they want to leave the red planet. \"I just miss being able to breath air, see water, and eat meat, man i really miss meat.\"", EarthsickColonist = Name}
			})
		end
	end
end

function OnMsg.ColonistStatusEffect(colonist, status_effect, bApply)
	if bApply and status_effect == Effect then
		CheckStory(colonist)
	end
end