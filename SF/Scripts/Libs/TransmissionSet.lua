module(..., package.seeall)
local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("SF.Scripts.Libs.QuestLib")

local function fn(p, callback, p2)
	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	local total = 0

	if not p then
		while __wf_atom_7e8ad928(_T.curTransmission) do
			if not __wf_atom_7e8ad928(callback) and callback() then
				print("Wait for active transmission user early exit")
				break
			end

			if p2 and not __wf_atom_7e8ad928(_T.ForceDialogClose) and _T.ForceDialogClose then
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
		Sleep(0)

		if __wf_atom_7e8ad928(callback) or not callback() then
			if p2 and not __wf_atom_7e8ad928(_T.ForceDialogClose) and _T.ForceDialogClose then
				break
			else
				total += __wf_atom_03df4e1d()
			end
		else
			print("Wait for active transmission user early exit")
			return total
		end
	end

	return total
end

local function fn2(object, p, instance, p2, p3, p4)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_b4a422ed = object:__wf_atom_b4a422ed(p)

	if __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
		__wf_atom_b4a422ed = object:__wf_atom_89fb3a41(p, {})
	end

	if __wf_atom_7e8ad928(__wf_atom_b4a422ed) then
		return false
	end

	if gGameRules:IsA(__wf_atom_311a7128) then
		module.CreateHudlessTransmission(__wf_atom_b4a422ed, p4)
	elseif __wf_atom_7e8ad928(instance) and p2 then
		if p4 == nil then
			gGameRules:__wf_atom_ae06b572(__wf_atom_b4a422ed)
		else
			gGameRules:__wf_atom_ae06b572(__wf_atom_b4a422ed, p4)
		end
	elseif not __wf_atom_7e8ad928(instance) then
		if instance:IsA(__wf_atom_47cae841) and not __wf_atom_7e8ad928(instance:__wf_atom_4221009f()) then
			instance = instance:__wf_atom_4221009f()
		end

		if p4 == nil then
			instance:__wf_atom_1a73b1c2(__wf_atom_b4a422ed)
		else
			instance:__wf_atom_1a73b1c2(__wf_atom_b4a422ed, p4)
		end
	end

	if p3 then
		fn()
	end

	return true
end

function PlayGlobalTransmission(p, p2, p3)
	return (fn2(p, p2, nil, true, p3))
end

function PlayLocalTransmission(p, p2, p3, p4)
	return not __wf_atom_7e8ad928(p3) and fn2(p, p2, p3, false, p4)
end

function PlayDialogMenuTransmission(p, p2, p3, p4, p5)
	local v = __wf_atom_7e8ad928(p4) and true or p4
	local v2

	if not __wf_atom_7e8ad928(p3) then
		v2 = fn2(p, p2, p3)
	end

	if not __wf_atom_7e8ad928(p5) and p5 > 0 then
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

		for _, v3 in ipairs(__wf_atom_ef7900cf) do
			if v3 ~= p3 and v3:__wf_atom_8a6b8fc3(p3) <= p5 then
				fn2(p, p2, v3)
			end
		end
	end

	if v and v2 then
		fn(false, nil, true)
		return __wf_atom_7e8ad928(_T.ForceDialogClose) or not _T.ForceDialogClose
	else
		return true
	end
end

function PlayRadialTransmission(p, p2, p3, p4, p5)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v in ipairs(__wf_atom_ef7900cf) do
		if v:__wf_atom_d5fda8be(p3) <= p4 then
			fn2(p, p2, v, false)
		end
	end

	if p5 then
		fn()
	end
end

function PlayQuestDependentTransmission(p, p2, p3, p4, p5, p6)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v in ipairs(__wf_atom_ef7900cf) do
		local v2

		if module2.HasCompletedQuest(p2) then
			v2 = p4
		elseif __wf_atom_7e8ad928(p5) or p5 == EMPTY_SYMBOL then
			v2 = p3
		elseif module2.QuestIsActive(p2) then
			v2 = p5
		else
			v2 = p3
		end

		if __wf_atom_7e8ad928(v2) or v2 == EMPTY_SYMBOL then
			continue
		end

		fn2(p, v2, v)
	end

	if p6 then
		fn()
	end
end

function WaitForTransmissions(p, p2, p3)
	return fn(p, p2, p3) or 0
end

function TransmissionPlaying()
	return not __wf_atom_7e8ad928(_T.curTransmission)
end

function GetCurTransmission()
	return _T.curTransmission
end

function EmptyTransmissionQueue(list, p)
	local v = p or __wf_atom_a8ef5ffb

	for _, v2 in ipairs(list) do
		v2:__wf_atom_bf2d466b(v)
	end
end

function CloseTransmissions()
	module.ForceCloseTransmission(true)
end