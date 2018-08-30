local Key1 = "TunnelDanger"

local function CheckStory()
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local UICity = UICity

	if not Sent[Key1]
		and UICity.labels.Tunnel
		and #UICity.labels.Tunnel > 0
		and CountColonistsWithTrait("Idiot") > 0
	then
		local MartianTribuneMod = MartianTribuneMod
		local GetColonistWithTrait = MartianTribuneMod.Functions.GetColonistWithTrait
		local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist
		local AddStory = MartianTribuneMod.Functions.AddEngPotentialStory
		local Colonist = GetColonistWithTrait("Idiot")
		local Name = IsValidColonist(Colonist) and Colonist.name or T{9013763, "idiot colonist"}

		AddStory({
			key = Key1,
			title = T{9013857, "Tunnels are Dangerous"},
			story = T{9013858, "     \"Tunnels are extremly dangerous and unnatural\" claims <IdiotColonist>. \"Teleporting from one place to another is not human. No matter what others say about it I will NEVER use a tunnel\". The Martian Tribune would like to point out that this is not how tunnels work, it's not how any of this works.", IdiotColonist = Name}
		})
	end
end

local tunnelInit = Tunnel.GameInit
function Tunnel.GameInit(...)
	if tunnelInit then
		tunnelInit(...)
	end
	CheckStory()
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end