-- MAIN CONTROL FUNCTIONS FOR MARTIAN TRIBUNE

local current_version = MartianTribuneMod.current_version
local LeadershipTraitId = "ColonyLeader"
local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
local oldData
local firstUse

local function SetupSaveGameData()
	if not oldData or not oldData.MartianTribune then
		MartianTribune = {
			name = "Martian Tribune Save Data",
			Count = { name = "Story Counts" },
			Published = { name = "Published Stories" },
			Removed = { name = "Removed Stories" },
			Sent = { name = "Sent Stories" },
			VersionNumber = 0,
			TopUrgentStories = { name = "Top Urgent Stories" },
			TopPotentialStories = { name = "Top Potential Stories" },
			TopFreeStories = { name = "Top Free Stories" },
			TopArchive = { name = "Top Story Archive" },
			EngUrgentStories = { name = "Engineering Urgent Stories" },
			EngPotentialStories = { name = "Engineering Potential Stories" },
			EngFreeStories = { name = "Engineering Free Stories" },
			EngArchive = { name = "Engineering Story Archive" },
			SocialUrgentStories = { name = "Social Urgent Stories" },
			SocialPotentialStories = { name = "Social Potential Stories" },
			SocialFreeStories = { name = "Social Free Stories" },
			SocialArchive = { name = "Social Story Archive" },
			LeaderName = false,
			LeaderTitle = false,
			LeaderColonist = false,
			Sponsor = false,
			SponsorName = false,
			ColonistsHaveArrived = false
		}
		if UICity.day > 1
			and UICity.labels.Colonist ~= nil
			and #UICity.labels.Colonist > 0
			and oldData and not oldData.g_MTTopArchive
		then
			MartianTribune.ColonistsHaveArrived = true
			-- Make sure a "new leader" message gets sent for the first leader
			MartianTribune.Count.LeaderDeadSol = UICity.day - 4
		end
	else
		MartianTribune = oldData.MartianTribune
	end
end

local function SetupMissionSponsor()
	local MartianTribune = MartianTribune
	local MissionSponsor = GetMissionSponsor()
	if not MartianTribune.Sponsor then
		MartianTribune.SponsorName = MissionSponsor.name
		MartianTribune.Sponsor = T{MissionSponsor.display_name}
	end
end

-- Generate a "Title" to use for the Colony Leader
local function SetLeaderTitle()
	local MartianTribune = MartianTribune
	if not MartianTribune.LeaderTitle then
		local SponsorName = MartianTribune.SponsorName
		local Titles = {
			IMM = T{9013500, "CEO"},
			BlueSun = T{9013501, "CFO"},
			CSNA = T{9013502, "President"},
			ISRO = T{9013503, "Prime Minister"},
			ESA = T{9013502, "President"},
			SpaceY = T{9013504, "Chairman"},
			NewArk = T{9013505, "Oracle"},
			Roscosmos = T{9013502, "President"},
			paradox = T{9013501, "CFO"},
			stargatecommand = T{9013506, "Major General"},
			Trinova = T{9013507, "COO"}
		}

		if SponsorName == "IMM"
			or SponsorName == "BlueSun"
			or SponsorName == "SpaceY"
			or SponsorName == "paradox"
		then
			-- if one of the above 4, randomly pick one of the 3 and return that
			local random_num = Random(1,3)  -- randomize these corps to get one of the 3 following leader types
			if random_num == 1 then
				MartianTribune.LeaderTitle = T{9013504, "Chairman"}
			elseif random_num == 2 then
				MartianTribune.LeaderTitle = T{9013501, "CFO"}
			else
				MartianTribune.LeaderTitle = T{9013500, "CEO"}
			end
		elseif Titles[SponsorName] == nil then
			MartianTribune.LeaderTitle = T{9013502, "President"}  -- if unaccounted for, they get a "President"
		else
			MartianTribune.LeaderTitle = Titles[SponsorName] -- if it wasn't those 4, and wasn't unaccounted for, then return the name provided
		end
	end
end

local function PostprocessTrait(trait_id)
	local trait = TraitPresets[trait_id]
	if not trait then
		print("Did not find trait "..trait_id.." inside TraitPresets")
		return
	end
	trait:AddIncompatible()
	trait._incompatible = string.gsub(trait._incompatible, " ", "")
	local tbl = string.tokenize(trait._incompatible, ",", false, true)
	for _, val in ipairs(tbl) do
		local class = TraitPresets[val]
		class:AddIncompatible()
		assert(class, "Invalid trait:", val)
		rawset(trait.incompatible, val, true)
		rawset(class.incompatible, trait_id, true)
	end
	if trait.rare then 
		g_RareTraits[trait_id] = true
	else
		g_NoneRareTraits[trait_id] = true
	end
	if trait.hidden_on_start then
		g_HiddenTraitsDefault[trait_id] = true
	end
	TraitPresets[trait_id] = trait
end

-- Leadership "trait" so that it can be displayed in the colonist info.
local function CreateLeaderTrait()
	local MartianTribune = MartianTribune
	local LeaderTitle = MartianTribune.LeaderTitle
	local Sponsor = MartianTribune.Sponsor

	-- Trait needs to be created on every game start/load, otherwise if someone loads a different save the trait will have the wrong name/description, e.g. Oracle with a Paradox sponsor because they had loaded a game using Church of the New Ark first.
	if Sponsor then
		local trait = TraitPreset:new()
		trait.name = LeadershipTraitId
		trait.id = LeadershipTraitId
		trait.display_name = LeaderTitle
		trait.description = _InternalTranslate(T{9014489,"<MTSponsor> <MTLeaderTitle>", MTSponsor = Sponsor, MTLeaderTitle = _InternalTranslate(LeaderTitle)})
		trait.category = "other"
		trait.group = trait.category
		trait.weight = 30
		trait.rare = false
		trait.auto = false
		trait.show_in_traits_ui = true
		trait.hidden_on_start = true
		trait.dome_filter_only = true
		trait.incompatible = {}
		TraitPresets[LeadershipTraitId] = trait
		PostprocessTrait(LeadershipTraitId)
	end
	GuruTraitBlacklist[LeadershipTraitId] = true
end

-- Create a list of rare traits that exist within the colony for use in selecting a leader
local function GetAvailableRareTraits()
	if not UICity then
		return empty_table
	end
	
	local LeaderTraitTable = {}
	-- Go through the list of rare traits as defined by the game - this means that we will pick up rare traits that get added in future (e.g. from a new mystery) automatically.
	for trait_id,v in pairs(g_RareTraits) do
		if CountColonistsWithTrait(trait_id) > 0 then
			LeaderTraitTable[#LeaderTraitTable + 1] = trait_id
		end
	end
	return LeaderTraitTable
end

-- Selecting a new leader from the current list of colonists if one does not exist.
-- Defaults to "Silent Leader" if no colonists exist
local function SetNewLeader()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived

	if not IsValidColonist(MartianTribune.LeaderColonist) and ColonistsHaveArrived then
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local LeaderTraitTable = GetAvailableRareTraits()

		if (#LeaderTraitTable > 0) then  -- pick a trait to single out
			local LeaderTrait = table.rand(LeaderTraitTable)
			MartianTribune.LeaderColonist = GetColonistWithTrait(LeaderTrait)
		end
		-- failed to find a usable leader with a rare trait
		local colonists = UICity.labels.Colonist or empty_table
		if not IsValidColonist(MartianTribune.LeaderColonist) and #colonists > 0 then
			MartianTribune.LeaderColonist = table.rand(colonists)
		end

		if IsValidColonist(MartianTribune.LeaderColonist) then
			MartianTribune.LeaderColonist:AddTrait(LeadershipTraitId)
		end
	end  -- if we have a leader already chosen and alive, then they stay leader

	if not IsValidColonist(MartianTribune.LeaderColonist) then
		MartianTribune.LeaderName = MartianTribuneMod.Name.SilentLeader
	else
		MartianTribune.LeaderName = MartianTribune.LeaderColonist.name
	end
end

-- Section 6:  OnMsg functions
function OnMsg.MartianTribuneLeaderDied()
	MartianTribune.Count.LeaderDeadSol = UICity.day
	MartianTribune.LeaderColonist = nil
	SetNewLeader()
end

function OnMsg.ColonistBorn(colonist, event)
	-- Just in case this could happen due to Project Phoenix...
	if colonist.traits.ColonyLeader then
		colonist:RemoveTrait(LeadershipTraitId)
	end
end

-- Count number of founders
function OnMsg.ColonistsLanded()
	-- This is fired after the full load of colonists have disembarked.
	local MartianTribune = MartianTribune
	if not MartianTribune.ColonistsHaveArrived then
		-- founders
		MartianTribune.ColonistsHaveArrived = true
		MartianTribune.Count.NumFounders = #UICity.labels.Colonist
		SetNewLeader()
		Msg("MartianTribuneFoundingLeader")
	end
end

function OnMsg.NewMapLoaded()
	-- Initialize save game data
	SetupSaveGameData()
	MartianTribune.VersionNumber = current_version
	SetupMissionSponsor()
	SetLeaderTitle()
	CreateLeaderTrait()
	Msg("MartianTribuneInitializeStories")
end

function OnMsg.PersistLoad(data)
	oldData = data
	local MartianTribuneMod = MartianTribuneMod
	-- Prior to version 775, individual globals were used
	firstUse = not oldData.MartianTribune and not oldData.g_MTTopArchive
	SetupSaveGameData()

	if not firstUse then
		-- Check whether there are any save data updates that need to be applied.
		local SaveGameUpdate = MartianTribuneMod.Functions.SaveGameUpdate
		if SaveGameUpdate then
			SaveGameUpdate(oldData)
		end
	else
		MartianTribune.VersionNumber = current_version
	end
	data.MartianTribune = MartianTribune
	oldData = nil
end

function OnMsg.LoadGame()
	local MartianTribune = MartianTribune

	SetupMissionSponsor()
	-- If Leader Title is not already set, generate it.
	if not MartianTribune.LeaderTitle then
		SetLeaderTitle()
	-- Invalid/Odd Leader Title - reset it.
	elseif type(MartianTribune.LeaderTitle) ~= "userdata" then
		MartianTribune.LeaderTitle = false
		SetLeaderTitle()
	end
	CreateLeaderTrait()

	if IsValidColonist(MartianTribune.LeaderColonist) then
		if not MartianTribune.LeaderColonist.traits[LeadershipTraitId] then
			MartianTribune.LeaderColonist:AddTrait(LeadershipTraitId)
		end
	elseif MartianTribune.ColonistsHaveArrived then
		MartianTribune.LeaderColonist = nil
		SetNewLeader()
	end

	-- If this is the first time this mod is used with the loaded game, the story tables will
	-- not have been created yet.
	-- In that case, we need to initialize the story tables for the first time.
	if firstUse then
		Msg("MartianTribuneInitializeStories")
	end

	-- Check for any stories that should have been added/removed
	Msg("MartianTribuneCheckStories")

	local LastPublished = MartianTribune.Count.LastPublished
	-- if not firstUse and LastPublished and LastPublished == UICity.hour
	--[[if not firstUse and LastPublished and LastPublished == UICity.day
	then
		-- Restore notification popup
		Msg("MartianTribuneShowNotification")
	end]]--
end

-- every 3 days a new edition gets pushed
-- function OnMsg.NewHour()
function OnMsg.NewDay()
	local MartianTribune = MartianTribune
	local UICity = UICity

	Msg("MartianTribuneCheckStories")
	local LastPublished = MartianTribune.Count.LastPublished

	--if UICity.hour % 3 == 0 and LastPublished ~= UICity.hour then
	if UICity.day % 3 == 0 and (LastPublished == nil or LastPublished < UICity.day)
	then
		Msg("MartianTribuneRelease")
		-- MartianTribune.Count.LastPublished = UICity.hour
		MartianTribune.Count.LastPublished = UICity.day
	end
end
