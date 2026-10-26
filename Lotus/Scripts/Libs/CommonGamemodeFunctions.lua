module(..., package.seeall)
local module = require("EE.Interface.Utilities")

local function fn(p, p2)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) and #__wf_atom_2226b35c > 0 then
		for _, v in ipairs(__wf_atom_2226b35c) do
			v:FirePort(p2)
		end
	end
end

function Round(p, value)
	local v = 10 ^ (value or 0)
	return math.floor(p * v + 0.5) / v
end

local function fn2(list)
	local result = {}

	while #list > 0 do
		local v = __wf_atom_5784a397(1, #list)
		table.insert(result, list[v])
		table.remove(list, v)
	end

	return result
end

function ScrambleArray(p)
	return (fn2(p))
end

function CopyList(list)
	local result = {}

	for i = 1, #list do
		table.insert(result, list[i])
	end

	return result
end

function Closest(list, p)
	local v = 3.4028234663852886e38
	local v2 = nil

	for i = 1, #list do
		local __wf_atom_d5fda8be = list[i]:__wf_atom_d5fda8be(p)

		if not (__wf_atom_d5fda8be < v) then
			continue
		end

		v2 = list[i]
		v = __wf_atom_d5fda8be
	end

	return v2
end

function Farthest(list, p)
	local v = 0
	local v2 = nil

	for i = 1, #list do
		local __wf_atom_d5fda8be = list[i]:__wf_atom_d5fda8be(p)

		if not (v < __wf_atom_d5fda8be) then
			continue
		end

		v2 = list[i]
		v = __wf_atom_d5fda8be
	end

	return v2
end

function ClosestToObjectiveOverNavmesh(list, p, object)
	local v = 3.4028234663852886e38
	local v2 = nil

	for _, v3 in ipairs(list) do
		local __wf_atom_fdebcbf3 = object:__wf_atom_fdebcbf3(v3)

		if not (__wf_atom_fdebcbf3 < v and (not p or p and v3:IsEnabled())) then
			continue
		end

		v2 = v3
		v = __wf_atom_fdebcbf3
	end

	return v2
end

local function fn3(p, list) -- 1 equivalent call inferred from this helper
	for _, v in ipairs(list) do
		if p == v then
			return true
		end
	end

	return false
end

function SortByLayerIndex(list, list2)
	local result = {}

	for i = #list, 1, -1 do
		if __wf_atom_7e8ad928(list[i]) then
			table.remove(list, i)
		else
			local __wf_atom_e800787c = list[i]:__wf_atom_e800787c()

			if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
				if __wf_atom_7e8ad928(list2) or fn3(__wf_atom_e800787c:__wf_atom_db682341(), list2) then -- inferred equivalent call
					continue
				end
			end

			table.remove(list, i)
		end
	end

	while #list > 0 do
		local v = 3.4028234663852886e38
		local v2 = nil

		for i = 1, #list do
			local layerIndex = list[i]:__wf_atom_e800787c():GetLayerIndex()

			if not (layerIndex < v) then
				continue
			end

			v2 = i
			v = layerIndex
		end

		if not __wf_atom_7e8ad928(v2) then
			table.insert(result, list[v2])
			table.remove(list, v2)
		end

		Sleep(0)
	end

	return result
end

function SortByValue(list)
	local result = {}

	while #list > 0 do
		local v = 3.4028234663852886e38
		local v2 = nil

		for i = 1, #list do
			if not (list[i] < v) then
				continue
			end

			v = list[i]
			v2 = i
		end

		if not __wf_atom_7e8ad928(v2) then
			table.insert(result, list[v2])
			table.remove(list, v2)
		end

		Sleep(0)
	end

	return result
end

function ZoneCheckList(p, list)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)
	local result = {}

	for i = 1, #list do
		local __wf_atom_e800787c = list[i]:__wf_atom_e800787c()

		for j = 1, #__wf_atom_2226b35c do
			if __wf_atom_e800787c ~= __wf_atom_2226b35c[j]:__wf_atom_e800787c() then
				continue
			end

			table.insert(result, list[i])
			break
		end
	end

	return result
end

function ZoneCheck(p, list)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)
	local v = nil

	for i = 1, #list do
		local __wf_atom_e800787c = list[i]:__wf_atom_e800787c()

		for j = 1, #__wf_atom_2226b35c do
			if __wf_atom_e800787c == __wf_atom_2226b35c[j]:__wf_atom_e800787c() then
				v = list[i]
			end
		end
	end

	return v
end

function RemoveFromTable(list, p)
	for i = 1, #list do
		if list[i] ~= p then
			continue
		end

		table.remove(list, i)
		break
	end
end

function MergeTables(list, list2)
	for i = 1, #list2 do
		table.insert(list, list2[i])
	end

	return list
end

function IsATypeInList(instance, list)
	for _, className in ipairs(list) do
		if not __wf_atom_7e8ad928(className) and instance:IsA(className) then
			return true
		end
	end

	return false
end

function GetObjectsInTile(list, p)
	local result = {}

	for i, v in ipairs(list) do
		if not __wf_atom_7e8ad928(v) then
			local __wf_atom_e800787c = v:__wf_atom_e800787c()

			if not __wf_atom_7e8ad928(__wf_atom_e800787c) and __wf_atom_e800787c:GetLayerIndex() == p then
				table.insert(result, v)
			end
		end

		if i > 100 and i % 100 == 0 then
			Sleep(0)
		end
	end

	return result
end

function GetExitLayerIndex()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ExitMarker"))

	for _, v in ipairs(__wf_atom_2226b35c) do
		local __wf_atom_e800787c = v:__wf_atom_e800787c()

		if not __wf_atom_7e8ad928(__wf_atom_e800787c) and __wf_atom_e800787c:__wf_atom_db682341() == Symbol("Exit") then
			return (__wf_atom_e800787c:GetLayerIndex())
		end
	end

	return 9999
end

function GetMaxLayerIndex(p)
	local all = gRegion:FindAll(__wf_atom_e1d1671b)
	local v = 0

	for _, v2 in ipairs(all) do
		local __wf_atom_e800787c = v2:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) then
			continue
		end

		local __wf_atom_db682341 = __wf_atom_e800787c:__wf_atom_db682341()

		if
			not (__wf_atom_7e8ad928(p) or __wf_atom_db682341 == p)
			or v2:__wf_atom_6c640264()
			or v2:__wf_atom_b1dbf338():c_str() == "FlyIn"
		then
			continue
		end

		local layerIndex = __wf_atom_e800787c:GetLayerIndex()

		if v < layerIndex then
			v = layerIndex
		end
	end

	return v
end

function IsAlertMission()
	if __wf_atom_7e8ad928(_T.MissionSettings) then
		_T.MissionSettings = {}
	end

	if __wf_atom_7e8ad928(_T.MissionSettings.isAlert) then
		local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
		_T.MissionSettings.isAlert = __wf_atom_72fc675e.alertId ~= ""
	end

	return _T.MissionSettings.isAlert
end

function IsInvasionMission()
	if __wf_atom_7e8ad928(_T.MissionSettings) then
		_T.MissionSettings = {}
	end

	if __wf_atom_7e8ad928(_T.MissionSettings.isInvasion) then
		local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
		_T.MissionSettings.isInvasion = __wf_atom_72fc675e.invasionId ~= ""
	end

	return _T.MissionSettings.isInvasion
end

function IsSyndicateMission()
	if __wf_atom_7e8ad928(_T.MissionSettings) then
		_T.MissionSettings = {}
	end

	if __wf_atom_7e8ad928(_T.MissionSettings.isSyndicate) then
		local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
		_T.MissionSettings.isSyndicate = __wf_atom_72fc675e.syndicateTag:__wf_atom_8598f3a9()
	end

	return _T.MissionSettings.isSyndicate
end

function IsSortieMission()
	if __wf_atom_7e8ad928(_T.MissionSettings) then
		_T.MissionSettings = {}
	end

	if __wf_atom_7e8ad928(_T.MissionSettings.isSortie) then
		local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
		_T.MissionSettings.isSortie = __wf_atom_72fc675e.sortieId ~= ""
	end

	return _T.MissionSettings.isSortie
end

function IsKuvaMission()
	if __wf_atom_7e8ad928(_T.MissionSettings) then
		_T.MissionSettings = {}
	end

	if __wf_atom_7e8ad928(_T.MissionSettings.isKuva) then
		local __wf_atom_72fc675e = gGameRules:__wf_atom_72fc675e()
		_T.MissionSettings.isKuva = __wf_atom_72fc675e.goalTag == Symbol("GhostTower")
	end

	return _T.MissionSettings.isKuva
end

function IsRelicMission()
	return (string.find(tostring(gGameRules:__wf_atom_72fc675e().activeMissionTag), "Void"))
end

function FailMission()
	gGameRules:EndGame(0)
end

function GiveAllPlayersXP(p, p2)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v in ipairs(__wf_atom_ef7900cf) do
		v:__wf_atom_d2b2176d():__wf_atom_355b9a20(p, v, p2)
	end
end

local function fn4(className, object)
	if __wf_atom_7e8ad928(object) then
		return 0
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
		return 0
	end

	for i = 1, __wf_atom_d2b2176d:__wf_atom_62abd325(0) do
		local __wf_atom_ba1c3957 = __wf_atom_d2b2176d:__wf_atom_ba1c3957(i - 1, 0)

		if not __wf_atom_7e8ad928(__wf_atom_ba1c3957) and __wf_atom_ba1c3957:IsA(className) then
			return (__wf_atom_d2b2176d:__wf_atom_b62f2024(i - 1, 0))
		end
	end

	return 0
end

function InventoryWheelItemCount(p)
	return (fn4(p, gRegion:__wf_atom_c4f78a8f()))
end

function ReplenishItem(object, p, list)
	if not __wf_atom_7e8ad928(object) then
		if fn4(p, object) > 0 then
			return
		end

		if not __wf_atom_7e8ad928(list) and #list > 0 then
			for i, _ in ipairs(list) do
				if fn4(list[i], object) > 0 then
					return
				end
			end
		end

		if not __wf_atom_7e8ad928((object:__wf_atom_d2b2176d())) then
			object:GiveItem(p, true)
		end
	end
end

function NumItemsScanned(object, list, p)
	local count = 0

	if __wf_atom_7e8ad928(object) then
		return count
	end

	for _, v in ipairs(list) do
		if not (object:__wf_atom_d2b2176d():__wf_atom_8c420d1b(v) == 1 or __wf_atom_72884638("LotusGameRules.MissionDebug")) then
			continue
		end

		if p then
			v:FirePort("Hide")
		end

		count += 1
	end

	return count
end

function WaitForTransmissions()
	local v = 10

	while __wf_atom_7e8ad928(_T.curTransmission) do
		v -= __wf_atom_084b3e93()

		if v <= 0 then
			print("WaitForTransmissions timed out")
			break
		else
			Sleep(0)
		end
	end

	while not __wf_atom_7e8ad928(_T.curTransmission) do
		Sleep(0)
	end
end

function RunScriptTriggers(p, p2, p3)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	if #__wf_atom_2226b35c == 0 or __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		return
	end

	local v = #__wf_atom_2226b35c

	for i = 1, p3 and 1 or v do
		if __wf_atom_7e8ad928(__wf_atom_2226b35c[i]) then
			continue
		end

		__wf_atom_2226b35c[i]:FirePort("Execute")

		if p2 then
			__wf_atom_2226b35c[i]:FirePort("Disable")
		end
	end
end

function TaggedFirePorts(p, p2)
	fn(p, p2)
end

function DestroyTaggedObjects(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	for _, v in ipairs(__wf_atom_2226b35c) do
		v:Destroy()
	end
end

function DestroyTypeObjects(p)
	local all = gRegion:FindAll(p)

	for _, v in ipairs(all) do
		v:Destroy()
	end
end

function EnableTaggedObjects(p, p2)
	local v = __wf_atom_7e8ad928(p2) and true or p2
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	for _, v2 in ipairs(__wf_atom_2226b35c) do
		if v2:IsA(__wf_atom_d00f34c2) then
			if v then
				v2:TurnOn()
			else
				v2:TurnOff()
			end
		elseif v2:IsA(__wf_atom_4d4372ee) then
			v2:Enable(v)
		elseif v then
			v2:Enable()
		else
			v2:Disable()
		end
	end
end

function ShowTaggedObjects(p, p2)
	local v = __wf_atom_7e8ad928(p2) and true or p2
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	for _, v2 in ipairs(__wf_atom_2226b35c) do
		v2:SetVisibility(v)
	end
end

function GetLevelExitMarker(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ExitMarker"))

	for _, v in ipairs(__wf_atom_2226b35c) do
		local __wf_atom_e800787c = v:__wf_atom_e800787c()

		if
			not __wf_atom_7e8ad928(__wf_atom_e800787c)
			and __wf_atom_e800787c:__wf_atom_db682341() == Symbol("Exit")
			and (__wf_atom_7e8ad928(p) or __wf_atom_e800787c:__wf_atom_dd89d98c() == p)
		then
			return v
		end
	end

	if __wf_atom_7e8ad928(__wf_atom_2226b35c) or not (#__wf_atom_2226b35c > 0) then
		return
	else
		return __wf_atom_2226b35c[1]
	end
end

function MarkExtraction(p)
	local gGameRules = gGameRules
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ExitMarker"))
	local v = nil

	for _, v2 in ipairs(__wf_atom_2226b35c) do
		local __wf_atom_e800787c = v2:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) or __wf_atom_e800787c:__wf_atom_db682341() ~= Symbol("Exit") then
			continue
		end

		v = v2
	end

	if __wf_atom_7e8ad928(v) and not __wf_atom_7e8ad928(__wf_atom_2226b35c) and #__wf_atom_2226b35c > 0 then
		v = __wf_atom_2226b35c[1]
	end

	if not __wf_atom_7e8ad928(v) then
		v:FirePort("Enable")

		if p or __wf_atom_7e8ad928(p) then
			__wf_atom_7d789620:__wf_atom_5e16fe4a(v)
			v:__wf_atom_fb3c4935(0)
		else
			v:__wf_atom_fb3c4935(1)
		end
	end

	gGameRules:__wf_atom_0089d40e(true)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("StreamingElevatorDoorHint"))

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("ObjectiveDoorHint"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2:FirePort("Unlock")
		end

		local __wf_atom_0a6a5887_3 = gRegion:__wf_atom_0a6a5887(Symbol("DoorExitGate"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_3) then
			__wf_atom_0a6a5887_3:FirePort("Unlock")
		end
	else
		__wf_atom_0a6a5887:FirePort("Unlock")
	end

	if __wf_atom_7e8ad928(v) then
		return
	else
		return v
	end
end

function LockStreamingElevator(p)
	local v

	if p then
		v = gRegion:__wf_atom_0a6a5887(Symbol("LockElevatorDoor"))
	else
		v = gRegion:__wf_atom_0a6a5887(Symbol("UnlockElevatorDoor"))
	end

	if not __wf_atom_7e8ad928(v) then
		v:FirePort("TriggerPort")
	end
end

function GetPlayerSpawn()
	local all = gRegion:FindAll(__wf_atom_0916f346)

	for _, v in ipairs(all) do
		local __wf_atom_e800787c = v:__wf_atom_e800787c()

		if
			not __wf_atom_7e8ad928(__wf_atom_e800787c)
			and __wf_atom_e800787c:__wf_atom_db682341() == Symbol("Spawn")
		then
			return v
		end
	end
end

function UnlockAllProcDoors()
	local v = {
		Symbol("DoorExitGate"),
		Symbol("DoorObjectiveGate"),
		Symbol("DoorBossGate"),
		Symbol("SabotageBlastDoor")
	}

	for _, v2 in ipairs(v) do
		fn(v2, "Unlock")
	end

	fn(Symbol("ObjectiveDoor"), "Execute")
end

function SetGatedLockDown(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("DoorHint"))
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("PanicButton"))

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for _, v in ipairs(__wf_atom_2226b35c) do
			if p then
				v:FirePort("Lock")
			else
				v:FirePort("Unlock")
			end
		end

		for _, v in ipairs(__wf_atom_2226b35c2) do
			if p then
				v:FirePort("Disable")
			else
				v:FirePort("Enable")
			end
		end
	end
end

function SetAlarms(p)
	local v, v2

	if p then
		v = "Enable"
		v2 = "TurnOn"
	else
		v = "Disable"
		v2 = "TurnOff"
	end

	if p then
		local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("Alarm"))

		for i = #__wf_atom_2226b35c, 1, -1 do
			local position = __wf_atom_2226b35c[i]:GetPosition()
			local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("Alarm"), position, 0, 20)

			if __wf_atom_7e8ad928(__wf_atom_439c0d29) or not (#__wf_atom_439c0d29 > 0) then
				continue
			end

			__wf_atom_2226b35c[i]:Destroy()
		end
	end

	fn(Symbol("Alarm"), v)
	fn(Symbol("AlarmFlare"), v)
	fn(Symbol("AlarmLight"), v2)
end

function LightsOut()
	local v = __wf_atom_5784a397(0, 32768)
	math.randomseed(172373)
	fn(Symbol("LightFlare"), "Disable")
	fn(Symbol("GodRay"), "Hide")
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("Light"))
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("LightFixture"))
	local __wf_atom_2226b35c3 = gRegion:__wf_atom_2226b35c(Symbol("LightNoVolt"))
	local __wf_atom_2226b35c4 = gRegion:__wf_atom_2226b35c(Symbol("LightFixtureNoVolt"))
	local __wf_atom_2226b35c5 = gRegion:__wf_atom_2226b35c(Symbol("LightFixtureTemplate"))

	if not (__wf_atom_7e8ad928(__wf_atom_2226b35c) or __wf_atom_7e8ad928(__wf_atom_2226b35c3)) then
		for i = 1, #__wf_atom_2226b35c3 do
			table.insert(__wf_atom_2226b35c, __wf_atom_2226b35c3[i])
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c2) then
		if not __wf_atom_7e8ad928(__wf_atom_2226b35c4) then
			for i = 1, #__wf_atom_2226b35c4 do
				table.insert(__wf_atom_2226b35c2, __wf_atom_2226b35c4[i])
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_2226b35c5) then
			for i = 1, #__wf_atom_2226b35c5 do
				table.insert(__wf_atom_2226b35c2, __wf_atom_2226b35c5[i])
			end
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c2) then
		for i = 1, #__wf_atom_2226b35c2 do
			if not __wf_atom_7e8ad928(__wf_atom_2226b35c2[i]) then
				__wf_atom_2226b35c2[i]:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, 0)
			end
		end
	end

	if not __wf_atom_7e8ad928(__wf_atom_2226b35c) then
		for i = 1, #__wf_atom_2226b35c do
			if __wf_atom_2226b35c[i]:IsA(__wf_atom_d00f34c2) then
				if math.random() <= 0.4 then
					local position = __wf_atom_2226b35c[i]:GetPosition()
					local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("LightFixture"), position, 0, 20)

					if math.random() <= 1 then
						__wf_atom_2226b35c[i]:SetColor(Color(64, 196, 255, 255))

						if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
							__wf_atom_f738b4af:SetMaterialParam(SF.EMISSIVE_MAP_ATTEN, 0.5)
						end
					end

					__wf_atom_2226b35c[i]:__wf_atom_368b8980(0.2 + math.random() * 0.3)
					__wf_atom_2226b35c[i]:__wf_atom_924bdba8(-0.9)
					__wf_atom_2226b35c[i]:SetEffect(3)
				else
					__wf_atom_2226b35c[i]:FirePort("TurnOff")
				end

				local __wf_atom_e800787c = __wf_atom_2226b35c[i]:__wf_atom_e800787c()

				if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
					__wf_atom_e800787c:__wf_atom_ee502535(true)
				end
			else
				print("EnvSetup Error: " .. __wf_atom_2226b35c[i]:__wf_atom_5b41f63b() .. " was tagged as Light when it shouldn't be!")
				__wf_atom_2226b35c[i]:FirePort("TurnOff")
			end
		end
	end

	math.randomseed(v)
end

function CreateAreaMarker(p, p2, p3, p4)
	local entity = gRegion:CreateEntity(p, p2, __wf_atom_80368bb1)
	entity:__wf_atom_400189c4(p3)
	entity:__wf_atom_14f387e1(Range(p3, 5000))

	if not __wf_atom_7e8ad928(p4) then
		entity:__wf_atom_b811702e(p4)
	end

	return entity
end

function CreateAreaMarkerAroundEntities(p, list, p2, p3)
	if __wf_atom_7e8ad928(list) or #list == 0 then
		return
	end

	local v = Vector()

	for _, v2 in ipairs(list) do
		if not __wf_atom_7e8ad928(v2) then
			v += v2:GetPosition()
		end
	end

	local v2 = v / #list
	local v3 = __wf_atom_7e8ad928(p2) and 10 or p2
	local v4 = __wf_atom_7e8ad928(p3) and 5 or p3

	for _, v5 in ipairs(list) do
		local __wf_atom_d5fda8be = v5:__wf_atom_d5fda8be(v2)

		if v3 < __wf_atom_d5fda8be then
			v3 = __wf_atom_d5fda8be
		end
	end

	gRegion:__wf_atom_2202ffb6():__wf_atom_3c37bceb(v2, 30)
	__wf_atom_7e8ad928(v2)
	local v5 = v3 + v4
	local entity = gRegion:CreateEntity(p, v2, __wf_atom_80368bb1)
	entity:__wf_atom_400189c4(v5)
	entity:__wf_atom_14f387e1(Range(v5, 5000))
	entity:Enable()
	return entity
end

function UpdateAreaMarkerAroundEntities(object, list, p, p2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(list) or #list == 0 then
		return
	end

	local v = Vector()

	for i = #list, 1, -1 do
		if __wf_atom_7e8ad928(list[i]) then
			table.remove(list, i)
		else
			local isA = list[i]:IsA(__wf_atom_67c46eba)

			if isA and (not isA or list[i]:IsKilled()) then
				table.remove(list, i)
			else
				v += list[i]:GetPosition()
			end
		end
	end

	local v2 = v / #list

	if v2 == Vector() then
		return
	end

	local v3 = __wf_atom_7e8ad928(p) and 10 or p
	local v4 = __wf_atom_7e8ad928(p2) and 5 or p2

	for _, v5 in ipairs(list) do
		local __wf_atom_d5fda8be = v5:__wf_atom_d5fda8be(v2)

		if v3 < __wf_atom_d5fda8be then
			v3 = __wf_atom_d5fda8be
		end
	end

	gRegion:__wf_atom_2202ffb6():__wf_atom_3c37bceb(v2, 30)
	__wf_atom_7e8ad928(v2)
	local v5 = v3 + v4
	object:SetPosition(v2)
	object:__wf_atom_400189c4(v5)
	object:__wf_atom_14f387e1(Range(v5, 5000))
end

function FindTaggedInSameTile(object, object2)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(object)
	local result = {}
	local __wf_atom_e800787c = object2:__wf_atom_e800787c()

	if __wf_atom_7e8ad928(__wf_atom_e800787c) then
		print("Null zone for: " .. object2:__wf_atom_5b41f63b())
		return nil
	end

	local layerIndex = __wf_atom_e800787c:GetLayerIndex()
	print("Looking for " .. object:c_str() .. " in layer " .. layerIndex)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	for _, v in ipairs(__wf_atom_2226b35c) do
		local __wf_atom_e800787c2 = v:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c2) then
			print("Null zone for: " .. v:__wf_atom_5b41f63b())

			if __wf_atom_7d789620:__wf_atom_5e5adb53(v) + 1 == layerIndex then
				table.insert(result, v)
			end
		elseif __wf_atom_e800787c2:GetLayerIndex() == layerIndex then
			table.insert(result, v)
		else
			print("Layer for " .. v:__wf_atom_5b41f63b() .. ": " .. __wf_atom_e800787c2:GetLayerIndex())
		end
	end

	return result
end

function MergeAiSpecs(object)
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_1db08652 = gGameRules:__wf_atom_72fc675e():__wf_atom_1db08652()
	local v = 0

	if not __wf_atom_7e8ad928(object) then
		__wf_atom_1db08652 = object:__wf_atom_0958db03()
	end

	if __wf_atom_7e8ad928(__wf_atom_1db08652) or not (#__wf_atom_1db08652 > 0) then
		print("No extra AISpec found!")
		return
	end

	for i = 1, #__wf_atom_1db08652 do
		local v2 = __wf_atom_1db08652[i]
		local probability = v2.probability
		local agent = v2.agent
		local maxSimultaneous = v2.maxSimultaneous
		local tier = v2.tier
		local mergeSymbol = v2.mergeSymbol
		local v3 = Type(agent)

		if not __wf_atom_7e8ad928(v3) then
			__wf_atom_7d789620:__wf_atom_2b33739c(v3, probability, maxSimultaneous, tier, mergeSymbol)
		end

		if v < tier then
			v = tier
		end
	end
end

function HasExtraEnemyTier(p)
	local __wf_atom_1db08652 = gGameRules:__wf_atom_72fc675e():__wf_atom_1db08652()

	if not __wf_atom_7e8ad928(__wf_atom_1db08652) and #__wf_atom_1db08652 > 0 then
		for i = 1, #__wf_atom_1db08652 do
			if __wf_atom_1db08652[i].tier == p then
				return true
			end
		end
	end

	return false
end

function SoloRemoveEnemies(p, p2)
	local v = nil

	if not p then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			v = __wf_atom_c4f78a8f:__wf_atom_e800787c()
		end
	end

	local all = gRegion:FindAll(__wf_atom_9e85eea2)

	for _, v2 in ipairs(all) do
		local __wf_atom_e800787c = v2:__wf_atom_e800787c()

		if v2:__wf_atom_e93896ba() == Symbol("TENNO") or (v2:IsA(__wf_atom_f1872364) or v2:__wf_atom_464a4772()) then
			continue
		end

		if
			p
			or not __wf_atom_7e8ad928(__wf_atom_e800787c) and not __wf_atom_7e8ad928(v) and __wf_atom_e800787c == v
		then
			v2:Destroy()
		else
			local __wf_atom_30e3d82b = v2:__wf_atom_30e3d82b()

			if
				not p2
				or p2 and not (__wf_atom_7e8ad928(__wf_atom_30e3d82b) or __wf_atom_30e3d82b:__wf_atom_160c488b())
			then
				v2:Destroy()
			end
		end
	end
end

function PulseMarker(instance, p)
	if __wf_atom_7e8ad928(instance) or not instance:IsA(__wf_atom_17f001c3) then
		return
	end

	local __wf_atom_5028a4cd = instance:__wf_atom_5028a4cd()

	if __wf_atom_7e8ad928(p) then
		local HEX2RGB = module.HEX2RGB(__wf_atom_5028a4cd:__wf_atom_dcecedb0())
		p = Color(HEX2RGB.r * 0.3, HEX2RGB.g * 0.3, HEX2RGB.b * 0.3, 255)
	end

	instance:PulseColor(__wf_atom_5028a4cd, p)
end

function FormatTime(p, p2)
	local v = math.floor(p / 60)
	local v2 = math.floor(p % 60)
	local v3

	if v < 10 and p2 ~= true then
		v3 = tostring(0 .. v)
	else
		v3 = tostring(v)
	end

	local v4

	if v2 < 10 then
		v4 = tostring(0 .. v2)
	else
		v4 = tostring(v2)
	end

	return v3 .. ":" .. v4
end

MODE_START = 1
ROUND_STARTED = 2
ROUND_ENDED = 3
INTERMISSION = 4
MODE_FAILED = 5
MODE_COMPLETE = 6

function CreateModeMgr(onStateChangedCallback)
	return {
		OnStateChangedCallback = onStateChangedCallback,
		NV_MODE_STATE = Symbol("ModeState"),
		mAllowStateRestart = false,
		GetHumanReadableState = function(self, p)
			return (tostring(p))
		end,
		SetModeState = function(self, gModeMgrState)
			if not gRegion:IsMaster() then
				return
			end

			if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_589d05aa) then
				print("ModeMgr: Note: Net vars unsupported in this gameRules type, or gameRules is nil!")
				_T.gModeMgrState = gModeMgrState
			else
				local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(self.NV_MODE_STATE, 1)

				if gModeMgrState ~= __wf_atom_d163c8e5 then
					gGameRules:SetNetPersistentVar(self.NV_MODE_STATE, gModeMgrState)
				elseif self.mAllowStateRestart then
					print("ModeState = " .. self:GetHumanReadableState(__wf_atom_d163c8e5) .. ", restart")
					self.OnStateChangedCallback(__wf_atom_d163c8e5)
				end
			end
		end,
		GetModeState = function(self, p)
			if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_589d05aa) then
				if __wf_atom_7e8ad928(_T.gModeMgrState) then
					_T.gModeMgrState = 0
				end

				if _T.gModeMgrState ~= p then
					print("ModeState = " .. self:GetHumanReadableState(_T.gModeMgrState))
					self.OnStateChangedCallback(_T.gModeMgrState)
				end

				return _T.gModeMgrState
			else
				local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(self.NV_MODE_STATE, 1)

				if __wf_atom_d163c8e5 ~= p then
					print("ModeState = " .. self:GetHumanReadableState(__wf_atom_d163c8e5))
					self.OnStateChangedCallback(__wf_atom_d163c8e5)
				end

				return __wf_atom_d163c8e5
			end
		end,
		Clear = function(p)
			gGameRules:__wf_atom_0ab0a47f(p.NV_MODE_STATE)
		end
	}
end

function GenerateOrokinLockHints()
	if _T.OrokinLockPuzzle == nil or _T.OrokinLockPuzzle.Solution == nil then
		print("Attempting to generate orokin lock hints for unspecified solution!")
		return
	end

	local solution = _T.OrokinLockPuzzle.Solution
	local v = {}

	for i = 1, #solution - 1 do
		table.insert(v, {
			first = solution[i],
			second = solution[i + 1],
			isInvalid = false,
			index = i
		})
	end

	local symbolPairs = fn2(v)
	_T.OrokinLockPuzzle.SymbolPairs = symbolPairs
	return symbolPairs
end

local function fn5(object)
	local speakerName = _T.TaggedDialog.DebugMenu.speakerName
	local menuOptions = _T.TaggedDialog.DebugMenu.menuOptions
	local menuCallback = _T.TaggedDialog.DebugMenu.menuCallback
	local v = nil

	local function fn6(_, p)
		v = p
	end

	local v2 = {}

	for _, menuOption in ipairs(menuOptions) do
		local v3 = menuOption
		table.insert(v2, {
			mName = menuOption,
			func = function()
				return v3
			end
		})
	end

	table.insert(v2, {
		mName = "Cancel",
		func = function() end
	})

	if speakerName then
		object.mDefaultTitle = speakerName
	end

	object:__wf_atom_050e1ad5(v2, fn6, true)

	if v then
		menuCallback(v2[v.mIndex].mName)
	end

	local mScriptAction = object.mScriptAction

	if not __wf_atom_7e8ad928(mScriptAction) then
		mScriptAction:Destroy()
	end
end

local function fn6(menuOptions, menuCallback, speakerName)
	if _T.TaggedDialog == nil then
		_T.TaggedDialog = {}
	end

	_T.TaggedDialog.DebugMenu = {
		mName = "",
		mCallback = fn5,
		menuOptions = menuOptions,
		menuCallback = menuCallback,
		speakerName = speakerName
	}
	local v = WeakResource("/Lotus/Types/Gameplay/DebugMenuAction")
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	local entity = gRegion:CreateEntity(Type(v), __wf_atom_c4f78a8f:GetPosition(), __wf_atom_80368bb1)
	__wf_atom_c4f78a8f:__wf_atom_a1b79f95():ExecuteAction(entity)
end

function ShowDebugMenu(menuOptions, menuCallback, speakerName)
	fn6(menuOptions, menuCallback, speakerName)
end

function StateSelect(items, menuCallback)
	local menuOptions = {}

	for k, item in pairs(items) do
		menuOptions[item] = k
	end

	fn6(menuOptions, menuCallback, "Choose a state")
end

function GoToCheckpoint(p, list)
	local respawnPt = nil

	for i = 1, p do
		if list[i].respawnPt then
			respawnPt = list[i].respawnPt
		end
	end

	if respawnPt then
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(respawnPt)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			gRegion:__wf_atom_c4f78a8f():Teleport(
				__wf_atom_0a6a5887:GetPosition(),
				__wf_atom_0a6a5887:__wf_atom_dc309f8a()
			)
		end
	end
end