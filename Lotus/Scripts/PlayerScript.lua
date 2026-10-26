local module = require("Lotus.Interface.LotusUtilities")
local v = Symbol("BattleBegins")
local v2 = Symbol("BattleConcluded")
local module2 = require("Lotus.Interface.TransmissionUtilities")

local function fn(object)
	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		local __wf_atom_6480316c = __wf_atom_c67f9605:__wf_atom_6480316c(
			__wf_atom_e55d02aa:__wf_atom_e0ccd217(),
			__wf_atom_e55d02aa:__wf_atom_1bb5b1ff()
		)
		local __wf_atom_9765cbd5 = __wf_atom_e55d02aa:__wf_atom_9765cbd5()

		if __wf_atom_9765cbd5 < __wf_atom_6480316c then
			__wf_atom_e55d02aa:__wf_atom_263a11c2(__wf_atom_6480316c - __wf_atom_9765cbd5)
		else
			__wf_atom_e55d02aa:__wf_atom_67dd6811(__wf_atom_6480316c)
		end
	end
end

function DynMusicStateChanged(value, value2)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) or __wf_atom_7e8ad928(__wf_atom_a0f6588f:__wf_atom_18a5d83b(0)) then
		return
	end

	local __wf_atom_9be88b01 = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0):__wf_atom_9be88b01()
	local v3

	if string.find(value, "Combat") == nil then
		v3 = false
	else
		v3 = string.find(value2, "Fallback") == nil
	end

	local v4

	if string.find(value2, "Combat") == nil then
		v4 = false
	else
		v4 = string.find(value2, "Fallback") == nil
	end

	local v5 = not v3
	local transmissionResponse = nil

	if v3 and not v4 then
		print("Combat -> idle")
		transmissionResponse = module2:GetTransmissionResponse(v2, __wf_atom_9be88b01, __wf_atom_c4f78a8f)
	elseif v4 and v5 then
		print("Idle -> combat")
		transmissionResponse = module2:GetTransmissionResponse(v, __wf_atom_9be88b01, __wf_atom_c4f78a8f)
	end

	if not __wf_atom_7e8ad928(transmissionResponse) then
		__wf_atom_c4f78a8f:__wf_atom_1a73b1c2(transmissionResponse)
	end
end

function HideHudWeaponPanel()
	_T.HideWeaponPanel()
end

function ShowHudWeaponPanel()
	_T.ShowWeaponPanel()
end

function HideHudAbilityPanel()
	_T.HideAbilityPanel()
end

function ShowHudAbilityPanel()
	_T.ShowAbilityPanel()
end

function ReportSoundPerceptionOnMove(object)
	while not __wf_atom_7e8ad928(object) do
		if object:__wf_atom_08998754() == 2 then
			gRegion:__wf_atom_2202ffb6():__wf_atom_192b9cb0(
				2,
				6,
				object:GetPosition(),
				object,
				innerRadius,
				outerRadius,
				true
			)
		end

		local v3 = Random(intervalMin, intervalMax)
		Sleep(v3)
	end
end

function Update(object)
	Sleep(1)
	local uiMode = module.GetUIMode()

	if
		uiMode ~= module.UI_MODE_IN_GAME and uiMode ~= module.UI_MODE_IN_DOJO
		or __wf_atom_7e8ad928(object)
		or not (object:__wf_atom_8efce136() or object:IsMaster())
	then
		return
	end

	if maxLevel and gRegion:IsMaster() then
		fn(object)
	end

	if not (_T.MusicStateChangeRegistered or __wf_atom_7e8ad928(gGameRules)) then
		local __wf_atom_a374c1f8 = gGameRules:__wf_atom_a374c1f8()

		if not __wf_atom_7e8ad928(__wf_atom_a374c1f8) then
			__wf_atom_a374c1f8:__wf_atom_3b0f0168("DynMusicStateChanged")
			_T.MusicStateChangeRegistered = true
		end
	end

	if not __wf_atom_7e8ad928(hudOverride) then
		local v3 = true

		if checkPreferDefaultHud then
			local __wf_atom_18a5d83b = __wf_atom_a0f6588f:__wf_atom_18a5d83b(0)

			if not __wf_atom_7e8ad928(__wf_atom_18a5d83b) then
				local settings = __wf_atom_18a5d83b:Settings()

				if not __wf_atom_7e8ad928(settings) then
					v3 = not settings:__wf_atom_4d3fd30a()
				end
			end
		end

		if
			v3
			and not __wf_atom_7e8ad928(gGameData)
			and not __wf_atom_7e8ad928(object)
			and object:__wf_atom_4417a5d4()
		then
			_T.ShouldSaveHudTrackers = true
			gGameData:__wf_atom_f0cbae7f(hudOverride, true)
			_T.ShouldSaveHudTrackers = nil
		end
	end

	if doReportSoundPerceptionOnMov and gRegion:IsMaster() then
		object:__wf_atom_8a035cd5(Symbol("ReportSoundPerceptionOnMove"), false)
	end

	while not __wf_atom_7e8ad928(object) do
		module.UpdateHeadTracking(object, true)
		Sleep(0)
	end
end