local Key1 = "DomeForbidBirth1"
local Key2 = "DomeForbidBirth2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and not Sent[Key2] and ColonistsHaveArrived then
		local DomesWithBirthControl = FilterObjects({
			filter = function(dome)
				return dome.allow_birth == false
			end },
			UICity.labels.Dome or empty_table
		)

		if DomesWithBirthControl and #DomesWithBirthControl > 0 then
			local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
			local Dome = table.rand(DomesWithBirthControl)
			local Name = IsValid(Dome) and Dome.name or T{9013859, "dome that forbids births"}
			local random_num = Random(1,2)

			if random_num == 1 then
				AddStory({
					key = Key1,
					title = T{9013860, "<DomeName> has introduced a no procreation edict", DomeName = Name},
					story = T{9013861, "     <DomeName> has announced that no more kids shall be allowed to be born, with colonists encouraged to ignore the sexy trait of other colonists, and to enjoy their own company as opposed to other colonists company.", DomeName = Name}
				})
			else
				AddStory({
					key = Key2,
					title = T{9013862, "Birth control debate rages on"},
					story = T{9013863, "     <DomeName> has recently introduced a policy of no procreation, encouraging population control. There was much discussion based on how this would be enforced, with arguments for outlawing sex, handing out condoms, removing genitalia, and birth control pills. In the end, it was decided that all male inhabitants of the dome must take a daily birth control pill. Those that complain are reminded that this option only beat removing genitalia by 2 votes.", DomeName = Name}
				})
			end
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end