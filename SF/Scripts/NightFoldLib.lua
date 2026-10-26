module(..., package.seeall)
local level = WeakResource("/SF/Levels/Tent.level")
local v = Vector(0, -500, 0)
local v2 = {
	"/SF/Language/SystemMessages/NightfoldDisabledTransition",
	"/SF/Language/SystemMessages/NightfoldDisabledCombat"
}
BT_NONE = 0
BT_MOVERS = 1
BT_COMBAT = 2

function IsNightFoldStreamed()
	local __wf_atom_b2b2c625 = gRegion:__wf_atom_b2b2c625()

	for _, v3 in ipairs(__wf_atom_b2b2c625) do
		local v4 = tostring(v3)

		if string.find(v4, "/SF/Levels/Tent") then
			return true
		end
	end

	return false
end

function AddLocalNightFoldOffsetToVector(data)
	local __wf_atom_7d5c620f = gRegion:__wf_atom_eab484a7():__wf_atom_7d5c620f()
	return (Vector(data.x - 250 * __wf_atom_7d5c620f, data.y, data.z - 250 * __wf_atom_7d5c620f))
end

function StreamNightFold(p)
	if _T.mNightFoldRequested ~= nil then
		return
	end

	if IsNightFoldStreamed() then
		_T.mNightFoldRequested = true
		return
	end

	local __wf_atom_7d5c620f = gRegion:__wf_atom_eab484a7():__wf_atom_7d5c620f()
	print("I'm streaming into nightfold now. My playerId is", __wf_atom_7d5c620f)
	_T.mNightFoldRequested = true
	local levelArgs = Engine.OpenLevelArgs()
	levelArgs.level = level
	levelArgs.streamingLayer = 500
	levelArgs.streamingMode = 1

	if p then
		levelArgs:__wf_atom_c4be912d(p)
	end

	levelArgs:__wf_atom_60471db9(AddLocalNightFoldOffsetToVector(v), __wf_atom_80368bb1)
	levelArgs.streamingPriority = 2
	levelArgs.isAutonomous = true
	Engine.StreamRegion(levelArgs)
end

function ReloadNightFold()
	local levelArgs = Engine.OpenLevelArgs()
	levelArgs.level = level
	levelArgs.streamingLayer = 500
	levelArgs.streamingPriority = 2
	levelArgs.isAutonomous = true
	levelArgs:__wf_atom_c4be912d("OnNightfoldRemoved")
	Engine.__wf_atom_94cafc05(levelArgs)
end

function OnNightfoldRemoved()
	_T.mNightFoldRequested = nil

	if not (__wf_atom_7e8ad928(gRegion:__wf_atom_eab484a7()) or __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f())) then
		StreamNightFold()
	end
end

function AvatarInNightFold(object, p)
	local __wf_atom_e800787c = object:__wf_atom_e800787c()

	if __wf_atom_7e8ad928(__wf_atom_e800787c) then
		return p
	end

	return __wf_atom_e800787c:__wf_atom_dd89d98c() - 1 == 500
end

local function fn()
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	if not __wf_atom_7e8ad928(all) then
		for i = 1, #all do
			if all[i]:__wf_atom_1d13ef4d() then
				return all[i]
			end
		end
	end
end

function DisableAllSkiesButTagged(p, p2)
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	if __wf_atom_7e8ad928(all) then
		return
	end

	local v3 = Symbol(p)
	local v4 = 0

	for i = 1, #all do
		if all[i]:__wf_atom_db682341() ~= v3 then
			continue
		end

		v4 = i
		break
	end

	if v4 == 0 then
		print("(NightFoldLib.lua) DisableAllskiesButTagged called with tag: " .. p .. " but no DynamicSky has this tag.")
		return
	end

	local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

	for i = 1, #all do
		if v4 == i then
			if not __wf_atom_7e8ad928(__wf_atom_8ad59546) and p2 then
				all[i]:SetTimeOfDay(__wf_atom_8ad59546:__wf_atom_cb3427c9())
			end

			all[i]:Enable(true)
		else
			all[i]:Enable(false)
		end
	end
end

function GetTaggedSky(p)
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	if not __wf_atom_7e8ad928(all) then
		for i = 1, #all do
			if all[i]:__wf_atom_db682341() == Symbol(p) then
				return all[i]
			end
		end
	end
end

function ToggleSky(p)
	local v3 = fn()
	local v4 = GetTaggedSky(Symbol("NightFoldDynSky"))

	if not p then
		v4, v3 = v3, v4
	end

	if not __wf_atom_7e8ad928(v3) then
		local __wf_atom_8ad59546 = gRegion:__wf_atom_8ad59546()

		if not __wf_atom_7e8ad928(__wf_atom_8ad59546) then
			v3:SetTimeOfDay(__wf_atom_8ad59546:__wf_atom_cb3427c9())
		end

		v3:Enable(true)
	end

	if not __wf_atom_7e8ad928(v4) then
		v4:Enable(false)
	end
end

function GetNightFoldLevel()
	return level
end

function RegisterPreventNighfoldUsage(p, p2, p3, p4)
	if _T.PreventNightfoldUsage == nil and p ~= true then
		return
	end

	if _T.PreventNightfoldUsage == nil and p then
		_T.PreventNightfoldUsage = {}
	end

	local v3 = p2 == nil and "unknown" or p2

	if _T.PreventNightfoldUsage[v3] == nil then
		if not p then
			return
		end

		_T.PreventNightfoldUsage[v3] = {}
		_T.PreventNightfoldUsage[v3].count = 0
		_T.PreventNightfoldUsage[v3].timeoutTime = nil
		_T.PreventNightfoldUsage[v3].blockExit = nil
	end

	_T.PreventNightfoldUsage[v3].count = math.max(0, _T.PreventNightfoldUsage[v3].count + (p and 1 or -1))

	if _T.PreventNightfoldUsage[v3].count == 0 then
		_T.PreventNightfoldUsage[v3] = nil
	elseif p then
		if p3 then
			_T.PreventNightfoldUsage[v3].blockExit = true
		end

		if p4 ~= nil then
			local timeoutTime = Time() + p4

			if
				_T.PreventNightfoldUsage[v3].timeoutTime == nil
				or _T.PreventNightfoldUsage[v3].timeoutTime < timeoutTime
			then
				_T.PreventNightfoldUsage[v3].timeoutTime = timeoutTime
			end
		end
	end

	if p ~= true then
		local flag = true

		for k, _ in pairs(_T.PreventNightfoldUsage) do
			if _T.PreventNightfoldUsage[k] == nil then
				continue
			end

			flag = false
			break
		end

		if flag then
			_T.PreventNightfoldUsage = nil
		end
	end

	if _T.PreventNightfoldUsage == nil or _T.PreventNightfoldUsage[v3] == nil then
		print("DBG:  RegisterPreventNighfoldUsage", v3, p, "0")
	else
		print("DBG:  RegisterPreventNighfoldUsage", v3, p, _T.PreventNightfoldUsage[v3].count)
	end
end

function ClearPreventNighfoldUsage(p)
	local v3 = p == nil and "unknown" or p

	if __wf_atom_7e8ad928(_T.PreventNightfoldUsage) then
		return
	end

	_T.PreventNightfoldUsage[v3] = nil
	print("DBG:  ClearPreventNighfoldUsage", v3)
end

function IsNightfoldBlockedById(p, p2)
	if not (_T.PreventNightfoldUsage ~= nil and _T.PreventNightfoldUsage[p] ~= nil and _T.PreventNightfoldUsage[p].count ~= 0) then
		return false
	end

	return not p2 or _T.PreventNightfoldUsage[p].blockExit == true
end

function IsNightfoldBlocked(p)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local motionControl = __wf_atom_c4f78a8f:MotionControl()
		local v3

		if not __wf_atom_7e8ad928(motionControl) then
			v3 = motionControl:__wf_atom_282af4d6() or nil
		end

		if not __wf_atom_7e8ad928(v3) then
			SetPreventNightfoldUsageReason(BT_MOVERS)
			return true
		end
	end

	if _T.PreventNightfoldUsage == nil then
		return false
	end

	local v3 = Time()

	for k, _ in pairs(_T.PreventNightfoldUsage) do
		if _T.PreventNightfoldUsage[k].timeoutTime == nil or not (_T.PreventNightfoldUsage[k].timeoutTime < v3) then
			if not p or _T.PreventNightfoldUsage[k].blockExit then
				return true
			end
		else
			print("DBG:  RegisterPreventNighfoldUsage TIMED OUT on", k)
			_T.PreventNightfoldUsage[k] = nil
		end
	end

	if not p then
		_T.PreventNightfoldUsage = nil
	end

	return false
end

function IsNightfoldExitBlocked()
	return IsNightfoldBlocked(true)
end

function SetPreventNightfoldUsageReason(preventNightfoldUsageReason)
	if __wf_atom_7e8ad928(_T.PreventNightfoldUsageReason) then
		_T.PreventNightfoldUsageReason = 0
	end

	_T.PreventNightfoldUsageReason = preventNightfoldUsageReason
end

function GetPreventNightfoldUsageReason()
	if __wf_atom_7e8ad928(_T.PreventNightfoldUsageReason) or not (_T.PreventNightfoldUsageReason <= #v2) then
		return
	end

	local v3 = v2[_T.PreventNightfoldUsageReason]

	if __wf_atom_7e8ad928(v3) then
		return
	else
		return v3
	end
end

function SetForceInteractDisable(p, p2)
	if __wf_atom_7e8ad928(p2) then
		return
	end

	if __wf_atom_7e8ad928(_T.AncestorsWithForceDisabledInteracts) then
		_T.AncestorsWithForceDisabledInteracts = {}
	end

	for i = #_T.AncestorsWithForceDisabledInteracts, 1, -1 do
		if _T.AncestorsWithForceDisabledInteracts[i] ~= p then
			continue
		end

		if not p2 then
			table.remove(_T.AncestorsWithForceDisabledInteracts, i)
		end

		return
	end

	if p2 then
		table.insert(_T.AncestorsWithForceDisabledInteracts, p)
	end
end

function ShouldForceInteractDisable(p)
	if __wf_atom_7e8ad928(_T.AncestorsWithForceDisabledInteracts) then
		return false
	end

	for _, ancestorsWithForceDisabledInteract in pairs(_T.AncestorsWithForceDisabledInteracts) do
		if ancestorsWithForceDisabledInteract == p then
			return true
		end
	end

	return false
end

function SetHideAncestorNPC(p, p2)
	if __wf_atom_7e8ad928(p2) then
		return
	end

	if __wf_atom_7e8ad928(_T.AncestorsToBeHidden) then
		_T.AncestorsToBeHidden = {}
	end

	for i = #_T.AncestorsToBeHidden, 1, -1 do
		if _T.AncestorsToBeHidden[i] ~= p then
			continue
		end

		if not p2 then
			table.remove(_T.AncestorsToBeHidden, i)
		end

		return
	end

	if p2 then
		table.insert(_T.AncestorsToBeHidden, p)
	end
end

function ShouldForceHideAncestor(p)
	if __wf_atom_7e8ad928(_T.AncestorsToBeHidden) then
		return false
	end

	for _, v3 in pairs(_T.AncestorsToBeHidden) do
		if v3 == p then
			return true
		end
	end

	return false
end

function SetForceStationReveal(p, p2)
	if __wf_atom_7e8ad928(p2) then
		return
	end

	if __wf_atom_7e8ad928(_T.AncestorsWithForceRevealedStations) then
		_T.AncestorsWithForceRevealedStations = {}
	end

	for i = #_T.AncestorsWithForceRevealedStations, 1, -1 do
		if _T.AncestorsWithForceRevealedStations[i] ~= p then
			continue
		end

		if not p2 then
			table.remove(_T.AncestorsWithForceRevealedStations, i)
		end

		return
	end

	if p2 then
		table.insert(_T.AncestorsWithForceRevealedStations, p)
	end
end

function ShouldForceStationReveal(p)
	if __wf_atom_7e8ad928(_T.AncestorsWithForceRevealedStations) then
		return false
	end

	for _, ancestorsWithForceRevealedStation in pairs(_T.AncestorsWithForceRevealedStations) do
		if ancestorsWithForceRevealedStation == p then
			return true
		end
	end

	return false
end

function SetHideAncestorStation(p, p2)
	if __wf_atom_7e8ad928(p2) then
		return
	end

	if __wf_atom_7e8ad928(_T.AncestorsWithForceHideStations) then
		_T.AncestorsWithForceHideStations = {}
	end

	for i = #_T.AncestorsWithForceHideStations, 1, -1 do
		if _T.AncestorsWithForceHideStations[i] ~= p then
			continue
		end

		if not p2 then
			table.remove(_T.AncestorsWithForceHideStations, i)
		end

		return
	end

	if p2 then
		table.insert(_T.AncestorsWithForceHideStations, p)
	end
end

function ShouldForceHideStation(p)
	if __wf_atom_7e8ad928(_T.AncestorsWithForceHideStations) then
		return false
	end

	for _, ancestorsWithForceHideStation in pairs(_T.AncestorsWithForceHideStations) do
		if ancestorsWithForceHideStation == p then
			return true
		end
	end

	return false
end