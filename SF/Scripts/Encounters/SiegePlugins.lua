local module = require("Lotus.Scripts.Libs.AudioLib")
local module2 = require("SF.Scripts.Libs.EncounterLib")
local module3 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module4 = require("SF.Scripts.Libs.SparrowLib")
local module5 = require("EE.Interface.Utilities")
local module6 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module7 = require("Lotus.Scripts.Libs.Query")
local v = { ARTIFACT = 1, TACTICALMAP = 2, ESCAPEBALLOON = 3 }
local v2 = Symbol("SiegeArtifact")
local v3 = Symbol("TENNO")
local v4 = Symbol("RandomTeam")
local __wf_atom_402b3832s = {}
local v5 = nil
local artifactAvatar2 = nil
local v6 = nil
local v7 = nil
local v8 = nil
local v9 = {}
local v10 = false
local count = 0
local v11 = ""
local v12 = 0

function FadeIn(object)
	if not __wf_atom_7e8ad928(object) then
		object:SetVisibility(true, true)
	end

	local fadeInDuration2 = fadeInDuration

	while fadeInDuration2 >= 0 and not __wf_atom_7e8ad928(object) do
		fadeInDuration2 -= __wf_atom_084b3e93()
		object:__wf_atom_a763aa1a(__wf_atom_421b01aa(fadeInDuration2 / fadeInDuration, 0, 1))
		Sleep(0)
	end
end

local function fn()
	local v13 = 0

	for _, v14 in ipairs(reinforcementAgentWeights) do
		v13 += v14
	end

	local v14 = math.random() * v13

	for i, v15 in ipairs(reinforcementAgentWeights) do
		v13 -= v15

		if v13 <= v14 then
			return i
		end
	end
end

local function fn2(p)
	local __wf_atom_28ce676a = v7:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(p, Range(2, 5), 3)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(25)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(2, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("SiegePlugins.lua"), Color("0xFF8C00"))
	return module7.GetPositions(numReinforcementsToSpawn, __wf_atom_28ce676a)
end

local function fn3(pos, p, p2)
	local v13 = fn2(pos)

	for i = 1, numReinforcementsToSpawn do
		local v14 = fn()
		local reinforcementAgent = reinforcementAgents[v14]
		local v15

		if i <= #v13 then
			v15 = v13[i]
		elseif #v13 > 0 then
			v15 = v13[1]
		else
			v15 = pos
		end

		local __wf_atom_402b3832 = v7:__wf_atom_402b3832(reinforcementAgent, v15, p, Symbol("RandomTeam"), p2)

		if __wf_atom_7e8ad928(__wf_atom_402b3832) then
			continue
		end

		v6:__wf_atom_97f955c1(__wf_atom_402b3832)
		__wf_atom_402b3832:__wf_atom_022766eb(v2)
		__wf_atom_402b3832:__wf_atom_03cc4f3c(Symbol("Guard"), v5:GetPosition(), 1)
	end
end

local function fn4(__wf_atom_0e0a6fee)
	if __wf_atom_7e8ad928(v5) then
		return false
	end

	local position = v5:GetPosition()
	local v13 = {
		pos = __wf_atom_0e0a6fee,
		dis = v7:__wf_atom_57856d42(__wf_atom_0e0a6fee, position)
	}
	local pointInstances = module2.FindPointInstances(v6, __wf_atom_96b9d246)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
		spawnControlReinforcementTag,
		v6:GetPosition(),
		0,
		v6:__wf_atom_103377cc()
	)
	local mergeTables = module6.MergeTables(pointInstances, __wf_atom_439c0d29, true)
	local v14 = {}

	for _, mergeTable in ipairs(mergeTables) do
		local __wf_atom_dcc0a6f8 = mergeTable:__wf_atom_dcc0a6f8()

		if not (#__wf_atom_dcc0a6f8 > 0) then
			continue
		end

		for _, v15 in ipairs(__wf_atom_dcc0a6f8) do
			local position2 = v15:GetPosition()
			local __wf_atom_57856d42 = v7:__wf_atom_57856d42(position2, position)
			local v16 = position.y - position2.y

			if __wf_atom_57856d42 < maxAgentSpawnDistance and math.abs(v16) < maxAgentSpawnHeightDifference then
				table.insert(v14, { pos = position2, dis = __wf_atom_57856d42 })
			end
		end
	end

	table.sort(v14, function(a, b)
		return a.dis > b.dis
	end)
	local enemyLevel = module2.GetEnemyLevel(v6)
	local v15 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
	local v16 = {}

	for _ = 1, enemiesToSpawn do
		local v17

		if #v14 > 0 then
			local v18 = __wf_atom_5784a397(1, (math.min(3, #v14)))
			v17 = v14[v18]
			table.remove(v14, v18)
		else
			v17 = v13
		end

		table.insert(v16, v17)
	end

	table.sort(v16, function(a, b)
		return a.dis < b.dis
	end)

	for i = 1, enemiesToSpawn do
		local pos = v16[i].pos
		local v17 = __wf_atom_fa8d0177(v5:GetPosition(), pos)
		local v18 = Rotation(v17.heading, 0, 0)
		local __wf_atom_402b3832 = v7:__wf_atom_402b3832(artifactHeavyAgentType, pos, v18, Symbol("RandomTeam"), v15)

		if __wf_atom_7e8ad928(__wf_atom_402b3832) then
			return false
		end

		v6:__wf_atom_97f955c1(__wf_atom_402b3832)
		table.insert(__wf_atom_402b3832s, __wf_atom_402b3832)
		local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			continue
		end

		fn3(pos, v18, v15)

		if fadeInEnemies then
			__wf_atom_50a7d83e:__wf_atom_8a035cd5(Symbol("FadeIn"), false)
		end

		if not __wf_atom_7e8ad928(agentSpawnAnim) then
			__wf_atom_50a7d83e:__wf_atom_921c1a5f(agentSpawnAnim, false, 4, 1, true)
		end

		local __wf_atom_50a7d83e2 = __wf_atom_402b3832:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e2) then
			print("Couldn't find objective avatar")
			return
		end

		__wf_atom_55142dd4(__wf_atom_50a7d83e2, "OnKilled")
		__wf_atom_402b3832:__wf_atom_f54283ea()
		local motionControl = __wf_atom_50a7d83e2:MotionControl()

		if not __wf_atom_7e8ad928(motionControl) then
			motionControl:__wf_atom_5ab9523f(agentSpeedMultiplier)
		end

		if objectiveType == v.ESCAPEBALLOON then
			local __wf_atom_bb3e7833 = v5:__wf_atom_bb3e7833(__wf_atom_0f45538d)

			if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
				print("Siege additional objective couldn't find interactable for some reason'")
				return
			end

			__wf_atom_bb3e7833:Enable()
			__wf_atom_55142dd4(v5, "OnDisabled")

			if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
				__wf_atom_402b3832:__wf_atom_aa4361c1(Symbol("UseAction"), __wf_atom_bb3e7833, 2, 1)
			end

			local v19 = __wf_atom_50a7d83e2:Attach(
				paperTrailType,
				Symbol("GAME_C1_NECK1"),
				__wf_atom_28d5d4aa,
				Rotation(-90, 0, 0)
			)
			table.insert(v9, v19)
		else
			local __wf_atom_e919fb8e = __wf_atom_50a7d83e2:__wf_atom_e919fb8e()
			__wf_atom_e919fb8e.artifactAvatar = artifactAvatar2
			__wf_atom_50a7d83e2:__wf_atom_51cd6126(Symbol("ArtifactAttack"), "HeavyOnDamage")
			__wf_atom_402b3832:__wf_atom_f23858e5(artifactAvatar2)
			__wf_atom_402b3832:__wf_atom_4e4078ea(true)
		end

		module.EnableTaggedSequencers(Symbol("ChargeScream"), true)

		if objectiveType == v.TACTICALMAP then
			local __wf_atom_d2b2176d = __wf_atom_50a7d83e2:__wf_atom_d2b2176d()
			__wf_atom_50a7d83e2:GiveItem(torchType, true)
			local v19 = Vector(0, 0.5, 0)
			__wf_atom_d2b2176d:Equip(4, 0)
			__wf_atom_d2b2176d:__wf_atom_b9375444(false)
			local v20 = nil

			while __wf_atom_7e8ad928(v20) do
				v20 = __wf_atom_d2b2176d:__wf_atom_35a10d3c(0)
				Sleep(0)
			end

			local __wf_atom_66088189 = v20:__wf_atom_66088189(1, 0)

			if not __wf_atom_7e8ad928(__wf_atom_66088189) then
				local v21 = __wf_atom_66088189:Attach(torchTrailType, EMPTY_SYMBOL, v19, __wf_atom_80368bb1)
				table.insert(v9, v21)
			end
		end

		Sleep(spawnDelay)
	end

	return true
end

local function fn5()
	local __wf_atom_e529dedd = v6:__wf_atom_e529dedd()

	while #__wf_atom_e529dedd == 0 or __wf_atom_e529dedd[1]:__wf_atom_4026dfb5() < 2 do
		Sleep(0)
	end

	local __wf_atom_be637430 = v6:__wf_atom_be637430()
	local v13 = nil

	for _, v14 in ipairs(__wf_atom_be637430) do
		local __wf_atom_50a7d83e = v14:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) and __wf_atom_50a7d83e:__wf_atom_464a4772() then
			v13 = __wf_atom_50a7d83e
		end

		v14:__wf_atom_022766eb(v2)
	end

	while not (v10 or __wf_atom_7e8ad928(v13)) do
		if v13:__wf_atom_bb81a9df() < forceStartObjectiveBossHealthThreshold then
			v10 = true
		end

		Sleep(1)
	end
end

function HeavyOnDamage(object)
	if not gRegion:IsMaster() or __wf_atom_7e8ad928(object) then
		return
	end

	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if not (__wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) or object:IsKilled() or object:__wf_atom_bedb4e3f()) then
		local __wf_atom_9d766292 = object:__wf_atom_9d766292()

		if __wf_atom_7e8ad928(__wf_atom_9d766292) then
			return
		end

		local artifactAvatar = object:__wf_atom_e919fb8e().artifactAvatar

		if __wf_atom_7e8ad928(artifactAvatar) then
			return
		end

		local __wf_atom_679ed446 = __wf_atom_9d766292:__wf_atom_679ed446()

		if
			not __wf_atom_7e8ad928(__wf_atom_679ed446)
			and __wf_atom_679ed446:IsA(__wf_atom_67c46eba)
			and Distance(artifactAvatar:GetPosition(), __wf_atom_679ed446:GetPosition()) < defenseArtifactRadius
		then
			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_4e4078ea(false)
				__wf_atom_30e3d82b:__wf_atom_f23858e5(__wf_atom_679ed446)
				__wf_atom_30e3d82b:__wf_atom_4e4078ea(true)
			end

			if not __wf_atom_7e8ad928(object) then
				object:__wf_atom_8a035cd5(Symbol("ReturnToArtifact"), false)
			end
		end
	end
end

function ReturnToArtifact(object)
	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_3ede53b4(Symbol("ArtifactAttack"))
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	local artifactAvatar = object:__wf_atom_e919fb8e().artifactAvatar
	local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()
	local v13 = 10

	while
		not __wf_atom_7e8ad928(object)
		and not object:IsKilled()
		and not object:__wf_atom_bedb4e3f()
		and v13 > 0
		and not (__wf_atom_7e8ad928(__wf_atom_216d6edd) or __wf_atom_216d6edd:IsKilled() or __wf_atom_7e8ad928(artifactAvatar) or artifactAvatar:IsKilled() or Distance(
			artifactAvatar:GetPosition(),
			__wf_atom_216d6edd:GetPosition()
		) > defenseArtifactRadius)
	do
		v13 -= __wf_atom_084b3e93()
		Sleep(0)
	end

	if __wf_atom_7e8ad928(object) or __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
		return
	end

	if __wf_atom_7e8ad928(artifactAvatar) then
		__wf_atom_30e3d82b:__wf_atom_4e4078ea(false)
		return
	end

	__wf_atom_30e3d82b:__wf_atom_4e4078ea(false)
	__wf_atom_30e3d82b:__wf_atom_f23858e5(artifactAvatar)
	__wf_atom_30e3d82b:__wf_atom_4e4078ea(true)
	Sleep(5)

	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_51cd6126(Symbol("ArtifactAttack"), "HeavyOnDamage")
end

function SetupProtectArtifact(object)
	v8 = object
	v6 = object:__wf_atom_3d96ddcd()
	local position = v6:GetPosition()
	v7 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	if _T.OngoingSiege == nil then
		return
	end

	v11 = _T.OngoingSiege:c_str()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(artifactSpawnPointTag, position, 0, 50)

	if #__wf_atom_439c0d29 < 1 then
		return
	end

	local v13 = __wf_atom_439c0d29[math.random(1, #__wf_atom_439c0d29)]
	v5 = gRegion:CreateEntity(artifactType, v13:GetPosition(), v13:__wf_atom_dc309f8a())

	if __wf_atom_7e8ad928(v5) then
		return
	end

	v5:MakeInvulnerable()

	if objectiveType == v.ARTIFACT or objectiveType == v.ESCAPEBALLOON then
		__wf_atom_55142dd4(v5, "OnDestroyed")
	else
		__wf_atom_55142dd4(v5, "OnDamaged")
	end

	fn5()

	if __wf_atom_7e8ad928(v5) then
		return
	end

	v5:MakeVulnerable()

	if objectiveType == v.TACTICALMAP or objectiveType == v.ARTIFACT then
		artifactAvatar2 = v5:Attach(artifactAvatarType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

		if __wf_atom_7e8ad928(artifactAvatar2) then
			return
		else
			artifactAvatar2:__wf_atom_7470861b():__wf_atom_9fba31e6(Symbol("Invulnerable"), 26, 6, 0)
		end
	end

	local __wf_atom_be637430 = v6:__wf_atom_be637430()

	for _, v14 in ipairs(__wf_atom_be637430) do
		v14:__wf_atom_022766eb(v2)
	end

	if not __wf_atom_7e8ad928(startedSound) then
		module5.PlaySound(startedSound)
	end

	module3.AddHudTitle(v8, v11, objectiveTitleLoc)
	module3.AddHudTask(v8, v11, v11, objectiveDescLoc)

	if enemiesToSpawn > 1 then
		module3.UpdateOrAddHudCounterTask(v8, v11, objectiveDescLoc, count, enemiesToSpawn)
	end

	module3.UpdateVisibility(true, objectiveUIDisplayDuration)
	module4.AddSparrowDestination(v5, v8, v11 .. "AdditionalObjective", module4.PRIORITY.QUEST)
	Sleep(2)
	module4.SpawnSparrow()
	Sleep(objectiveUIDelay)

	if not fn4(v7:__wf_atom_0e0a6fee(position, 10, 10)) then
		return
	end

	while v12 == 0 and not __wf_atom_7e8ad928(_T.OngoingSiege) do
		Sleep(1)
	end

	for _, v14 in ipairs(__wf_atom_402b3832s) do
		if __wf_atom_7e8ad928(v14) then
			continue
		end

		local __wf_atom_50a7d83e = v14:__wf_atom_50a7d83e()

		if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
			__wf_atom_50a7d83e:__wf_atom_3ede53b4(Symbol("ArtifactAttack"))
		end

		if not __wf_atom_7e8ad928(v14) then
			v14:__wf_atom_6bb5f08a(v3)
			v14:__wf_atom_f23858e5(nil)
			v14:__wf_atom_920a5a62()

			if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
				local motionControl = __wf_atom_50a7d83e:MotionControl()

				if not __wf_atom_7e8ad928(motionControl) then
					motionControl:__wf_atom_5ab9523f(agentSpeedMultiplier)
				end
			end
		end

		if not __wf_atom_7e8ad928(artifactAvatar2) then
			artifactAvatar2:Destroy()
		end

		if not __wf_atom_7e8ad928(v5) then
			v5:MakeInvulnerable()
		end
	end

	for _, v14 in ipairs(v9) do
		if not __wf_atom_7e8ad928(v14) then
			v14:Destroy()
		end
	end

	module4.RemoveSparrowDestination(v5)
	module4.RemoveSparrow()

	if __wf_atom_7e8ad928(_T.OngoingSiege) or _T.OngoingSiege:c_str() ~= v11 then
		module3.RemoveHudTask(v8, v11, v11)
	elseif v12 == 1 then
		module3.CompleteHudTask(v8, v11, v11, 5)
		module.EnableTaggedSequencers(Symbol("ServerAlarm"), false)

		if not __wf_atom_7e8ad928(successSound) then
			module5.PlaySound(successSound)
		end
	else
		module3.AddHudTitle(v8, v11, objectiveTitleFailedLoc)
		module3.AddHudTask(v8, v11, v11, objectiveDescFailedLoc)
		module3.RemoveHudTask(v8, v11, v11, 7)

		if not __wf_atom_7e8ad928(failedSound) then
			module5.PlaySound(failedSound)
		end

		_T.SiegeObjectiveStatus = 1
	end
end

function OnDamaged(_)
	v12 = 2

	if not __wf_atom_7e8ad928(artifactAvatar2) then
		artifactAvatar2:Destroy()
	end
end

function OnDisabled(_)
	if v12 == 0 then
		v12 = 2
	end
end

function OnDestroyed(_)
	if v12 == 0 and objectiveType == v.ARTIFACT then
		v12 = 2
	end
end

function OnKilled(_)
	if v12 ~= 0 then
		return
	end

	count += 1

	if enemiesToSpawn > 1 then
		module3.UpdateOrAddHudCounterTask(v8, v11, objectiveDescLoc, count, enemiesToSpawn)
	end

	if count >= enemiesToSpawn then
		module.EnableTaggedSequencers(Symbol("ServerAlarm"), false)
		v12 = 1
	end
end

function SpawnTaggedSpawnControl(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
		spawnControlTag,
		__wf_atom_3d96ddcd:GetPosition(),
		0,
		__wf_atom_3d96ddcd:__wf_atom_103377cc()
	)
	local pointInstances = module2.FindPointInstances(__wf_atom_3d96ddcd, __wf_atom_96b9d246, spawnControlTag)
	local mergeTables = module6.MergeTables(__wf_atom_439c0d29, pointInstances, true)

	if __wf_atom_7e8ad928(mergeTables) or #mergeTables <= 0 then
		instance:Destroy()
		return
	end

	local mergeTable = mergeTables[math.random(1, #mergeTables)]
	local __wf_atom_f7c1604d = mergeTable:__wf_atom_f7c1604d(#mergeTable:__wf_atom_dcc0a6f8())
	local __wf_atom_d524865a = mergeTable:__wf_atom_d524865a()
	local enemyLevel = module2.GetEnemyLevel(__wf_atom_3d96ddcd)

	for i = 1, __wf_atom_d524865a do
		local v13 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)

		if not (i <= #__wf_atom_f7c1604d) or __wf_atom_7e8ad928(__wf_atom_f7c1604d[i]) then
			continue
		end

		local __wf_atom_66a525a6 = __wf_atom_f7c1604d[i]:__wf_atom_66a525a6()

		if __wf_atom_66a525a6 > 0 then
			v13 = __wf_atom_66a525a6
		end

		__wf_atom_3d96ddcd:__wf_atom_97f955c1((__wf_atom_7d789620:CreateAgent(
			__wf_atom_f7c1604d[i]:__wf_atom_0b636f17(),
			__wf_atom_f7c1604d[i],
			v4,
			v13
		)))
	end
end