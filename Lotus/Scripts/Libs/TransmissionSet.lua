module(..., package.seeall)
local v = Symbol("WaitingForDialogComlpete")
local module = require("Lotus.Interface.LotusUtilities")

local function fn(p, p2)
	local flag

	if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
		module.ForceCloseTransmission(true)
		flag = true
	end

	if flag then
		return
	end

	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	local v2 = __wf_atom_7e8ad928(p) and 1 or p

	if not gGameRules:IsA(__wf_atom_311a7128) then
		gGameRules:SetNetPersistentVar(v, v2)
	end

	local total = 0

	if not p2 then
		while __wf_atom_7e8ad928(_T.curTransmission) do
			local flag2

			if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
				module.ForceCloseTransmission(true)
				flag2 = true
			end

			if flag2 then
				break
			end

			if total >= 10 then
				print("Wait for active transmission timed out")
				break
			else
				Sleep(0)
				total += __wf_atom_03df4e1d()
			end
		end
	end

	while not __wf_atom_7e8ad928(_T.curTransmission) do
		local flag2

		if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
			module.ForceCloseTransmission(true)
			flag2 = true
		end

		if flag2 then
			break
		end

		Sleep(0)
		total += __wf_atom_03df4e1d()
	end

	if not (__wf_atom_7e8ad928(gGameRules) or gGameRules:IsA(__wf_atom_311a7128)) then
		gGameRules:__wf_atom_0ab0a47f(v)
	end

	return total
end

local function fn2(object, p, instance, p2, p3, p4)
	local v2 = nil

	if gGameRules:IsA(__wf_atom_589d05aa) then
		local v3 = nil
		local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()

		if __wf_atom_72fc675e.tier > 0 then
			v3 = Resource((nil):__wf_atom_5b41f63b())
		elseif
			__wf_atom_72fc675e.periodicMissionTag == module.ELITE_ALERT_PERIODIC_MISSION_TAG
			or __wf_atom_72fc675e.periodicMissionTag == module.ELITE_ALERT_PERIODIC_MISSION_TAG_ALT
		then
			v3 = Resource((nil):__wf_atom_5b41f63b())
		end

		if not __wf_atom_7e8ad928(v3) then
			if p3 then
				v2 = v3:__wf_atom_89fb3a41(p, {})
			else
				v2 = v3:__wf_atom_b4a422ed(p)
			end
		end
	end

	if __wf_atom_7e8ad928(object) and __wf_atom_7e8ad928(v2) then
		return false
	end

	if __wf_atom_7e8ad928(v2) then
		if p3 then
			v2 = object:__wf_atom_89fb3a41(p, {})
		else
			v2 = object:__wf_atom_b4a422ed(p)
		end
	end

	if __wf_atom_7e8ad928(v2) then
		return false
	end

	if gGameRules:IsA(__wf_atom_311a7128) then
		module.CreateHudlessTransmission(v2, p4)
	elseif __wf_atom_7e8ad928(instance) and p2 then
		if p4 == nil then
			gGameRules:__wf_atom_ae06b572(v2)
		else
			gGameRules:__wf_atom_ae06b572(v2, p4)
		end
	elseif not __wf_atom_7e8ad928(instance) then
		if instance:IsA(__wf_atom_47cae841) and not __wf_atom_7e8ad928(instance:__wf_atom_4221009f()) then
			instance = instance:__wf_atom_4221009f()
		end

		if p4 == nil then
			instance:__wf_atom_1a73b1c2(v2)
		else
			instance:__wf_atom_1a73b1c2(v2, p4)
		end
	end

	return true
end

local function fn3(object, p, p2, p3, p4)
	local count = 0

	if __wf_atom_7e8ad928(object) then
		return count > 0
	end

	for i = 1, 99 do
		local v2 = Symbol(tostring(p) .. "_" .. i)
		local v3

		if p4 then
			v3 = object:__wf_atom_89fb3a41(v2, {})
		else
			v3 = object:__wf_atom_b4a422ed(v2)
		end

		if __wf_atom_7e8ad928(v3) then
			break
		end

		if fn2(object, v2, p2, p3) then
			count += 1
		end
	end

	return count > 0
end

function PlayGlobalTransmission(p, p2, p3, p4, p5)
	local flag

	if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
		module.ForceCloseTransmission(true)
		flag = true
	end

	if flag then
		return
	end

	if p3 then
		module.ForceCloseTransmission(true)
	end

	local v2 = fn2(p, p2, nil, true, false, p5)
	local v3 = fn3(p, p2, nil, true, false)

	if p4 and (v2 or v3) then
		fn()
	end

	return v2
end

function PlayGlobalRandomTransmission(p, p2, p3, p4)
	local flag

	if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
		module.ForceCloseTransmission(true)
		flag = true
	end

	if flag then
		return
	end

	if p3 then
		module.ForceCloseTransmission(true)
	end

	local v2 = fn2(p, p2, nil, true, true)
	fn3(p, p2, nil, true, true)

	if p4 then
		fn()
	end

	return v2
end

function PlayLocalTransmission(p, p2, p3, p4)
	local flag

	if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
		module.ForceCloseTransmission(true)
		flag = true
	end

	if flag then
		return
	end

	local v2

	if __wf_atom_7e8ad928(p3) then
		return false
	else
		v2 = fn2(p, p2, p3, false, nil, p4)
		fn3(p, p2, p3, false)
	end

	return v2
end

function PlayTransmissionInTile(p, p2, object)
	local flag

	if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
		module.ForceCloseTransmission(true)
		flag = true
	end

	if flag or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local __wf_atom_e800787c = object:__wf_atom_e800787c()

	if __wf_atom_7e8ad928(__wf_atom_e800787c) then
		return
	end

	local layerIndex = __wf_atom_e800787c:GetLayerIndex()

	for _, v2 in ipairs(__wf_atom_ef7900cf) do
		local __wf_atom_e800787c2 = v2:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c2) or __wf_atom_e800787c2:GetLayerIndex() ~= layerIndex then
			continue
		end

		fn2(p, p2, v2, false)
		fn3(p, p2, v2, false)
	end
end

function PlayTransmissionInMarkedZones(p, p2, p3)
	local flag

	if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
		module.ForceCloseTransmission(true)
		flag = true
	end

	if flag or __wf_atom_7e8ad928(p3) then
		return
	end

	local __wf_atom_4b1dfe77 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_4b1dfe77(p3, 1, 999)

	for _, v2 in ipairs(__wf_atom_4b1dfe77) do
		if not v2:IsA(__wf_atom_7e6ed5fa) then
			continue
		end

		fn2(p, p2, v2, false)
		fn3(p, p2, v2, false)
	end
end

function PlayConditionalTransmission(p, p2, p3, p4, p5)
	local flag

	if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
		module.ForceCloseTransmission(true)
		flag = true
	end

	if flag then
		return
	end

	if p4 then
		module.ForceCloseTransmission(true)
	end

	if not __wf_atom_7e8ad928(p3) then
		p2 = Symbol(tostring(p2) .. "_" .. tostring(p3))
	end

	fn2(p, p2, nil, true)
	fn3(p, p2, nil, true)

	if p5 then
		fn()
	end
end

function PlayLocalConditionalTransmission(p, p2, p3, p4)
	local flag

	if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
		module.ForceCloseTransmission(true)
		flag = true
	end

	if flag then
		return
	end

	local count = 0

	if __wf_atom_7e8ad928(p3) then
		return count > 0
	end

	if not __wf_atom_7e8ad928(p4) then
		p2 = Symbol(tostring(p2) .. "_" .. tostring(p4))
	end

	if fn2(p, p2, p3, false) then
		count += 1
	end

	if fn3(p, p2, p3, false) then
		count += 1
	end

	return count > 0
end

function SetupMissionTransmissionSet(missionTransmissionSet)
	if __wf_atom_7e8ad928(_T.MissionTransmissionSet) and not __wf_atom_7e8ad928(missionTransmissionSet) then
		_T.MissionTransmissionSet = missionTransmissionSet
	end
end

local function fn4(object, p, p2, p3, p4)
	local flag

	if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
		module.ForceCloseTransmission(true)
		flag = true
	end

	if flag then
		return
	end

	if p2 then
		module.ForceCloseTransmission(true)
	end

	local v2

	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_311a7128) then
		v2 = object:__wf_atom_a4299765()
	else
		v2 = gGameData:__wf_atom_a4299765()
	end

	local v3 = false

	if not __wf_atom_7e8ad928(v2) then
		local v4 = v2.mOperatorType == 4
		local v5 = p4 == 4 or v4 and p4 == nil
		local v6

		if v5 then
			v6 = v2.mAdultOperatorCustomization
		else
			v6 = v2.mOperatorCustomization
		end

		local __wf_atom_c4774ee9 = v6:__wf_atom_c4774ee9(9)

		if not __wf_atom_7e8ad928(__wf_atom_c4774ee9.mItemType) then
			local v7 = Resource(__wf_atom_c4774ee9.mItemType)

			if not __wf_atom_7e8ad928(v7) then
				v3 = fn2(v7:__wf_atom_d0c8d09f(), p, object:__wf_atom_eff0517e(), false)
			end
		end

		if not v3 then
			if v5 then
			end

			v3 = fn2(Resource(nil), p, object:__wf_atom_eff0517e(), false)
		end
	end

	if p3 and v3 then
		fn()
	end
end

function PlayLocalOperatorTransmission(p, p2, p3, p4)
	fn4(gRegion:__wf_atom_eab484a7(), p, p2, p3, p4)
end

function PlayGlobalOperatorTransmission(p, p2, p3)
	if p2 then
		module.ForceCloseTransmission(true)
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v2 in ipairs(__wf_atom_3c8e1a7a) do
		fn4(v2, p, p2, p3)
	end
end

function PlayGlobalOperatorConvoTransmissions(object, p, p2, p3)
	local flag

	if __wf_atom_72884638("LotusGameRules.SkipTransmissions") or _T.PlayerDead then
		module.ForceCloseTransmission(true)
		flag = true
	end

	if flag then
		return
	end

	if p2 then
		module.ForceCloseTransmission(true)
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()
	local v2 = {}

	for _, v3 in ipairs(__wf_atom_3c8e1a7a) do
		local v4 = nil
		local __wf_atom_a4299765 = v3:__wf_atom_a4299765()

		if not __wf_atom_7e8ad928(__wf_atom_a4299765) then
			local __wf_atom_c4774ee9 = __wf_atom_a4299765.mOperatorCustomization:__wf_atom_c4774ee9(9)

			if not __wf_atom_7e8ad928(__wf_atom_c4774ee9.mItemType) then
				local v5 = Resource(__wf_atom_c4774ee9.mItemType)

				if not __wf_atom_7e8ad928(v5) then
					v4 = v5:__wf_atom_d0c8d09f()
				end
			end
		end

		if __wf_atom_7e8ad928(v4) then
			table.insert(v2, Resource(nil))
		else
			table.insert(v2, v4)
		end
	end

	local v3 = p
	local count = 0

	while true do
		if count > 0 then
			v3 = Symbol(tostring(p) .. "_" .. count)
		end

		local v4

		if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_b4a422ed(v3)) then
			v4 = false
		else
			v4 = fn2(object, v3, nil, true)
		end

		if not v4 then
			for i, v5 in ipairs(__wf_atom_3c8e1a7a) do
				v4 = fn2(v2[i], v3, v5:__wf_atom_eff0517e(), false)
			end
		end

		if not v4 then
			break
		end

		count += 1
		Sleep(0)
	end

	if p3 then
		fn()
	end
end

function WaitForTransmissionsToComplete(p, p2)
	return fn(p, p2) or 0
end

local function fn5(p, p2)
	_T.InWorldTransmissionsLoading[p2] = nil

	if p then
		table.insert(_T.InWorldTransmissionQueue, Resource(p2))
	end
end

function PlayScreenTransmission(object, p, openSound, openDelay)
	_T.InWorldTransmissionsLoading = _T.InWorldTransmissionsLoading or {}
	_T.InWorldTransmissionQueue = _T.InWorldTransmissionQueue or {}

	if not __wf_atom_7e8ad928(openSound) then
		if __wf_atom_7e8ad928(_T.InWorldTransmissionIntro) then
			_T.InWorldTransmissionIntro = {}
		end

		_T.InWorldTransmissionIntro.openSound = openSound
	end

	if not __wf_atom_7e8ad928(openDelay) and openDelay > 0 then
		if __wf_atom_7e8ad928(_T.InWorldTransmissionIntro) then
			_T.InWorldTransmissionIntro = {}
		end

		_T.InWorldTransmissionIntro.openDelay = openDelay
	end

	local __wf_atom_b4a422ed = object:__wf_atom_b4a422ed(p)

	if not __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
		local __wf_atom_5b41f63b = __wf_atom_b4a422ed:__wf_atom_5b41f63b()
		_T.InWorldTransmissionsLoading[__wf_atom_5b41f63b] = true
		gGameRules:RequestResource(__wf_atom_5b41f63b, fn5)
	end
end

local function fn6() -- 2 equivalent calls inferred from this helper
	return _T.InWorldTransmissionsLoading and next(_T.InWorldTransmissionsLoading)
		or #_T.InWorldTransmissionQueue > 0
		or _T.InWorldTransmissionPlaying
end

function InWorldTransmissionQueuedOrPlaying()
	return fn6() -- inferred equivalent call
end

function WaitForInWorldTransmissionComplete()
	local total = 0

	while fn6() and total <= 30 do -- inferred equivalent call
		Sleep(0)
		total += __wf_atom_084b3e93()
	end
end

function TransmissionPlaying()
	return not __wf_atom_7e8ad928(_T.curTransmission)
end

function GetCurTransmission()
	return _T.curTransmission
end