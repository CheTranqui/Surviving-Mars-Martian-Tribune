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
				local LeaderTitle = MartianTribune.LeaderTitle
				local LeaderName = MartianTribune.LeaderName
				AddStory({
					key = Key1,
					title = T{9013860, "<MTLeaderTitle> Declares One-Child Policy on Mars", MTLeaderTitle = LeaderTitle},
					story = T{9013861, "     <DomeName> has announced that they have received notice that no more children be born. The dome lockdown is due to each family moving in at the same time and some have expressed resentment and a desire to move to less restrictive domelife.  What are your thoughts?  Have we already outgrown our britches?  Is it <MTLeaderTitle> <MTLeader>'s right to make such a sweeping declaration?  Write in your opinions, we'd love to hear your thoughts on the matter!", DomeName = Name, MTLeaderTitle = LeaderTitle, MTLeader = LeaderName}
				})
			else
				AddStory({
					key = Key2,
					title = T{9013862, "Birth Control Debate Rages"},
					story = T{9013863, "     <DomeName> has recently introduced a policy against procreation, in favor of population control. There was such discussion based on how this would be enforced, with arguments for outlawing sex, requiring use of condoms, requiring all above age 12 to receive a vasectomy, or simply mandating the use of birth control pills. In the end, it was determined that proof must be given that one is not capable of conceiving. As a result, expect the medical clinics to be busy in the coming weeks and don't forget to pick up your birth control with your food rations this week.", DomeName = Name}
				})
			end
		end
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end
