local O2Key1 = "O2Shortage1"
local O2Key2 = "O2Shortage2"
local WaterKey1 = "WaterShortage1"
local WaterKey2 = "WaterShortage2"

local function CheckStory()
	local MartianTribune = MartianTribune
	local MartianTribuneMod = MartianTribuneMod
	local GetPopulatedDomes = MartianTribuneMod.Functions.GetPopulatedDomes
	local Sent = MartianTribune.Sent
	local UICity = UICity

	local populatedDomesWithNoOxygen = GetPopulatedDomes(g_DomesWithNoOxygen)
	local populatedDomesWithNoWater = GetPopulatedDomes(g_DomesWithNoWater)
	local populatedDomesWithNoPower = GetPopulatedDomes(g_DomesWithNoPower)

	if #populatedDomesWithNoOxygen > 0
		or #populatedDomesWithNoWater > 0
		or #populatedDomesWithNoPower > 0
	then
		local LastIncidentDay = MartianTribune.Count.LastIncidentDay
		if LastIncidentDay == nil or UICity.day - LastIncidentDay > 20 then  -- checks time since incident day so this doesn't trigger multiple times for just one shortage event
			local LeaderTitle = MartianTribune.LeaderTitle
			local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory

			if #populatedDomesWithNoOxygen > #populatedDomesWithNoPower then  --  i.e.  OXYGEN SHORTAGE
				local DomeWithoutO2 = table.rand(populatedDomesWithNoOxygen)
				local Name = DomeWithoutO2.name or T{9013634, "dome without oxygen"}
				local random_num =
					(not Sent[O2Key1] and Sent[O2Key2] and 1)
					or (Sent[O2Key1] and not Sent[O2Key2] and 2)
					or Random(1,2)  -- 2 separate oxygen shortage stories

				MartianTribune.Count.LastIncidentDay = UICity.day

				if random_num == 1 then
					AddStory({
						key = O2Key1,
						title = T{9013624, "All of <MTDomeWithoutO2Name> Holds Their Breath", MTDomeWithoutO2Name = Name},
						story = T{9013625, "     <MTDomeWithoutO2Name> is in dire straits as their oxygen supply was cut off from them recently.  While the <MTLeaderTitle> has already sent for the materials and drones necessary for repair, <MTDomeWithoutO2Name> citizens wonder anxiously: will it all arrive in time to matter?  For the rest of us: be prepared for a potential emergency evacuation.", MTDomeWithoutO2Name = Name, MTLeaderTitle = LeaderTitle}
					})
				elseif random_num == 2 then
					AddStory({
						key = O2Key2,
						title = T{9013626, "<MTDomeWithoutO2Name> Lets Off Some Steam", MTDomeWithoutO2Name = Name},
						story = T{9013627, "     Without any oxygen, <MTDomeWithoutO2Name> is no longer able to sustain the population it once did.  Please make room in your own home for refugees.  Hopefully the drones are already on it, but either way, <MTDomeWithoutO2Name> will be offline for a time while under repair.", MTDomeWithoutO2Name = Name}
					})
				end -- end Oxygen Shortage stories
			end
			
			if #populatedDomesWithNoWater > #populatedDomesWithNoPower then  -- begin WATER SHORTAGE
				local DomeWithoutWater = table.rand(populatedDomesWithNoWater)
				local DomeName = DomeWithoutWater.name or T{9013632, "dome without water"}
				local WaterDomeResident = table.rand(DomeWithoutWater.labels.Colonist)
				local ResidentName =
					(WaterDomeResident ~= nil and WaterDomeResident.name)
					or T{9013633, "colonist"}

				local random_num =
					(not Sent[WaterKey1] and Sent[WaterKey2] and 1)
					or (Sent[WaterKey1] and not Sent[WaterKey2] and 2)
					or Random(1,2)  -- 2 separate water shortage stories

				MartianTribune.Count.LastIncidentDay = UICity.day

				if random_num == 1 then
					local LeaderName = MartianTribune.LeaderName
					AddStory({
						key = WaterKey1,
						title = T{9013628, "Drought Declared"},
						story = T{9013629, "     A drought has been declared in <MTDomeWithoutWaterName>.  Dehydration is setting in and the citizens are nervous.  <MTWaterDomeResident> has declared it a non-issue, professing his faith in <MTLeaderTitle> <MTLeader>'s planning and provision.", MTDomeWithoutWaterName = DomeName, MTWaterDomeResident = ResidentName, MTLeaderTitle = LeaderTitle, MTLeader = LeaderName}
					})
				elseif random_num == 2 then
					AddStory({
						key = WaterKey2,
						title = T{9013630, "Engineers Working To Mitigate Water Shortage"},
						story = T{9013631, "     Water is in short supply in <MTDomeWithoutWaterName>.  While several engineers have begun working on a humidity reclamation project, even they have expressed doubt as to its viability.  This could be it for <MTDomeWithoutWaterName> as farms begin to shut down.", MTDomeWithoutWaterName = DomeName}
					})
				end
			end  -- end Water Shortage stories
		end  -- end IncidentDay check
	end  -- no shortages of note
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end