local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("SF.Scripts.Libs.QuestLib")
local module5 = require("Lotus.Scripts.Libs.AudioLib")
Symbol("MendicantKingSpawned")
local v = nil
local position = nil
local v2 = nil
local v3 = nil
local v4 = nil
local kingDeco2 = nil
local v5 = Symbol("Guard")
Symbol("PatrolEncounterPlayer")
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = nil
local overrideSpawnDistanceRange2 = nil
local v10 = Symbol("RandomTeam")
local v11 = nil
local v12 = nil
local v13 = nil

local function fn()
	if __wf_atom_7e8ad928(bossAgentType) or __wf_atom_7e8ad928(v2) then
		return
	end

	local position2 = v2:GetPosition()
	local __wf_atom_dc309f8a = v2:__wf_atom_dc309f8a()

	if not __wf_atom_7e8ad928(kingDeco2) then
		position2 = kingDeco2:GetPosition()
		__wf_atom_dc309f8a = kingDeco2:__wf_atom_dc309f8a()
	end

	local pointInstances = module.FindPointInstances(v2, nil, Symbol("MendicantSpawnForwarder"))
	local bossLevelOverride2

	if bossLevelOverride > 0 then
		bossLevelOverride2 = bossLevelOverride
	elseif
		__wf_atom_7e8ad928(questRef)
		or not module2.IsInOverworld()
		or module4.HasCompletedQuest(questRef) and not module4.QuestIsActive(questRef)
	then
		local enemyLevel = module.GetEnemyLevel(v2)
		bossLevelOverride2 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
	else
		bossLevelOverride2 = questEnemyLevelRangeOveride
	end

	v6 = v:__wf_atom_402b3832(
		bossAgentType,
		position2,
		__wf_atom_dc309f8a,
		module.DEFAULT_TEAM,
		bossLevelOverride2,
		nil
	)

	if __wf_atom_7e8ad928(v6) then
		return false
	end

	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("MendicantDV"))
	local v14 = -1
	local v15 = 99999999

	for i = 1, #__wf_atom_2226b35c do
		if __wf_atom_7e8ad928(__wf_atom_2226b35c[i]) then
			continue
		end

		if v14 < 0 then
			v15 = __wf_atom_2226b35c[i]:__wf_atom_c215662d(position2)
			v14 = i
		else
			local __wf_atom_c215662d = __wf_atom_2226b35c[i]:__wf_atom_c215662d(position2)

			if __wf_atom_c215662d < v15 then
				v15 = __wf_atom_c215662d
				v14 = i
			end
		end
	end

	if v14 > 0 then
		v6:__wf_atom_243da0d3(__wf_atom_2226b35c[v14], true)
	end

	v2:__wf_atom_97f955c1(v6)
	v7 = v6:__wf_atom_50a7d83e()
	v7:SetBlackboardBool(Symbol("IsReady"), false)
	v7:__wf_atom_7c8621d6()
	v7:__wf_atom_17e77e5b(Localize(bossName, nil))
	v7:__wf_atom_5cb037b2(Symbol(bossName))
	v7:SetVisibility(false)
	v7:__wf_atom_d1b42aad(false)
	v7:__wf_atom_30964595(false)
	v7:__wf_atom_0ed81088(false)
	v7:SetDisableGravity(true)
	v7:Teleport(v:__wf_atom_0e0a6fee(position2), __wf_atom_dc309f8a)
	module2.SetImmunity(v7, true)
	v8 = module2.FindTaggedChild(v7:__wf_atom_be0bea4a(), Symbol("BossAwarenessTrigger"))

	if __wf_atom_7e8ad928(v8) then
		v8 = v7:Attach(
			Resource("/SF/Types/Enemies/Bosses/ReplicatedPlayerAwarenessScriptTrigger"),
			Symbol("GAME_C1_SPINE1"),
			__wf_atom_28d5d4aa,
			__wf_atom_80368bb1
		)
	end

	v8:__wf_atom_400189c4(bossBarActivationRadius)

	if not __wf_atom_7e8ad928(kingDeco2) then
		kingDeco2:__wf_atom_921c1a5f(spawnAnimation, false, false)
	end

	v7:__wf_atom_52bae0cc(spawnAnimation, 4, true)
	v13 = v7:Attach(mndBossMusic, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, nil)
	module5.EnableTaggedSoundSysVolumes(Symbol("MusicMendicantKing"), true)
	v7:__wf_atom_8914dfde("ShowBoss", 5)

	for _, pointInstance in pairs(pointInstances) do
		pointInstance:FirePort("TriggerPort")
	end

	if not __wf_atom_7e8ad928(kingDeco2) then
		kingDeco2:Destroy()
	end

	v7:SetVisibility(true)
	v7:__wf_atom_d1b42aad(true)
	v7:__wf_atom_30964595(true)
	v7:__wf_atom_0ed81088(true)
	v7:SetDisableGravity(false)

	while v7:__wf_atom_c138b19b(spawnAnimation, false) do
		Sleep(0)
	end

	module2.SetImmunity(v7, false)
	v8:Enable()
	v7:SetBlackboardBool(Symbol("IsReady"), true)
end

function PreSpawn(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
		Symbol("GladesShockwaveBell"),
		__wf_atom_3d96ddcd:GetPosition(),
		0,
		50
	)

	if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		return
	end

	local v14 = __wf_atom_f738b4af:Attach(soulModeOverlayType, EMPTY_SYMBOL)
	local v15 = __wf_atom_f738b4af:Attach(soulSphereType, EMPTY_SYMBOL, Vector(0, -2, 0))
	__wf_atom_3d96ddcd:__wf_atom_d494454b(v14)
	__wf_atom_3d96ddcd:__wf_atom_d494454b(v15)
	CreateKingDeco(__wf_atom_3d96ddcd)
end

function PostSpawn(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	__wf_atom_3d96ddcd:__wf_atom_26b04ea9()
	local v14 = nil

	for _, v15 in pairs(__wf_atom_3d96ddcd:__wf_atom_6199ef01()) do
		if v15:IsA(bossAgentType) then
			v14 = v15
		end
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
		Symbol("GladesShockwaveBell"),
		__wf_atom_3d96ddcd:GetPosition(),
		0,
		50
	)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		module2.RemoveAttachments(__wf_atom_f738b4af, soulModeOverlayType)
		module2.RemoveAttachments(__wf_atom_f738b4af, soulSphereType)
	end

	if __wf_atom_7e8ad928(v14) then
		print("No boss agent found!")
		return
	end

	local __wf_atom_50a7d83e = v14:__wf_atom_50a7d83e()
	local kingDeco

	if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		kingDeco = __wf_atom_3d96ddcd:__wf_atom_e919fb8e().kingDeco
	end

	if not __wf_atom_7e8ad928(kingDeco) then
		kingDeco:__wf_atom_921c1a5f(spawnAnimation, false, false)
	end

	__wf_atom_50a7d83e:SetVisibility(false)
	__wf_atom_50a7d83e:__wf_atom_8914dfde("ShowBoss", 2)

	if not __wf_atom_7e8ad928(kingDeco) then
		kingDeco:Destroy()
	end

	__wf_atom_50a7d83e:SetVisibility(true)
	v2 = __wf_atom_3d96ddcd
	SpawnEnemies()
end

function CreateKingDeco(object)
	for _, v14 in pairs(object:__wf_atom_fe00d825()) do
		if not v14:IsA(mendicantKingDeco) then
			continue
		end

		kingDeco2 = v14
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.kingDeco = kingDeco2
		return
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("MendicantKingSpawn"), object:GetPosition(), 0, 15)

	if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		__wf_atom_f738b4af = object
	end

	local groundPos = module3.GetGroundPos(__wf_atom_f738b4af:GetPosition())

	if not __wf_atom_7e8ad928(mendicantKingDeco) then
		local groundAlignedSpawnPosRot, _ = module3.GetGroundAlignedSpawnPosRot(
			mendicantKingDeco,
			groundPos,
			__wf_atom_f738b4af:__wf_atom_dc309f8a()
		)

		if enableDebug then
			gRegion:__wf_atom_8d991675(groundAlignedSpawnPosRot, 3, __wf_atom_f738b4af:__wf_atom_dc309f8a(), 3)
		end

		kingDeco2 = gRegion:CreateEntity(
			mendicantKingDeco,
			groundAlignedSpawnPosRot,
			__wf_atom_f738b4af:__wf_atom_dc309f8a()
		)
		object:__wf_atom_d494454b(kingDeco2)
		local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
		__wf_atom_e919fb8e.kingDeco = kingDeco2
	end
end

local function fn2()
	local result = {}
	local v14 = {}
	local pointInstances = module.FindPointInstances(v2, __wf_atom_96b9d246)

	if not __wf_atom_7e8ad928(pointInstances) and #pointInstances > 0 then
		for _, pointInstance in ipairs(pointInstances) do
			local __wf_atom_dcc0a6f8 = pointInstance:__wf_atom_dcc0a6f8()

			if not (#__wf_atom_dcc0a6f8 > 0) then
				continue
			end

			table.insert(result, {
				spawnPoints = pointInstance:__wf_atom_f7c1604d(#__wf_atom_dcc0a6f8),
				spawnCount = math.min(
					module2.Round(pointInstance:__wf_atom_1d28ac91() * scaledSpawnMult[__wf_atom_421b01aa(v4, 1, #scaledSpawnMult)]),
					20
				)
			})

			for _, v15 in ipairs(__wf_atom_dcc0a6f8) do
				table.insert(v14, v15)
			end
		end
	end

	local pointInstances2 = module.FindPointInstances(v2, gNpcSpawnPointType)
	return result, (module2.MergeTables(v14, pointInstances2, true))
end

local function fn3()
	local v14 = not module2.IsInOverworld()
	position = v2:GetPosition()
	overrideSpawnDistanceRange2 = Range(0, v2:__wf_atom_103377cc())
	local v15

	if v14 then
		v15 = gRegion:FindAll(
			gNpcSpawnPointType,
			position,
			overrideSpawnDistanceRange2.minValue,
			overrideSpawnDistanceRange2.maxValue + 1
		)
	else
		v15 = gRegion:FindAll(
			gNpcSpawnPointType,
			position,
			overrideSpawnDistanceRange2.minValue,
			overrideSpawnDistanceRange2.maxValue * 1.5
		)

		for i = #v15, 1, -1 do
			if v15[i]:IsEnabled() then
				if v15[i]:__wf_atom_a5304c35(position) > overrideSpawnDistanceRange2.maxValue + 2 then
					table.remove(v15, i)
				end
			else
				table.remove(v15, i)
			end
		end
	end

	if v14 then
		local layerIndex = module2.GetLayerIndex(v2)
		module2.FilterObjectsInLayerIndex(layerIndex, v15)
	end

	local randomizeTableOrder = module2.RandomizeTableOrder(v15)
	return (module.FilterDisallowedSpawnpoints(randomizeTableOrder))
end

local function fn4()
	local v14 = nil
	local encounterChillout = module.GetEncounterChillout(v2)
	local v15

	if encounterChillout then
		v15 = false
	else
		v15 = module.GetEncounterBoostEnemies(v2)
	end

	local maxValue = __wf_atom_5784a397(baseSpawnCount.minValue, baseSpawnCount.maxValue)

	if encounterChillout then
		maxValue = math.ceil(maxValue * 0.5)
	elseif v15 then
		maxValue = baseSpawnCount.maxValue
	end

	if #scaledSpawnMult >= 1 then
		return module2.Round(maxValue * scaledSpawnMult[__wf_atom_421b01aa(v4, 1, #scaledSpawnMult)]), v14, v15
	end

	return maxValue, v14, v15
end

local function fn5(list)
	local v14

	if not (limitOvercrowdingRadius > 0) then
		return v14
	end

	local __wf_atom_e0730826 = v:__wf_atom_e0730826(v2, limitOvercrowdingRadius, false)
	v14 = 0

	for _, v15 in ipairs(__wf_atom_e0730826) do
		local __wf_atom_50a7d83e = v15:__wf_atom_50a7d83e()

		if
			__wf_atom_7e8ad928(__wf_atom_50a7d83e)
			or __wf_atom_50a7d83e:IsKilled()
			or __wf_atom_50a7d83e:__wf_atom_e93896ba() ~= faction
		then
			continue
		end

		v14 -= 1
	end

	for _, v15 in ipairs(list) do
		v14 += v15.spawnCount
	end

	return v14
end

function SpawnEnemies()
	v = module2.WaitForAiDir()
	v4 = math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 3)
	local v14, v15 = fn2()
	local v16 = fn3()
	local mergeTables = module2.MergeTables(v15, v16, true)
	local spawnCount2, _, _ = fn4()

	if #v14 == 0 then
		table.insert(v14, { spawnPoints = mergeTables, spawnCount = spawnCount2 })
	end

	local knightLevelOverride2

	if module.IsHardModeActive() then
		knightLevelOverride2 = Range(module.GetHardEnemyModeLevel(), module.GetHardEnemyModeLevel() + 2)
	elseif knightLevelOverride.minValue > 0 then
		knightLevelOverride2 = knightLevelOverride
	elseif
		__wf_atom_7e8ad928(questRef)
		or not module2.IsInOverworld()
		or module4.HasCompletedQuest(questRef) and not module4.QuestIsActive(questRef)
	then
		knightLevelOverride2 = module.GetEnemyLevel(v2)
	else
		knightLevelOverride2 = questEnemyLevelRangeOveride
	end

	local v17 = fn5(v14)

	if not __wf_atom_7e8ad928(v17) and v17 <= 0 then
		print("Enemy cap is <= 0")
		return
	end

	local v18 = v2:__wf_atom_2b1fe281() % 100
	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local count = 0

	for _, v19 in ipairs(v14) do
		local spawnPoints = v19.spawnPoints
		local spawnCount = v19.spawnCount
		local v20 = Range(0.05, 0.15)
		local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(
			position,
			overrideSpawnDistanceRange2,
			spawnCount
		)

		for i = 1, spawnCount do
			local v21

			if not (__wf_atom_7e8ad928(spawnPoints) or not (#spawnPoints > 0)) then
				v21 = spawnPoints[1]
			end

			local v22 = __wf_atom_5784a397(knightLevelOverride2.minValue, knightLevelOverride2.maxValue)
			local knightAgents = knightAgents
			local v23

			if not __wf_atom_7e8ad928(knightAgents) then
				if __wf_atom_7e8ad928(v21) then
					local randomPointInRangeOnNav

					if #randomSpawnsOnNavInRange > 0 then
						randomPointInRangeOnNav = randomSpawnsOnNavInRange[#randomSpawnsOnNavInRange]
						table.remove(randomSpawnsOnNavInRange, #randomSpawnsOnNavInRange)
					else
						randomPointInRangeOnNav = v:GetRandomPointInRangeOnNav(
							position,
							math.max(overrideSpawnDistanceRange2.minValue, 2),
							overrideSpawnDistanceRange2.maxValue,
							true,
							0.5
						)
					end

					local v24 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)

					if spawnAlert then
						local nearestObject = module2.NearestObject(randomPointInRangeOnNav, __wf_atom_ef7900cf)

						if not __wf_atom_7e8ad928(nearestObject) then
							v24 = __wf_atom_fa8d0177(randomPointInRangeOnNav, nearestObject:GetPosition())
						end
					end

					v23 = v:__wf_atom_402b3832(knightAgents, randomPointInRangeOnNav, v24, v10, v22)
				else
					local __wf_atom_66a525a6 = v21:__wf_atom_66a525a6()

					if __wf_atom_66a525a6 > 0 then
						v22 = __wf_atom_66a525a6
					end

					v23 = v:CreateAgent(knightAgents, v21, v10, v22)
					table.remove(spawnPoints, 1)
				end

				module.IsHeavyAgent(v23)
			end

			if __wf_atom_7e8ad928(v23) then
				print("Failed to spawn agent")
			else
				v2:__wf_atom_97f955c1(v23)
				count += 1
				v23:__wf_atom_03cc4f3c(v5, position, guardRadiusWhenAllAlerted)
				local __wf_atom_50a7d83e = v23:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					__wf_atom_50a7d83e:SetVisibility(false)
					__wf_atom_50a7d83e:__wf_atom_52bae0cc(knightSpawnAnim, 4, true)
					__wf_atom_50a7d83e:SetVisibility(true)
				end

				if v18 > 0 and v18 <= count then
					print("Restored up to previous enemy count")
					return
				end

				if not __wf_atom_7e8ad928(v17) and v17 <= count then
					print("Spawn cap reached")
					return
				end
			end

			if i < spawnCount2 then
				Sleep(__wf_atom_104bfe98(v20.minValue, v20.maxValue, math.random()))
			end

			if module.ShouldShutDown(v2) then
				return
			end
		end
	end
end

function GiveLoreDrop(p, p2, p3)
	if not __wf_atom_7e8ad928(p2) then
		if p3 == EMPTY_SYMBOL then
			module2.GiveLoreFragment(p2, p)
		else
			module2.GiveLoreFragmentMemory(p2, p, p3)
		end
	end
end

local function fn6()
	v3 = v2:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(v2, v3)

	if #v3 > 0 then
		return true
	end

	local pointInstances = module.FindPointInstances(
		v2,
		WeakResource("/SF/Types/Game/EncounterCustomBoundsTrigger"),
		Symbol("EncounterCustomBoundsTrigger")
	)

	if __wf_atom_7e8ad928(pointInstances) or not (#pointInstances > 0) then
		return true
	end

	print("Waiting for custom trigger...")

	while not module.ShouldShutDown(v2) do
		local __wf_atom_b7c04e13 = v2:__wf_atom_b7c04e13()

		for _, pointInstance in ipairs(pointInstances) do
			if __wf_atom_7e8ad928(pointInstance) then
				return false
			end

			for _, v14 in ipairs(__wf_atom_b7c04e13) do
				if
					__wf_atom_7e8ad928(v14)
					or v14:IsKilled()
					or not pointInstance:__wf_atom_1eaf335c(v14:GetPosition())
				then
					continue
				end

				if not pointInstance:IsEnabled() then
					continue
				end

				print("Custom trigger, starting enemy spawns")
				return true
			end
		end

		Sleep(0.1)
	end

	return false
end

local function fn7() -- 2 equivalent calls inferred from this helper
	return (Symbol("MendicantKing-SubBoss"))
end

local function fn8(object)
	v = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return false
	end

	v2 = object:__wf_atom_26b04ea9() or object
	v9 = object:__wf_atom_dd85e6db()
	position = object:GetPosition()
	overrideSpawnDistanceRange2 = Range(0, object:__wf_atom_103377cc())
	local all = gRegion:FindAll(bossAgentType:__wf_atom_c6772fb4())

	if #all > 0 then
		v7 = all[1]
		v6 = v7:__wf_atom_30e3d82b()
		v13 = gRegion:__wf_atom_0a6a5887(bossMusicTag)
		v12 = module.DisableNearbyEncounters(v2, Range(0, 35), false)
		return true
	else
		if overrideSpawnDistanceRange.minValue > 0 and overrideSpawnDistanceRange.maxValue > 0 then
			overrideSpawnDistanceRange2 = overrideSpawnDistanceRange
		end

		if __wf_atom_7e8ad928(gGameData) then
			print("Game Data is null!")
			return false
		end

		local v14 = fn7() -- inferred equivalent call

		if not gGameData:__wf_atom_20bf298d(v14) then
			return
		end

		v12 = module.DisableNearbyEncounters(v2, Range(0, 35), false)

		if not __wf_atom_7e8ad928(randomCombatBlockingContainerType) then
			v11 = module.SpawnCombatBlockingContainer(randomCombatBlockingContainerType, object:GetPosition())
		end

		CreateKingDeco(v2)

		if not fn6() then
			print("Shutdown due to level streaming")
			return false
		end

		SpawnEnemies()
		fn()
		Sleep(0)

		if __wf_atom_7e8ad928(v2) then
			print("Shutdown due to level streaming")
			return false
		end

		v2:__wf_atom_2cc8420c(v2:__wf_atom_dd85e6db())
		return true
	end
end

local function fn9()
	v2:__wf_atom_4026dfb5()
	local flag = false

	while not module.ShouldShutDown(v2) do
		v3 = v2:__wf_atom_6199ef01()
		module.CleanUpOutOfRangeEnemies(v2, v3)

		if not flag then
			for _, v14 in ipairs(v3) do
				if not v14:__wf_atom_04ea4887() then
					continue
				end

				flag = true
				break
			end

			if flag then
				for _, v14 in ipairs(v3) do
					v14:__wf_atom_30b587a4()

					if guardRadiusWhenAllAlerted > 0 then
						v14:__wf_atom_03cc4f3c(v5, position, guardRadiusWhenAllAlerted)
					end
				end
			end
		end

		if __wf_atom_7e8ad928(v7) then
			v2:__wf_atom_8e6fec76(4)
			break
		end

		if v7:IsKilled() then
			v2:__wf_atom_8e6fec76(4)
			local v14 = fn7() -- inferred equivalent call
			gGameData:__wf_atom_a975522c(v14, 1800, true, "")
			module5.EnableTaggedSoundSysVolumes(Symbol("MusicMendicantKing"), false)

			if __wf_atom_7e8ad928(v13) then
				break
			end

			v13:Destroy()
			break
		else
			Sleep(1)
		end
	end

	if v2:__wf_atom_4026dfb5() == 4 then
		if not __wf_atom_7e8ad928(loreDrop) and gRegion:IsMaster() then
			local __wf_atom_b7c04e13 = v2:__wf_atom_b7c04e13()

			for _, v14 in ipairs(__wf_atom_b7c04e13) do
				GiveLoreDrop(loreDrop, v14, loreMemeorySymbol)
			end
		end

		if firePostFightPorts then
			for _, v14 in ipairs(postFightPorts) do
				local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(v14, v2:GetPosition(), 0, 100)
				Sleep(delay)
				__wf_atom_f738b4af:FirePort("TriggerPort")
			end
		end
	end
end

local function fn10()
	if __wf_atom_7e8ad928(v2) then
		print("Shutdown due to level streaming")
		return
	end

	if v2:__wf_atom_3634e6d2() == 0 then
		v2:__wf_atom_050639fe()
		v2:__wf_atom_8776856a(0)
		v2:__wf_atom_8e6fec76(4)

		if module2.IsInOverworld() then
			while not __wf_atom_7e8ad928(v2) and v2:__wf_atom_e464a32f() > 0 and v:__wf_atom_c6f505f2(v2) > 0 do
				Sleep(0)
			end
		else
			v2:Disable()
		end
	else
		local v14 = #v3
		v2:__wf_atom_8776856a(v14)
		v2:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(v2) then
		print("Shutdown due to level streaming")
		return
	end

	if not __wf_atom_7e8ad928(v12) then
		for _, v14 in ipairs(v12) do
			if __wf_atom_7e8ad928(v14) or v14 == v2 then
				continue
			end

			v14:Enable()
		end
	end

	if not __wf_atom_7e8ad928(v11) then
		v11:Destroy()
	end

	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(throneMoverTag, v2:GetPosition(), 0, 15)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		__wf_atom_f738b4af:__wf_atom_d815cb96()
	end

	module.RemoveAgents(v2)
	module.RemoveObjects(v2)
	Sleep(0)
end

function StartMendicantKingEncounter(object)
	if not fn8(object) then
		return
	end

	object:__wf_atom_8e6fec76(2)
	fn9()
	fn10()
end