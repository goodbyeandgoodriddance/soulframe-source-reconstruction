local module = require("EE.Interface.Utilities")

function VisitWebsiteCallback(p)
	if tonumber(p) == 4 then
		module.DoOpenWebBrowser("https://soulframe.com/user")
		_T.Enabling2FA = true
	end
end

local function fn()
	if Engine.__wf_atom_fc67ba71() or __wf_atom_7e8ad928(gGameData) or gGameData:__wf_atom_bc4c8046() then
		return nil
	end

	local dialogSettings = Engine.DialogSettings()
	dialogSettings.dialogType = 1
	dialogSettings.locString = "/Lotus/Language/Dojo/TradeStartRequires2FA"
	dialogSettings.firstString = "/Lotus/Language/Dojo/EnableNow"
	dialogSettings.secondString = "/Lotus/Language/Dojo/EnableLater"
	dialogSettings:SetCallback("VisitWebsiteCallback")
	return (gClient:__wf_atom_3cb140dc():__wf_atom_d6d30071(dialogSettings))
end

function EMO_START(object)
	if __wf_atom_7e8ad928(object) or object ~= gRegion:__wf_atom_c4f78a8f() or fn() then
		return
	end

	if not object:__wf_atom_7b686578() then
		if not __wf_atom_7e8ad928(object:__wf_atom_39bdffdf()) then
			module.ShowMessage("/Lotus/Language/Dojo/TradeNotAllowedWhileDueling")
			return
		end

		if object:__wf_atom_7bcdbf55(Symbol("Kneel")) then
			module.ShowMessage("/Lotus/Language/Dojo/TradeNotAllowedWhileKneeling")
			return
		else
			object:__wf_atom_b0f26b7e()
		end
	end

	if not gGameRules:__wf_atom_af3bd666() then
		return
	end

	local __wf_atom_7be88783 = gMatchingService:__wf_atom_7be88783()

	if not __wf_atom_7e8ad928(__wf_atom_7be88783) then
		__wf_atom_7be88783:Execute("ToggleVendor", "")
	end
end