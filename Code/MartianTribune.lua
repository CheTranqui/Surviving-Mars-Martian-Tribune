-- function OnMsg.NewDay()
function OnMsg.NewHour()
--  this_mod_dir stores the number of characters to walk back in order to get into the main mod directory
--  with the debug.getinfo(1, "S"), it's said that sometimes a 2 works, if the 1 does not
	local this_mod_dir = debug.getinfo(1, "S").source:sub(2, -24)
	AddCustomOnScreenNotification(MartianTribune,
		T{"The Martian Tribune"},
		T{"Sol <MTSol> AMC"},
		this_mod_dir.."UI/MT_Notification_Icon.tga",  --  Here, we concatenate to import the custom notification icon
		MTPopup,  -- this calls the function OnClick of this notification icon
		{MTSol = UICity.day,
		expiration = 150000,
		priority = "Normal",}
	)
end

function MTGetLeaderTitle()
	if sponsorDoubleCheck == nil then  -- if we've already done this, just go to the "return"
		sponsorDoubleCheck = GetMissionSponsor().name --otherwise, get the name
--  In game Sponsor.name possibilities:
--		International Mars Mission = "IMM"
--		USA = "NASA"
--		Blue Sun Corporation = "BlueSun"
--		China = "CSNA"
--		India = "ISRO"
--		Europe = "ESA"
--		SpaceY = "SpaceY"
--		Church of the New Ark = "NewArk"
--		Russia = "Roscosmos"
--		Paradox Interactive = "paradox"
--		Stargate Command = "stargatecommand"
--	
		if sponsorDoubleCheck == "IMM" or sponsorDoubleCheck == "BlueSun" or sponsorDoubleCheck == "SpaceY" or sponsorDoubleCheck == "paradox" then
			MTBusinessTitleRandom = Random(1,3)  -- randomize these corps to get one of the 3 following leader types
				if MTBusinessTitleRandom == 1 then
					MTLdrTtl = "Chairman"
					MTChairman = true
					MTCFO = false
					MTCEO = false
				elseif MTBusinessTitleRandom == 2 then
					MTLdrTtl = "CFO"
					MTChairman = false
					MTCFO = true
					MTCEO = false
				elseif MTBusinessTitleRandom == 3 then
					MTLdrTtl = "CEO"
					MTChairman = false
					MTCFO = false
					MTCEO = true
				end
		elseif sponsorDoubleCheck == "ISRO" then  -- each of these get a fixed leader type
			MTLdrTtl = "Prime Minister"
		elseif sponsorDoubleCheck == "NewArk" then
			MTLdrTtl = "Oracle"
		elseif sponsorDoubleCheck == "stargatecommand" then
			MTLdrTtl = "Major General"
		else MTLdrTtl = "President"  -- if unaccounted for, they get a "President"
		end
	end
	return MTLdrTtl  -- unique variable to this function, not used elsewhere
end

