local Key1 = "Passport"

local function CheckStory()
	local MartianTribune = MartianTribune
	local ColonistsHaveArrived = MartianTribune.ColonistsHaveArrived
	local Sent = MartianTribune.Sent

	if not Sent[Key1] and ColonistsHaveArrived then
		local AddStory = MartianTribuneMod.Functions.AddSocialFreeStory
		AddStory({
			key = Key1,
			title = T{9013649, "New Martian Passport Revealed"},
			story = T{9013650, "     The Martian Tribune has received an advance copy of the new Martian passport, designed behind closed doors in Armstrong City on Luna.  The passport is red, the front has a hologram of Mars with Phobos and Deimos behind it. Designers have stated the passport is \"completely uncopyable\". If you have yet to see the design, plenty of copies are rumored to be available from various undisclosed sources both here on Mars as well as on the Moon."}
		})
	end
end

function OnMsg.MartianTribuneCheckStories()
	CheckStory()
end