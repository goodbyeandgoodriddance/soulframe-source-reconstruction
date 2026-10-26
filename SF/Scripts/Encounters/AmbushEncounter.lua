local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module3 = require("SF.Scripts.Libs.RaycastLib")
local module4 = require("Lotus.Scripts.Libs.Query")
local module5 = require("SF.Scripts.Libs.ObjectiveHudLib")
local v = Symbol("RandomTeam")
local v2 = nil
local position = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local count = 0
local v8 = false
local reinforceInterval2 = 0
local v9 = nil
local v10 = nil
local v11 = nil
local flag = false
local flag2 = false
local total = 0

local function fn()
	local __wf_atom_549749d8 = gRegion:__wf_atom_549749d8(faction)
	local __wf_atom_103377cc = v4:__wf_atom_103377cc()

	for _, v12 in ipairs(__wf_atom_549749d8) do
		if not (v12:__wf_atom_1c8f7b2d(v4) <= __wf_atom_103377cc + 5) then
			continue
		end

		local __wf_atom_30e3d82b = v12:__wf_atom_30e3d82b()

		if __wf_atom_7e8ad928(__wf_atom_30e3d82b) or v12:IsKilled() then
			continue
		end

		for _, className in ipairs(reinforceAgentTypes) do
			if not __wf_atom_30e3d82b:IsA(className) or module2.IsInTable(__wf_atom_30e3d82b, v5) then
				continue
			end

			__wf_atom_30e3d82b:__wf_atom_30b587a4()
			v3:__wf_atom_97f955c1(__wf_atom_30e3d82b)
			break
		end
	end

	v5 = v3:__wf_atom_6199ef01()
	module.CleanUpOutOfRangeEnemies(v4, v5)

	if not (v8 or __wf_atom_7e8ad928(v7)) then
		local __wf_atom_30e3d82b = v7:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_04ea4887() then
			v8 = true
		end
	end

	v6 = v4:__wf_atom_b3bb0c43(100) + __wf_atom_679e0b25("Server.NumVirtualTestClients")
	v6 = math.min(math.max(v6, 1), 3)
end

local function fn2()
	local v12 = Symbol("Flee")

	for _, v13 in pairs(v5) do
		if __wf_atom_7e8ad928(v13) or v13:IsA(largeAgentType) then
			continue
		end

		local __wf_atom_50a7d83e = v13:__wf_atom_50a7d83e()

		if __wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled() then
			continue
		end

		v13:__wf_atom_8b514502()
		v13:__wf_atom_aa4361c1(v12, v4)
		v13:StormTarget(nil)
	end

	flag2 = true
end

function OnKilled(object)
	local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()

	if canFlee and not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:IsA(largeAgentType) then
		fn2()
	end

	Sleep(2)
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("DeathCabbage"), position, 0, 3)

	if not __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		v3:__wf_atom_d494454b(__wf_atom_f738b4af)
	end
end

local function fn3(position2, p, p2, p3, object, p4)
	local __wf_atom_28ce676a = v2:__wf_atom_28ce676a()

	if spawnAroundPlayer and not __wf_atom_7e8ad928(object) then
		p = Range(p.minValue + 5, p.maxValue + 5)
	end

	__wf_atom_28ce676a:__wf_atom_267bfc41(position2, p, p3)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(30)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(1.5, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("AmbushEncounter"), Color("0xFFFF00"))

	if p4 then
		__wf_atom_28ce676a:__wf_atom_28a1a374(Vector(0, -1, 0), { 4, 27, 24, 40 })
	end

	if spawnAroundPlayer and not __wf_atom_7e8ad928(object) then
		local cameraControl = object:CameraControl()

		if not __wf_atom_7e8ad928(cameraControl) then
			local __wf_atom_dd7246c7 = cameraControl:__wf_atom_dd7246c7()

			if not __wf_atom_7e8ad928(__wf_atom_dd7246c7) then
				__wf_atom_28ce676a:__wf_atom_9b7f7161(
					object:GetPosition(),
					__wf_atom_dd7246c7:__wf_atom_a06d543c(),
					-1,
					2,
					1,
					1,
					false
				)
			end
		end
	end

	return (module4.GetPositions(p2, __wf_atom_28ce676a))
end

local function fn4()
	local v12 = nil

	if __wf_atom_7e8ad928(largeAgentType) then
		v8 = true
	elseif #v5 == 0 then
		local enemyLevel = module.GetEnemyLevel(v4)
		local pointInstances = module.FindPointInstances(v4, gNpcSpawnPointType)
		local v13 = nil

		if __wf_atom_7e8ad928(pointInstances) or not (#pointInstances > 0) then
			local v14 = fn3(position, Range(0, 16), 1, 2)

			if __wf_atom_7e8ad928(v14) or #v14 == 0 then
				return false
			end

			v13 = v14[__wf_atom_5784a397(1, #v14)]
			local v15 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			v12 = v2:__wf_atom_402b3832(largeAgentType, v13, v15, v, enemyLevel.maxValue)
		else
			local pointInstance = pointInstances[__wf_atom_5784a397(1, #pointInstances)]
			v12 = v2:CreateAgent(largeAgentType, pointInstance, v, enemyLevel.maxValue)
		end

		if not __wf_atom_7e8ad928(v12) then
			v3:__wf_atom_97f955c1(v12)

			if numPois > 0 then
				local v14 = 360 / numPois

				for i = 1, numPois do
					local v15 = v13 + __wf_atom_9341614d(Vector(8, 0, 0), Rotation(v14 * i, 0, 0))
					local __wf_atom_0e0a6fee = v2:__wf_atom_0e0a6fee(v15)
					local entity = gRegion:CreateEntity(
						poiTypes[__wf_atom_5784a397(1, #poiTypes)],
						__wf_atom_0e0a6fee,
						__wf_atom_fa8d0177(v13, v15)
					)
					v3:__wf_atom_d494454b(entity)
				end
			end
		end
	else
		for _, v13 in ipairs(v5) do
			if not v13:IsA(largeAgentType) then
				continue
			end

			v12 = v13
			break
		end
	end

	if __wf_atom_7e8ad928(v12) then
		return false
	end

	v7 = v12:__wf_atom_50a7d83e()
	__wf_atom_55142dd4(v7, "OnKilled")
	return true
end

local function fn5(__wf_atom_3634e6d2)
	local v12 = v9[v6] - __wf_atom_3634e6d2

	if v12 <= 0 then
		return false
	end

	if count + v12 == v10[v6] - 1 and __wf_atom_7e8ad928(largeAgentType) then
		v12 += 1
	end

	local hintToPlayerRadius2 = v4:__wf_atom_103377cc()

	if count == 0 then
		if useActivationRadiusForSpawnsAroundPlayer then
			hintToPlayerRadius2 = v4:__wf_atom_8f18e876()
		else
			hintToPlayerRadius2 = hintToPlayerRadius
		end
	end

	local enemyLevel = module.GetEnemyLevel(v4)
	local __wf_atom_9c85bbdb = v4:__wf_atom_9c85bbdb(hintToPlayerRadius2)
	local position2 = position
	local v13 = nil

	if __wf_atom_7e8ad928(v7) then
		if spawnAroundPlayer then
			v13 = module2.NearestObject(position, __wf_atom_9c85bbdb)

			if __wf_atom_7e8ad928(v13) then
				return false
			end

			position2 = v13:GetPosition()

			if module2.Distance2d(position, position2) <= hintToPlayerRadius + 20 then
				v3:__wf_atom_c53e1842(position2)
				position = position2
			end
		end
	else
		position2 = v7:GetPosition()
	end

	local v14 = spawnPointTag == EMPTY_SYMBOL and {}
		or gRegion:__wf_atom_439c0d29(spawnPointTag, position2, 0, hintToPlayerRadius2)
	local v15 = fn3(position2, reinforcementSpawnRange, v12, reinforceMinSpacing, v13, reinforcementsSpawnOnTerrainOnly)

	if __wf_atom_7e8ad928(v15) or #v15 == 0 then
		reinforceInterval2 = reinforceInterval
		return false
	end

	local v16 = math.min(#v15, v12)

	for i = 1, v16 do
		local reinforceAgentType = reinforceAgentTypes[__wf_atom_5784a397(1, #reinforceAgentTypes)]
		local v17 = math.ceil(count / v10[v6])
		local v18 = __wf_atom_104bfe98(enemyLevel.minValue, enemyLevel.maxValue, v17)

		if __wf_atom_7e8ad928(v4) then
			return
		end

		local __wf_atom_9c85bbdb2 = v4:__wf_atom_9c85bbdb(hintToPlayerRadius2)
		local v19 = nil
		local position3

		if #v14 > 0 then
			local v20 = __wf_atom_5784a397(1, #v14)
			position3 = v14[v20]:GetPosition()
			v19 = v14[v20]:__wf_atom_dc309f8a()
			table.remove(v14, v20)
		elseif #v15 > 0 then
			local v20 = __wf_atom_5784a397(1, #v15)
			position3 = v15[v20]
			table.remove(v15, v20)
		else
			position3 = v2:GetRandomPointInRangeOnNav(
				position2,
				math.max(reinforcementSpawnRange.minValue, 2),
				reinforcementSpawnRange.maxValue,
				true,
				0.5
			)
		end

		if __wf_atom_7e8ad928(v19) then
			v19 = Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			v13 = module2.NearestObject(position3, __wf_atom_9c85bbdb2)

			if not __wf_atom_7e8ad928(v13) then
				v19 = __wf_atom_fa8d0177(position3, v13:GetPosition())
			end
		end

		local __wf_atom_402b3832 = v2:__wf_atom_402b3832(
			reinforceAgentType,
			position3,
			v19,
			v,
			v18,
			reinforcementSpawnAnim
		)

		if not (__wf_atom_7e8ad928(__wf_atom_402b3832) or __wf_atom_7e8ad928(reinforcementSpawnFx)) then
			local v20

			if __wf_atom_7e8ad928((Resource(reinforcementSpawnFx):__wf_atom_b6b760b5())) then
				v20 = module3.GetGroundPos(position3)
			else
				v20, v19 = module3.GetGroundAlignedSpawnPosRot(reinforcementSpawnFx, position3, v19)
			end

			local entity = gRegion:CreateEntity(reinforcementSpawnFx, v20, v19)
			v3:__wf_atom_d494454b(entity)
		end

		if __wf_atom_7e8ad928(__wf_atom_402b3832) then
			print("Failed to spawn agent")
		else
			v3:__wf_atom_97f955c1(__wf_atom_402b3832)
			count += 1

			if not __wf_atom_7e8ad928((__wf_atom_402b3832:__wf_atom_50a7d83e())) then
				__wf_atom_402b3832:__wf_atom_30b587a4()
				__wf_atom_402b3832:StormTarget(v13)
			end

			if count >= v10[v6] then
				print("Spawn cap reached")
				break
			elseif i < v16 then
				Sleep(__wf_atom_8d119bab(reinforcementSpawnInterval.minValue, reinforcementSpawnInterval.maxValue))
			end
		end
	end

	fn()
	reinforceInterval2 = reinforceInterval
end

local function fn6(object)
	v2 = module2.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return false
	end

	v3 = object
	v4 = object:__wf_atom_26b04ea9() or object
	position = v4:GetPosition()
	v9 = { maxSimEnemies1p, maxSimEnemies2p, maxSimEnemies3p }
	v10 = {
		__wf_atom_5784a397(maxTotalEnemies1p.minValue, maxTotalEnemies1p.maxValue),
		__wf_atom_5784a397(maxTotalEnemies2p.minValue, maxTotalEnemies2p.maxValue),
		__wf_atom_5784a397(maxTotalEnemies3p.minValue, maxTotalEnemies3p.maxValue)
	}
	v11 = __wf_atom_5784a397(fleeThreshold.minValue, fleeThreshold.maxValue)
	v3:__wf_atom_8e6fec76(1)

	if __wf_atom_7e8ad928(v3) or v3:__wf_atom_4026dfb5() == 6 then
		return false
	end

	fn()

	if #setupScripts > 0 then
		local v12 = module2.StartPluginScripts(setupScripts, object)

		while not __wf_atom_7e8ad928(v3) and #v12 > 0 and v3:__wf_atom_4026dfb5() ~= 6 do
			for i = #v12, 1, -1 do
				if not (__wf_atom_7e8ad928(v12[i]) or not v12[i]:IsRunning()) then
					continue
				end

				table.remove(v12, i)
			end

			Sleep(0)
		end
	end

	if not (__wf_atom_7e8ad928(largeAgentType) or fn4()) then
		return false
	end

	Sleep(0)

	if __wf_atom_7e8ad928(v3) then
		print("Shutdown due to level streaming")
		return false
	end

	v3:__wf_atom_2cc8420c(v3:__wf_atom_dd85e6db())
	return true
end

local function fn7()
	local flag3 = false
	local spawnWarningTimer2 = 0
	local canFlee = canFlee

	if fleeChance < 1 and math.random() > fleeChance then
		canFlee = false
	end

	if __wf_atom_7e8ad928(largeAgentType) then
		v8 = true
	end

	if flag then
		module5.UpdateOrAddHudTask(v3)
	end

	while not module.ShouldShutDown(v3) do
		fn()

		if not __wf_atom_7e8ad928(warningSequencerType) and math.random() <= warningChanceToPlay then
			if flag3 or not (v4:__wf_atom_b3bb0c43(hintToPlayerRadius) > 0) then
				if flag3 then
					spawnWarningTimer2 -= 1
				end
			else
				local __wf_atom_9c85bbdb = v4:__wf_atom_9c85bbdb(hintToPlayerRadius)
				local nearestObject = module2.NearestObject(position, __wf_atom_9c85bbdb)
				local v12 = __wf_atom_f55d6358(
					nearestObject:GetPosition() + Vector(0, 2, 0),
					position + Vector(0, 2, 0),
					0.4
				)
				local entity = gRegion:CreateEntity(warningSequencerType, v12, __wf_atom_80368bb1)
				entity:Enable()
				v3:__wf_atom_d494454b(entity)
				spawnWarningTimer2 = spawnWarningTimer
				flag3 = true
			end
		end

		if not __wf_atom_7e8ad928(largeAgentType) and (__wf_atom_7e8ad928(v7) or v7:IsKilled()) then
			v8 = false
		end

		if v8 and spawnWarningTimer2 <= 0 then
			if count < v10[v6] then
				local __wf_atom_3634e6d2 = v3:__wf_atom_3634e6d2()

				if not __wf_atom_7e8ad928(v7) and v7:IsA(__wf_atom_9e85eea2) then
					__wf_atom_3634e6d2 -= 1
				end

				if __wf_atom_3634e6d2 < v9[v6] or __wf_atom_3634e6d2 <= reinforceThreshold then
					if reinforceInterval2 <= 0 or count > 0 and __wf_atom_3634e6d2 <= 0 then
						fn5(__wf_atom_3634e6d2)
					else
						reinforceInterval2 -= 1
					end
				end
			else
				reinforceInterval2 = reinforceInterval
			end
		end

		if __wf_atom_7e8ad928(v3) then
			print("Shutdown due to level streaming")
			break
		end

		local __wf_atom_3634e6d2 = v3:__wf_atom_3634e6d2()

		if __wf_atom_7e8ad928(largeAgentType) then
			if __wf_atom_7e8ad928(largeAgentType) then
				if count >= v10[v6] and __wf_atom_3634e6d2 == 0 then
					v3:__wf_atom_8e6fec76(4)
					break
				elseif canFlee and not flag2 and count == v10[v6] and __wf_atom_3634e6d2 <= v11 then
					fn2()
				end
			end
		elseif __wf_atom_3634e6d2 == 0 or flag2 and total >= 8 then
			v3:__wf_atom_8e6fec76(4)
			break
		elseif flag2 then
			total += __wf_atom_03df4e1d()
		end

		Sleep(1)
	end

	print("Ambush encuonter ending...")
end

local function fn8()
	if __wf_atom_7e8ad928(v3) then
		print("Shutdown due to level streaming")
		return
	end

	if v3:__wf_atom_3634e6d2() == 0 or v3:__wf_atom_4026dfb5() == 4 then
		v3:__wf_atom_050639fe()
		v3:__wf_atom_8776856a(0)
		v3:__wf_atom_8e6fec76(4)

		if module2.IsInOverworld() then
			while not __wf_atom_7e8ad928(v3) and v3:__wf_atom_e464a32f() > 0 and v2:__wf_atom_c6f505f2(v3) > 0 do
				Sleep(0.5)
			end
		elseif not __wf_atom_7e8ad928(v4) then
			v4:Disable()
		end

		if flag then
			module5.CompleteHudTask(v3)
			Sleep(4)
		end
	else
		v3:__wf_atom_8e6fec76(6)
	end

	if __wf_atom_7e8ad928(v3) then
		print("Shutdown due to level streaming")
		return
	end

	module.RemoveAgents(v3)
	module.RemoveObjects(v3)
	Sleep(0)
end

function AmbushEncounter(object)
	if fn6(object) then
		object:__wf_atom_8e6fec76(2)
		fn7()
		fn8()
	elseif not __wf_atom_7e8ad928(object) then
		object:__wf_atom_8e6fec76(6)
	end
end

function AmbushTaleEncounter(object)
	flag = true

	if not fn6(object) then
		object:__wf_atom_8e6fec76(6)
		return
	end

	object:__wf_atom_8e6fec76(2)
	fn7()
	fn8()
end

function RemoveParentHintTagsOnPrimed(object)
	local __wf_atom_19688c5e = object:__wf_atom_19688c5e()

	for _, v12 in ipairs(__wf_atom_19688c5e) do
		object:__wf_atom_61860938(v12)
	end
end