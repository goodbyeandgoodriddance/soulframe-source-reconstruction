local module = require("SF.Scripts.Libs.TransmissionSet")
local module2 = require("Lotus.Interface.LotusUtilities")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("SF.Scripts.Libs.CommonFunctionsLib")

function Interact(_, object)
	if not object:__wf_atom_4417a5d4() then
		return
	end

	local transmission = transmission
	local v = Resource(syndicate)

	if not __wf_atom_7e8ad928(v) then
		local reputationInfoForSyndicate, _, _, _, _ = module2.GetReputationInfoForSyndicate(v)
		local v2 = transmissionRanked[reputationInfoForSyndicate]

		if not __wf_atom_7e8ad928(v2) then
			transmission = v2
		end
	end

	module.CloseTransmissions()
	module2.CreateHudlessTransmission(transmission)
end

local function fn(loreFragmentRes)
	local c_str = loreFragmentRes:__wf_atom_014a76a2():c_str()

	if _T.Discoveries ~= nil and _T.Discoveries[c_str] ~= nil then
		return true
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	return __wf_atom_c4f78a8f ~= nil
		and __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_ff0dc264(loreFragmentRes)
		and true
		or false
end

function InitFirstTimeInHub(object)
	local v = fn(loreFragmentRes)
	local c_str = loreFragmentRes:__wf_atom_014a76a2():c_str()
	local _EMPTY_SYMBOL = EMPTY_SYMBOL

	if not __wf_atom_7e8ad928(gGameData) then
		gGameData:__wf_atom_0cbd9965()
	end

	if not (__wf_atom_7e8ad928(fragmentNeededToShow) or module4.HasFragment(fragmentNeededToShow)) then
		object:Disable()
	elseif not (__wf_atom_7e8ad928(requiredQuestToComplete) or module3.HasCompletedQuest(requiredQuestToComplete)) then
		object:Disable()
	elseif v then
		if _T.FirstTimeInHub ~= nil and _T.FirstTimeInHub[c_str] ~= nil then
			_T.FirstTimeInHub[c_str] = nil
		end
	else
		if __wf_atom_7e8ad928(_T.FirstTimeInHub) then
			_T.FirstTimeInHub = {}
		end

		_T.FirstTimeInHub[c_str] = true
	end
end

function PlayTransmissionIfFirstTimeInHub(_)
	if not gRegion:__wf_atom_c4f78a8f():__wf_atom_4417a5d4() then
		return
	end

	local c_str = loreFragmentRes:__wf_atom_014a76a2():c_str()

	if _T.FirstTimeInHub ~= nil and _T.FirstTimeInHub[c_str] ~= nil and _T.FirstTimeInHub[c_str] == true then
		module2.CreateHudlessTransmission(transmission)
	end
end