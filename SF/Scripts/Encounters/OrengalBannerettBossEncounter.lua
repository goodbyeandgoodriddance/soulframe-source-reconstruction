local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
require("SF.Scripts.Libs.StatsLib")
require("SF.Scripts.Libs.RaycastLib")
local module3 = require("SF.Scripts.Libs.QuestLib")
local module4 = require("SF.Scripts.Libs.TransmissionSet")
local v = Symbol("RandomTeam")
local v2 = Color(0, 255, 0)
local v3 = nil
local position = nil
local v4 = nil
local v5 = nil
local v6 = nil
local overrideSpawnRange2 = nil
local v7 = false
local v8 = nil
local v9 = nil
local entities = {}
Symbol("InvulSymbol")
local v10 = nil
local flag = false
local reinforcementSpawnDelaytime2 = 0
local v11 = nil
local v12 = 1
local v13 = Symbol("BattleTank")
local v14 = nil

local function fn()
	if v4:__wf_atom_5b6b447d() ~= EMPTY_SYMBOL then
		return
	end

	if #trapTypes > 0 and trapChance > 0 and math.random() <= trapChance then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
			trapSpawnTag,
			position,
			minTrapSpawnDistanceFromHint,
			maxTrapSpawnDistanceFromHint
		)

		if #__wf_atom_439c0d29 > 0 then
			if pickSingleRandomTrapSpawn then
				local v15 = nil

				if __wf_atom_7e8ad928(v15) and #__wf_atom_439c0d29 > 0 then
					v15 = __wf_atom_439c0d29[__wf_atom_5784a397(1, #__wf_atom_439c0d29)]
				end

				if not __wf_atom_7e8ad928(v15) then
					local trapType = trapTypes[__wf_atom_5784a397(1, #trapTypes)]
					local entity = gRegion:CreateEntity(
						trapType,
						v15:GetPosition(),
						Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					)
					v4:__wf_atom_d494454b(entity)
					v15:FirePort("Disable")
				end
			else
				for _, v15 in ipairs(__wf_atom_439c0d29) do
					if __wf_atom_7e8ad928(v15) then
						continue
					end

					local trapType = trapTypes[__wf_atom_5784a397(1, #trapTypes)]
					local entity = gRegion:CreateEntity(
						trapType,
						v15:GetPosition(),
						Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					)
					v4:__wf_atom_d494454b(entity)
					v15:FirePort("Disable")
				end
			end
		end
	end
end

local function fn2()
	v5 = v4:__wf_atom_be637430()
	module.CleanUpOutOfRangeEnemies(v4, v5)

	if #v5 > 0 then
		return
	end

	local v15 = {}
	local v16 = {}
	v6 = math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 3)
	local pointInstances = module.FindPointInstances(v4, __wf_atom_96b9d246)

	if not __wf_atom_7e8ad928(pointInstances) and #pointInstances > 0 then
		for _, pointInstance in ipairs(pointInstances) do
			local __wf_atom_dcc0a6f8 = pointInstance:__wf_atom_dcc0a6f8()

			if not (#__wf_atom_dcc0a6f8 > 0) then
				continue
			end

			table.insert(v15, {
				spawnPoints = pointInstance:__wf_atom_f7c1604d(#__wf_atom_dcc0a6f8),
				spawnCount = math.min(
					module2.Round(pointInstance:__wf_atom_1d28ac91() * scaledSpawnMult[__wf_atom_421b01aa(v6, 1, #scaledSpawnMult)]),
					20
				)
			})

			for _, v17 in ipairs(__wf_atom_dcc0a6f8) do
				table.insert(v16, v17)
			end
		end
	end

	if useHintSpawns then
		local pointInstances2 = module.FindPointInstances(v4, gNpcSpawnPointType)
		v16 = module2.MergeTables(v16, pointInstances2, true)
	end

	if useFoundSpawns then
		local v17 = not module2.IsInOverworld()
		local v18

		if v17 then
			v18 = gRegion:FindAll(
				gNpcSpawnPointType,
				position,
				overrideSpawnRange2.minValue,
				overrideSpawnRange2.maxValue + 1
			)
		else
			v18 = gRegion:FindAll(
				gNpcSpawnPointType,
				position,
				overrideSpawnRange2.minValue,
				overrideSpawnRange2.maxValue * 1.5
			)

			for i = #v18, 1, -1 do
				if v18[i]:IsEnabled() then
					if v18[i]:__wf_atom_a5304c35(position) > overrideSpawnRange2.maxValue + 2 then
						table.remove(v18, i)
					end
				else
					table.remove(v18, i)
				end
			end
		end

		if v17 then
			local layerIndex = module2.GetLayerIndex(v4)
			module2.FilterObjectsInLayerIndex(layerIndex, v18)
		end

		local randomizeTableOrder = module2.RandomizeTableOrder(v18)
		v16 = module2.MergeTables(v16, randomizeTableOrder, true)
	end

	local filterDisallowedSpawnpoints = module.FilterDisallowedSpawnpoints(v16)
	local encounterChillout = module.GetEncounterChillout(v4)
	local v17

	if encounterChillout then
		v17 = false
	else
		v17 = module.GetEncounterBoostEnemies(v4)
	end

	local maxValue = __wf_atom_5784a397(baseSpawnCount.minValue, baseSpawnCount.maxValue)

	if encounterChillout then
		maxValue = math.ceil(maxValue * 0.5)
	elseif v17 then
		maxValue = baseSpawnCount.maxValue
	end

	if #scaledSpawnMult >= 1 then
		maxValue = module2.Round(maxValue * scaledSpawnMult[__wf_atom_421b01aa(v6, 1, #scaledSpawnMult)])
	end

	if #v15 == 0 then
		table.insert(v15, { spawnPoints = filterDisallowedSpawnpoints, spawnCount = maxValue })
	end

	local questEnemyLevelRangeOveride2

	if
		__wf_atom_7e8ad928(questRef)
		or not module2.IsInOverworld()
		or module3.HasCompletedQuest(questRef) and not module3.QuestIsActive(questRef)
	then
		questEnemyLevelRangeOveride2 = module.GetEnemyLevel(v4)
	else
		questEnemyLevelRangeOveride2 = questEnemyLevelRangeOveride
	end

	local v18 = v4:__wf_atom_2b1fe281() % 100
	local v19 = false
	local count = 0

	for i, v20 in ipairs(v15) do
		local spawnPoints = v20.spawnPoints
		local spawnCount = v20.spawnCount
		local v21 = Range(0.1, 0.4)
		local v22

		if doRandomGuardBehaviour then
			local v23 = math.floor(spawnCount * 0.5)
			v22 = module2.IsInOverworld()
				and #gRegion:__wf_atom_439c0d29(
					Symbol("PointOfInterest"),
					position,
					overrideSpawnRange2.minValue,
					overrideSpawnRange2.maxValue * 1.5
				) > 0
				and 0
				or v23
		else
			v22 = 0
		end

		local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(position, overrideSpawnRange2, spawnCount)

		for j = 1, spawnCount do
			local v23

			if not (__wf_atom_7e8ad928(spawnPoints) or not (#spawnPoints > 0)) then
				v23 = spawnPoints[1]
			end

			local v24 = __wf_atom_5784a397(questEnemyLevelRangeOveride2.minValue, questEnemyLevelRangeOveride2.maxValue)
			local v25

			if #customAgentTypes > 0 then
				if __wf_atom_7e8ad928(customAgentTypes[j]) then
					v25 = customAgentTypes[__wf_atom_5784a397(1, #customAgentTypes)]
				else
					v25 = customAgentTypes[j]
				end
			elseif v17 and not v19 and i == #v15 and j == spawnCount then
				v25 = module.GetRandomEnemyAgentType(v23, faction, v24, v4, 0, 2, true)
			else
				v25 = module.GetRandomEnemyAgentType(v23, faction, v24, v4)
			end

			local v26

			if not __wf_atom_7e8ad928(v25) then
				if __wf_atom_7e8ad928(v23) then
					local randomPointInRangeOnNav

					if #randomSpawnsOnNavInRange > 0 then
						randomPointInRangeOnNav = randomSpawnsOnNavInRange[#randomSpawnsOnNavInRange]
						table.remove(randomSpawnsOnNavInRange, #randomSpawnsOnNavInRange)
					else
						randomPointInRangeOnNav = v3:GetRandomPointInRangeOnNav(
							position,
							math.max(overrideSpawnRange2.minValue, 2),
							overrideSpawnRange2.maxValue,
							true,
							0.5
						)
					end

					local v27 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					v26 = v3:__wf_atom_402b3832(v25, randomPointInRangeOnNav, v27, v, v24)
				else
					local __wf_atom_66a525a6 = v23:__wf_atom_66a525a6()

					if __wf_atom_66a525a6 > 0 then
						v24 = __wf_atom_66a525a6
					end

					v26 = v3:CreateAgent(v25, v23, v, v24)
					table.remove(spawnPoints, 1)
				end

				if module.IsHeavyAgent(v26) then
					v19 = true
				end
			end

			if __wf_atom_7e8ad928(v26) then
				print("Failed to spawn agent")
			else
				if (holdPosition or j <= v22) and __wf_atom_7e8ad928(v26:__wf_atom_661f4a51()) then
					module.HoldPosition(v26, true)
				end

				v4:__wf_atom_97f955c1(v26)

				if not v7 then
					v7 = module.IsHeavyAgent(v26)
				end

				count += 1
				local __wf_atom_50a7d83e = v26:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					if factionOverride ~= EMPTY_SYMBOL then
						__wf_atom_50a7d83e:SetFaction(factionOverride)
					end

					if forceNonTargetable then
						__wf_atom_50a7d83e:__wf_atom_dd875cd8(true)
					end

					if spawnAlert then
						v26:__wf_atom_30b587a4()
						local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
						local nearestObject = module2.NearestObject(
							__wf_atom_50a7d83e:GetPosition(),
							__wf_atom_ef7900cf
						)

						if not __wf_atom_7e8ad928(nearestObject) then
							v26:StormTarget(nearestObject)
						end
					end
				end

				if v18 > 0 and v18 <= count then
					break
				end
			end

			if j < maxValue then
				Sleep(__wf_atom_104bfe98(v21.minValue, v21.maxValue, math.random()))
			end

			if module.ShouldShutDown(v4) then
				return
			end
		end
	end
end

local function fn3()
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("SiegeEngineSpawn"), position, 0, 10)
	local position2 = __wf_atom_f738b4af:GetPosition()
	local __wf_atom_dc309f8a = __wf_atom_f738b4af:__wf_atom_dc309f8a()

	if siegeEngineLevel > 0 then
		local _siegeEngineLevel = siegeEngineLevel
	else
		module.GetEnemyLevel(v4)
	end

	v8 = v3:__wf_atom_402b3832(
		seigeEningeType,
		position2,
		__wf_atom_dc309f8a,
		module.DEFAULT_TEAM,
		siegeEngineLevel,
		nil
	)
	v9 = v8:__wf_atom_50a7d83e()
	v9:__wf_atom_b811702e(Symbol("OrengallTank"))
	v9:__wf_atom_17e77e5b(Localize(seigeEngineName, nil))
	v9:__wf_atom_5cb037b2(Symbol(seigeEngineName))
	v9:__wf_atom_7470861b():__wf_atom_b6bcaf97(true)
	local v15 = v9:Attach(
		Resource("/SF/Types/Enemies/Bosses/ReplicatedPlayerAwarenessScriptTrigger"),
		Symbol("GAME_C1_SPINE1"),
		__wf_atom_28d5d4aa,
		__wf_atom_80368bb1
	)
	v15:Enable()
	v15:__wf_atom_400189c4(80)
end

local function fn4()
	if v4:__wf_atom_5b6b447d() ~= EMPTY_SYMBOL or __wf_atom_7e8ad928(explosives) then
		return
	end

	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("ExplosivesSpawn"), position, 0, 100)

	if #__wf_atom_439c0d29 > 0 then
		for _, v15 in ipairs(__wf_atom_439c0d29) do
			if __wf_atom_7e8ad928(v15) then
				continue
			end

			local entity = gRegion:CreateEntity(
				explosives,
				v15:GetPosition(),
				Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			)
			entity:__wf_atom_b811702e(Symbol("OdeExplosiveAmmo"))
			v4:__wf_atom_d494454b(entity)
			table.insert(entities, entity)
			v15:SetVisibility(false, true)
			v15:FirePort("Disable")
		end

		local __wf_atom_439c0d29_2 = gRegion:__wf_atom_439c0d29(Symbol("BarrelFXTrigger"), position, 0, 30)

		for _, v15 in ipairs(__wf_atom_439c0d29_2) do
			v15:FirePort("Execute")
		end
	end
end

local function fn5()
	if not module2.IsInOverworld() then
		return
	end

	for _, v15 in pairs(reinforcementEncounterTypes) do
		v3:AddEncounter(v15)
	end

	v10 = module.CreateReinforcementMgr(v3, v4)
	v10.mActivationStyle = module.AS_SPECIFIC_ENCOUNTER_TYPE
	v10.mActivationPosStyle = module.APS_ARRAY_POS
	v10.mSpecificEncounterTypes = reinforcementEncounterTypes
	v10.mIncludeChildHints = true
	v10.mMinNumAgents = { 2, 2, 2, 2 }
	v10.mMaxNumAgents = { 7, 7, 7, 7 }
	v10.mReinforceDelay = 10
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
		Symbol("ReinforcementHint"),
		position,
		0,
		v4:__wf_atom_103377cc()
	)
	v10.mActivationPoints = __wf_atom_439c0d29

	function v10.ShouldReinforce(data, _)
		if data.mReinforceDelay < data.mTimeSinceLastReinforcement and data.mNumAgents <= 2 and not flag then
			flag = true
		end

		if flag and reinforcementSpawnDelaytime2 <= 0 then
			flag = false
			reinforcementSpawnDelaytime2 = reinforcementSpawnDelaytime
			return true
		else
			return false
		end
	end
end

function CreateOrengallAssistManager(mHint)
	return {
		mHint = mHint,
		mNumAgents = 0,
		mMinAgentsAlive = 2,
		mTimeSinceLastOrengal = 0,
		mAmbushSpawnDelaytime = 5,
		mOrengalAsistTimeRange = 10,
		mShouldAmbush = false,
		mShouldAmbishTime = 0,
		mAmbushTrigger = nil,
		mPlayers = gRegion:__wf_atom_a8553251(),
		mAmbushTarget = nil,
		ShouldOrengalAttack = function(self)
			if
				self.mOrengalAsistTimeRange < self.mTimeSinceLastOrengal
				and self.mNumAgents >= self.mMinAgentsAlive
				and not self.mShouldAmbush
			then
				self.mShouldAmbush = true
			end

			if
				self.mShouldAmbush
				and self.mShouldAmbishTime <= 0
				and self.mNumAgents >= self.mMinAgentsAlive
				and __wf_atom_7e8ad928(self.mAmbushTrigger)
			then
				self.mShouldAmbush = false
				self.mShouldAmbishTime = self.mAmbushSpawnDelaytime
				return true
			else
				return false
			end
		end,
		Update = function(self, p)
			self.mTimeSinceLastOrengal += p
			self.mShouldAmbishTime -= p
			self.mNumAgents = self.mHint:__wf_atom_3634e6d2(true)

			if self:ShouldOrengalAttack() then
				local __wf_atom_be637430 = self.mHint:__wf_atom_be637430()

				for _, v15 in ipairs(__wf_atom_be637430) do
					if v15:__wf_atom_50a7d83e():__wf_atom_464a4772() then
						print("WolfTarget is vip Ignore target")
					else
						self.mPlayers = gRegion:__wf_atom_a8553251()

						for _, mPlayer in ipairs(self.mPlayers) do
							if not (Distance(mPlayer:GetPosition(), v15:__wf_atom_50a7d83e():GetPosition()) <= 5) then
								continue
							end

							self.mAmbushTarget = v15:__wf_atom_50a7d83e()
							break
						end
					end
				end

				if __wf_atom_7e8ad928(self.mAmbushTarget) or self.mAmbushTarget:IsKilled() then
					print("Trigger is active waiting for you to look at it.")
				else
					self.mAmbushTrigger = self.mAmbushTarget:Attach(
						Resource("/SF/Types/Quests/OmenBeastQuests/OrengallQuestAssets/OrengallNoConvoSummonTrigger"),
						Symbol("GAME_C1_SPINE1"),
						__wf_atom_28d5d4aa,
						__wf_atom_80368bb1
					)
					print("Orengal back up has arrived")
				end
			end
		end
	}
end

function RemoveNpc(instance)
	Sleep(10)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local v15 = 2.5

	while v15 >= 0 do
		instance:__wf_atom_a763aa1a(__wf_atom_421b01aa(1 - v15 / 5, 0, 1))
		Sleep(0)
		v15 -= __wf_atom_03df4e1d()
	end

	instance:Destroy()
end

function RemaniningAgentsEscape()
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("FleePoint"))
	local __wf_atom_be637430 = v4:__wf_atom_be637430()

	for _, v15 in pairs(__wf_atom_be637430) do
		if v15:__wf_atom_50a7d83e() == nil then
			continue
		end

		v15:MoveTo(__wf_atom_0a6a5887, true, true, false)
		v15:__wf_atom_50a7d83e():__wf_atom_8a035cd5(Symbol("RemoveNpc"), false)
	end
end

local function fn6(p, object)
	if __wf_atom_7e8ad928(bossTransmissionSet) or __wf_atom_7e8ad928(object) then
		return
	end

	if gRegion:IsMaster() then
		if __wf_atom_7e8ad928((object:__wf_atom_30e3d82b())) then
			return
		end

		if v12 <= 0 then
			module4.PlayRadialTransmission(bossTransmissionSet, p, object:GetPosition(), 100)
			v12 = __wf_atom_5784a397(transmissionInterval.minValue, transmissionInterval.maxValue)
		end
	end
end

function Initialize(object)
	v3 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return
	end

	local v15 = false

	if devModeOnly then
		print("Early out, WIP encounter at " .. object:__wf_atom_5b41f63b())
		object:Disable()
	else
		v14 = gRegion:__wf_atom_2226b35c(Symbol("LeadUpDialogue"))
		position = object:GetPosition()
		overrideSpawnRange2 = Range(0, object:__wf_atom_103377cc())
		v4 = object

		if overrideSpawnRange.minValue > 0 and overrideSpawnRange.maxValue > 0 then
			overrideSpawnRange2 = overrideSpawnRange
		end

		v4:__wf_atom_8e6fec76(1)
		fn2()
		fn3()
		fn4()

		if __wf_atom_7e8ad928(v4) then
			print("Shutdown due to level streaming")
			return
		end

		fn()
		v4:__wf_atom_2cc8420c(v4:__wf_atom_dd85e6db())
		v4:__wf_atom_8e6fec76(2)
		flag = false
		reinforcementSpawnDelaytime2 = reinforcementSpawnDelaytime
		fn5()

		while not module.ShouldShutDown(v4) do
			v5 = v4:__wf_atom_be637430()
			module.CleanUpOutOfRangeEnemies(v4, v5)

			if __wf_atom_7e8ad928(v9) then
				v4:__wf_atom_8e6fec76(6)
				break
			end

			if v9:__wf_atom_bb81a9df() >= 0.1 then
				local __wf_atom_06db1fb1 = gRegion:__wf_atom_06db1fb1(v4:GetPosition(), 100)

				if
					not __wf_atom_7e8ad928(__wf_atom_06db1fb1)
					and v3:__wf_atom_37241977(__wf_atom_06db1fb1:__wf_atom_a96eb2aa())
				then
					local v16 = __wf_atom_084b3e93()

					if flag then
						reinforcementSpawnDelaytime2 -= v16
					end

					if not __wf_atom_7e8ad928(v10) then
						v10:Update(v16)
					end

					if not __wf_atom_7e8ad928(v11) then
						v11:Update(v16)
					end

					local flag2 = true
					local flag3

					for _, v17 in ipairs(v14) do
						if not v17:IsEnabled() then
							continue
						end

						flag3 = false
						flag2 = false
						break
					end

					if flag2 then
						flag3 = true
					end

					if flag3 then
						fn6(v13, v9)
						v12 -= v16
					end
				end
			end

			if v9:__wf_atom_bedb4e3f() or v9:IsKilled() and v15 == false then
				if #v14 >= 1 then
					for _, v16 in ipairs(v14) do
						if v16:IsEnabled() then
							v16:Disable()
						end
					end
				end

				v9:SetBlackboardBool(Symbol("TankBossDefeated"), true)
				RemaniningAgentsEscape()
				Sleep(5)
				v4:__wf_atom_8e6fec76(4)
				break
			else
				if debugDraw then
					module.DebugDrawAgents(v5, v2)
				end

				Sleep(0)
			end
		end

		v10 = nil
		v11 = nil

		if __wf_atom_7e8ad928(v4) then
			print("Shutdown due to level streaming")
			return
		end

		if module.ShouldShutDown(v4) then
			v4:__wf_atom_8e6fec76(6)
		end

		module.RemoveAgents(v4)
		module.RemoveObjects(v4)
		Sleep(0)
	end
end