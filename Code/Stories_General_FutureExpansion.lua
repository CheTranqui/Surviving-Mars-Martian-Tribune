local Key1 = "FutureExpansion"

local function CheckStory()
	local Sent = MartianTribune.Sent
	
	if not Sent[Key1] and #(UICity.labels.Colonist or empty_table) > 600 then
		local AddTopStory = MartianTribuneMod.Functions.AddTopPotentialStory
		AddTopStory({
			key = Key1,
			title = T{9013552, "Successful Martian Colony Brings Hope"},
			story = T{9013553, "     Our beautiful Martian colony, that started many sol ago has brought hope to humanity, inspiring her to look beyond, unto other planets, with a desire to colonise other rocks within the Milky Way. Most of the impetus at the moment are for colonisation of the moon, Europa, Venus and Jupiter.  Russia has stated that it would consider trying to colonise Pluto, though this was before realising Russia is already bigger than the icy dwarf planet."}
		})
	end
end

function OnMsg.ColonistBorn(colonist, event)
	CheckStory()
end