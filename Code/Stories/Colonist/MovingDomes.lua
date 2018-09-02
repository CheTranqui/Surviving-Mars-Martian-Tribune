local Key1 = "MovingDomes"

local function CheckStory(colonist, old_dome, new_dome)
	local MartianTribune = MartianTribune
	local Sent = MartianTribune.Sent
	local MartianTribuneMod = MartianTribuneMod
	local IsValidColonist = MartianTribuneMod.Functions.IsValidColonist

	if not Sent[Key1] and IsValidColonist(colonist) and IsValid(old_dome) and IsValid(new_dome) then
		local AddStory = MartianTribuneMod.Functions.AddSocialPotentialStory
		local ColonistName = colonist.name
		local OldDomeName = old_dome.name or T{9013691, "random dome <num>", num=1}
		local NewDomeName = new_dome.name or T{9013691, "random dome <num>", num=2}

		AddStory({
			key = Key1,
			title = T{9013689, "The Rock Is Always Redder"},
			story = T{9013690, "     In a recent survey performed by the Martian Tribune a number of citizens have expressed disappointment after moving to a new dome.  <ColonistName> hit the nail on the head saying, \"I always thought that moving from <MTMovingDome1> to <MTMovingDome2> would be a huge upgrade in lifestyle, but I've have found it to be basically the same as before. I guess it's true what they say: The rock is redder on the other side.\"", ColonistName = ColonistName, MTMovingDome1 = OldDomeName, MTMovingDome2 = NewDomeName}
		})
	end
end

-- Trigger for walking to another dome
local origTransportByFoot = Colonist.TransportByFoot
function Colonist:TransportByFoot(...)
	local old_dome = self.dome

	if origTransportByFoot then
		origTransportByFoot(self, ...)
	end

	local new_dome = self.dome
	-- Make sure that they actually did move
	if IsValid(old_dome) and IsValid(new_dome) and old_dome ~= new_dome then
		CheckStory(self, old_dome, new_dome)
	end
end
