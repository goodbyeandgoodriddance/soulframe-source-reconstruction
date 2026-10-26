local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.RaycastLib")
local module3 = require("Lotus.Scripts.Libs.Query")
local module4 = require("SF.Scripts.Libs.EncounterLib")
local entities = {}
local v = { Vector(15, 0, 15), Vector(-15, 0, 15), Vector(-15, 0, -15), Vector(15, 0, -15) }
local v2 = Symbol("Grineer")
local v3 = Symbol("RandomTeam")
local v4 = WeakResource("/SF/Objects/Ode/OdeDropPod/OdeDropPodDoor")
local v5 = Type("/SF/Types/Game/Encounters/Ode/Dynamic/DropPod/SpawnDropPodProximityTrigger")
local v6 = WeakResource("/SF/Types/Game/DamageTriggers/OdeDropPodDamageTrigger")
local v7 = WeakResource("/SF/Fx/Events/Ode/DropPod/DropPodFire")
local v8 = Symbol("OdeSignalsLandingZone")
local v9 = nil
local v10 = nil
local position = nil
local v11 = nil
local v12 = nil
local v13 = nil

local function fn(object)
	v9 = module.WaitForAiDir()

	if __wf_atom_7e8ad928(object) then
		print("Shutdown due to level streaming")
		return false
	end

	v10 = object
	position = v10:GetPosition()
	v11 = v10:__wf_atom_26b04ea9() or v10
	v10:__wf_atom_683a94c6(100)
	v10:__wf_atom_8e6fec76(1)
	return true
end

local function fn2(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()
	__wf_atom_e919fb8e.playerInProximity = true
	v12 = object:__wf_atom_7be51ede()
end

local function fn3(p, p2, _, p3)
	local v14 = p3 or position
	local __wf_atom_28ce676a = v9:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(v14, p, p2)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(15)
	__wf_atom_28ce676a:__wf_atom_df6829ae(Range(6, 3.4028234663852886e38))
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_28a1a374(Vector(0, -1, 0), { 4, 27, 24, 40 })
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("DynamicCampsiteEncounter.lua"), Color("0xFFCC00"))
	return __wf_atom_28ce676a
end

local function fn4(p)
	if __wf_atom_7e8ad928(v11) then
		return
	end

	if not __wf_atom_7e8ad928(shipType) then
		local groundPos = module2.GetGroundPos(p)
		local v14 = groundPos + Vector(0, 300, 0)
		local total = 0
		local entity = gRegion:CreateEntity(shipType, v14, Rotation(__wf_atom_5784a397(0, 360), 0, 0))

		if __wf_atom_7e8ad928(entity) then
			return
		end

		table.insert(entities, entity)
		entity:PlaySound(descendSound, false, 1, false)
		v11:__wf_atom_d494454b(entity)
		local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(v6)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			__wf_atom_bb3e7833:Enable()
		end

		while total <= 3 do
			Sleep(0)
			total += __wf_atom_03df4e1d()

			if __wf_atom_7e8ad928(entity) then
				return
			else
				entity:SetPosition(__wf_atom_f55d6358(v14, groundPos, (math.min(1, total / 3))))
			end
		end

		entity:SetPosition(groundPos)
		entity:PlaySound(impactSound, false, 1, false)
		entity:Attach(shipImpactFxType, EMPTY_SYMBOL)

		if not __wf_atom_7e8ad928(shipRubbleType) then
			local v15 = { Vector(1, 0, 0), Vector(-1, 0, 0) }

			for i = 1, #v15 do
				local groundAlignedSpawnPosRot, v16 = module2.GetGroundAlignedSpawnPosRot(
					shipRubbleType,
					p + v15[i],
					Rotation(__wf_atom_5784a397(0, 360), 0, 0),
					true,
					30
				)

				if __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
					continue
				end

				local entity2 = gRegion:CreateEntity(
					shipRubbleType,
					groundAlignedSpawnPosRot + Vector(0, -0.05, 0),
					v16
				)
				v11:__wf_atom_d494454b(entity2)
			end
		end

		__wf_atom_bb3e7833:Disable()
		entity:FirePort("PlayTriggeredAnim")
		entity:__wf_atom_7b7015c9(shipAmbientAnim)
		local __wf_atom_bb3e7833_2 = entity:__wf_atom_bb3e7833(v7)

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_2) then
			__wf_atom_bb3e7833_2:Destroy()
		end
	end
end

local function fn5()
	if v10:__wf_atom_3634e6d2() > 0 then
		return
	end

	local enemyLevel = module4.GetEnemyLevel(v10)
	local v14 = math.min(gRegion:__wf_atom_d52d8448() + __wf_atom_679e0b25("Server.NumVirtualTestClients"), 3)
	local v15 = ({ Range(3, 4), Range(5, 6), Range(6, 8) })[v14]
	local v16 = __wf_atom_5784a397(v15.minValue, v15.maxValue)
	local v17 = { {}, {}, {} }

	for _, v18 in ipairs(entities) do
		if __wf_atom_7e8ad928(v18) then
			continue
		end

		local __wf_atom_f582136d = v18:__wf_atom_f582136d(gNpcSpawnPointType)

		for k, v19 in pairs(__wf_atom_f582136d) do
			table.insert(v17[k], v19)
		end
	end

	local v18 = {}

	for _, list in ipairs(v17) do
		for _, v19 in ipairs(list) do
			table.insert(v18, v19)
		end
	end

	local v19 = #v18 < v16 and #v18 or v16

	if v19 <= 0 then
		return
	end

	local v20, v21

	if __wf_atom_7e8ad928(squadListType) then
		v20 = false
	else
		v21 = module4.GetRandomSquadList(v19, squadListType)
		v20 = not __wf_atom_7e8ad928(v21)
	end

	local __wf_atom_2b1fe281 = v10:__wf_atom_2b1fe281()
	local count = 0

	for i = 1, v19 do
		local v22

		if not (__wf_atom_7e8ad928(v18) or not (#v18 > 0 and i <= #v18)) then
			v22 = v18[i]
		end

		local v23 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
		local agentType

		if v20 then
			if v21[i].useCustomAgentType then
				agentType = v21[i].agentType
			else
				agentType = module4.GetRandomEnemyAgentType(
					nil,
					v2,
					v23,
					v10,
					v21[i].agentSpec.archetype,
					v21[i].agentSpec.rank,
					v21[i].agentSpec.exclusiveRank
				)
			end
		else
			agentType = module4.GetRandomEnemyAgentType(v22, v2, v23, v10)
		end

		if __wf_atom_7e8ad928(agentType) then
			print("ERROR: Couldn't find enemy type to spawn!")
		else
			local position2, v24

			if not __wf_atom_7e8ad928(v22) then
				position2 = v22:GetPosition()
				v24 = v22:__wf_atom_dc309f8a()
			end

			if not __wf_atom_7e8ad928(position2) then
				local v25 = {
					__wf_atom_4ebf67cb,
					__wf_atom_3feeb44a,
					__wf_atom_43e0c427,
					__wf_atom_7b01f9ce
				}
				gRegion:__wf_atom_c20d246a(
					position2 + Vector(0, 1, 0),
					position2 - Vector(0, 1, 0),
					v25,
					nil,
					position2
				)
				local __wf_atom_402b3832 = v9:__wf_atom_402b3832(agentType, position2, v24, v3, v23)

				if not __wf_atom_7e8ad928(__wf_atom_402b3832) then
					v10:__wf_atom_97f955c1(__wf_atom_402b3832)
					count += 1

					if __wf_atom_2b1fe281 > 0 and __wf_atom_2b1fe281 <= count then
						break
					end
				end
			end
		end

		if i < v19 then
			Sleep(0)
		end

		if module4.ShouldShutDown(v10, v11) then
			break
		end
	end
end

local function fn6()
	if v10:__wf_atom_4026dfb5() <= 1 then
		v10:__wf_atom_8e6fec76(1)
	end

	Sleep(1)
	v13 = v10:__wf_atom_6199ef01()
	module4.CleanUpOutOfRangeEnemies(v10, v13)

	if #v13 == 0 then
		fn5()
	end

	if v10:__wf_atom_4026dfb5() <= 2 then
		v10:__wf_atom_8e6fec76(2)
	end

	for _, v14 in ipairs(entities) do
		if __wf_atom_7e8ad928(v14) then
			continue
		end

		local __wf_atom_f582136d = v14:__wf_atom_f582136d(v4)

		for _, v15 in ipairs(__wf_atom_f582136d) do
			v15:Destroy()
		end

		Sleep(0.3)
	end

	if __wf_atom_7e8ad928(v10) then
		print("Shutdown due to level streaming")
		return
	end

	local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
	local __wf_atom_be637430 = v11:__wf_atom_be637430()

	for _, v14 in ipairs(__wf_atom_be637430) do
		v14:__wf_atom_30b587a4()
		local __wf_atom_50a7d83e = v14:__wf_atom_50a7d83e()
		local nearestObject = module.NearestObject(__wf_atom_50a7d83e:GetPosition(), __wf_atom_ef7900cf)

		if not __wf_atom_7e8ad928(nearestObject) then
			v14:StormTarget(nearestObject)
		end
	end

	local total = 0

	while not module4.ShouldShutDown(v10, v11) and v10:__wf_atom_3634e6d2() > 0 do
		v13 = v10:__wf_atom_6199ef01()
		module4.CleanUpOutOfRangeEnemies(v10, v13)
		total += __wf_atom_084b3e93()
		Sleep(0)
	end
end

local function fn7()
	if __wf_atom_7e8ad928(v10) then
		print("Shutdown due to level streaming")
		return
	end

	if module4.ShouldShutDown(v10) then
		v10:__wf_atom_8776856a(#v13)
		module4.RemoveAgents(v10)
		v10:__wf_atom_8e6fec76(6)
	else
		v10:__wf_atom_050639fe()
		v10:__wf_atom_8776856a(0)
		v10:__wf_atom_8e6fec76(4)

		if not module.IsInOverworld() then
			v10:Disable()
		end
	end

	while not __wf_atom_7e8ad928(v10) and v10:__wf_atom_e464a32f() > 0 and v9:__wf_atom_c6f505f2(v10) > 0 do
		Sleep(0)
	end

	if __wf_atom_7e8ad928(v10) then
		print("Shutdown due to level streaming")
		return
	end

	module4.RemoveAgents(v10)

	if v10:__wf_atom_4026dfb5() ~= 4 then
		module4.RemoveObjects(v10)
	end

	Sleep(0)
end

function StartDropPod(object)
	if not fn(object) then
		return
	end

	local v14

	if v8 ~= EMPTY_SYMBOL then
		v14 = gRegion:__wf_atom_439c0d29(v8, position, 0, v10:__wf_atom_103377cc())
	end

	local v15 = {}

	if #v14 > 0 then
		if isSiege then
			local v16 = v14[1]

			for _, v17 in ipairs(v14) do
				if not (Distance(v16:GetPosition(), object:GetPosition()) > Distance(v17:GetPosition(), object:GetPosition())) then
					continue
				end

				v16 = v17
			end

			local position2 = v16:GetPosition()
			fn4(position2)
			local nearbyEnemies = module4.FindNearbyEnemies(position2, 40)

			if #nearbyEnemies > 0 then
				for _, nearbyEnemy in pairs(nearbyEnemies) do
					local __wf_atom_30e3d82b = nearbyEnemy:__wf_atom_30e3d82b()

					if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
						__wf_atom_30e3d82b:__wf_atom_30b587a4()
					end
				end
			end
		else
			for _, v16 in ipairs(v14) do
				local position2 = v16:GetPosition()
				fn4(position2)
				local nearbyEnemies = module4.FindNearbyEnemies(position2, 40)

				if not (#nearbyEnemies > 0) then
					continue
				end

				for _, nearbyEnemy in pairs(nearbyEnemies) do
					local __wf_atom_30e3d82b = nearbyEnemy:__wf_atom_30e3d82b()

					if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
						__wf_atom_30e3d82b:__wf_atom_30b587a4()
					end
				end
			end
		end

		if #entities == 0 or __wf_atom_7e8ad928(v10) then
			return
		end
	else
		local entity = gRegion:CreateEntity(v5, position, v10:__wf_atom_dc309f8a(), nil, nil)

		if __wf_atom_7e8ad928(entity) then
			return
		end

		v10:__wf_atom_d494454b(entity)
		__wf_atom_55142dd4(entity, "OnTouched", fn2)
		local __wf_atom_e919fb8e = entity:__wf_atom_e919fb8e()

		while true do
			if __wf_atom_e919fb8e == nil then
				if not __wf_atom_7e8ad928(entity) then
					__wf_atom_e919fb8e = entity:__wf_atom_e919fb8e()
				end
			elseif __wf_atom_e919fb8e.playerInProximity ~= nil and __wf_atom_e919fb8e.playerInProximity then
				break
			end

			Sleep(1)
		end

		if __wf_atom_7e8ad928(v10) then
			print("Shutdown due to level streaming")
			return
		end

		if __wf_atom_7e8ad928(v12) then
			local __wf_atom_9c85bbdb = v10:__wf_atom_9c85bbdb(100)
			v12 = module.NearestObject(position, __wf_atom_9c85bbdb)
		end

		if __wf_atom_7e8ad928(v12) or v12:IsKilled() then
			return
		end

		local __wf_atom_ab18bf26 = v12:__wf_atom_ab18bf26()
		local v16 = { 25, __wf_atom_5784a397(65, 80) }
		local v17 = v16[__wf_atom_5784a397(1, 2)]
		local v18 = v12:GetPosition() + v17 * __wf_atom_ab18bf26

		for _ = 1, __wf_atom_5784a397(1, 3) do
			local v19 = Vector()
			local v20 = __wf_atom_5784a397(1, #v)
			VectorAdd(v19, v18, v[v20])
			table.remove(v, v20)
			table.insert(v15, v19)
		end

		v10:__wf_atom_c53e1842(v15[1])
		position = module2.GetGroundPos(position)
		local v19 = module.RemoveDuplicatesFromTable(v15)

		if __wf_atom_7e8ad928(v11) then
			v11 = object
		end

		local v20 = Range(0, 5)

		for _, v21 in ipairs(v19) do
			local v22 = fn3(v20, 3, nil, v21)
			local positions = module3.GetPositions(1, v22)

			if #positions > 0 then
				fn4(positions[1])
			end
		end

		if #entities == 0 or __wf_atom_7e8ad928(v10) then
			return
		end

		local nearbyEnemies = module4.FindNearbyEnemies(v18, 40)

		if #nearbyEnemies > 0 and v17 <= v16[1] then
			for _, nearbyEnemy in pairs(nearbyEnemies) do
				nearbyEnemy:__wf_atom_30e3d82b():__wf_atom_30b587a4()
			end
		end

		Sleep(2)
	end

	fn6()
	fn7()
end