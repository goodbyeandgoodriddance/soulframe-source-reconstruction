module(..., package.seeall)
local module = require("Lotus.Interface.LotusUtilities")
local module2 = require("Lotus.Interface.UIStyleUtilities")
local module3 = require("EE.Interface.Utilities")
local v = Symbol("MidrathDensityVolume")
local v2 = Symbol("StreamTrigger")
local v3 = nil
local v4 = nil
local v5 = Symbol("Neutral")

function Round(p, value)
	local v6 = 10 ^ (value or 0)
	return math.floor(p * v6 + 0.5) / v6
end

function RandomRound(p, p2)
	local v6 = p2 or p % 1

	if v6 > 0 and math.random() <= v6 then
		return (math.ceil(p))
	end

	return (math.floor(p))
end

function Distance2d(p, p2)
	return Distance(Vector(p.x, 0, p.z), Vector(p2.x, 0, p2.z))
end

function Distance2DSqr(p, p2)
	return __wf_atom_a93b9922(Vector(p.x, 0, p.z), Vector(p2.x, 0, p2.z))
end

function LengthSqr(data)
	return data.x * data.x + data.y * data.y + data.z * data.z
end

function NearestObject(p, list, p2, p3, p4)
	local v6 = 3.4028234663852886e38
	local v7 = nil
	local v8 = nil

	for i = 1, #list do
		if __wf_atom_7e8ad928(list[i]) then
			continue
		end

		local v9

		if p3 then
			v9 = list[i]:__wf_atom_a5304c35(p)
		else
			v9 = list[i]:__wf_atom_d5fda8be(p)
		end

		if not (v9 < v6 and (__wf_atom_7e8ad928(p2) or p2 == 0 or v9 <= p2)) then
			continue
		end

		v8 = list[i]
		v7 = i
		v6 = v9
	end

	if p4 then
		return v7
	end

	return v8
end

function NearestPositionToObject(object, list, p, p2, p3)
	local v6 = 3.4028234663852886e38
	local v7 = nil
	local v8 = nil

	for i = 1, #list do
		local v9

		if p2 then
			v9 = object:__wf_atom_a5304c35(list[i])
		else
			v9 = object:__wf_atom_d5fda8be(list[i])
		end

		if not (v9 < v6 and (__wf_atom_7e8ad928(p) or p == 0 or v9 <= p)) then
			continue
		end

		v8 = list[i]
		v7 = i
		v6 = v9
	end

	if p3 then
		return v7
	end

	return v8
end

function NearestPosition(p, list, p2, p3, p4)
	local v6 = 3.4028234663852886e38
	local v7 = nil
	local v8 = nil

	for i = 1, #list do
		local v9

		if p3 then
			v9 = Distance2d(p, list[i])
		else
			v9 = Distance(p, list[i])
		end

		if not (v9 < v6 and (__wf_atom_7e8ad928(p2) or p2 == 0 or v9 <= p2)) then
			continue
		end

		v8 = list[i]
		v7 = i
		v6 = v9
	end

	if p4 then
		return v7
	end

	return v8
end

function SortByDistance(list, p, p2)
	table.sort(list, function(a, b)
		if __wf_atom_7e8ad928(a) or __wf_atom_7e8ad928(b) then
			return false
		end

		if p2 then
			return a:__wf_atom_d5fda8be(p) > b:__wf_atom_d5fda8be(p)
		end

		return a:__wf_atom_d5fda8be(p) < b:__wf_atom_d5fda8be(p)
	end)
	return list
end

function SortPositionsByDistance(list, p, p2)
	table.sort(list, function(a, b)
		if __wf_atom_7e8ad928(a) or __wf_atom_7e8ad928(b) then
			return false
		end

		if p2 then
			return Distance(a, p) > Distance(b, p)
		end

		return Distance(a, p) < Distance(b, p)
	end)
	return list
end

local function fn(object, p)
	local __wf_atom_80cf57aa = object:__wf_atom_80cf57aa()
	local __wf_atom_a06d543c = object:__wf_atom_a06d543c()
	local __wf_atom_acb19668 = object:__wf_atom_acb19668()
	local v6 = __wf_atom_edfe0d73(__wf_atom_a06d543c, __wf_atom_acb19668) * (__wf_atom_8d119bab(
		-__wf_atom_80cf57aa.x,
		__wf_atom_80cf57aa.x
	) * 0.5) + __wf_atom_acb19668 * (__wf_atom_8d119bab(-__wf_atom_80cf57aa.y, __wf_atom_80cf57aa.y) * 0.5) + __wf_atom_a06d543c * (__wf_atom_8d119bab(
		-__wf_atom_80cf57aa.z,
		__wf_atom_80cf57aa.z
	) * 0.5)

	if p then
		v6.y = 0
	end

	return object:GetPosition() + v6
end

local function fn2(object)
	local v6 = math.random() * 2 * 3.141592653589793
	local v7 = object:__wf_atom_4e28532a() * math.sqrt((math.random()))
	local v8 = Vector(v7 * math.cos(v6), 0, v7 * math.sin(v6))
	return object:GetPosition() + v8
end

local function fn3(object) -- 1 equivalent call inferred from this helper
	local v6 = Vector()
	__wf_atom_23c6d7dc(v6)
	return object:GetPosition() + v6 * object:__wf_atom_4e28532a()
end

function GetRandomPointInVolume(object, p)
	if object:__wf_atom_bbcb227c() or object:__wf_atom_642b7ae0() then
		if p then
			return (fn2(object))
		end

		return fn3(object) -- inferred equivalent call
	elseif object:__wf_atom_fdefab34() then
		return (fn(object, p))
	end
end

function GetAveragePosition(list, p)
	local v6 = Vector()

	for _, v7 in ipairs(list) do
		v6 += v7:GetPosition()
	end

	local v7 = v6 / #list

	if p then
		return (gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(v7, 100, 100))
	end

	return v7
end

function GetRandomPointInRange(p, p2, p3)
	local v6 = math.random() * 2 * 3.141592653589793
	local v7 = __wf_atom_104bfe98(p2, p3, (math.sqrt((math.random()))))
	return p + Vector(v7 * math.cos(v6), 0, v7 * math.sin(v6))
end

function TryGetNavmeshPosition(p)
	__wf_atom_7e8ad928(_T.mWorldPosition)

	if gRegion:Raycast(p + Vector(0, 1, 0), p + Vector(0, -3, 0), nil, nil, Vector()) then
		return p
	end

	return (gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_0e0a6fee(_T.mWorldPosition, 30, 50))
end

function CopyTable(p)
	return module3.CopyTable(p)
end

function MergeTables(list, list2, p)
	local result = list or {}

	if p then
		for _, v6 in ipairs(list) do
			for i = #list2, 1, -1 do
				if list2[i] == v6 then
					table.remove(list2, i)
				end
			end
		end
	end

	for i = 1, #list2 do
		table.insert(result, list2[i])
	end

	return result
end

function RandomizeTableOrder(p)
	return module3.ShuffleTable(p)
end

function ReverseTableOrder(list)
	local result = {}

	for i = #list, 1, -1 do
		table.insert(result, list[i])
	end

	return result
end

function FindTypeInTable(items, className)
	for _, item in pairs(items) do
		if item:IsA(className) then
			return item
		end
	end

	return nil
end

function PickEntriesFromTable(list, p)
	local v6 = math.min(#list, p)
	local result = {}

	while #result < v6 do
		local v7 = __wf_atom_5784a397(1, #list)
		table.insert(result, list[v7])
		table.remove(list, v7)
	end

	return result
end

function TableContains(p, p2)
	return module3.IsValueInTable(p, p2)
end

function TableGetIndex(list, p)
	for i, v6 in ipairs(list) do
		if v6 == p then
			return i
		end
	end

	return nil
end

function RemoveDuplicatesFromTable(list)
	local result = {}

	for _, v6 in ipairs(list) do
		local v7 = false

		for _, v8 in ipairs(result) do
			if v6 ~= v8 then
				continue
			end

			v7 = true
			break
		end

		if not v7 then
			table.insert(result, v6)
		end
	end

	return result
end

function RemoveFromTable(p, list)
	if __wf_atom_7e8ad928(list) or __wf_atom_7e8ad928(p) then
		return
	end

	local v6 = false

	for i = #list, 1, -1 do
		if list[i] ~= p then
			continue
		end

		table.remove(list, i)
		v6 = true
	end

	return v6
end

function IsInTable(p, items)
	if not __wf_atom_7e8ad928(items) then
		for _, item in pairs(items) do
			if item == p then
				return true
			end
		end
	end

	return false
end

function AddUniqueToTable(p, list)
	if __wf_atom_7e8ad928(list) or IsInTable(p, list) then
		return false
	end

	table.insert(list, p)
	return true
end

function CountTableItems(items)
	local count = 0

	if not __wf_atom_7e8ad928(items) then
		for _, _ in pairs(items) do
			count += 1
		end
	end

	return count
end

function RemoveNilEntries(list)
	if __wf_atom_7e8ad928(list) then
		return
	end

	local result = {}

	for _, v6 in ipairs(list) do
		if not __wf_atom_7e8ad928(v6) then
			table.insert(result, v6)
		end
	end

	return result
end

function FindTaggedChild(list, tag)
	for _, v6 in ipairs(list) do
		if not __wf_atom_7e8ad928(v6) and v6:HasTag(tag) then
			return v6
		end
	end
end

function FindTaggedChildren(list, tag)
	local result = {}

	for _, v6 in ipairs(list) do
		if __wf_atom_7e8ad928(v6) or not v6:HasTag(tag) then
			continue
		end

		table.insert(result, v6)
	end

	return result
end

function hideBones(object, list)
	for _, v6 in ipairs(list) do
		object:__wf_atom_83fac646(v6, __wf_atom_80368bb1, __wf_atom_28d5d4aa, Vector(0.001, 0.001, 0.001))
	end
end

function RemoveAttachments(object, p)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) then
		return
	end

	local __wf_atom_f582136d = object:__wf_atom_f582136d(p)

	for _, v6 in ipairs(__wf_atom_f582136d) do
		v6:Destroy()
	end
end

function TaggedFirePorts(p, p2)
	if __wf_atom_7e8ad928(p) or p == EMPTY_SYMBOL then
		print("Nil or empty tag symbol!")
		return
	end

	if __wf_atom_7e8ad928(p2) or p2 == "" then
		print("Port is nil!")
		return
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	for _, v6 in ipairs(__wf_atom_2226b35c) do
		if v6:IsA(__wf_atom_7e616794) then
			v6:FirePort(p2)
		end
	end
end

function Fade(p, value, value2, p2)
	local v6 = value or 0.5
	local v7 = value2 or 1

	if v6 > 0 then
		local v8 = 1 / v6

		if p then
			gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(v7, v8)
		else
			gRegion:__wf_atom_8ad59546():__wf_atom_f92e3acc(0, v8)
		end
	elseif p then
		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(v7)
	else
		gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(0)
	end

	if p2 then
		Sleep(v6)
	end
end

function HasFragment(p)
	local v6

	if not (__wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameData:GetInventory())) then
		v6 = gGameData:GetInventory():__wf_atom_0dec86a1()
	end

	for _, v7 in ipairs(v6) do
		if p == v7.mItemType then
			return true
		end
	end

	return false
end

function HasSpecificLoreMemoryUnlocked(object, p, p2)
	if not (__wf_atom_7e8ad928(object) or object:IsKilled()) then
		local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) and __wf_atom_d2b2176d:__wf_atom_705a2744(p, p2) then
			return true
		end
	end

	return false
end

function GiveLoreFragment(object, p, p2)
	if
		__wf_atom_7e8ad928(object)
		or __wf_atom_7e8ad928(p)
		or object:__wf_atom_631bafa1() and not (__wf_atom_a0f6588f:__wf_atom_f89aa44a() and gGameData)
	then
		return
	end

	object:GiveLoreFragment(p)

	if p2 then
		gGameRules:CommitInventoryCheckpointToDB(0, 0)
	end
end

function GiveLoreFragmentMemory(object, p, p2, p3)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(p2) then
		return
	end

	if object:__wf_atom_631bafa1() and not (__wf_atom_a0f6588f:__wf_atom_f89aa44a() and gGameData) then
		return
	end

	object:GiveLoreFragmentMemory(p, p2)

	if p3 then
		gGameRules:CommitInventoryCheckpointToDB(0, 0)
	end
end

function AnyPlayerHasItem(p)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for i = 1, #__wf_atom_ef7900cf do
		if __wf_atom_ef7900cf[i]:HasItem(p) then
			return true
		end

		if not __wf_atom_ef7900cf[i]:__wf_atom_631bafa1() or __wf_atom_7e8ad928(gGameData) then
			continue
		end

		local inventory = gGameData:GetInventory()

		if
			not __wf_atom_7e8ad928(inventory) and inventory:__wf_atom_e3bbb1ae(p)
			or inventory:__wf_atom_94318d43(p)
			or inventory:OwnsItem(p)
		then
			return true
		end
	end

	return false
end

function DestroyObjectList(list, p)
	for _, v6 in ipairs(list) do
		if __wf_atom_7e8ad928(v6) then
			continue
		end

		if not p then
			v6:Destroy()
		end

		if not __wf_atom_7e8ad928(v6) then
			gRegion:__wf_atom_dd1e4d10(v6)
		end
	end
end

function StartPluginScripts(list, object)
	local result = {}

	if #list > 0 and not __wf_atom_7e8ad928(object) then
		for i = 1, #list do
			if __wf_atom_7e8ad928(list[i]) then
				continue
			end

			local v6 = object:Attach(list[i], EMPTY_SYMBOL)
			object:__wf_atom_d494454b(v6)
			v6:FirePort("Execute")
			table.insert(result, v6)
		end
	end

	return result
end

function StartRandomPluginScript(list, object)
	if #list > 0 and not __wf_atom_7e8ad928(object) then
		local v6 = object:Attach(list[__wf_atom_5784a397(1, #list)], EMPTY_SYMBOL)
		object:__wf_atom_d494454b(v6)
		v6:FirePort("Execute")
	end

	return {}
end

local function fn4(object) -- 2 equivalent calls inferred from this helper
	if __wf_atom_7e8ad928(object) then
		return false
	end

	return object:__wf_atom_799d95f5()
end

local function fn5(p)
	local __wf_atom_b2b2c625 = gRegion:__wf_atom_b2b2c625()

	for _, v6 in ipairs(__wf_atom_b2b2c625) do
		if string.find(tostring(v6), p) then
			return true
		end
	end

	return false
end

local function fn6(p)
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_d2b2176d = __wf_atom_c4f78a8f:__wf_atom_d2b2176d()
		local __wf_atom_28224c27 = __wf_atom_d2b2176d:__wf_atom_28224c27(5)
		__wf_atom_d2b2176d:__wf_atom_c8700ab5(p)

		if not __wf_atom_7e8ad928(__wf_atom_28224c27) then
			__wf_atom_28224c27:__wf_atom_cfecab5d(not p)
		end
	end
end

local function fn7()
	local v6 = Symbol("Spawn")
	local v7 = Symbol("Exit")
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("ExitTrigger"))
	local v8 = nil
	local v9 = nil

	for _, v10 in ipairs(__wf_atom_2226b35c) do
		local __wf_atom_e800787c = v10:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) then
			continue
		end

		if __wf_atom_e800787c:__wf_atom_db682341() == v7 then
			v8 = v10
		elseif __wf_atom_e800787c:__wf_atom_db682341() == v6 then
			v9 = v10
		end
	end

	if __wf_atom_7e8ad928(v8) then
		return v9
	end

	return v8
end

function IsInNightFold(p)
	return fn4(p)
end

function HasStreamedLevel(p)
	return (fn5(p))
end

function IsInOverworld()
	return (fn5("/SF/Levels/MidrathRedux/Scope"))
end

function WaitToExitNightfold(p)
	while true do
		local flag = true
		local v6

		if p then
			v6 = gRegion:__wf_atom_ef7900cf()
		else
			v6 = { gRegion:GetPlayerAvatar() }
		end

		for _, v7 in ipairs(v6) do
			if not fn4(v7) then -- inferred equivalent call
				continue
			end

			flag = false
			break
		end

		if flag then
			break
		else
			Sleep(0)
		end
	end
end

function WaitToEnterNightfold()
	local playerAvatar = gRegion:GetPlayerAvatar()

	while true do
		if fn4(playerAvatar) then -- inferred equivalent call
			break
		end

		Sleep(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			playerAvatar = gRegion:GetPlayerAvatar()
		end
	end
end

function IsInMultiplayerSession()
	return not __wf_atom_7e8ad928(gMatchingService) and gMatchingService:__wf_atom_8b3e33a6() > 1
end

function IsStreamingLevel()
	return _T.isStreamingLevel
		or __wf_atom_7e8ad928(gClient)
		or gClient:IsLoading()
		or gClient:IsStreamingLevel()
		or not gClient:__wf_atom_2ad290b4()
		or Game.__wf_atom_2b221245()
		or gRegion:__wf_atom_83b2f434()
end

function WaitForLevel()
	while __wf_atom_7e8ad928(gGameRules) do
		Sleep(0)
	end

	while IsStreamingLevel() do
		Sleep(0)
	end

	while gRegion:IsMaster() and not _T.ProcLevelSetupDone do
		Sleep(0)
	end
end

function WaitForPlayer()
	while __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f()) do
		Sleep(0)
	end
end

function WaitForLoginSequence()
	local v6 = false

	while __wf_atom_7e8ad928(gRegion:__wf_atom_c4f78a8f()) do
		Sleep(0)
	end

	while not _G.LoginSequencePlayed do
		Sleep(0)
		v6 = true
	end

	return v6
end

function WaitForAiDir()
	if not gRegion:IsMaster() then
		print("WARNING: Attempted to wait for AI Director on Client. Nothing to wait for.")
		return nil
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	if fn5("/SF/Levels/MidrathRedux/Scope") then
		while not (__wf_atom_7d789620:IsEnabled() and __wf_atom_7d789620:__wf_atom_5e711c72()) do
			Sleep(0)
		end
	else
		while not (__wf_atom_7d789620:IsEnabled() or __wf_atom_7d789620:__wf_atom_5e711c72()) do
			Sleep(0)
		end
	end

	while not __wf_atom_7d789620:__wf_atom_d0c59e69() do
		Sleep(0)
	end

	return __wf_atom_7d789620
end

function EnableLevelExit()
	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local v6 = fn7()

	if not __wf_atom_7e8ad928(v6) then
		gRegion:FindNearestTagged(Symbol("WarpPoint"), v6:GetPosition()):Enable()
		__wf_atom_7d789620:__wf_atom_5e16fe4a(v6)
	end

	__wf_atom_7d789620:__wf_atom_0089d40e(true)
	print("Level exit enabled")
end

local function fn8(object) -- 3 equivalent calls inferred from this helper
	local __wf_atom_e800787c = object:__wf_atom_e800787c()
	local v6

	if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
		return (__wf_atom_e800787c:GetLayerIndex())
	end

	return v6
end

function GetLayerIndex(object)
	return fn8(object) -- inferred equivalent call
end

function FilterObjectsInLayerIndex(p, list)
	if __wf_atom_7e8ad928(p) then
		return
	end

	for i = #list, 1, -1 do
		if fn8(list[i]) ~= p then -- inferred equivalent call
			table.remove(list, i)
		end
	end

	return list
end

function FilterObjectsInZone(p, list)
	if __wf_atom_7e8ad928(p) then
		return
	end

	for i = #list, 1, -1 do
		if list[i]:__wf_atom_e800787c() ~= p then
			table.remove(list, i)
		end
	end

	return list
end

function FilterObjectsMinMaxLayerIndex(p, p2, list)
	for i = #list, 1, -1 do
		local v6 = fn8(list[i]) -- inferred equivalent call

		if not (__wf_atom_7e8ad928(v6) or not __wf_atom_7e8ad928(p) and v6 < p or not __wf_atom_7e8ad928(p2) and p2 < v6) then
			continue
		end

		table.remove(list, i)
	end

	return list
end

function GetFirstIndexForTileType(p)
	local all = gRegion:FindAll(__wf_atom_e1d1671b)
	local v6 = 0

	for _, v7 in ipairs(all) do
		local __wf_atom_e800787c = v7:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) or __wf_atom_e800787c:__wf_atom_db682341() ~= p then
			continue
		end

		local layerIndex = __wf_atom_e800787c:GetLayerIndex()

		if v6 == 0 or layerIndex < v6 then
			v6 = layerIndex
		end
	end

	return v6
end

local function fn9(p, p2)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	for i = #__wf_atom_2226b35c, 1, -1 do
		local __wf_atom_e800787c = __wf_atom_2226b35c[i]:__wf_atom_e800787c()

		if __wf_atom_7e8ad928(__wf_atom_e800787c) or __wf_atom_e800787c:__wf_atom_db682341() ~= p2 then
			table.remove(__wf_atom_2226b35c, i)
		end
	end

	return __wf_atom_2226b35c
end

function FindTaggedInTileType(p, p2)
	return (fn9(p, p2))
end

function IsIntileIndex(object, p)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_e800787c = object:__wf_atom_e800787c()

		if not __wf_atom_7e8ad928(__wf_atom_e800787c) and __wf_atom_e800787c:GetLayerIndex() == p then
			return true
		end
	end

	return false
end

function GetNearestStreamTrigger(p)
	local nearestTagged = gRegion:FindNearestTagged(v2, p)

	if __wf_atom_7e8ad928(nearestTagged) or not (nearestTagged:__wf_atom_a5304c35(p) <= 60) then
		return nil
	end

	return nearestTagged
end

function GetProcLevelForStreamingTunnel(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)
	local v6 = GetNearestStreamTrigger(__wf_atom_0a6a5887:GetPosition())

	if __wf_atom_7e8ad928(v6) then
		return nil
	end

	return v6:__wf_atom_d7947b11()
end

LEVEL_PRIORITY = { NONE = 1, WORLD = 2, DYNAMIC = 3, QUEST = 4 }

local function fn10(p, p2, p3)
	local v6 = p3 or LEVEL_PRIORITY.NONE
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(p)

	for _, v7 in ipairs(__wf_atom_2226b35c) do
		local v8 = GetNearestStreamTrigger(v7:GetPosition())

		if __wf_atom_7e8ad928(v8) then
			continue
		end

		local __wf_atom_e919fb8e = v8:__wf_atom_e919fb8e()

		if not __wf_atom_e919fb8e.streamTriggerProcLevel then
			__wf_atom_e919fb8e.streamTriggerProcLevel = {}
		end

		__wf_atom_e919fb8e.streamTriggerProcLevel[v6] = p2
		local v9 = 0
		local v10 = nil

		for k, v11 in pairs(__wf_atom_e919fb8e.streamTriggerProcLevel) do
			if not (v9 < k and v11) then
				continue
			end

			v10 = v11
			v9 = k
		end

		v8:__wf_atom_e36d377e(v10)
	end
end

function SetProcLevelForStreamingTunnel(p, p2, p3)
	fn10(p, p2, p3)
end

function SetQuestProcLevel(p, p2)
	fn10(p, p2, LEVEL_PRIORITY.QUEST)
end

function GetExitTrigger()
	return (fn7())
end

function GetEntranceWaypoint()
	return gRegion:__wf_atom_0a6a5887(Symbol("LevelEntranceWp"))
end

function GetExitWaypoint()
	return gRegion:__wf_atom_0a6a5887(Symbol("LevelExitWp"))
end

function GetStreamingExitWaypoint()
	local v6 = fn9(Symbol("StreamingDungeonExitWp"), Symbol("Exit"))

	if __wf_atom_7e8ad928(v6) or not (#v6 > 0) then
		return
	else
		return v6[1]
	end
end

local function fn11(__wf_atom_b2b2c625)
	local v6 = CopyTable(__wf_atom_b2b2c625)

	for i = #v6, 1, -1 do
		local v7 = tostring(v6[i])

		if v7 == "/SF/Levels/Tent/Scope" then
			table.remove(v6, i)
		elseif string.find(v7, "Skybox") or string.find(v7, "SkyBox") or string.find(v7, "skybox") then
			table.remove(v6, i)
		end
	end

	return v6
end

function GetTilesetName(p)
	if fn5("/SF/Levels/MidrathRedux/Scope") then
		return
	end

	local v6 = fn11(gRegion:__wf_atom_b2b2c625())[__wf_atom_7e8ad928(p) and 1 or p]
	local v7 = {}

	for k in string.gmatch(tostring(v6), "[^/]+") do
		table.insert(v7, k)
	end

	for k, v8 in pairs(v7) do
		if v8 == "Procs" then
			return v7[k + 1]
		end
	end

	return nil
end

function GetTileName(p)
	if fn5("/SF/Levels/MidrathRedux/Scope") or __wf_atom_7e8ad928(p) then
		return
	end

	local v6 = fn11(gRegion:__wf_atom_b2b2c625())[p]
	local v7 = {}

	for k in string.gmatch(tostring(v6), "[^/]+") do
		table.insert(v7, k)
	end

	for k, v8 in pairs(v7) do
		if v8 == "Scope" then
			return v7[k - 1]
		end
	end

	return nil
end

function GetBiomeIdFromDensityVolume(p)
	if __wf_atom_7e8ad928(v3) then
		v3 = gRegion:__wf_atom_0a6a5887(v)
	end

	if __wf_atom_7e8ad928(v3) then
		return 0
	end

	return v3:GetColor(p, true).green
end

function GetRegionIdFromDensityVolume(p)
	if __wf_atom_7e8ad928(v3) then
		v3 = gRegion:__wf_atom_0a6a5887(v)
	end

	if __wf_atom_7e8ad928(v3) then
		return 0
	end

	return v3:GetColor(p, true).blue
end

function PauseOverworldResourceSpawning()
	if __wf_atom_7e8ad928(_T.OverworldResourceSpawningPaused) then
		_T.OverworldResourceSpawningPaused = 0
	end

	_T.OverworldResourceSpawningPaused = math.max(0, _T.OverworldResourceSpawningPaused + 1)
	print("DBG: OverworldResourceSpawningPaused " .. _T.OverworldResourceSpawningPaused)
end

function ResumeOverworldResourceSpawning()
	if __wf_atom_7e8ad928(_T.OverworldResourceSpawningPaused) then
		_T.OverworldResourceSpawningPaused = 0
	end

	_T.OverworldResourceSpawningPaused = math.max(0, _T.OverworldResourceSpawningPaused - 1)
	print("DBG: OverworldResourceSpawningPaused " .. _T.OverworldResourceSpawningPaused)
end

function IsOverworldResourceSpawningPaused()
	return not __wf_atom_7e8ad928(_T.OverworldResourceSpawningPaused) and _T.OverworldResourceSpawningPaused > 0
end

function AddStreamedLevelOffSetVector(data)
	local __wf_atom_7d5c620f = gRegion:__wf_atom_eab484a7():__wf_atom_7d5c620f()
	return (Vector(data.x - 250 * __wf_atom_7d5c620f, data.y, data.z - 250 * __wf_atom_7d5c620f))
end

function StreamInLevelRegion(level, p, p2, streamingLayer, isAutonomous, p3)
	if p ~= nil or HasStreamedLevel((tostring(level))) then
		return
	end

	if streamingLayer < 255 or streamingLayer > 511 then
		print("WARNING: StreamingLayerIdx is out of range, level will not be streamed in")
		return
	end

	local __wf_atom_7d5c620f = gRegion:__wf_atom_eab484a7():__wf_atom_7d5c620f()
	print("I'm streaming into new level now. My playerId is", __wf_atom_7d5c620f)
	local levelArgs = Engine.OpenLevelArgs()
	levelArgs.level = level
	levelArgs.streamingLayer = streamingLayer
	levelArgs.streamingMode = 1

	if p3 then
		levelArgs:__wf_atom_c4be912d(p3)
	end

	levelArgs:__wf_atom_60471db9(p2, __wf_atom_80368bb1)
	levelArgs.streamingPriority = 2
	levelArgs.isAutonomous = isAutonomous
	Engine.StreamRegion(levelArgs)
	return true
end

function StreamOutLevelRegion(streamingLayer)
	if streamingLayer < 255 or streamingLayer > 511 then
		print("WARNING: StreamingLayerIdx is out of range, level will not be streamed in")
		return
	end

	local levelArgs = Engine.OpenLevelArgs()
	levelArgs.streamingLayer = streamingLayer
	Engine.__wf_atom_94cafc05(levelArgs)
end

function CreateRandomEntitiesAtWaypoints(list, p, object)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(p, object:GetPosition(), 0, 40)

	if not (#__wf_atom_439c0d29 > 0 and #list > 0) then
		return
	end

	local v6 = #list
	local result = {}

	for _, v7 in ipairs(__wf_atom_439c0d29) do
		if __wf_atom_7e8ad928(v7) then
			continue
		end

		local v8 = list[__wf_atom_5784a397(1, v6)]
		table.insert(result, (gRegion:CreateEntity(v8, v7:GetPosition(), v7:__wf_atom_dc309f8a())))
	end

	return result
end

function Deflect(object, p)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_9c4e6f99)
	local v6 = {}
	local total = 0

	if __wf_atom_7e8ad928(p) then
		p = 0.1
	end

	while __wf_atom_7e8ad928(__wf_atom_bb3e7833) and #v6 == 0 and total < p do
		__wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_9c4e6f99)

		if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

			for _, v7 in pairs(__wf_atom_be0bea4a) do
				local __wf_atom_bb3e7833_2 = v7:__wf_atom_bb3e7833(__wf_atom_9c4e6f99)

				if __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
					continue
				end

				__wf_atom_bb3e7833 = __wf_atom_bb3e7833_2
				break
			end
		end

		v6 = object:__wf_atom_f582136d(__wf_atom_baf9587d)

		if #v6 == 0 then
			local __wf_atom_be0bea4a = object:__wf_atom_be0bea4a()

			for _, _ in pairs(__wf_atom_be0bea4a) do
				local __wf_atom_f582136d = object:__wf_atom_f582136d(__wf_atom_baf9587d)

				if not (#__wf_atom_f582136d > 0) then
					continue
				end

				for i = 1, #v6 do
					table.insert(__wf_atom_f582136d, v6[i])
				end
			end
		else
			for k, v7 in pairs(v6) do
				if v7:IsA(__wf_atom_9c4e6f99) then
					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
						table.remove(v6, k)
						__wf_atom_bb3e7833 = v7
					end
				else
					v7:Die()
				end
			end
		end

		Sleep(0)
		total += __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		local __wf_atom_9f2332e5 = __wf_atom_bb3e7833:__wf_atom_9f2332e5()
		local v7

		if not __wf_atom_7e8ad928(__wf_atom_9f2332e5) then
			v7 = __wf_atom_9f2332e5:__wf_atom_6009c8ed() or nil
		end

		local v8

		if not __wf_atom_7e8ad928(v7) then
			v8 = v7:__wf_atom_a96eb2aa() or nil
		end

		if not __wf_atom_7e8ad928(v8) and v8:IsLocal() then
			__wf_atom_bb3e7833:__wf_atom_696c19a3(__wf_atom_28d5d4aa)
		end
	end
end

function SetReviveShrinePreference(reviveShrinePreference, p)
	local reviveShrinePreference2 = _T.ReviveShrinePreference

	if __wf_atom_7e8ad928(reviveShrinePreference) then
		_T.ReviveShrinePreference = nil
		_T.ReviveShrinePreferenceIsImperative = false
	elseif reviveShrinePreference ~= reviveShrinePreference2 then
		_T.ReviveShrinePreference = reviveShrinePreference

		if p then
			_T.ReviveShrinePreferenceIsImperative = true
		else
			_T.ReviveShrinePreferenceIsImperative = false
		end
	end
end

function GetReviveShrinePreference()
	return _T.ReviveShrinePreference
end

function IsReviveShrineImperative()
	return _T.ReviveShrinePreferenceIsImperative
end

function GetProcPortals(p)
	local all = gRegion:FindAll(__wf_atom_f51baf83)
	local v6 = Vector(0, 3, 0)
	local result = {}

	for _, door in ipairs(all) do
		local position = door:GetPosition()
		local __wf_atom_a06d543c = door:__wf_atom_a06d543c()
		local v7 = position + v6 + __wf_atom_a06d543c * 5
		local v8 = position + v6 - __wf_atom_a06d543c * 5
		local __wf_atom_ec87469e = gRegion:__wf_atom_ec87469e(v7)
		local __wf_atom_ec87469e2 = gRegion:__wf_atom_ec87469e(v8)
		local startTag = nil
		local layerIndex = nil
		local layerIndex2, endTag

		if not __wf_atom_7e8ad928(__wf_atom_ec87469e) then
			endTag = __wf_atom_ec87469e:__wf_atom_db682341()

			if not __wf_atom_7e8ad928(__wf_atom_ec87469e) then
				layerIndex2 = __wf_atom_ec87469e:GetLayerIndex()
			end
		end

		if not __wf_atom_7e8ad928(__wf_atom_ec87469e2) then
			startTag = __wf_atom_ec87469e2:__wf_atom_db682341()

			if not __wf_atom_7e8ad928(__wf_atom_ec87469e2) then
				layerIndex = __wf_atom_ec87469e2:GetLayerIndex()
			end
		end

		table.insert(result, {
			door = door,
			startId = layerIndex,
			endId = layerIndex2,
			startTag = startTag,
			endTag = endTag
		})
	end

	for i = #result, 1, -1 do
		if not (__wf_atom_7e8ad928(result[i].startId) or __wf_atom_7e8ad928(result[i].endId) or result[i].startId == result[i].endId or not (TableContains(p, result[i].startId) or TableContains(p, result[i].endId))) then
			continue
		end

		table.remove(result, i)
	end

	return result
end

local function fn12(id, items)
	local v6 = nil
	local v7 = Symbol("Dead-End")
	local v8 = Symbol("Spawn")

	if __wf_atom_7e8ad928(v4) then
		v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local position = GetEntranceWaypoint():GetPosition()
	local position2 = GetStreamingExitWaypoint():GetPosition()

	local function fn13(p) -- 3 equivalent calls inferred from this helper
		return not __wf_atom_7e8ad928(p) and p ~= 3.4028234663852886e38
	end

	if not fn13(v4:__wf_atom_57856d42(position, position2)) then -- inferred equivalent call
		print("Nav pathing problem between proc entrance and exit! Environment puzzle script early out due to not able path.")
		return nil
	end

	local v9 = {}
	local v10 = { id = id, deadends = {} }

	for _, item in pairs(items) do
		if item.startId == id or item.endId == id then
			table.insert(v9, item)
		end
	end

	for i = #v9, 1, -1 do
		if v9[i].startTag == v7 or v9[i].endTag == v7 then
			table.insert(v10.deadends, v9[i])
			table.remove(v9, i)
		elseif v9[i].startTag == v8 or v9[i].endTag == v8 then
			v10.entrance = v9[i]
			table.remove(v9, i)
		end
	end

	if __wf_atom_7e8ad928(v10.entrance) then
		local v11 = 3.4028234663852886e38
		local entrance = nil
		local v12 = nil

		for k, v13 in pairs(v9) do
			local position3 = v13.door:GetPosition()
			local __wf_atom_57856d42 = v4:__wf_atom_57856d42(position3, position)

			if not fn13(__wf_atom_57856d42) then -- inferred equivalent call
				print("Nav pathing problem! Script can not path from tile index " .. tostring(v13.startId) .. " or " .. tostring(v13.endId) .. " to spawn tile.")
				table.remove(v9, k)
			end

			if not (__wf_atom_57856d42 > 0 and __wf_atom_57856d42 < v11) then
				continue
			end

			v12 = k
			entrance = v13
			v11 = __wf_atom_57856d42
		end

		if not (__wf_atom_7e8ad928(entrance) or __wf_atom_7e8ad928(v12)) then
			v10.entrance = entrance
			table.remove(v9, v12)
		end
	end

	if __wf_atom_7e8ad928(v10.exit) then
		local v11 = 3.4028234663852886e38
		local exit = nil
		local v12 = nil

		for k, v13 in pairs(v9) do
			local position3 = v13.door:GetPosition()
			local __wf_atom_57856d42 = v4:__wf_atom_57856d42(position3, position2)

			if not fn13(__wf_atom_57856d42) then -- inferred equivalent call
				print("Nav pathing problem! Script can not path from tile index " .. tostring(v13.startId) .. " or " .. tostring(v13.endId) .. " to exit tile.")
				table.remove(v9, k)
			end

			if not (__wf_atom_57856d42 > 0 and __wf_atom_57856d42 < v11) then
				continue
			end

			v12 = k
			exit = v13
			v11 = __wf_atom_57856d42
		end

		if not (__wf_atom_7e8ad928(exit) or __wf_atom_7e8ad928(v12)) then
			v10.exit = exit
			table.remove(v9, v12)
		end
	end

	if not __wf_atom_7e8ad928(v10.entrance) and not __wf_atom_7e8ad928(v10.exit) then
		return v10
	end

	return v6
end

function SortPortalsInZoneByAccessType(id)
	return (fn12(id, GetProcPortals({ id })))
end

function SortPortalsInMultipleZonesByAccessType(list)
	local v6 = GetProcPortals(list)
	local result = {}

	for _, v7 in ipairs(list) do
		local v8 = fn12(v7, v6)

		if not __wf_atom_7e8ad928(v8) then
			table.insert(result, v8)
		end
	end

	return result
end

function GetTileEntrance(p)
	local v6 = SortPortalsInZoneByAccessType(p)
	local v7

	if not (__wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(v6.entrance) or __wf_atom_7e8ad928(v6.entrance.door)) then
		return v6.entrance.door
	end

	return v7
end

function GetTileEntrancePosition(p)
	local v6 = GetTileEntrance(p)
	local v7

	if not __wf_atom_7e8ad928(v6) then
		return (v6:GetPosition())
	end

	return v7
end

function GetTileExit(p)
	local v6 = SortPortalsInZoneByAccessType(p)
	local v7

	if not (__wf_atom_7e8ad928(v6) or __wf_atom_7e8ad928(v6.exit) or __wf_atom_7e8ad928(v6.exit.door)) then
		return v6.exit.door
	end

	return v7
end

function GetTileExitPosition(p)
	local v6 = GetTileExit(p)
	local v7

	if not __wf_atom_7e8ad928(v6) then
		return (v6:GetPosition())
	end

	return v7
end

function GetDynamicSky()
	local all = gRegion:FindAll(__wf_atom_4d4372ee)

	for _, v6 in ipairs(all) do
		if v6:__wf_atom_1d13ef4d() then
			return v6
		end
	end
end

function GetAndEnableMainDynamicSky()
	local all = gRegion:FindAll(__wf_atom_4d4372ee)
	local v6 = nil

	for _, v7 in ipairs(all) do
		if v7:__wf_atom_1d13ef4d() then
			v6 = v7
		else
			v7:Enable(false)
		end
	end

	if not (__wf_atom_7e8ad928(v6) or v6:IsEnabled()) then
		v6:Enable(true)
	end

	return v6
end

function ModifySky(total, p, p2, p3, p4, p5, p6)
	local v6 = __wf_atom_7e8ad928(p4) and 3 or p4
	local v7 = p6 or Symbol("OvercastSky")
	local v8 = Symbol("DefaultMainSky")
	local all = gRegion:FindAll(__wf_atom_4d4372ee)
	local postProcess = gRegion:__wf_atom_8ad59546().postProcess
	local v9 = nil

	for _, v10 in ipairs(all) do
		if v10:__wf_atom_db682341() == v7 and p then
			v9 = v10
		elseif v10:__wf_atom_db682341() == v8 and not p then
			v9 = v10
		else
			v10:Enable(false)
			v10:__wf_atom_e2779837(false)
		end
	end

	if not __wf_atom_7e8ad928(v9) then
		v9:Enable(true)
		v9:__wf_atom_e2779837(true)

		if p2 then
			local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()

			if total < __wf_atom_cb3427c9 then
				total += 24
			end

			v9:SetTimeOfDay(__wf_atom_cb3427c9)
			local v10 = 1

			while v10 > 0 and not __wf_atom_7e8ad928(v9) do
				v10 = math.max(0, v10 - __wf_atom_084b3e93() / v6)
				local v11 = __wf_atom_24a82b69(v10)
				v9:SetTimeOfDay((__wf_atom_104bfe98(__wf_atom_cb3427c9, total, 1 - v11)))

				if p3 then
					postProcess:__wf_atom_54a04966(v11 * 10)
					postProcess:__wf_atom_f846a58a(__wf_atom_104bfe98(1, 3, v11))
				end

				if p5 then
					_T.SpellFX = 1 - v10
				end

				Sleep(0)
			end
		else
			v9:SetTimeOfDay(total)
		end
	end
end

function IsNight()
	local v6 = Range(22, 24)
	local v7 = Range(0, 6)
	local __wf_atom_cb3427c9 = gRegion:__wf_atom_8ad59546():__wf_atom_cb3427c9()
	return v6:Contains(__wf_atom_cb3427c9) or v7:Contains(__wf_atom_cb3427c9)
end

local function fn13(object, p)
	if _T.devSkipCinematics then
		print("Early out of _WaitForCinematicToFinish, devSkipCinematics enabled")
		return true
	end

	print("Waiting for cinematic to start...")

	while not (__wf_atom_7e8ad928(object) or object:__wf_atom_7d4910e4() or object:__wf_atom_e9546dc6()) do
		Sleep(0)
	end

	print("Cinematic started, waiting for it to end... ")

	while not __wf_atom_7e8ad928(object) and object:__wf_atom_7d4910e4() and not object:__wf_atom_e9546dc6() do
		if not __wf_atom_7e8ad928(p) and object:__wf_atom_a5549761(true) < p then
			return true
		end

		Sleep(0)
	end

	print("Cinematic ended")
end

local function fn14(currentCin, p, instance, p2)
	if _T.devSkipCinematics then
		print("Early out of _PlayCinematicAndWait, devSkipCinematics enabled")
		return true
	end

	if not __wf_atom_7e8ad928(currentCin) then
		_T.CurrentCin = currentCin

		if p then
			fn6(false)
		end

		local position = currentCin:GetPosition()
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("DroptablePickup"), position, 0, 50)

		for _, v6 in ipairs(__wf_atom_439c0d29) do
			v6:SetVisibility(false, true)
		end

		if
			currentCin:IsA(__wf_atom_804af126)
			and not __wf_atom_7e8ad928(instance)
			and instance:IsA(__wf_atom_7e6ed5fa)
		then
			currentCin:SetInstigatorAvatar(instance)
		end

		currentCin:FirePort("StartPlaying")
		fn13(currentCin, p2)
		local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(Symbol("DroptablePickup"), position, 0, 50)

		for _, v6 in ipairs(__wf_atom_439c0d29_2) do
			v6:SetVisibility(true, true)
		end

		if p then
			fn6(true)
		end

		if not __wf_atom_7e8ad928(currentCin) then
			print("Cinematic completed")
			return true
		end
	end

	print("Cinematic failed to complete!")
	return false
end

local function fn15(currentCin, p, p2, p3, p4)
	if _T.devSkipCinematics then
		print("Early out of _PlayCinematicRelativeToPlayerAndWait, devSkipCinematics enabled")
		return true
	end

	if not __wf_atom_7e8ad928(currentCin) then
		_T.CurrentCin = currentCin
		local position = currentCin:GetPosition()
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("DeathCabbage"), position, 0, 50)

		for _, v6 in ipairs(__wf_atom_439c0d29) do
			v6:Destroy()
		end

		local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(Symbol("DroptablePickup"), position, 0, 50)

		for _, v6 in ipairs(__wf_atom_439c0d29_2) do
			v6:Destroy()
		end

		currentCin:__wf_atom_8f4c0eeb(p, p2, p3, p4)
		currentCin:FirePort("StartPlayingRelative")
		fn13(currentCin, 0)

		if not __wf_atom_7e8ad928(currentCin) then
			print("Cinematic completed")
			return true
		end
	end

	print("Cinematic failed to complete!")
	return false
end

function WaitForCinematicToFinish(p, p2)
	fn13(p, p2)
end

function PlayCinematicAndWait(currentCin, p, p2, p3)
	return (fn14(currentCin, p, p2, p3))
end

function PlayCinematicWithTagAndWait(p, p2, p3, p4)
	if __wf_atom_7e8ad928(p) or p == EMPTY_SYMBOL then
		print("PlayCinematicWithTagAndWait: Invalid cinematic tag")
	else
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			return (fn14(__wf_atom_0a6a5887, p2, p3, p4))
		end

		print("Cinematic tagged " .. tostring(p) .. " not found!")
	end

	return false
end

function PlayCinematicWithTagRelativeAndWait(p, p2, p3, p4, p5)
	if __wf_atom_7e8ad928(p) or p == EMPTY_SYMBOL then
		print("PlayCinematicWithTagAndWait: Invalid cinematic tag")
	else
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			return (fn15(__wf_atom_0a6a5887, p2, p3, p4, p5))
		end

		print("Cinematic tagged " .. tostring(p) .. " not found!")
	end

	return false
end

function WaitForCinematicWithTagToFinish(p, p2)
	if __wf_atom_7e8ad928(p) or p == EMPTY_SYMBOL then
		print("WaitForCinematicWithTagToFinish: Invalid cinematic tag")
	else
		local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

		if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
			print("Cinematic tagged " .. tostring(p) .. " not found!")
		else
			fn13(__wf_atom_0a6a5887, p2)
			return true
		end
	end

	return false
end

function StreamAndPlayCinematicLevel(p, p2, p3, value, value2)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local v6 = Resource("/SF/Types/Input/CinematicInputFilter")
	local v7 = value or 0
	local v8 = value2 or 0
	_T.StoryLib_PlayingCin = true
	local currentBackgroundInfo = module2.GetCurrentBackgroundInfo()

	if not __wf_atom_7e8ad928(_T.HideBackground) then
		_T.HideBackground()
	end

	_T.QuestStartCinPlaying = true
	local movie = __wf_atom_8e4fda44:FindMovie(module3.GetChatMovie())
	local v9 = not __wf_atom_7e8ad928(movie) and movie:IsVisible()
	local v10 = {
		WeakResource("/Lotus/Interface/ChatRedux.swf"),
		WeakResource("/Lotus/Interface/Notifications.swf"),
		WeakResource("/SF/Interface/GenericNotification.swf"),
		WeakResource("/Lotus/Interface/ThemedSquadOverlay.swf")
	}

	for _, v11 in ipairs(v10) do
		local movie2 = __wf_atom_8e4fda44:FindMovie(v11)

		if not __wf_atom_7e8ad928(movie2) then
			movie2:SetVisible(false)
		end
	end

	if _T.StoryLib_MoviesToAlpha ~= nil then
		for _, v11 in ipairs(_T.StoryLib_MoviesToAlpha) do
			local movie2 = __wf_atom_8e4fda44:FindMovie(v11)

			if not __wf_atom_7e8ad928(movie2) then
				movie2:__wf_atom_e57658c2("_root", 12, 0)
			end
		end
	end

	__wf_atom_8e4fda44:__wf_atom_06b56505(0)

	if not (p3 or __wf_atom_7e8ad928(_T.DisableUIInput)) then
		_T.DisableUIInput()
	end

	if not __wf_atom_7e8ad928(v6) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:__wf_atom_aeb02c14(v6)
		end
	end

	_T.BlockAmbientTransmissions = true
	local module4 = require("Lotus.Interface.Libs.DioramaLoader")
	local dioramaLoader = module4.CreateDioramaLoader(_T.BackgroundMovie)
	dioramaLoader:LoadDiorama(p)

	if dioramaLoader:IsLoading() then
		if v7 ~= 0 then
			dioramaLoader:SetFadeParams(v7, 0, v8)
			gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(v7)
		end

		if p2 and not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "2")
		end

		while not dioramaLoader:LoadingComplete() do
			Sleep(0)
		end

		if p2 and not __wf_atom_7e8ad928(_T.BackgroundMovie) then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
		end

		dioramaLoader:FinishLoad()

		if not _T.StoryLib_SkipClearFade then
			gRegion:__wf_atom_8ad59546():__wf_atom_47f0b80b(0)
		end

		local __wf_atom_c3b255b8 = __wf_atom_392793db:__wf_atom_c3b255b8()

		while
			not __wf_atom_7e8ad928(__wf_atom_c3b255b8)
			and __wf_atom_c3b255b8:__wf_atom_7d4910e4()
			and _T.QuestStartCinPlaying
			or _T.StoryLib_HoldBackgroundRegion
		do
			Sleep(0)

			if not __wf_atom_7e8ad928(movie) then
				movie:SetVisible(false)
			end

			if not _T.StoryLib_BlockTransmissions or __wf_atom_7e8ad928(_T.curTransmission) then
				continue
			end

			module.ClearTransmissionQueue()
			module.InterruptTransmission()
		end

		__wf_atom_8e4fda44:__wf_atom_62a19abc()
	end

	Fade(true, 0, 1)
	Fade(false, 1, 0)
	__wf_atom_8e4fda44:__wf_atom_06b56505(1)

	for _, v11 in ipairs(v10) do
		local movie2 = __wf_atom_8e4fda44:FindMovie(v11)

		if not __wf_atom_7e8ad928(movie2) then
			movie2:SetVisible(true)
		end
	end

	if not __wf_atom_7e8ad928(movie) then
		movie:SetVisible(v9)
	end

	if _T.StoryLib_MoviesToAlpha ~= nil then
		for _, v11 in ipairs(_T.StoryLib_MoviesToAlpha) do
			local movie2 = __wf_atom_8e4fda44:FindMovie(v11)

			if not __wf_atom_7e8ad928(movie2) then
				movie2:__wf_atom_e57658c2("_root", 12, 100)
			end
		end

		_T.StoryLib_MoviesToAlpha = nil
	end

	if not __wf_atom_7e8ad928(v6) then
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

		if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
			__wf_atom_c4f78a8f:__wf_atom_cf966a74(v6)
		end
	end

	if currentBackgroundInfo.Visible and not __wf_atom_7e8ad928(_T.ShowBackground) then
		_T.ShowBackground(
			0,
			currentBackgroundInfo.HighlightOffset,
			currentBackgroundInfo.HighlightOn,
			currentBackgroundInfo.VisRangeInfo
		)
	end

	_T.StoryLib_BlockTransmissions = nil
	_T.StoryLib_PlayingCin = false
end

function SetMeleeEnabled(p)
	fn6(p)
end

function RelativeTeleport(object, object2, list)
	local position = object:GetPosition()
	local __wf_atom_dc309f8a = object:__wf_atom_dc309f8a()
	local position2 = object2:GetPosition()
	local __wf_atom_dc309f8a2 = object2:__wf_atom_dc309f8a()

	for _, v6 in ipairs(list) do
		local v7 = position - v6:GetPosition()
		local v8 = __wf_atom_dc309f8a - __wf_atom_dc309f8a2
		local v9 = position2 + __wf_atom_9341614d(v7, v8)
		local v10 = __wf_atom_dc309f8a + v8
		v6:__wf_atom_f0f9fb38(v6:__wf_atom_4e50d390() + v8)
		v6:Teleport(v9, v10)
	end
end

function SetCustomLockOnSettings(object, p, p2, value, value2)
	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_92aa9d91 = object:__wf_atom_92aa9d91()

		if p == 0 then
			__wf_atom_92aa9d91:__wf_atom_5b5911cb(Resource(__wf_atom_92aa9d91:__wf_atom_1bb5b1ff()):__wf_atom_ab10ec5a())
			return
		end

		if p2 == 0 then
			__wf_atom_92aa9d91:__wf_atom_35df58c3(0)
		end

		__wf_atom_92aa9d91:__wf_atom_5b5911cb(p)
		__wf_atom_92aa9d91:__wf_atom_35df58c3(p2, value or 0, value2 or 0)
	end
end

function RestoreEnergy()
	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if not __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		local __wf_atom_e55d02aa = __wf_atom_c4f78a8f:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			for i = 0, 2 do
				__wf_atom_e55d02aa:__wf_atom_19516b62(100, i)
			end
		end
	end
end

function AnyPlayerNearPos(p, p2, _)
	if __wf_atom_7e8ad928(v4) then
		v4 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	return #v4:__wf_atom_3fe13ea3(p, p2) > 0
end

function AnyPlayerInTrigger(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v6 in ipairs(__wf_atom_ef7900cf) do
		if not __wf_atom_7e8ad928(v6) and not v6:IsKilled() and object:__wf_atom_4b409d7b(v6) then
			return true
		end
	end

	return false
end

function SetImmunity(object, p)
	local v6 = Symbol("InvulSymbol")

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_7470861b = object:__wf_atom_7470861b()

		if not __wf_atom_7e8ad928(__wf_atom_7470861b) then
			if p == true then
				__wf_atom_7470861b:__wf_atom_9fba31e6(v6, 26, 6, 0)
			else
				__wf_atom_7470861b:__wf_atom_63396172(v6)
			end
		end
	end
end

function IsInvulnerable(object)
	local v6 = Symbol("InvulSymbol")

	if not __wf_atom_7e8ad928(object) then
		local __wf_atom_7470861b = object:__wf_atom_7470861b()

		if not __wf_atom_7e8ad928(__wf_atom_7470861b) and __wf_atom_7470861b:IsA(__wf_atom_205d3f84) then
			return __wf_atom_7470861b:__wf_atom_c7742567(v6)
		end
	end

	return false
end

function GiveXpToPlayer(p, instance)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_7e6ed5fa) and not instance:IsKilled() then
		local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()

		if not __wf_atom_7e8ad928(__wf_atom_d2b2176d) then
			__wf_atom_d2b2176d:__wf_atom_355b9a20(p, instance, EMPTY_SYMBOL)
		end
	end
end

function GiveXpToPlayersInRadius(p, p2, p3)
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()

	for _, v6 in pairs(__wf_atom_ef7900cf) do
		if v6:IsKilled() then
			continue
		end

		local __wf_atom_d2b2176d = v6:__wf_atom_d2b2176d()

		if __wf_atom_7e8ad928(__wf_atom_d2b2176d) or not (v6:__wf_atom_a5304c35(p2) <= p3) then
			continue
		end

		__wf_atom_d2b2176d:__wf_atom_355b9a20(p, v6, EMPTY_SYMBOL)
	end
end

function IsSoulModeActive(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	return object:__wf_atom_92aa9d91():__wf_atom_3911136e() or _T.ForceSoulMode
end

function UnequipWeapon(object, p)
	if __wf_atom_7e8ad928(object) or not (gRegion:IsMaster() or object:__wf_atom_4417a5d4()) then
		return
	end

	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if p then
		__wf_atom_d2b2176d:Unequip(0, 2)
		return
	end

	__wf_atom_d2b2176d:Unequip(0, 0)

	while not __wf_atom_7e8ad928(object) and not object:IsKilled() and __wf_atom_d2b2176d:__wf_atom_aba9c26e(0) ~= 14 do
		Sleep(0)
	end
end

function AttunateFovOverTime(object, p, p2)
	local v6 = 0

	while v6 < p do
		v6 = __wf_atom_421b01aa(v6 + __wf_atom_084b3e93(), 0, p)
		object:__wf_atom_25382a0d((__wf_atom_104bfe98(1, p2, __wf_atom_24a82b69(v6 / p))))
		Sleep(0)
	end
end

function DeactivateAbilities(p, p2, p3)
	if not (p3 or gRegion:IsMaster()) then
		return
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v6 in __wf_atom_3c8e1a7a do
		if __wf_atom_7e8ad928(v6) then
			continue
		end

		local playerAvatar = v6:GetPlayerAvatar(0)
		local v7

		if not __wf_atom_7e8ad928(playerAvatar) then
			v7 = playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()
		end

		if not __wf_atom_7e8ad928(v7) then
			v7:__wf_atom_2ffcdee6()
		end

		if not (p2 and gRegion:IsMaster()) then
			continue
		end

		local __wf_atom_d9286ba5 = v6:__wf_atom_d9286ba5()

		for _, v8 in __wf_atom_d9286ba5 do
			if not __wf_atom_7e8ad928(v8) then
				v8:Suicide()
			end
		end
	end

	if p then
		for _, v6 in __wf_atom_3c8e1a7a do
			if __wf_atom_7e8ad928(v6) then
				continue
			end

			local __wf_atom_e55d02aa = v6:GetPlayerAvatar(0):__wf_atom_d2b2176d():__wf_atom_e55d02aa()

			while not __wf_atom_7e8ad928(__wf_atom_e55d02aa) and __wf_atom_e55d02aa:__wf_atom_8db03a52() do
				Sleep(0)
			end
		end
	end
end

function BlockAbilities(p, p2)
	if not (p2 or gRegion:IsMaster()) then
		return
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v6 in __wf_atom_3c8e1a7a do
		if __wf_atom_7e8ad928(v6) then
			continue
		end

		local playerAvatar = v6:GetPlayerAvatar(0)

		if __wf_atom_7e8ad928(playerAvatar) then
			continue
		end

		local __wf_atom_e55d02aa = playerAvatar:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

		if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
			__wf_atom_e55d02aa:__wf_atom_c62d97c1(p, {})
		end
	end
end

function DespawnPlayerSummons()
	if not gRegion:IsMaster() then
		return
	end

	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v6 in __wf_atom_3c8e1a7a do
		if __wf_atom_7e8ad928(v6) then
			continue
		end

		local __wf_atom_d9286ba5 = v6:__wf_atom_d9286ba5()

		for _, v7 in __wf_atom_d9286ba5 do
			if not __wf_atom_7e8ad928(v7) then
				v7:Suicide()
			end
		end
	end
end

function PlayerIsInBattle(p)
	if _T.disableNightfoldCombatCheck ~= nil or __wf_atom_7e8ad928(p) then
		return false
	end

	local all = gRegion:FindAll(__wf_atom_9e85eea2)

	for i = 1, #all do
		if
			not all[i]:IsKilled()
			and all[i]:__wf_atom_e93896ba() ~= v5
			and not all[i]:__wf_atom_129d1aba(p)
			and (all[i]:__wf_atom_464a4772() and all[i]:__wf_atom_8a6b8fc3(p) < 50 or all[i]:__wf_atom_3a6b0cbb() and all[i]:__wf_atom_8a6b8fc3(p) < 30)
		then
			return true
		end
	end

	return false
end

function RegisterDisableEnemyLootDrops(p)
	if __wf_atom_7e8ad928(_T.EnemyLootDropsDisabled) then
		_T.EnemyLootDropsDisabled = 0
	end

	_T.EnemyLootDropsDisabled = math.max(0, _T.EnemyLootDropsDisabled + (p and 1 or -1))
	gGameRules:__wf_atom_0daba688(_T.EnemyLootDropsDisabled == 0)
end

INVALID = 0

function CreateModeMgr(onStateChangedCallback)
	return {
		OnStateChangedCallback = onStateChangedCallback,
		NV_MODE_STATE = Symbol("ModeState"),
		mAllowStateRestart = false,
		mState = INVALID,
		mRestartState = false,
		GetHumanReadableState = function(self, p)
			return (tostring(p))
		end,
		SetModeState = function(state, gModeMgrState)
			if not gRegion:IsMaster() then
				return
			end

			if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_589d05aa) then
				print("ModeMgr: Note: Net vars unsupported in this gameRules type, or gameRules is nil!")
				_T.gModeMgrState = gModeMgrState
			elseif gModeMgrState ~= state.mState then
				gGameRules:SetNetPersistentVar(state.NV_MODE_STATE, gModeMgrState)
			elseif state.mAllowStateRestart then
				state.mRestartState = true
			end
		end,
		GetModeState = function(p)
			if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_589d05aa) then
				return _T.gModeMgrState or INVALID
			end

			return p.mState
		end,
		Update = function(self, p)
			if p then
				if __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_589d05aa) then
					if _T.gModeMgrState then
						for i = INVALID + 1, _T.gModeMgrState do
							self.OnStateChangedCallback(i, true, i ~= _T.gModeMgrState)
						end
					end
				else
					local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(self.NV_MODE_STATE, INVALID)

					for i = INVALID + 1, __wf_atom_d163c8e5 do
						self.mState = i
						print("ModeState = " .. self:GetHumanReadableState(i))
						self.OnStateChangedCallback(i, true, i ~= __wf_atom_d163c8e5)
					end

					self.mRestartState = false
				end
			elseif __wf_atom_7e8ad928(gGameRules) or not gGameRules:IsA(__wf_atom_589d05aa) then
				if _T.gModeMgrState and _T.gModeMgrState ~= self.mState then
					self.OnStateChangedCallback(_T.gModeMgrState)
				end
			else
				local __wf_atom_d163c8e5 = gGameRules:__wf_atom_d163c8e5(self.NV_MODE_STATE, INVALID)

				if self.mState == __wf_atom_d163c8e5 then
					if self.mRestartState then
						print("ModeState = " .. self:GetHumanReadableState(__wf_atom_d163c8e5) .. ", restart")
						self.OnStateChangedCallback(self.mState)
						self.mRestartState = false
					end
				else
					self.mState = __wf_atom_d163c8e5
					print("ModeState = " .. self:GetHumanReadableState(self.mState))
					self.OnStateChangedCallback(self.mState)
				end
			end
		end,
		Clear = function(p)
			gGameRules:__wf_atom_0ab0a47f(p.NV_MODE_STATE)
		end
	}
end

function GetRandomDebugDrawColor()
	local v6 = __wf_atom_5784a397(1, 3)

	if v6 == 1 then
		return (Color(255, __wf_atom_5784a397(128, 255), __wf_atom_5784a397(0, 255)))
	elseif v6 == 2 then
		return (Color(__wf_atom_5784a397(0, 255), 255, __wf_atom_5784a397(128, 255)))
	end

	return (Color(__wf_atom_5784a397(128, 255), __wf_atom_5784a397(0, 255), 255))
end

function HideTutorialMessage()
	if __wf_atom_7e8ad928(_T.CurrentTutorialMessage) then
		return
	end

	Sleep(0.3)
	_T.CurrentTutorialMessage = nil
	_T.HideImpactMessage()
	Sleep(0.3)
end

function ShowTutorialMessage(currentTutorialMessage)
	if not __wf_atom_7e8ad928(_T.CurrentTutorialMessage) then
		if _T.CurrentTutorialMessage == currentTutorialMessage then
			return
		else
			HideTutorialMessage()
		end
	end

	_T.CurrentTutorialMessage = currentTutorialMessage
	_T.ShowImpactMessage(currentTutorialMessage, -1)
end

function CanShowMessage(object, p, p2, p3)
	if
		__wf_atom_7e8ad928(object)
		or object:IsKilled()
		or not __wf_atom_7e8ad928(p2) and p3 < object:__wf_atom_8a6b8fc3(p2)
	then
		return false
	end

	if not IsInOverworld() then
		return false
	end

	if p or not IsInNightFold(object) then
		return true
	end

	return false
end