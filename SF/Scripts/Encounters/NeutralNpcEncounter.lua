local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local v = Color(0, 255, 255)
local v2 = Symbol("NpcSpawn")
local v3 = Symbol("NpcNightSpawn")
local v4 = Symbol("PointOfInterest")
local v5 = Symbol("VillagerPoi")
local v6 = Symbol("RequiresItem")
local v7 = Symbol("Neutral")
local v8 = Symbol("TENNO")
local v9 = nil
local position = nil
local creator = nil
local v10 = nil
local v11 = nil

local function fn()
	local __wf_atom_57e5ac18 = gRegion:__wf_atom_57e5ac18()
	local result = {}

	for _, v12 in ipairs(__wf_atom_57e5ac18) do
		local __wf_atom_e93896ba = v12:__wf_atom_e93896ba()

		if
			v12:IsKilled()
			or not v12:IsA(__wf_atom_9e85eea2)
			or __wf_atom_e93896ba == v7
			or __wf_atom_e93896ba == v8
		then
			continue
		end

		if not (v12:__wf_atom_1c8f7b2d(creator) <= v11 + 10) then
			continue
		end

		table.insert(result, v12)
	end

	return result
end

local function fn2(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	for i = 0, object:__wf_atom_c0d09e05() - 1 do
		for j = 1, #normalEyesMats do
			if object:__wf_atom_3de89c8e(i) == normalEyesMats[j] then
				object:__wf_atom_a887a262(i, catEyesMat, false)
			end
		end
	end
end

local function fn3(object)
	if __wf_atom_7e8ad928(object) or object:IsKilled() then
		return
	end

	for i = 1, object:__wf_atom_c0d09e05() do
		if object:__wf_atom_3de89c8e(i) == catEyesMat then
			object:__wf_atom_cf87dd64(false)
		end
	end
end

local function fn4()
	v10 = creator:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(creator, v10)

	if #v10 > 0 then
		return
	end

	local __wf_atom_e800787c = creator:__wf_atom_e800787c()
	local v12 = {}
	local v13

	if useDayNightCycle and module2.IsNight() then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v3, position, 0, v11)
		local pointInstances = module.FindPointInstances(creator, gNpcSpawnPointType, v3)
		v13 = module2.MergeTables(pointInstances, __wf_atom_439c0d29, true)
	else
		v13 = {}
	end

	if #v13 == 0 then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v2, position, 0, v11)
		local pointInstances = module.FindPointInstances(creator, gNpcSpawnPointType, v2)
		v13 = module2.MergeTables(pointInstances, __wf_atom_439c0d29, true)
	end

	if #v13 < npcCount then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(v4, position, 0, v11)
		local pointInstances = module.FindPointInstances(creator, __wf_atom_46b5a019, v3)
		local mergeTables = module2.MergeTables(__wf_atom_439c0d29, pointInstances, true)

		for i = #mergeTables, 1, -1 do
			local __wf_atom_1cd2b24a = mergeTables[i]:__wf_atom_1cd2b24a()

			if not (not module2.IsInTable(v5, __wf_atom_1cd2b24a) or module2.IsInTable(v6, __wf_atom_1cd2b24a)) then
				continue
			end

			table.remove(mergeTables, i)
		end

		v12 = module2.RandomizeTableOrder(mergeTables)
	end

	local randomizeTableOrder = module2.RandomizeTableOrder(v13)
	module2.FilterObjectsInZone(__wf_atom_e800787c, randomizeTableOrder)
	local __wf_atom_2b1fe281 = creator:__wf_atom_2b1fe281()

	if __wf_atom_2b1fe281 > 0 then
		npcCount = __wf_atom_2b1fe281
	end

	local enemyLevel = module.GetEnemyLevel(creator)
	local v14 = Range(0.1, 0.4)
	local count = 0

	for i = 1, npcCount do
		local v15 = nil
		local v16 = nil

		if __wf_atom_7e8ad928(randomizeTableOrder) or not (#randomizeTableOrder > 0) then
			if not __wf_atom_7e8ad928(v12) and #v12 > 0 then
				v16 = v12[1]
			end
		else
			v15 = randomizeTableOrder[1]
		end

		local v17 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
		local npcAgentType = npcAgentTypes[__wf_atom_5784a397(1, #npcAgentTypes)]
		local v18

		if not __wf_atom_7e8ad928(npcAgentType) then
			if __wf_atom_7e8ad928(v15) then
				if __wf_atom_7e8ad928(v16) then
					local randomPointInRangeOnNav = v9:GetRandomPointInRangeOnNav(position, 2, v11, true, 0.5)
					local v19 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					v18 = v9:__wf_atom_402b3832(npcAgentType, randomPointInRangeOnNav, v19, Symbol("RandomTeam"), v17)
				else
					local randomPointInRangeOnNav = v9:GetRandomPointInRangeOnNav(v16:GetPosition(), 0, 3, true, 0.5)
					local v19 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					v18 = v9:__wf_atom_402b3832(npcAgentType, randomPointInRangeOnNav, v19, Symbol("RandomTeam"), v17)
					table.remove(v12, 1)
				end
			else
				local __wf_atom_0b636f17 = v15:__wf_atom_0b636f17()

				if not __wf_atom_7e8ad928(__wf_atom_0b636f17) then
					npcAgentType = __wf_atom_0b636f17
				end

				v18 = v9:CreateAgent(npcAgentType, v15, Symbol("RandomTeam"), v17)
				table.remove(randomizeTableOrder, 1)
			end
		end

		fn2(v18:__wf_atom_50a7d83e())

		if __wf_atom_7e8ad928(v18) then
			count += 1
			print("Failed to spawn agent due to no spawn point found. This is needed for conditions like NPC spawning in houses at night time.")
		else
			creator:__wf_atom_97f955c1(v18)
			count += 1
		end

		if i < npcCount then
			Sleep(__wf_atom_104bfe98(v14.minValue, v14.maxValue, math.random()))
		end

		if module.ShouldShutDown(creator) then
			break
		end
	end
end

function Start(object)
	v9 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return
	end

	position = object:GetPosition()
	v11 = object:__wf_atom_103377cc()
	creator = object
	creator:__wf_atom_8e6fec76(1)
	fn4()

	if __wf_atom_7e8ad928(creator) then
		print("Shutdown due to level streaming")
		return
	end

	creator:__wf_atom_2cc8420c(creator:__wf_atom_dd85e6db())
	creator:__wf_atom_8e6fec76(2)
	local v12 = math.random() <= chanceToSpellbreak

	while not module.ShouldShutDown(creator) and creator:__wf_atom_3634e6d2() > 0 do
		v10 = creator:__wf_atom_6199ef01()
		module.CleanUpOutOfRangeEnemies(creator, v10)

		if debugDraw then
			module.DebugDrawAgents(v10, v)
		end

		if v12 and #v10 > 0 then
			v10[__wf_atom_5784a397(1, #v10)]:__wf_atom_50a7d83e():Attach(
				spellbreakLookTriggerType,
				EMPTY_SYMBOL,
				Vector(0, 2, 0),
				__wf_atom_80368bb1,
				creator
			)
			v12 = false
		end

		Sleep(0)
	end

	if __wf_atom_7e8ad928(creator) then
		print("Shutdown due to level streaming")
		return
	end

	if creator:__wf_atom_3634e6d2() == 0 then
		creator:__wf_atom_050639fe()
		creator:__wf_atom_8776856a(0)
		creator:__wf_atom_8e6fec76(4)
	else
		creator:__wf_atom_8776856a(#v10)
		creator:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(creator) then
		print("Shutdown due to level streaming")
		return
	end

	module.RemoveAgents(creator)
	Sleep(0)
end

function SpellBreak(_, instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()
	local __wf_atom_30e3d82b = __wf_atom_3d96ddcd:__wf_atom_30e3d82b()
	__wf_atom_30e3d82b:__wf_atom_cdd21129()
	__wf_atom_30e3d82b:__wf_atom_920a5a62()
	creator = instance:GetCreator()
	v11 = creator:__wf_atom_103377cc()
	v10 = creator:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(creator, v10)
	local v12 = fn()

	if v12 == 0 then
		instance:Destroy()
		return
	end

	if not (__wf_atom_7e8ad928(__wf_atom_3d96ddcd) or __wf_atom_3d96ddcd:IsKilled()) then
		fn3(__wf_atom_3d96ddcd)
		local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(__wf_atom_46b5a019, __wf_atom_3d96ddcd:GetPosition(), 2)

		if not __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
			__wf_atom_e2db08ce:Disable()
		end

		__wf_atom_3d96ddcd:SetFaction(v8)
		__wf_atom_3d96ddcd:__wf_atom_2f3f52aa(5)
		__wf_atom_3d96ddcd:SetHealth(__wf_atom_5784a397(10, 50))
		__wf_atom_30e3d82b:__wf_atom_aa4361c1(Symbol("Flee"), creator)
		__wf_atom_30e3d82b:__wf_atom_6bb5f08a(Symbol("Grineer"))
		__wf_atom_30e3d82b:__wf_atom_f54283ea()
	end

	local v13 = math.random(spellbreakDetectionDelay.minValue, spellbreakDetectionDelay.maxValue)
	Sleep(v13)
	local flag = false

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) and not __wf_atom_3d96ddcd:IsKilled() and #v12 > 0 then
		__wf_atom_3d96ddcd:__wf_atom_7470861b():__wf_atom_c2d9fb01(1)
		local copyTable = module2.CopyTable(v12)
		local sortByDistance = module2.SortByDistance(copyTable, __wf_atom_3d96ddcd:GetPosition(), false)
		local v14 = sortByDistance[1]
		local v15

		if not (__wf_atom_7e8ad928(v14) or v14:IsKilled()) then
			v15 = v14:__wf_atom_30e3d82b()
		end

		for _, v16 in ipairs(sortByDistance) do
			if __wf_atom_7e8ad928(v16) or v16:IsKilled() then
				continue
			end

			local __wf_atom_30e3d82b2 = v16:__wf_atom_30e3d82b()

			if not module.IsRangedAgent(__wf_atom_30e3d82b2) then
				continue
			end

			v14 = v16
			v15 = __wf_atom_30e3d82b2
			flag = true
			break
		end

		if not (__wf_atom_7e8ad928(v15) or __wf_atom_7e8ad928(v14) or v14:IsKilled()) then
			gRegion:PlaySound(whistleAlertSound, v14:GetPosition(), false, 0, nil, nil, nil, true)
			v15:__wf_atom_30b587a4()

			if flag then
				v15:SetTarget(__wf_atom_3d96ddcd)
				local v16 = math.random(3, 10)
				v15:__wf_atom_ae219cdf(__wf_atom_3d96ddcd, v16, true, true)
				Sleep(v16)

				if not (__wf_atom_7e8ad928(instance) or __wf_atom_7e8ad928(v15)) then
					v15:__wf_atom_920a5a62()
				end
			else
				v15:StormTarget(__wf_atom_3d96ddcd)
			end
		end
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end