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
		local AddSocialStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local Name = colonist.name

		if Name then
			AddSocialStory({
				key = Key1,
				title = T{9013843, "Missing your home planet?  You're not alone."},
				story = T{9013844, "     Coffee with <EarthsickColonist> the other day revealed just how deeply some of us miss the prairies and oceans of Earth. One such colonist, upon a wider discussion revealed that they, \"just miss being able to breath air, see water, and eat meat. Man, I really miss meat.\" Know that you're not alone out here.  We're in this together!", EarthsickColonist = Name}
			})
		end
	end
end

function OnMsg.ColonistStatusEffect(colonist, status_effect, bApply)
	if bApply and status_effect == Effect then
		CheckStory(colonist)
	end
end
