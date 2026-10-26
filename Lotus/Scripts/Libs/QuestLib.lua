module(..., package.seeall)
local module = require("Lotus.Interface.LotusUtilities")

local function fn(p)
	local __wf_atom_fe84572e = gGameData:GetInventory():__wf_atom_fe84572e()

	for i = 1, #__wf_atom_fe84572e do
		local v = __wf_atom_fe84572e[i]

		if not __wf_atom_7e8ad928(v) and v.mItemType == p then
			return true
		end
	end

	return false
end

local function fn2(object)
	if __wf_atom_7e8ad928(gGameData) or __wf_atom_7e8ad928(gGameData:GetInventory()) then
		return nil
	end

	local __wf_atom_fe84572e = gGameData:GetInventory():__wf_atom_fe84572e()

	for _, v in ipairs(__wf_atom_fe84572e) do
		if v.mItemType == object then
			return v
		end
	end

	return nil
end

local function fn3(items, object)
	if not items then
		return ""
	end

	local v = fn2(object)

	if not v then
		print("Failed to find item for key " .. object:__wf_atom_5b41f63b())
		return ""
	end

	local decoded = cjson.decode(v.mCustomData) or {}

	for k, item in pairs(items) do
		decoded[k] = item
	end

	return cjson.encode(decoded)
end

function HasQuest(p)
	return (fn(p))
end

function Start(mItemType, p)
	local v = fn(mItemType)

	if v and not p then
		return
	end

	local reward = SF.Reward()
	reward.mRewardType = 0
	reward.mProductCategory = 21
	reward.mItemType = mItemType
	local flag = false
	local v2 = false
	local v3 = false
	local v4 = 5
	local total = 0

	local function fn4(p2, _)
		if p2 then
			v2 = true
		else
			v3 = true
		end
	end

	if not v then
		gGameData:__wf_atom_d2d692f8(reward, fn4)

		while not v2 do
			Sleep(0)
			total += __wf_atom_084b3e93()

			if not flag and total > 1 then
				_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
				flag = true
			end

			if not (v3 and v4 < total) then
				continue
			end

			v3 = false
			print("Retrying give quest...")
			gGameData:__wf_atom_d2d692f8(reward, fn4)
			v4 = math.min(v4 * 2, 60)
			total = 0
		end
	end

	v2 = false
	v3 = false
	gGameData:__wf_atom_a818d8af(mItemType, fn4)
	local total2 = 0
	local v5 = 5

	while not v2 do
		Sleep(0)
		total2 += __wf_atom_084b3e93()

		if not flag and total2 > 1 then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
			flag = true
		end

		if not (v3 and v5 < total2) then
			continue
		end

		v3 = false
		print("Retrying set active quest...")
		gGameData:__wf_atom_a818d8af(mItemType, fn4)
		v5 = math.min(v5 * 2, 60)
		total2 = 0
	end

	if flag then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end
end

function CompleteStage(p, p2, p3)
	if gGameData:GetInventory():GetActiveQuest() ~= p then
		return
	end

	local flag = false
	local v = false
	local v2 = false

	local function fn4(p4, _)
		if p4 then
			v = true
		else
			v2 = true
		end
	end

	gGameData:CompleteQuestStage(p2, fn4, 1, fn3(p3, p))
	local total = 0
	local v3 = 5

	while not v do
		Sleep(0)
		total += __wf_atom_084b3e93()

		if not flag and total > 1 then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
			flag = true
		end

		if not v2 or not (v3 < total) or __wf_atom_7e8ad928(gGameData) then
			continue
		end

		v2 = false
		print("Retrying CompleteStage.")
		gGameData:CompleteQuestStage(p2, fn4, 1, fn3(p3, p))
		v3 = math.min(v3 * 2, 60)
		total = 0
	end

	if flag then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end

	module.UpdateQuests(true)
end

function GiveTriggeredItems(object, p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	if gGameData:__wf_atom_c94f8724(object, p) then
		print("Already received items for " .. object:__wf_atom_5b41f63b() .. " at stage " .. p)
		return
	end

	local v = false
	local flag = false

	local function fn4(p2, _)
		v = true

		if p2 then
			flag = true
		else
			flag = false
		end
	end

	local count = 0

	while not flag and count < 5 do
		if __wf_atom_7e8ad928(gGameData) then
			return
		end

		gGameData:GiveTriggeredItemsForQuestKeyChain(Resource(object), p, fn4)
		count += 1

		while not v do
			Sleep(0)
		end

		v = false
		Sleep(0)
	end

	if flag then
		print("Received items for " .. object:__wf_atom_5b41f63b() .. " at stage " .. p)
	else
		print("Failed giving triggered items for " .. object:__wf_atom_5b41f63b() .. " at stage " .. p .. " after " .. count .. " tries.")
	end
end

function GiveTriggeredMessage(p, p2)
	if __wf_atom_7e8ad928(gGameData) or gGameData:__wf_atom_939c7133(p, p2 + 1) then
		return
	end

	local v = false
	local v2 = false

	local function fn4(p3, p4)
		if p3 then
			v = true
			return
		end

		v2 = true
		print("Failed to give mail: " .. p4)
	end

	gGameData:__wf_atom_190d2ecb(p, p2 + 1, fn4)
	local flag = false
	local total = 0
	local v3 = 5

	while not v do
		Sleep(0)
		total += __wf_atom_084b3e93()

		if not flag and total > 1 then
			_T.BackgroundMovie:Execute("ShowBlockingMessage", "1")
			flag = true
		end

		if not (v2 and v3 < total) then
			continue
		end

		v2 = false
		print("Retrying GiveMail.")
		gGameData:__wf_atom_190d2ecb(p, p2 + 1, fn4)
		v3 = math.min(v3 * 2, 60)
		total = 0
	end

	if flag then
		_T.BackgroundMovie:Execute("ShowBlockingMessage", "0")
	end
end

local function fn4(p)
	if __wf_atom_7e8ad928(gGameData) then
		return -1
	end

	local inventory = gGameData:GetInventory()

	if __wf_atom_7e8ad928(inventory) then
		return -1
	end

	local __wf_atom_fe84572e = inventory:__wf_atom_fe84572e()

	for i = 1, #__wf_atom_fe84572e do
		if __wf_atom_7e8ad928(__wf_atom_fe84572e[i]) or p ~= __wf_atom_fe84572e[i].mItemType then
			continue
		end

		local mProgress = __wf_atom_fe84572e[i].mProgress
		local v = not (#mProgress > 0) and -1 or mProgress[1].mCompletion

		for j, v2 in ipairs(mProgress) do
			if v2.mCompletion < v or v2.mCompletion == -1 then
				return j - 1
			end
		end

		return #mProgress
	end

	return -1
end

function GetNumQuestStagesComplete(p)
	return (fn4(p))
end

function IsBoonKdriveStore()
	local v = fn4(WeakResource("/Lotus/Types/Keys/YareliQuest/YareliQuestKeyChain"))
	return v >= 1 and v < 8
end

local function fn5(p)
	if __wf_atom_7e8ad928(gGameData) then
		return
	end

	local __wf_atom_fe84572e = gGameData:GetInventory():__wf_atom_fe84572e()

	for i = 1, #__wf_atom_fe84572e do
		if __wf_atom_fe84572e[i].mItemType == p then
			return __wf_atom_fe84572e[i].mCompleted
		end
	end
end

function HasCompletedQuest(p)
	return fn5(p)
end

function IsQuestReplay(p)
	return fn5(p)
end

local function fn6(p)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:Disable()

	if p == Symbol("CrewshipLoadout") then
		_T.RailjackLoadout_Enabling = nil
	elseif p == Symbol("CustomizeDrifter") then
		local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("DrifterDeco"))

		if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
			__wf_atom_0a6a5887_2:FirePort("Hide")
		end
	end

	if __wf_atom_0a6a5887:IsA(__wf_atom_6e0c84cf) then
		local __wf_atom_10aa6d9d = __wf_atom_0a6a5887:__wf_atom_10aa6d9d()

		if not __wf_atom_7e8ad928(__wf_atom_10aa6d9d) then
			__wf_atom_10aa6d9d:Close()
		end

		__wf_atom_0a6a5887:__wf_atom_2dc6c98a(false)
	end
end

function DisableUIConsoles(list)
	while _T.InitializedUiTriggers == false do
		Sleep(0)
	end

	for _, v in ipairs(list) do
		fn6(v)
	end

	module.UpdateUIConsoleTriggers(true)
end

function EnableUIConsole(p, p2)
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(p)

	if __wf_atom_7e8ad928(__wf_atom_0a6a5887) then
		return
	end

	__wf_atom_0a6a5887:Enable()

	if p2 then
		__wf_atom_0a6a5887:__wf_atom_2dc6c98a(true)
	end
end

function GenerateCustomDataString(p, p2)
	return fn3(p, p2)
end

function GetCustomData(object)
	local v = fn2(object)

	if v then
		return cjson.decode(v.mCustomData)
	end

	print("Failed to find item for key " .. object:__wf_atom_5b41f63b())
end