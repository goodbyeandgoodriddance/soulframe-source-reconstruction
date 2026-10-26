module(..., package.seeall)
local v = nil
local v2 = nil
local v3 = nil
local v4 = {}
local v5 = 0
PRIORITY = {
	CRITICAL = 600,
	QUEST = 600,
	TALE = 500,
	HIGH = 400,
	EXIT = 300,
	MEDIUM = 200,
	LOW = 100
}
local v6 = {
	[PRIORITY.CRITICAL] = "CRITICAL",
	[PRIORITY.QUEST] = "QUEST",
	[PRIORITY.TALE] = "TALE",
	[PRIORITY.HIGH] = "HIGH",
	[PRIORITY.EXIT] = "EXIT",
	[PRIORITY.MEDIUM] = "MEDIUM",
	[PRIORITY.LOW] = "LOW"
}
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
require("EE.Interface.Utilities")

local function fn(className)
	if __wf_atom_7e8ad928(gGameData) then
		return nil
	end

	local questController = gGameRules:GetQuestController()

	if __wf_atom_7e8ad928(questController) then
		return nil
	end

	local activeQuests = questController:GetActiveQuests()

	for _, activeQuest in ipairs(activeQuests) do
		if activeQuest:IsA(className) then
			return activeQuest
		end
	end

	return nil
end

local function fn2(questRes, questTask) -- 1 equivalent call inferred from this helper
	local __wf_atom_bb972fd2 = questRes:__wf_atom_bb972fd2()

	for i = 1, #__wf_atom_bb972fd2 do
		if tostring(__wf_atom_bb972fd2[i]) == questTask then
			return true
		end
	end

	return false
end

local function fn3(data)
	local v7

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

		for _, v8 in ipairs(__wf_atom_d10f2b47) do
			if v8.mId == "" then
				continue
			end

			v7 = v8
			break
		end
	end

	if v7 == nil then
		return false
	end

	if v7.mType == 0 then
		local v8 = fn(WeakResource(v7.mId))

		if __wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(data.questRes) or data.questRes ~= v8 then
			return data.taleHudId ~= nil and data.taleHudId == v7.mId
		else
			if __wf_atom_7e8ad928(data.questTask) then
				return true
			end

			return not not fn2(data.questRes, data.questTask) or data.taleHudId ~= nil and data.taleHudId == v7.mId -- inferred equivalent call
		end
	else
		return data.taleHudId ~= nil and data.taleHudId == v7.mId
	end
end

local function fn4(p)
	if __wf_atom_7e8ad928(p) then
		return "nil"
	end

	local sparrowDestination = _T.SparrowDestinations[p]

	if __wf_atom_7e8ad928(sparrowDestination) then
		return "nil"
	end

	local v7 = p .. ", "
	local v8

	if __wf_atom_7e8ad928(sparrowDestination.entity) then
		v8 = v7 .. "nil"
	else
		v8 = v7 .. sparrowDestination.entity:__wf_atom_5b41f63b()
		local __wf_atom_db682341 = sparrowDestination.entity:__wf_atom_db682341()

		if not __wf_atom_7e8ad928(__wf_atom_db682341) and __wf_atom_db682341 ~= EMPTY_SYMBOL then
			v8 ..= " [" .. tostring(__wf_atom_db682341) .. "] "
		end

		if not __wf_atom_7e8ad928(sparrowDestination.path) then
			v8 ..= "+path"
		end
	end

	local v9 = v8 .. ", "

	if not __wf_atom_7e8ad928(sparrowDestination.questRes) then
		local v10 = v9 .. sparrowDestination.questRes:GetName()

		if fn3(sparrowDestination) then
			v9 = v10 .. " (Tracked), "
		else
			v9 = v10 .. " (Not Tracked), "
		end
	end

	local v10 = v9 .. v6[math.floor(sparrowDestination.priority / 100) * 100] .. ", "
	local minValue = sparrowDestination.range.minValue
	local maxValue = sparrowDestination.range.maxValue
	return v10 .. minValue .. "-" .. (sparrowDestination.range.maxValue == 3.4028234663852886e38 and "FLT_MAX" or maxValue)
end

local function fn5()
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

	if __wf_atom_7e8ad928(v2) then
		v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	while not (v2:IsEnabled() or v2:__wf_atom_5e711c72()) do
		Sleep(0)
	end

	while not __wf_atom_2202ffb6:__wf_atom_eb1b4526() do
		Sleep(0)
	end
end

local function fn6(instance)
	local __wf_atom_dd85e6db = instance:__wf_atom_dd85e6db()

	if __wf_atom_7e8ad928(__wf_atom_dd85e6db) then
		__wf_atom_dd85e6db = instance:__wf_atom_90813fa0()
	end

	if __wf_atom_7e8ad928(__wf_atom_dd85e6db) then
		local __wf_atom_66046837 = instance:__wf_atom_66046837()

		if not __wf_atom_7e8ad928(__wf_atom_66046837) then
			__wf_atom_dd85e6db = Resource(__wf_atom_66046837:__wf_atom_5b41f63b())
		end
	end

	return __wf_atom_dd85e6db
end

local function fn7(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("SparrowGuide"))

	for _, v7 in ipairs(__wf_atom_2226b35c) do
		if __wf_atom_7e8ad928(p) or v7:__wf_atom_6f4c1c1b() == p then
			v7:Destroy()
		end
	end
end

function GetDestId(instance)
	if __wf_atom_7e8ad928(instance) then
		return nil
	end

	if instance:IsA(__wf_atom_7e6ed5fa) then
		return instance:GetName()
	end

	if instance:IsA(__wf_atom_f806fd7a) then
		local v7 = instance:__wf_atom_26b04ea9() or instance
		local v8 = v7:__wf_atom_db682341() or v7:GetName()
		local v9 = fn6(instance)
		local v10 = Symbol("MT_NONE")

		if not __wf_atom_7e8ad928(v9) then
			v10 = v9:__wf_atom_55116686()
		end

		if v10 == Symbol("MT_NONE") or v10 == EMPTY_SYMBOL then
			v10 = instance:__wf_atom_5b6b447d()
		end

		if v8 == EMPTY_SYMBOL or v10 == EMPTY_SYMBOL then
			return instance:GetName()
		end

		return tostring(v8) .. "-" .. tostring(v10)
	else
		local position = instance:GetPosition()
		position.x = math.floor(position.x)
		position.y = math.floor(position.y)
		position.z = math.floor(position.z)
		local v7 = string.gsub(tostring(position), "Vector", "")
		return instance:GetName() .. v7
	end
end

local function fn8(p, p2) -- 5 equivalent calls inferred from this helper
	return Distance(Vector(p.x, 0, p.z), Vector(p2.x, 0, p2.z))
end

local function fn9()
	local __wf_atom_3c8e1a7a = gRegion:__wf_atom_3c8e1a7a()

	for _, v7 in ipairs(__wf_atom_3c8e1a7a) do
		if v7:__wf_atom_3c213d6b() then
			return v7
		end
	end

	return nil
end

local function fn10()
	if __wf_atom_7e8ad928(_T.SparrowDestinations) then
		_T.SparrowDestinations = {}
	end

	local v7 = fn9()

	if __wf_atom_7e8ad928(v7) then
		return
	end

	for k, sparrowDestination in pairs(_T.SparrowDestinations) do
		if not (__wf_atom_7e8ad928(sparrowDestination.entity) or sparrowDestination.entity:IsA(__wf_atom_43e0c427) or sparrowDestination.entity:IsA(__wf_atom_7e6ed5fa) and sparrowDestination.entity:IsKilled()) then
			continue
		end

		_T.SparrowDestinations[k] = nil
		v7:RemoveSparrowDestination(k)
	end
end

local function fn11(sparrowDestination, __wf_atom_c4f78a8f)
	local distance = 3.4028234663852886e38
	local priority = 1
	local sparrowDestination2 = _T.SparrowDestinations[v]
	local v7

	if not __wf_atom_7e8ad928(gGameData) then
		local __wf_atom_d10f2b47 = gGameData:__wf_atom_d10f2b47()

		for _, v8 in ipairs(__wf_atom_d10f2b47) do
			if v8.mId == "" then
				continue
			end

			v7 = v8
			break
		end
	end

	local v8 = v7 ~= nil

	if not (__wf_atom_7e8ad928(sparrowDestination2) or __wf_atom_7e8ad928(sparrowDestination2.distance)) then
		distance = sparrowDestination2.distance
		priority = sparrowDestination2.priority
	end

	if __wf_atom_7e8ad928(sparrowDestination.distance) or __wf_atom_7e8ad928(sparrowDestination.entity) then
		return false
	end

	local v9 = fn3(sparrowDestination)

	if not v9 and sparrowDestination.priority < PRIORITY.MEDIUM and v8 then
		return false
	end

	if not (priority <= sparrowDestination.priority and (__wf_atom_7e8ad928(sparrowDestination.questRes) and __wf_atom_7e8ad928(sparrowDestination.taleHudId) or v9) and sparrowDestination.distance <= sparrowDestination.range.maxValue) then
		return false
	end

	if priority < sparrowDestination.priority then
		return true
	end

	if not __wf_atom_7e8ad928(sparrowDestination2) and distance < sparrowDestination2.range.minValue then
		return sparrowDestination.entity:__wf_atom_1c8f7b2d(sparrowDestination2.entity) < sparrowDestination2.range.minValue
	end

	if sparrowDestination.entity:IsA(__wf_atom_9e85eea2) and not sparrowDestination.entity:IsKilled() then
		local __wf_atom_30e3d82b = sparrowDestination.entity:__wf_atom_30e3d82b()

		if
			not __wf_atom_7e8ad928(__wf_atom_30e3d82b)
			and __wf_atom_30e3d82b:__wf_atom_04ea4887()
			and __wf_atom_30e3d82b:__wf_atom_216d6edd() == __wf_atom_c4f78a8f
		then
			return true
		end
	end

	if sparrowDestination.distance <= distance then
		return true
	end

	return false
end

local function fn12(p, p2)
	fn10()

	if __wf_atom_7e8ad928(v2) then
		v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()

	if __wf_atom_7e8ad928(__wf_atom_c4f78a8f) then
		return
	end

	local count = 0

	for _, _ in pairs(_T.SparrowDestinations) do
		count += 1
	end

	if count == 0 then
		print("No sparrow destinations!")
		return
	end

	v = nil

	for _, sparrowDestination in pairs(_T.SparrowDestinations) do
		sparrowDestination.distance = nil
	end

	local position = __wf_atom_c4f78a8f:GetPosition()
	local __wf_atom_e800787c = __wf_atom_c4f78a8f:__wf_atom_e800787c()
	local v7

	if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
		v7 = __wf_atom_e800787c:__wf_atom_dd89d98c()
	end

	for i = 700, PRIORITY.LOW, -1 do
		for k, sparrowDestination in pairs(_T.SparrowDestinations) do
			if
				sparrowDestination.priority ~= i
				or sparrowDestination.compassOnly
				or not (__wf_atom_7e8ad928(sparrowDestination.regionIndex) or v7 == sparrowDestination.regionIndex)
			then
				continue
			end

			if
				__wf_atom_7e8ad928(sparrowDestination.distance)
				and not __wf_atom_7e8ad928(sparrowDestination.entity)
			then
				sparrowDestination.distance = v2:__wf_atom_57856d42(sparrowDestination.entity:GetPosition(), position)

				if
					__wf_atom_7e8ad928(sparrowDestination.distance)
					or sparrowDestination.distance == 0
					or sparrowDestination.distance == 3.4028234663852886e38
				then
					sparrowDestination.distance = __wf_atom_c4f78a8f:__wf_atom_8a6b8fc3(sparrowDestination.entity)
				end
			end

			if fn11(sparrowDestination, __wf_atom_c4f78a8f) then
				v = k
			end
		end
	end

	if p2 ~= true then
		local v8 = "SparrowLib: Current Destination: " .. fn4(v) .. ", [Update Reason: " .. p .. "]"
		print(v8)
	end

	local v8 = fn9()

	if __wf_atom_7e8ad928(v) then
		if not __wf_atom_7e8ad928(v8) then
			v8:__wf_atom_7fb07ae3("")
		end
	elseif not __wf_atom_7e8ad928(v8) then
		v8:__wf_atom_7fb07ae3(v)
	end
end

function CreateReplicatedSparrowDestination(data)
	if __wf_atom_7e8ad928(data) then
		return nil
	end

	local sparrowDestination = SF.SparrowDestination()
	sparrowDestination.mId = data.id
	sparrowDestination.mEntityType = data.entity:__wf_atom_e14d8a8c()
	sparrowDestination.mEntityFullName = data.entity:__wf_atom_5b41f63b()
	sparrowDestination.mEntityPosition = data.entity:GetPosition()

	if __wf_atom_7e8ad928(data.owner) then
		sparrowDestination.mOwnerType = nil
		sparrowDestination.mOwnerFullName = ""
		sparrowDestination.mOwnerPosition = __wf_atom_28d5d4aa
		sparrowDestination.mOwnerSpawnRadius = 0
	else
		sparrowDestination.mOwnerType = data.owner:__wf_atom_e14d8a8c()
		sparrowDestination.mOwnerFullName = data.owner:__wf_atom_5b41f63b()

		if data.owner:IsA(__wf_atom_7e616794) then
			sparrowDestination.mOwnerPosition = data.owner:GetPosition()
		else
			sparrowDestination.mOwnerPosition = data.entity:GetPosition()
		end

		if data.owner:IsA(__wf_atom_f806fd7a) then
			sparrowDestination.mOwnerSpawnRadius = data.owner:__wf_atom_103377cc()
		else
			sparrowDestination.mOwnerSpawnRadius = 0
		end
	end

	if not __wf_atom_7e8ad928(data.priority) then
		sparrowDestination.mPriority = data.priority
	end

	sparrowDestination.mRange = data.range

	if not __wf_atom_7e8ad928(data.questRes) then
		sparrowDestination.mQuestRes = data.questRes
	end

	if not __wf_atom_7e8ad928(data.questTask) then
		sparrowDestination.mQuestTask = data.questTask
	end

	if not __wf_atom_7e8ad928(data.icon) then
		sparrowDestination.mIcon = data.icon
	end

	if not __wf_atom_7e8ad928(data.alwaysOnCompass) then
		sparrowDestination.mAlwaysOnCompass = data.alwaysOnCompass
	end

	if not __wf_atom_7e8ad928(data.allowMultiple) then
		sparrowDestination.mAllowMultiple = data.allowMultiple
	end

	if not __wf_atom_7e8ad928(data.compassOnly) then
		sparrowDestination.mCompassOnly = data.compassOnly
	end

	if not __wf_atom_7e8ad928(data.path) then
		sparrowDestination.mPath = data.path
	end

	if not __wf_atom_7e8ad928(data.numStars) then
		sparrowDestination.mNumStars = data.numStars
	end

	return sparrowDestination
end

local function fn13(instance, instance2, id, high, range, questRes, questTask, icon, alwaysOnCompass, allowMultiple, compassOnly, numStars)
	fn10()

	if __wf_atom_7e8ad928(instance) then
		print("SparrowLib: WARNING: Attempted to add a sparrow destination with a null entity.")

		if not __wf_atom_7e8ad928(id) then
			local v7 = "Destination Id: " .. fn4(id)
			print(v7)
		end
	else
		if __wf_atom_7e8ad928(instance2) and not __wf_atom_7e8ad928(instance) then
			print("SparrowLib: WARNING: Adding a sparrow destination with no owner. Entity id: " .. tostring(GetDestId(instance)))
			instance2 = instance
		end

		if __wf_atom_7e8ad928(high) then
			high = PRIORITY.HIGH
		end

		if __wf_atom_7e8ad928(range) then
			if PRIORITY.EXIT <= high then
				range = Range(0, 3.4028234663852886e38)
			else
				range = Range(0, 300)
			end
		end

		if __wf_atom_7e8ad928(id) then
			id = GetDestId(instance)
		end

		if __wf_atom_7e8ad928(id) then
			return
		end

		if not __wf_atom_7e8ad928(questTask) then
			questTask = tostring(questTask)
		end

		_T.SparrowDestinations[id] = {
			owner = instance2,
			entity = instance,
			id = id,
			priority = high,
			range = range,
			questRes = questRes,
			questTask = questTask,
			icon = icon,
			alwaysOnCompass = alwaysOnCompass,
			allowMultiple = allowMultiple,
			compassOnly = compassOnly,
			numStars = numStars
		}
		local __wf_atom_e800787c = instance:__wf_atom_e800787c()

		if not __wf_atom_7e8ad928(__wf_atom_e800787c) then
			_T.SparrowDestinations[id].regionIndex = __wf_atom_e800787c:__wf_atom_dd89d98c()
		end

		local v7 = nil
		local v8 = 0
		local maxValue = range.maxValue

		if instance:IsA(__wf_atom_f806fd7a) then
			v7 = tostring(instance:__wf_atom_db682341())
		elseif not __wf_atom_7e8ad928(instance2) and instance2:IsA(__wf_atom_f806fd7a) then
			v7 = tostring(instance2:__wf_atom_db682341())
			maxValue = math.max(math.min(maxValue, instance2:__wf_atom_103377cc() * 1.5), 50)
			v8 = 1
		end

		if v7 ~= nil then
			for _, activeTale in ipairs(_T.ActiveTales) do
				for _, list in ipairs(activeTale.paths) do
					for _, v9 in ipairs(list) do
						if v9.locationId ~= v7 then
							continue
						end

						_T.SparrowDestinations[id].taleHudId = activeTale.hudId
						_T.SparrowDestinations[id].priority = PRIORITY.TALE + v8
						_T.SparrowDestinations[id].range = Range(range.minValue, maxValue)
						break
					end
				end

				if _T.SparrowDestinations[id].taleHudId then
					break
				end
			end
		end

		local v9 = CreateReplicatedSparrowDestination(_T.SparrowDestinations[id])
		local v10 = fn9()

		if not (__wf_atom_7e8ad928(v10) or __wf_atom_7e8ad928(v9)) then
			v10:RemoveSparrowDestination(id)
			v10:AddSparrowDestination(v9)
		end

		local v11 = "SparrowLib: Add Sparrow Destination: " .. fn4(id)
		print(v11)
		fn12("AddSparrowDestination")
		return id
	end
end

function ApplySparrowCustomization(object, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if __wf_atom_7e8ad928(__wf_atom_a96eb2aa) then
		return
	end

	local imGuiSparrowCustomization = gGameRules:__wf_atom_1eafa462(__wf_atom_a96eb2aa)

	if _T.ImGuiSparrowCustomization and object == object2:__wf_atom_6f4c1c1b() then
		imGuiSparrowCustomization = _T.ImGuiSparrowCustomization
	end

	local __wf_atom_e55d02aa = object2:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if not __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		__wf_atom_e55d02aa:SetCustomization(imGuiSparrowCustomization)
	end
end

function ApplySparrowCustomizationToDeco(object, object2)
	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if
		__wf_atom_7e8ad928(__wf_atom_a96eb2aa)
		or GetSparrowSkinForPlayer(object:__wf_atom_a96eb2aa()) == WeakResource("/SF/Upgrades/Skins/Sparrow/FloppetBody")
	then
		return
	end

	local imGuiSparrowCustomization = gGameRules:__wf_atom_1eafa462(__wf_atom_a96eb2aa)

	if _T.ImGuiSparrowCustomization and object == object2:GetCreator() then
		imGuiSparrowCustomization = _T.ImGuiSparrowCustomization
	end

	if __wf_atom_7e8ad928(imGuiSparrowCustomization) then
		return
	end

	local v7 = Resource(imGuiSparrowCustomization:__wf_atom_035fdfa8(2))

	if __wf_atom_7e8ad928(v7) then
		return
	end

	local __wf_atom_c4774ee9 = v7:__wf_atom_c4774ee9(1, 0)

	if __wf_atom_7e8ad928(__wf_atom_c4774ee9) then
		return
	end

	object2:__wf_atom_45cf0e1a(__wf_atom_c4774ee9:__wf_atom_d24efbb2(), false, false)
	__wf_atom_c4774ee9:__wf_atom_e6329949(1, object2)
	local __wf_atom_4c3fbb4b = v7:__wf_atom_4c3fbb4b()

	for i = 1, #__wf_atom_4c3fbb4b do
		object2:CreateAutoChild(Engine.AutoChild(__wf_atom_4c3fbb4b[i]))
	end
end

function GetSparrowSkinForPlayer(p)
	if
		__wf_atom_7e8ad928(p)
		or __wf_atom_7e8ad928(gGameRules:__wf_atom_1eafa462(p))
		or __wf_atom_7e8ad928(gGameRules:__wf_atom_1eafa462(p):__wf_atom_d78fd481(2))
	then
		return
	end

	local mItemType = gGameRules:__wf_atom_1eafa462(p):__wf_atom_d78fd481(2).mItemType

	if __wf_atom_7e8ad928(mItemType) then
		mItemType = gGameRules:__wf_atom_1eafa462(p):__wf_atom_035fdfa8(2)
	end

	return mItemType
end

local function fn14(playerAvatar, agent)
	if __wf_atom_7e8ad928(v2) then
		v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if not (__wf_atom_7e8ad928(_T.OverrideSparrow) or __wf_atom_7e8ad928(_T.OverrideSparrow.agent)) then
		agent = _T.OverrideSparrow.agent
	end

	if __wf_atom_7e8ad928(playerAvatar) or __wf_atom_7e8ad928(agent) then
		return
	end

	local v7 = false
	local v8

	if playerAvatar:IsA(__wf_atom_47cae841) and not __wf_atom_7e8ad928(playerAvatar:__wf_atom_4221009f()) then
		v8 = playerAvatar
		playerAvatar = playerAvatar:__wf_atom_4221009f()
		v7 = true
	else
		v8 = playerAvatar:__wf_atom_3d96ddcd()

		if not __wf_atom_7e8ad928(v8) and v8:IsA(__wf_atom_47cae841) and v8:__wf_atom_4221009f() == playerAvatar then
			v7 = true
		end
	end

	fn7(playerAvatar)
	fn12("SpawnSparrow")
	local v9 = {
		__wf_atom_7b01f9ce,
		__wf_atom_d127f143,
		__wf_atom_43e0c427,
		__wf_atom_3feeb44a,
		__wf_atom_4ebf67cb
	}
	local v10 = nil
	local v11 = v7 and v8:__wf_atom_4e50d390() or playerAvatar:__wf_atom_4e50d390()
	v11.bank = 0
	local v12 = v7 and playerAvatar:__wf_atom_1c374cc9(Symbol("GAME_C1_HEAD1"), true) or playerAvatar:EyePosition()
	local v13 = 3 * (1 - __wf_atom_421b01aa(math.abs(v11.pitch / 90), 0, 1))
	local pos = v12 + __wf_atom_9341614d(Vector(1, 0, v13), v11)
	local v14 = Vector()

	if not __wf_atom_7e8ad928((gRegion:__wf_atom_fbb89790(v12, pos, 0.2, nil, v9, nil, v14))) then
		pos = v14
	end

	pos.y = v12.y

	if _T.OverrideSparrow and _T.OverrideSparrow.pos then
		pos = _T.OverrideSparrow.pos
	end

	local rot = v7 and v8:__wf_atom_2f2bada0() or playerAvatar:__wf_atom_2f2bada0()
	local flag

	if _T.OverrideSparrow and _T.OverrideSparrow.rot then
		rot = _T.OverrideSparrow.rot
		flag = false
	else
		flag = true
	end

	if __wf_atom_7e8ad928(_T.SparrowDestinations[v]) or __wf_atom_7e8ad928(_T.SparrowDestinations[v].entity) then
		if not __wf_atom_7e8ad928(_T.GetFlashMarker) then
			local flashMarker = _T.GetFlashMarker(WeakResource("/SF/Types/Game/MarkerInfos/PaintedMarkerInfo"))

			if not __wf_atom_7e8ad928(flashMarker) then
				local __wf_atom_d9e97c2c = v2:__wf_atom_d9e97c2c(pos, flashMarker.pos, 5, 5, 84410351, 153)

				if flag then
					rot = __wf_atom_fa8d0177(pos, __wf_atom_d9e97c2c)
				end

				if _T.SparrowDebugDraw then
					gRegion:__wf_atom_c189a462(pos, __wf_atom_d9e97c2c, Color(255, 0, 255), 3)
				end
			end
		end
	else
		local __wf_atom_d9e97c2c = v2:__wf_atom_d9e97c2c(
			pos,
			_T.SparrowDestinations[v].entity:GetPosition(),
			5,
			5,
			84410351,
			153
		)

		if flag then
			rot = __wf_atom_fa8d0177(pos, __wf_atom_d9e97c2c)
		end

		if _T.SparrowDebugDraw then
			gRegion:__wf_atom_c189a462(pos, __wf_atom_d9e97c2c, Color(255, 0, 255), 10)
		end
	end

	local __wf_atom_54cf3d0a = v2:__wf_atom_54cf3d0a(agent, pos, rot)

	if __wf_atom_7e8ad928(__wf_atom_54cf3d0a) then
		return __wf_atom_54cf3d0a, v10
	end

	local v15 = __wf_atom_e97f3142(rot)
	v15.y = 0
	local v16 = pos + v15 * 3

	if gRegion:__wf_atom_fbb89790(pos, v16, 0.2, nil, v9, nil, v14) then
		v16 = v14
	end

	__wf_atom_54cf3d0a:__wf_atom_4e6e77b6(v16, false)
	v10 = __wf_atom_54cf3d0a:__wf_atom_50a7d83e()

	if not __wf_atom_7e8ad928(v10) then
		v10:__wf_atom_6a95c7b8(playerAvatar)
		ApplySparrowCustomization(playerAvatar, v10)
	end

	Sleep(0)
	Sleep(0)

	if not __wf_atom_7e8ad928(v10) then
		v10:ProcessAnimEvent(Symbol("SFXGuideVocalSummon"))
	end

	return __wf_atom_54cf3d0a, v10
end

function _SimpleSpawnSparrow(p, agent, p2, p3, p4)
	if __wf_atom_7e8ad928(v2) then
		v2 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	end

	if not (__wf_atom_7e8ad928(_T.OverrideSparrow) or __wf_atom_7e8ad928(_T.OverrideSparrow.agent)) then
		agent = _T.OverrideSparrow.agent
	end

	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(agent) then
		return
	end

	fn7(p)
	fn12("SpawnSparrow")
	local __wf_atom_54cf3d0a = v2:__wf_atom_54cf3d0a(agent, p2, p3)
	local v7

	if not __wf_atom_7e8ad928(__wf_atom_54cf3d0a) then
		v7 = __wf_atom_54cf3d0a:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(v7) then
			v7:__wf_atom_6a95c7b8(p)

			if p4 and not __wf_atom_7e8ad928(v7) then
				v7:__wf_atom_98a0c9bd(Symbol("SPARROW_APPEAR_FX"), false)
			end
		end

		local v8 = __wf_atom_e97f3142(p3)
		v8.y = 0
		local v9 = p2 + v8 * 3
		local v10 = {
			__wf_atom_7b01f9ce,
			__wf_atom_d127f143,
			__wf_atom_43e0c427,
			__wf_atom_3feeb44a,
			__wf_atom_4ebf67cb
		}
		local v11 = Vector()

		if gRegion:__wf_atom_fbb89790(p2, v9, 0.2, nil, v10, nil, v11) then
			v9 = v11
		end

		__wf_atom_54cf3d0a:__wf_atom_4e6e77b6(v9, false)
		ApplySparrowCustomization(p, v7)
	end

	return __wf_atom_54cf3d0a, v7
end

function Distance2d(p, p2)
	return fn8(p, p2)
end

function SpawnSparrow(playerAvatar, p)
	if __wf_atom_7e8ad928(playerAvatar) then
		playerAvatar = gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)
	end

	if __wf_atom_7e8ad928(p) then
		p = v3
	end

	return fn14(playerAvatar, p)
end

function RemoveSparrow(p)
	fn7(p)
end

function SimpleSpawnSparrow(playerAvatar, p, p2, p3, p4)
	if __wf_atom_7e8ad928(p) then
		return
	end

	if __wf_atom_7e8ad928(playerAvatar) then
		playerAvatar = gRegion:__wf_atom_eab484a7():GetPlayerAvatar(0)
	end

	return _SimpleSpawnSparrow(playerAvatar, p, p2, p3, p4)
end

function GetSparrowForPlayer(p)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("SparrowGuide"))

	for _, v7 in ipairs(__wf_atom_2226b35c) do
		if v7:__wf_atom_6f4c1c1b() == p then
			return v7
		end
	end
end

function SetSparrowMode(sparrowMode)
	_T.SparrowMode = sparrowMode
end

function SparrowAliveForPlayer(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	return object:__wf_atom_c3ebaeea()
end

function SparrowGuidingForPlayer(object)
	if __wf_atom_7e8ad928(object) then
		return false
	end

	if
		__wf_atom_7e8ad928(object:__wf_atom_a96eb2aa())
		or __wf_atom_7e8ad928(object:__wf_atom_a96eb2aa():GetPlayerAvatar(0))
	then
		return object:__wf_atom_8a7e7fd5()
	end

	return object:__wf_atom_a96eb2aa():GetPlayerAvatar(0):__wf_atom_8a7e7fd5()
end

function CanShoulderPerch(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return false
	end

	local __wf_atom_a96eb2aa = object:__wf_atom_a96eb2aa()

	if
		__wf_atom_7e8ad928(__wf_atom_a96eb2aa)
		or object ~= __wf_atom_a96eb2aa:GetPlayerAvatar(0)
		or __wf_atom_a96eb2aa:__wf_atom_50a7d83e() ~= __wf_atom_a96eb2aa:GetPlayerAvatar(0)
	then
		return false
	end

	if
		__wf_atom_a96eb2aa:__wf_atom_c9889f2f()
		or object:__wf_atom_08998754() == 2 and object:__wf_atom_ee4f0cba() > 1
		or object:__wf_atom_08998754() == 4
	then
		return false
	end

	if object:__wf_atom_7b82e9e1(15) or object:__wf_atom_7b82e9e1(4) then
		return false
	end

	if
		object:__wf_atom_58dabbc7()
		or object:__wf_atom_47fbd15c()
		or not __wf_atom_7e8ad928(gRegion:__wf_atom_c3b255b8())
	then
		return false
	end

	if
		__wf_atom_7e8ad928(gRegion:__wf_atom_2202ffb6())
		or __wf_atom_7e8ad928(gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620())
		or gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620():__wf_atom_37241977(__wf_atom_a96eb2aa)
	then
		return false
	end

	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e) and __wf_atom_e919fb8e.disableSparrowShoulderPerch then
		return false
	end

	if
		not __wf_atom_7e8ad928(__wf_atom_e919fb8e)
		and not __wf_atom_7e8ad928(__wf_atom_e919fb8e.sparrowPlayerLastDamagedTime)
		and Time() - __wf_atom_e919fb8e.sparrowPlayerLastDamagedTime < 10
	then
		return false
	end

	if
		__wf_atom_7e8ad928(object:__wf_atom_d2b2176d())
		or not __wf_atom_7e8ad928(object:__wf_atom_d2b2176d():__wf_atom_35a10d3c(0))
	then
		return false
	end

	if
		__wf_atom_7e8ad928(object:__wf_atom_d2b2176d():__wf_atom_e55d02aa())
		or object:__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_5b41f63b() == "BaseSoul"
	then
		return false
	end

	if object:__wf_atom_d2b2176d():__wf_atom_e55d02aa():__wf_atom_a07f65c2() then
		return false
	end

	if
		module.IsInOverworld()
		and not object:__wf_atom_799d95f5()
		and (__wf_atom_7e8ad928(object:__wf_atom_a96eb2aa()) or __wf_atom_7e8ad928(GetSparrowSkinForPlayer(object:__wf_atom_a96eb2aa())) or GetSparrowSkinForPlayer(object:__wf_atom_a96eb2aa()):__wf_atom_5b41f63b() ~= "/SF/Upgrades/Skins/Sparrow/FloppetBody")
	then
		return _T.sparrowMode ~= "WaitAndHover" and _T.sparrowMode ~= "KeepActive"
	end

	return false
end

function GetShoulderOffset(object)
	local v7 = Vector(-0.09, 0, -0.02)

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(object:__wf_atom_d2b2176d()) then
		return v7
	end

	local __wf_atom_e55d02aa = object:__wf_atom_d2b2176d():__wf_atom_e55d02aa()

	if __wf_atom_7e8ad928(__wf_atom_e55d02aa) then
		return v7
	end

	v7 = __wf_atom_e55d02aa:__wf_atom_a1067f62()

	for i = 0, __wf_atom_e55d02aa:__wf_atom_06f3cb74() - 1 do
		local __wf_atom_b9a1f18c = __wf_atom_e55d02aa:__wf_atom_b9a1f18c(i)

		if
			__wf_atom_7e8ad928(__wf_atom_b9a1f18c)
			or not __wf_atom_b9a1f18c:IsA(__wf_atom_abf506db)
			or __wf_atom_b9a1f18c:IsA(__wf_atom_88b2ea5a)
			or not __wf_atom_b9a1f18c:__wf_atom_263db987()
		then
			continue
		end

		local __wf_atom_04f7e7b1 = __wf_atom_b9a1f18c:__wf_atom_04f7e7b1()

		if Length(__wf_atom_04f7e7b1) > Length(v7) then
			v7 = __wf_atom_04f7e7b1
		end
	end

	return v7
end

function SetupSparrowResources(p)
	v3 = p
end

function UpdateSparrowDestination(p)
	fn12("UpdateSparrowDestination", p)
end

function GetSparrowDestinations()
	return _T.SparrowDestinations
end

function GetCurrentSparrowDestination()
	if __wf_atom_7e8ad928(_T.SparrowDestinations) or __wf_atom_7e8ad928(_T.SparrowDestinations[v]) then
		return nil
	end

	return _T.SparrowDestinations[v]
end

function GetCurrentSparrowDestinationId()
	if gRegion:IsMaster() then
		return v
	end

	local v7 = fn9()

	if __wf_atom_7e8ad928(v7) then
		return nil
	end

	return (v7:GetCurrentSparrowDestinationId())
end

function GetSparrowDestinationCompassInfos()
	local v7 = fn9()

	if __wf_atom_7e8ad928(v7) then
		return nil
	end

	return (v7:__wf_atom_f2149813())
end

function GetCurrentSparrowMultiDestinations()
	local sparrowDestinations = {}

	if not (v ~= nil and _T.SparrowDestinations ~= nil) then
		return sparrowDestinations
	end

	local sparrowDestination = _T.SparrowDestinations[v]

	if __wf_atom_7e8ad928(sparrowDestination) or not sparrowDestination.allowMultiple then
		return sparrowDestinations
	end

	if fn3(sparrowDestination) then
		for _, sparrowDestination2 in pairs(_T.SparrowDestinations) do
			if
				__wf_atom_7e8ad928(sparrowDestination2)
				or sparrowDestination2.priority ~= sparrowDestination.priority
				or not sparrowDestination2.allowMultiple
			then
				continue
			end

			if not (not __wf_atom_7e8ad928(sparrowDestination2.questRes) and sparrowDestination2.questRes == sparrowDestination.questRes or not __wf_atom_7e8ad928(sparrowDestination2.taleHudId) and sparrowDestination2.taleHudId == sparrowDestination.taleHudId) then
				continue
			end

			table.insert(sparrowDestinations, sparrowDestination2)
		end
	else
		for _, sparrowDestination2 in pairs(_T.SparrowDestinations) do
			if
				__wf_atom_7e8ad928(sparrowDestination2)
				or sparrowDestination2.priority ~= sparrowDestination.priority
				or not sparrowDestination2.allowMultiple
			then
				continue
			end

			if not (__wf_atom_7e8ad928(sparrowDestination2.questRes) and __wf_atom_7e8ad928(sparrowDestination2.taleHudId) or fn3(sparrowDestination2)) then
				continue
			end

			table.insert(sparrowDestinations, sparrowDestination2)
		end
	end

	return sparrowDestinations
end

function GetSparrowDestinationById(p)
	if
		__wf_atom_7e8ad928(p)
		or __wf_atom_7e8ad928(_T.SparrowDestinations)
		or __wf_atom_7e8ad928(_T.SparrowDestinations[p])
	then
		return nil
	end

	return _T.SparrowDestinations[p]
end

function AddSparrowDestination(entity, p, p2, p3, p4, questRes, p5, icon, alwaysOnCompass, allowMultiple, numStars)
	return fn13(entity, p, p2, p3, p4, questRes, p5, icon, alwaysOnCompass, allowMultiple, false, numStars)
end

function AddSparrowDestinationTag(p, p2, p3, p4, p5, p6, p7, p8, p9)
	return fn13(gRegion:__wf_atom_0a6a5887(p), nil, p2, p3, p4, p5, p6, p7, p8, p9)
end

function AddSimpleDestination(entity, p, p2, p3)
	return fn13(entity, nil, p, p2, p3, nil, nil, nil, false, false, false, nil)
end

function AddQuestDestination(object, object2, p, p2, p3)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	return fn13(
		object,
		object2,
		object2:__wf_atom_5b41f63b():match("([^/]+)$") .. "-" .. (p or object:GetName()),
		PRIORITY.QUEST,
		p2,
		object2,
		p,
		nil,
		false,
		p3
	)
end

function AddCompassDestination(p, p2, p3, p4)
	return fn13(p, p2, p3, nil, nil, nil, nil, p4, nil, nil, true)
end

function RemoveSparrowDestination(p, p2, p3)
	fn10()

	if __wf_atom_7e8ad928(p2) then
		if __wf_atom_7e8ad928(p) then
			return
		end

		for k, sparrowDestination in pairs(_T.SparrowDestinations) do
			if sparrowDestination.entity ~= p then
				continue
			end

			p2 = k
			break
		end
	end

	if __wf_atom_7e8ad928(p2) then
		return
	end

	local v7 = "SparrowLib: Remove Sparrow Destination: " .. fn4(p2)
	print(v7)
	local v8 = false
	local v9 = fn9()

	if __wf_atom_7e8ad928(_T.SparrowDestinations[p2]) then
		if not __wf_atom_7e8ad928(p) then
			for k, sparrowDestination in pairs(_T.SparrowDestinations) do
				if not (sparrowDestination.entity ~= nil and (__wf_atom_7e8ad928(sparrowDestination.entity) or sparrowDestination.entity == p)) then
					continue
				end

				_T.SparrowDestinations[k] = nil

				if not __wf_atom_7e8ad928(v9) then
					v9:RemoveSparrowDestination(k)
				end
			end

			v8 = true
		end
	else
		_T.SparrowDestinations[p2] = nil

		if not __wf_atom_7e8ad928(v9) then
			v9:RemoveSparrowDestination(p2)
		end

		v8 = true
	end

	fn12("RemoveSparrowDestination", not v8 or p3)
end

function RemoveQuestDestinations(object, p)
	if __wf_atom_7e8ad928(object) then
		return
	end

	for k, sparrowDestination in pairs(_T.SparrowDestinations) do
		if sparrowDestination.questRes == object and sparrowDestination.questTask == p then
			RemoveSparrowDestination(nil, k)
		end
	end

	print("Removed destinations for quest" .. object:GetName() .. " " .. tostring(p))
end

function RemoveAllDestinationsForTale(p)
	local v7 = fn9()

	for k, sparrowDestination in pairs(_T.SparrowDestinations) do
		if not (p ~= nil and sparrowDestination.taleHudId == p) then
			continue
		end

		_T.SparrowDestinations[k] = nil

		if not __wf_atom_7e8ad928(v7) then
			v7:RemoveSparrowDestination(k)
		end
	end

	print("Removed destinations for tale " .. p)
end

function RemoveAllDestinationsForOwner(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	local v7 = fn9()

	for k, sparrowDestination in pairs(_T.SparrowDestinations) do
		if __wf_atom_7e8ad928(sparrowDestination.owner) or sparrowDestination.owner ~= object then
			continue
		end

		_T.SparrowDestinations[k] = nil

		if not __wf_atom_7e8ad928(v7) then
			v7:RemoveSparrowDestination(k)
		end
	end

	print("Removed destinations for owner " .. object:GetName())
end

function RemoveAllTestMultiDestinations()
	if __wf_atom_7e8ad928(_T.SparrowDestinations) then
		return
	end

	for _, v7 in ipairs(v4) do
		RemoveSparrowDestination(nil, v7)
	end

	v4 = {}
	v5 = 0
end

function RemoveCompassDestination(p, p2)
	if __wf_atom_7e8ad928(_T.SparrowDestinations) then
		return
	end

	if __wf_atom_7e8ad928(p2) then
		p2 = GetDestId(p)
	end

	if __wf_atom_7e8ad928(_T.SparrowDestinations[p2]) then
		if not __wf_atom_7e8ad928(p) then
			for k, sparrowDestination in pairs(_T.SparrowDestinations) do
				if
					not sparrowDestination.compassOnly
					or __wf_atom_7e8ad928(sparrowDestination.entity)
					or sparrowDestination.entity ~= p
				then
					continue
				end

				_T.SparrowDestinations[k] = nil
				local v7 = fn9()

				if not __wf_atom_7e8ad928(v7) then
					v7:RemoveSparrowDestination(k)
				end
			end
		end
	elseif _T.SparrowDestinations[p2].compassOnly then
		_T.SparrowDestinations[p2] = nil
		local v7 = fn9()

		if not __wf_atom_7e8ad928(v7) then
			v7:RemoveSparrowDestination(p2)
		end
	end
end

function RemoveAllCompassDestinationsForOwner(p)
	if __wf_atom_7e8ad928(p) then
		return
	end

	local v7 = fn9()

	for k, sparrowDestination in pairs(_T.SparrowDestinations) do
		if
			__wf_atom_7e8ad928(sparrowDestination.owner)
			or sparrowDestination.owner ~= p
			or not sparrowDestination.compassOnly
		then
			continue
		end

		_T.SparrowDestinations[k] = nil

		if not __wf_atom_7e8ad928(v7) then
			v7:RemoveSparrowDestination(k)
		end
	end
end

local function fn15(p)
	if __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(_T.SparrowDestinations[p]) then
		return
	end

	local v7 = CreateReplicatedSparrowDestination(_T.SparrowDestinations[p])
	local v8 = fn9()

	if not (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v7)) then
		v8:UpdateSparrowDestination(v7)
	end
end

function SetRangeForDestination(p, range)
	if not (__wf_atom_7e8ad928(_T.SparrowDestinations) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(_T.SparrowDestinations[p])) then
		_T.SparrowDestinations[p].range = range
		fn15(p)
	end

	fn12("SetRangeForDestination")
end

function SetPriorityForDestination(p, priority)
	if not (__wf_atom_7e8ad928(_T.SparrowDestinations) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(_T.SparrowDestinations[p])) then
		_T.SparrowDestinations[p].priority = priority
		fn15(p)
	end

	fn12("SetPriorityForDestination")
end

function SetIconForDestination(p, icon)
	if not (__wf_atom_7e8ad928(_T.SparrowDestinations) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(_T.SparrowDestinations[p])) then
		_T.SparrowDestinations[p].icon = icon
		fn15(p)
	end

	fn12("SetIconForDestination")
end

function SetAlwaysOnCompassForDestination(p, alwaysOnCompass)
	if not (__wf_atom_7e8ad928(_T.SparrowDestinations) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(_T.SparrowDestinations[p])) then
		_T.SparrowDestinations[p].alwaysOnCompass = alwaysOnCompass
		fn15(p)
	end

	fn12("SetAlwaysOnCompassForDestination")
end

function SetAllowMultipleForDestination(p, allowMultiple)
	if not (__wf_atom_7e8ad928(_T.SparrowDestinations) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(_T.SparrowDestinations[p])) then
		_T.SparrowDestinations[p].allowMultiple = allowMultiple
		fn15(p)
	end

	fn12("SetAllowMultipleForDestination")
end

function SetCompassOnlyForDestination(p, compassOnly)
	if not (__wf_atom_7e8ad928(_T.SparrowDestinations) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(_T.SparrowDestinations[p])) then
		_T.SparrowDestinations[p].compassOnly = compassOnly
		fn15(p)
	end

	fn12("SetCompassOnlyForDestination")
end

function SetNumStarsForDestination(p, numStars)
	if not (__wf_atom_7e8ad928(_T.SparrowDestinations) or __wf_atom_7e8ad928(p) or __wf_atom_7e8ad928(_T.SparrowDestinations[p])) then
		_T.SparrowDestinations[p].numStars = numStars
		fn15(p)
	end

	fn12("SetNumStarsForDestination")
end

function RefreshSparrowDestinations()
	fn10()
end

local function fn16(p, p2)
	fn5()
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local v7 = Vector()
	local v8 = Vector()
	__wf_atom_2202ffb6:__wf_atom_3cc125d0(p, v7)
	__wf_atom_2202ffb6:__wf_atom_3cc125d0(p2, v8)

	if v7 == __wf_atom_28d5d4aa or v8 == __wf_atom_28d5d4aa then
		return
	end

	local v9 = __wf_atom_2202ffb6:__wf_atom_c708a30e(v7, v8) or {}
	table.insert(v9, 1, p)
	table.insert(v9, p2)

	for i = #v9 - 1, 2, -1 do
		if v9[i] == v9[i - 1] or Distance(v9[i], v9[i - 1]) < 1 then
			table.remove(v9, i)
		elseif Distance(v9[i], p2) < 10 and Distance(v9[i], v9[i - 1]) < 10 then
			table.remove(v9, i)
		else
			p2 = v9[i]
		end
	end

	return v9
end

function GenerateLocalRoadPath(p, object)
	fn5()

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(p) or not _G.TestSparrowRoadPath then
		return
	end

	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()
	local position = object:GetPosition()
	local v7 = Vector()
	__wf_atom_2202ffb6:__wf_atom_3cc125d0(position, v7)

	if v7 == __wf_atom_28d5d4aa or fn8(position, v7) > 20 then -- inferred equivalent call
		return
	end

	local v8 = fn16(v7, p)
	local v9 = fn8(position, p) -- inferred equivalent call

	for i = #v8 - 1, 1, -1 do
		if v9 <= fn8(v8[i], p) then -- inferred equivalent call
			table.remove(v8, i)
		end
	end

	if #v8 >= 2 then
		local v10 = fn8(position, v8[1]) -- inferred equivalent call
		local count = #v8

		for i = 2, #v8 do
			if v10 > 60 then
				break
			end

			v10 += fn8(v8[i - 1], v8[i]) -- inferred equivalent call

			if _T.SparrowDebugDraw then
				gRegion:__wf_atom_8d991675(v8[i] + Vector(0, 2, 0), 0.25, Color(192, 0, 0), 7)
				gRegion:__wf_atom_628723a6(v8[i] + Vector(0, 2, 0), v8[i - 1] + Vector(0, 2, 0), Color(192, 0, 0), 7)
			end

			count = i
		end

		if count < #v8 then
			for i = #v8 - 1, count + 1, -1 do
				table.remove(v8, i)
			end
		end
	end

	if _T.SparrowDebugDraw then
		gRegion:__wf_atom_628723a6(v8[#v8] + Vector(0, 2, 0), v8[#v8 - 1] + Vector(0, 2, 0), Color(64, 0, 0), 7)
	end

	return v8
end

function GenerateRoadPath(p, p2)
	if
		__wf_atom_7e8ad928(_T.SparrowDestinations)
		or __wf_atom_7e8ad928(_T.SparrowDestinations[p])
		or __wf_atom_7e8ad928(_T.SparrowDestinations[p].entity)
	then
		return
	end

	local path = fn16(p2, _T.SparrowDestinations[p].entity:GetPosition())
	_T.SparrowDestinations[p].path = path
	fn15(p)
end

function SetupWaypointPath(p, object, p2)
	fn5()

	if
		__wf_atom_7e8ad928(_T.SparrowDestinations)
		or __wf_atom_7e8ad928(_T.SparrowDestinations[p])
		or __wf_atom_7e8ad928(_T.SparrowDestinations[p].entity)
	then
		return
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	local path = { v2:__wf_atom_0e0a6fee(object:GetPosition(), 20, 10) }
	local __wf_atom_2202ffb6 = gRegion:__wf_atom_2202ffb6()

	while true do
		object = object:__wf_atom_c5de56ac()

		if __wf_atom_7e8ad928(object) then
			break
		end

		local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(object:GetPosition(), 20, 10)

		if __wf_atom_2202ffb6:__wf_atom_e58b162a(path[#path], __wf_atom_0e0a6fee, 3) then
			table.insert(path, __wf_atom_0e0a6fee)
		end
	end

	if __wf_atom_7e8ad928(p2) or p2 then
		table.insert(path, (v2:__wf_atom_0e0a6fee(_T.SparrowDestinations[p].entity:GetPosition(), 20, 10)))
	end

	_T.SparrowDestinations[p].path = path
	fn15(p)
end

function RemoveWaypointPath(p)
	if not (__wf_atom_7e8ad928(_T.SparrowDestinations) or __wf_atom_7e8ad928(_T.SparrowDestinations[p])) then
		_T.SparrowDestinations[p].path = nil
		fn15(p)
	end
end

function SparrowImGui() end