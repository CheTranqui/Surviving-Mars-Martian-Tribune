-- 1. PRIMARY SAVE GAME DATA STORAGE
GlobalVar("MartianTribune", false)

local function AddStory(story, list)
	local MartianTribune = MartianTribune
	MartianTribune.Sent[story.key] = true
	list[#list + 1] = story
end

local function RemoveStory(key, list)
	local MartianTribune = MartianTribune
	local FindStoryInListByKey = MartianTribuneMod.Functions.FindStoryInListByKey
	local index, story = FindStoryInListByKey(list, key)
	if index then
		table.remove(list, index)
	end
	MartianTribune.Removed[key] = true
end

-- 2. PRIMARY NON-SAVE DATA STORE FOR SHARING COMMON FUNCTIONS, NAMES, MOD_DIR, ETC
-- Note: Using the "name" field in a list means that it is used as a title in any Examine windows in ECM when debugging
MartianTribuneMod = {
	mod_dir = CurrentModPath,
	current_version = Mods["lf1iELO"].version,
	Functions = { name = "Martian Tribune Common Functions" },
	Name = { name = "Common Colonist Fallback Name strings" },
	News = { name = "Shared popup Fake News items" },
	SaveGameFixes = { name = "Save Game Data Migrations" }
}

-- 3. COMMON FUNCTION DEFINITIONS

-- Compare two translatable strings (e.g. story titles)
MartianTribuneMod.Functions.CompareTranslationStrings = function(string1, string2)
	return _InternalTranslate(string1) == _InternalTranslate(string2)
end

-- Find a story in a list
MartianTribuneMod.Functions.FindStoryInListByKey = function(list, storyKey)
	for i = 1, #list do
		if list[i].key == storyKey then
			return i,list[i]
		end
	end
end

-- Add stories to the urgent/potential/free lists.
MartianTribuneMod.Functions.AddTopUrgentStory = function(story)
	AddStory(story, MartianTribune.TopUrgentStories)
end
MartianTribuneMod.Functions.AddTopPotentialStory = function(story)
	AddStory(story, MartianTribune.TopPotentialStories)
end
MartianTribuneMod.Functions.AddTopFreeStory = function(story)
	AddStory(story, MartianTribune.TopFreeStories)
end
MartianTribuneMod.Functions.AddEngUrgentStory = function(story)
	AddStory(story, MartianTribune.EngUrgentStories)
end
MartianTribuneMod.Functions.AddEngPotentialStory = function(story)
	AddStory(story, MartianTribune.EngPotentialStories)
end
MartianTribuneMod.Functions.AddEngFreeStory = function(story)
	AddStory(story, MartianTribune.EngFreeStories)
end
MartianTribuneMod.Functions.AddSocialUrgentStory = function(story)
	AddStory(story, MartianTribune.SocialUrgentStories)
end
MartianTribuneMod.Functions.AddSocialPotentialStory = function(story)
	AddStory(story, MartianTribune.SocialPotentialStories)
end
MartianTribuneMod.Functions.AddSocialFreeStory = function(story)
	AddStory(story, MartianTribune.SocialFreeStories)
end

-- Remove stories to the potential/free lists.
MartianTribuneMod.Functions.RemoveTopUrgentStory = function(key)
	RemoveStory(key, MartianTribune.TopUrgentStories)
end
MartianTribuneMod.Functions.RemoveTopPotentialStory = function(key)
	RemoveStory(key, MartianTribune.TopPotentialStories)
end
MartianTribuneMod.Functions.RemoveTopFreeStory = function(key)
	RemoveStory(key, MartianTribune.TopFreeStories)
end
MartianTribuneMod.Functions.RemoveEngUrgentStory = function(key)
	RemoveStory(key, MartianTribune.EngUrgentStories)
end
MartianTribuneMod.Functions.RemoveEngPotentialStory = function(key)
	RemoveStory(key, MartianTribune.EngPotentialStories)
end
MartianTribuneMod.Functions.RemoveEngFreeStory = function(key)
	RemoveStory(key, MartianTribune.EngFreeStories)
end
MartianTribuneMod.Functions.RemoveSocialUrgentStory = function(key)
	RemoveStory(key, MartianTribuneMod.SocialUrgentStories)
end
MartianTribuneMod.Functions.RemoveSocialPotentialStory = function(key)
	RemoveStory(key, MartianTribune.SocialPotentialStories)
end
MartianTribuneMod.Functions.RemoveSocialFreeStory = function(key)
	RemoveStory(key, MartianTribune.SocialFreeStories)
end

-- Check if a particular colonist is valid and alive
MartianTribuneMod.Functions.IsValidColonist = function(colonist)
	local isDying = Colonist.IsDying(colonist)
	return not isDying and isDying ~= nil
end

local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

-- Find a random colonist who does not have a specific trait.
MartianTribuneMod.Functions.GetColonistWithoutTrait = function(trait, colonistList)
	local colonists = FilterObjects({
		filter = function(colonist)
			return IsValidColonist(colonist) and colonist.traits and not colonist.traits[trait]
		end},
	colonistList or UICity.labels.Colonist or empty_table)
	if colonists and #colonists > 0 then
		return table.rand(colonists)
	end
	return nil
end

-- Find a random colonist who does have a specific trait.
MartianTribuneMod.Functions.GetColonistWithTrait = function(trait, colonistList)
	local colonists = FilterObjects({
		filter = function(colonist)
			return IsValidColonist(colonist) and colonist.traits and colonist.traits[trait]
		end},
	colonistList or UICity.labels.Colonist or empty_table)
	if colonists and #colonists > 0 then
		return table.rand(colonists)
	end
	return nil
end

-- Find the name of a random drone
MartianTribuneMod.Functions.GetRandomDroneName = function()
	local Drones = GetObjects{class = "Drone"}
	if #Drones > 0 then
		return table.rand(Drones).name
	end
	return T{9013810, "Drone #<num>", num=1}
end

-- Find all the populated domes within the given list of domes (e.g. "domes without power").
-- If no list is provided, it will use the list of domes in the colony.
MartianTribuneMod.Functions.GetPopulatedDomes = function(domeList)
	-- default to all domes if no list is provided
	return FilterObjects({
		filter = function(dome)
			return dome.labels.Colonist and #dome.labels.Colonist > 0
		end},
	domeList or UICity.labels.Dome or empty_table)
end

-- Retrieve the list of workers for a specific workplace
MartianTribuneMod.Functions.GetWorkers = function(workplace)
	if IsValid(workplace) then
		local Workers = {}
		for k, shift in pairs(workplace.workers) do
			for s, worker in pairs(shift) do
				if IsValidColonist(worker) then
					Workers[#Workers + 1] = worker
				end
			end
		end
		return Workers
	end
	return nil
end

-- Choose a random worker for a specific workplace
MartianTribuneMod.Functions.GetRandomWorker = function(workplace)
	local Workers = MartianTribuneMod.Functions.GetWorkers(workplace)
	if Workers ~= nil then
		return table.rand(Workers)
	end
	return nil
end

-- 4. COMMON COLONIST FALLBACK NAME STRINGS
MartianTribuneMod.Name.SilentLeader = T{9013508, "Silent Leader"}
MartianTribuneMod.Name.IdiotColonist = T{9013763, "idiot colonist"}
MartianTribuneMod.Name.VeganColonist = T{9013811, "random vegan"}
MartianTribuneMod.Name.TeenagerColonist = T{9013718, "random teenager"}
