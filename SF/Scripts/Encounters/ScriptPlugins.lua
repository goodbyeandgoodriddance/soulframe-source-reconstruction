local v = nil
local v2 = nil
local v3 = nil
local module = require("SF.Scripts.Libs.EncounterLib")
local module2 = require("SF.Scripts.Libs.RaycastLib")
local module3 = require("SF.Scripts.Libs.CommonFunctionsLib")
local module4 = require("Lotus.Scripts.Libs.Query")
local module5 = require("Lotus.Scripts.Libs.TableLib")

function SpawnRandomObjects(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local v4 = __wf_atom_5784a397(1, #randomObjectTypes)
	local randomObjectType = randomObjectTypes[v4]
	local v5 = __wf_atom_5784a397(numToSpawn.minValue, numToSpawn.maxValue)

	if math.random() > chanceToSpawn or v5 <= 0 or __wf_atom_7e8ad928(randomObjectType) then
		instance:Destroy()
		return
	end

	local position = __wf_atom_3d96ddcd:GetPosition()
	local v6 = {}

	if not __wf_atom_7e8ad928(spawnPointTags[v4]) and spawnPointTags[v4] ~= EMPTY_SYMBOL then
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
			spawnPointTags[v4],
			position,
			spawnRange.minValue,
			spawnRange.maxValue
		)

		for _, entity in ipairs(__wf_atom_439c0d29) do
			table.insert(v6, {
				pos = entity:GetPosition(),
				rot = entity:__wf_atom_dc309f8a(),
				entity = entity
			})
		end
	end

	if #v6 < v5 and useTacPosQuery then
		local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(
			position,
			spawnRange,
			v5 - #v6,
			querySpacing
		)

		for _, v7 in ipairs(randomSpawnsOnNavInRange) do
			local groundAlignedSpawnPosRot, rot = module2.GetGroundAlignedSpawnPosRot(
				randomObjectType,
				v7,
				Rotation(__wf_atom_5784a397(0, 360), 0, 0),
				false,
				30
			)

			if not __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
				table.insert(v6, { pos = groundAlignedSpawnPosRot, rot = rot })
			end
		end
	end

	local v7 = math.min(#v6, v5)

	if v7 == 0 then
		instance:Destroy()
		return
	end

	for _ = 1, v7 do
		local v8 = __wf_atom_5784a397(1, #v6)
		local entity = gRegion:CreateEntity(randomObjectType, v6[v8].pos, v6[v8].rot)

		if not __wf_atom_7e8ad928(v6[v8].entity) then
			v6[v8].entity:FirePort("Disable")
		end

		table.remove(v6, v8)
		__wf_atom_3d96ddcd:__wf_atom_d494454b(entity)
	end

	instance:Destroy()
end

function SpawnRandomPointsOfInterest(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local position = __wf_atom_3d96ddcd:GetPosition()
	local v4 = math.max(20, __wf_atom_3d96ddcd:__wf_atom_103377cc() + 5)
	local all = gRegion:FindAll(__wf_atom_46b5a019, position, 0, v4)

	if #all == 0 then
		all = gRegion:FindAll(__wf_atom_da394184, position, 0, v4)
	end

	if #all > 0 then
		instance:Destroy()
		return
	end

	local spawnRange2

	if spawnRange.minValue > -1 and spawnRange.maxValue > -1 then
		spawnRange2 = spawnRange
	else
		spawnRange2 = Range(5, 10)
	end

	local __wf_atom_6199ef01 = __wf_atom_3d96ddcd:__wf_atom_6199ef01()

	for _, v5 in ipairs(__wf_atom_6199ef01) do
		local __wf_atom_50a7d83e = v5:__wf_atom_50a7d83e()
		spawnRange.maxValue = math.max(
			spawnRange.maxValue,
			module3.Distance2d(position, __wf_atom_50a7d83e:GetPosition())
		)
	end

	local __wf_atom_3634e6d2 = __wf_atom_3d96ddcd:__wf_atom_3634e6d2()
	local v5 = __wf_atom_5784a397(__wf_atom_3634e6d2 + 1, __wf_atom_3634e6d2 + 3)
	local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(position, spawnRange2, v5, 3)
	local v6 = math.min(v5, #randomSpawnsOnNavInRange)

	if v6 <= 0 then
		instance:Destroy()
		return
	end

	for _ = 1, v6 do
		local v7 = __wf_atom_5784a397(1, #randomObjectTypes)
		local randomObjectType = randomObjectTypes[v7]
		local v8 = __wf_atom_5784a397(1, #randomSpawnsOnNavInRange)
		local groundPos = module2.GetGroundPos(randomSpawnsOnNavInRange[v8])
		local v9

		if faceInwards then
			v9 = __wf_atom_fa8d0177(randomSpawnsOnNavInRange[v8], position)
		else
			v9 = __wf_atom_fa8d0177(position, randomSpawnsOnNavInRange[v8])
		end

		local entity = gRegion:CreateEntity(randomObjectType, groundPos, v9)
		table.remove(randomSpawnsOnNavInRange, v8)
		__wf_atom_3d96ddcd:__wf_atom_d494454b(entity)
	end

	instance:Destroy()
end

function CorruptedNest(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local __wf_atom_26b04ea9 = __wf_atom_3d96ddcd:__wf_atom_26b04ea9()

	if not __wf_atom_7e8ad928(__wf_atom_26b04ea9) then
		__wf_atom_3d96ddcd = __wf_atom_26b04ea9
	end

	local __wf_atom_7d789620 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_0e0a6fee = __wf_atom_7d789620:__wf_atom_0e0a6fee(__wf_atom_3d96ddcd:GetPosition())
	local v4 = not __wf_atom_3d96ddcd:IsA(WeakResource("/SF/Types/Game/Encounters/Corruption/Hints/CorruptedNestEncounterHint"))
	local v5 = math.max(__wf_atom_3d96ddcd:__wf_atom_103377cc() - spawnRange.maxValue, 10)

	if v4 then
		local __wf_atom_28ce676a = __wf_atom_7d789620:__wf_atom_28ce676a()
		__wf_atom_28ce676a:__wf_atom_267bfc41(__wf_atom_0e0a6fee, Range(0, v5), 3)
		__wf_atom_28ce676a:__wf_atom_62a3e89b(20, 30, -30)
		__wf_atom_28ce676a:__wf_atom_4a7833f4()
		__wf_atom_28ce676a:__wf_atom_655394dc()
		__wf_atom_28ce676a:__wf_atom_06c7577b()
		__wf_atom_28ce676a:__wf_atom_7e9d12f8(25)
		__wf_atom_28ce676a:__wf_atom_df6829ae(Range(3, 3.4028234663852886e38))
		__wf_atom_28ce676a:__wf_atom_bacad54b()
		__wf_atom_28ce676a:__wf_atom_9699b67c(false)
		__wf_atom_28ce676a:__wf_atom_09d2b44e(false)
		__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("CorruptedNest"), Color("0x00FFFF"))
		local positions = module4.GetPositions(5, __wf_atom_28ce676a)

		if __wf_atom_7e8ad928(positions) or #positions == 0 then
			print("No valid tac position for corrupted nest " .. __wf_atom_3d96ddcd:GetName())
			__wf_atom_3d96ddcd:__wf_atom_8e6fec76(6)
			return
		else
			__wf_atom_0e0a6fee = positions[__wf_atom_5784a397(1, #positions)]
		end
	end

	local groundAlignedSpawnPosRot, v6 = module2.GetGroundAlignedSpawnPosRot(
		objectType,
		__wf_atom_0e0a6fee,
		Rotation(__wf_atom_5784a397(0, 360), 0, 0),
		false,
		30
	)

	if __wf_atom_7e8ad928(groundAlignedSpawnPosRot) then
		print("No valid ground position for corrupted nest " .. __wf_atom_3d96ddcd:GetName())
		__wf_atom_3d96ddcd:__wf_atom_8e6fec76(6)
	else
		local entity = gRegion:CreateEntity(objectType, groundAlignedSpawnPosRot + Vector(0, -0.2, 0), v6)
		__wf_atom_3d96ddcd:__wf_atom_d494454b(entity)
		__wf_atom_3d96ddcd:__wf_atom_c53e1842(groundAlignedSpawnPosRot)
		local entities = {}

		for _ = 1, __wf_atom_5784a397(numRandomObjects.minValue, numRandomObjects.maxValue) do
			local v7 = __wf_atom_5784a397(1, #randomObjectTypes)
			local randomObjectType = randomObjectTypes[v7]
			local randomPointInRangeOnNav = __wf_atom_7d789620:GetRandomPointInRangeOnNav(
				groundAlignedSpawnPosRot,
				spawnRange.minValue,
				spawnRange.maxValue,
				true,
				0.5
			)
			local v8 = offsets[v7] or __wf_atom_28d5d4aa
			local groundAlignedSpawnPosRot2, v9 = module2.GetGroundAlignedSpawnPosRot(
				randomObjectType,
				randomPointInRangeOnNav,
				Rotation(__wf_atom_5784a397(0, 360), 0, 0),
				false,
				30
			)

			if __wf_atom_7e8ad928(groundAlignedSpawnPosRot2) then
				continue
			end

			local entity2 = gRegion:CreateEntity(randomObjectType, groundAlignedSpawnPosRot2 + v8, v9)
			table.insert(entities, entity2)
			__wf_atom_3d96ddcd:__wf_atom_d494454b(entity2)
		end

		local __wf_atom_bb3e7833 = entity:__wf_atom_bb3e7833(__wf_atom_3a0953be)
		local __wf_atom_6199ef01 = __wf_atom_3d96ddcd:__wf_atom_6199ef01()
		local v7 = 1

		if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
			local __wf_atom_0e0a6fee2 = __wf_atom_7d789620:__wf_atom_0e0a6fee(__wf_atom_bb3e7833:GetPosition())

			if not __wf_atom_7e8ad928(__wf_atom_6199ef01) and #__wf_atom_6199ef01 > 0 then
				local __wf_atom_50a7d83e = __wf_atom_6199ef01[1]:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					__wf_atom_50a7d83e:Teleport(__wf_atom_0e0a6fee2, __wf_atom_bb3e7833:__wf_atom_dc309f8a())
				end

				v7 = 2
			end
		end

		if v4 and #__wf_atom_6199ef01 > 1 then
			for i = v7, #__wf_atom_6199ef01 do
				local __wf_atom_50a7d83e = __wf_atom_6199ef01[i]:__wf_atom_50a7d83e()

				if not __wf_atom_7e8ad928(__wf_atom_50a7d83e) then
					__wf_atom_50a7d83e:Teleport(
						__wf_atom_7d789620:GetRandomPointInRangeOnNav(
							groundAlignedSpawnPosRot,
							spawnRange.minValue,
							spawnRange.maxValue,
							true,
							0.5
						),
						Rotation(__wf_atom_5784a397(0, 360), 0, 0)
					)
				end
			end
		end

		local __wf_atom_fe00d825 = __wf_atom_3d96ddcd:__wf_atom_fe00d825()
		local v8 = WeakResource("/SF/Types/Enemies/Wildlife/Mockeries/Attachements/MockeriesHuskDeco")

		for _, v9 in ipairs(__wf_atom_fe00d825) do
			if not v9:IsA(v8) then
				continue
			end

			local randomPointInRangeOnNav

			if #entities > 0 then
				local v10 = __wf_atom_5784a397(1, #entities)
				randomPointInRangeOnNav = entities[v10]:GetPosition() + Vector(math.random(), 0, math.random())
				table.remove(entities, v10)
			else
				randomPointInRangeOnNav = __wf_atom_7d789620:GetRandomPointInRangeOnNav(
					groundAlignedSpawnPosRot,
					spawnRange.minValue,
					spawnRange.maxValue,
					true,
					0.5
				)
			end

			local groundPos = module2.GetGroundPos(randomPointInRangeOnNav + Vector(0, 1, 0))
			v9:Teleport(
				groundPos,
				(__wf_atom_d919c2d7(
					__wf_atom_fa8d0177(groundAlignedSpawnPosRot, groundPos),
					Rotation(__wf_atom_5784a397(-45, 45), 0, 0)
				))
			)
		end

		local v9 = WeakResource("/SF/Types/PickUps/LootContainers/LootChestBase")
		local nearestTagged = gRegion:FindNearestTagged(Symbol("LootChestSpawnPt"), groundAlignedSpawnPosRot)

		if not __wf_atom_7e8ad928(nearestTagged) then
			for _, v10 in ipairs(__wf_atom_fe00d825) do
				if not v10:IsA(v9) then
					continue
				end

				v10:Teleport(nearestTagged:GetPosition(), nearestTagged:__wf_atom_dc309f8a())
				v10:SetMeshScale(0.9)
				v10:__wf_atom_25c58c94(false, true)
				break
			end
		end

		local v10 = Symbol("Neutral")
		local __wf_atom_57e5ac18 = gRegion:__wf_atom_57e5ac18()

		for _, v11 in ipairs(__wf_atom_57e5ac18) do
			if v11:IsKilled() or v11:__wf_atom_e93896ba() ~= v10 or v11:__wf_atom_535d5cbb() then
				continue
			end

			v11:Teleport(
				__wf_atom_7d789620:GetRandomPointInRangeOnNav(
					groundAlignedSpawnPosRot,
					spawnRange.maxValue + 3,
					spawnRange.maxValue + 10,
					true,
					0.5
				),
				Rotation(__wf_atom_5784a397(0, 360), 0, 0)
			)
		end

		instance:Destroy()
	end
end

function SpawnCart(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local position = __wf_atom_3d96ddcd:GetPosition()
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
		Symbol("OdeCartSpawn"),
		position,
		0,
		__wf_atom_3d96ddcd:__wf_atom_103377cc()
	)

	if __wf_atom_7e8ad928(__wf_atom_439c0d29) or #__wf_atom_439c0d29 == 0 then
		print("No valid cart spawnpoint found " .. __wf_atom_3d96ddcd:GetName())
		__wf_atom_3d96ddcd:__wf_atom_8e6fec76(6)
	else
		local v4 = __wf_atom_439c0d29[__wf_atom_5784a397(1, #__wf_atom_439c0d29)]
		local position2 = v4:GetPosition()
		local __wf_atom_dc309f8a = v4:__wf_atom_dc309f8a()
		local randomContainerDeco = randomContainerDecos[__wf_atom_5784a397(1, #randomContainerDecos)]
		local entity = gRegion:CreateEntity(randomContainerDeco, position2, __wf_atom_dc309f8a)
		__wf_atom_3d96ddcd:__wf_atom_d494454b(entity)

		if not __wf_atom_7e8ad928(randomObjectTypes) and #randomObjectTypes > 0 then
			local randomObjectType = randomObjectTypes[__wf_atom_5784a397(1, #randomObjectTypes)]

			if containerAttachTag ~= EMPTY_SYMBOL and not __wf_atom_7e8ad928(randomObjectType) then
				local __wf_atom_f582136d = entity:__wf_atom_f582136d(__wf_atom_8d0b7f88)

				for i = #__wf_atom_f582136d, 1, -1 do
					if __wf_atom_f582136d[i]:__wf_atom_db682341() ~= containerAttachTag then
						table.remove(__wf_atom_f582136d, i)
					end
				end

				if not __wf_atom_7e8ad928(__wf_atom_f582136d) and #__wf_atom_f582136d > 0 then
					local v5 = __wf_atom_5784a397(1, #__wf_atom_f582136d)
					__wf_atom_3d96ddcd:__wf_atom_d494454b((gRegion:CreateEntity(
						randomObjectType,
						__wf_atom_f582136d[v5]:GetPosition(),
						__wf_atom_f582136d[v5]:__wf_atom_dc309f8a()
					)))
				end
			end
		end

		instance:Destroy()
	end
end

function DisablePreDeath(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local __wf_atom_6199ef01 = __wf_atom_3d96ddcd:__wf_atom_6199ef01()

	for _, v4 in ipairs(__wf_atom_6199ef01) do
		local __wf_atom_50a7d83e = v4:__wf_atom_50a7d83e()

		if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled()) then
			__wf_atom_50a7d83e:__wf_atom_7470861b():__wf_atom_b6bcaf97(false)
		end
	end

	instance:Destroy()
end

function SetInitialHealth(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local __wf_atom_6199ef01 = __wf_atom_3d96ddcd:__wf_atom_6199ef01()

	for _, v4 in ipairs(__wf_atom_6199ef01) do
		local __wf_atom_50a7d83e = v4:__wf_atom_50a7d83e()

		if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled()) then
			__wf_atom_50a7d83e:SetHealth(__wf_atom_50a7d83e:GetMaxHealth() * initialHealthPercentage)
		end
	end

	instance:Destroy()
end

local function fn()
	local _ = { Vector(1, 0, 1), Vector(-1, 0, 1), Vector(1, 0, -1) }
end

local function fn2() end

local function fn3() end

function MobileCampEvents(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	if math.random() > chanceToSpawn then
		return
	end

	local v4 = { fn, fn2, fn3 }
	v4[__wf_atom_5784a397(1, #v4)]()
	instance:Destroy()
end

function EnemyFormation(instance)
	Sleep(1)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	if math.random() > chanceToSpawn then
		return
	end

	local position = __wf_atom_3d96ddcd:GetPosition()
	local v4 = math.max(__wf_atom_3d96ddcd:__wf_atom_103377cc(), 20)
	local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(Symbol("FormationLeaderSpawn"), position, 0, v4)

	if #__wf_atom_439c0d29 == 0 then
		return
	end

	local v5 = __wf_atom_439c0d29[__wf_atom_5784a397(1, #__wf_atom_439c0d29)]
	local __wf_atom_31c6f706 = v5:__wf_atom_31c6f706()

	if #__wf_atom_31c6f706 == 0 then
		return
	end

	v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_6199ef01 = __wf_atom_3d96ddcd:__wf_atom_6199ef01()
	local __wf_atom_50a7d83es = {}
	local __wf_atom_50a7d83es2 = {}

	for _, v6 in ipairs(__wf_atom_6199ef01) do
		local __wf_atom_50a7d83e = v6:__wf_atom_50a7d83e()

		if
			__wf_atom_7e8ad928(__wf_atom_50a7d83e)
			or __wf_atom_50a7d83e:IsKilled()
			or __wf_atom_50a7d83e:__wf_atom_e93896ba() ~= requiredFaction
			or not (v6:__wf_atom_6f203663() <= 3)
		then
			continue
		end

		if v6:__wf_atom_6f203663() >= 2 then
			table.insert(__wf_atom_50a7d83es, __wf_atom_50a7d83e)
		else
			table.insert(__wf_atom_50a7d83es2, __wf_atom_50a7d83e)
		end
	end

	if #__wf_atom_50a7d83es == 0 or #__wf_atom_50a7d83es2 < 2 then
		return
	end

	local function fn4(_, _)
		return false
	end

	local function fn5(object, object2)
		local position2 = object2:GetPosition()
		local __wf_atom_e2db08ce = gRegion:__wf_atom_e2db08ce(__wf_atom_46b5a019, position2, 1)

		if not __wf_atom_7e8ad928(__wf_atom_e2db08ce) then
			object:Teleport(v:__wf_atom_0e0a6fee(position2, 1, 5), object2:__wf_atom_dc309f8a())
			local __wf_atom_30e3d82b = object:__wf_atom_30e3d82b()
			__wf_atom_e2db08ce:Enable()
			__wf_atom_30e3d82b:__wf_atom_cdd21129()
			__wf_atom_30e3d82b:SetPatrolRoute(nil)
			module.HoldPosition(__wf_atom_30e3d82b, true)
			__wf_atom_30e3d82b:__wf_atom_ce40066e(Symbol("ShouldPatrol"), false)
		end
	end

	table.sort(__wf_atom_50a7d83es, fn4)
	fn5(__wf_atom_50a7d83es[#__wf_atom_50a7d83es], v5)
	table.sort(__wf_atom_50a7d83es2, fn4)

	for i = 1, math.min(#__wf_atom_31c6f706, #__wf_atom_50a7d83es2) do
		fn5(__wf_atom_50a7d83es2[i], __wf_atom_31c6f706[i])
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function SpawnFugitive(instance)
	Sleep(1)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	if math.random() > chanceToSpawn then
		return
	end

	v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local position = __wf_atom_3d96ddcd:GetPosition()
	local v4 = nil
	local v5 = Range(10, (math.max(__wf_atom_3d96ddcd:__wf_atom_103377cc(), 30)))
	local __wf_atom_e919fb8e = __wf_atom_3d96ddcd:__wf_atom_e919fb8e()
	local v6 = false

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.patrolRoute) then
		local v7 = Range(20, 50)
		local total = 0
		local v8 = {}

		for i = 2, #__wf_atom_e919fb8e.patrolRoute do
			total += Distance(__wf_atom_e919fb8e.patrolRoute[i], __wf_atom_e919fb8e.patrolRoute[i - 1])

			if v7.minValue <= total and total <= v7.maxValue then
				table.insert(v8, { __wf_atom_e919fb8e.patrolRoute[i], __wf_atom_e919fb8e.patrolRoute[i - 1] })
			end
		end

		if #v8 > 0 then
			v4 = v8[__wf_atom_5784a397(1, #v8)]
			position = v4[1]
			v5 = Range(0, 20)
			v6 = true
		end
	end

	local __wf_atom_28ce676a = v:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, v5, 4)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(5, 5, -5)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(30)
	__wf_atom_28ce676a:__wf_atom_c9dbb0ae(Range(0, 10), -0.8, 3.1, 1, 0, false)
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("Fugitive"), Color("0xFF0000"))

	if v6 and #__wf_atom_e919fb8e.patrolRoute > 1 then
		__wf_atom_28ce676a:__wf_atom_e275b192(
			__wf_atom_e919fb8e.patrolRoute[1],
			__wf_atom_e97f3142(__wf_atom_fa8d0177(__wf_atom_e919fb8e.patrolRoute[1], __wf_atom_e919fb8e.patrolRoute[2])),
			120
		)

		for _, v7 in ipairs(v4) do
			__wf_atom_28ce676a:__wf_atom_2b700733(v7, 2, 0.2, 1)
		end
	end

	local positions = module4.GetPositions(1, __wf_atom_28ce676a)

	if #positions > 0 then
		local agentType = agentTypes[__wf_atom_5784a397(1, #agentTypes)]
		local __wf_atom_402b3832 = v:__wf_atom_402b3832(agentType, positions[1], __wf_atom_80368bb1, EMPTY_SYMBOL)
		local __wf_atom_50a7d83e = __wf_atom_402b3832:__wf_atom_50a7d83e()

		if not (__wf_atom_7e8ad928(__wf_atom_50a7d83e) or __wf_atom_50a7d83e:IsKilled()) then
			__wf_atom_50a7d83e:SetFaction(Symbol("TENNO"))
			__wf_atom_50a7d83e:__wf_atom_2f3f52aa(5)
			__wf_atom_50a7d83e:SetHealth(__wf_atom_5784a397(10, 50))
		end

		__wf_atom_402b3832:__wf_atom_6bb5f08a(Symbol("Grineer"))
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function SpawnAnimalCages(instance)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	local __wf_atom_103377cc = __wf_atom_3d96ddcd:__wf_atom_103377cc()
	local v4 = Range(0, (math.max(10, __wf_atom_103377cc + searchRange)))
	local cageType = cageTypes[__wf_atom_5784a397(1, #cageTypes)]

	if not __wf_atom_7e8ad928(cageType) then
		local cage = nil
		local __wf_atom_439c0d29 = gRegion:__wf_atom_439c0d29(
			Symbol("AnimalCageSpawn"),
			__wf_atom_3d96ddcd:GetPosition(),
			0,
			v4.maxValue
		)

		if not __wf_atom_7e8ad928(__wf_atom_439c0d29) and #__wf_atom_439c0d29 > 0 then
			module5.InPlaceShuffle(__wf_atom_439c0d29)

			for i = 1, numberOfCagesToSpawn do
				local v5 = __wf_atom_439c0d29[i]

				if __wf_atom_7e8ad928(v5) or not __wf_atom_7e8ad928(v5:__wf_atom_e919fb8e().cage) then
					continue
				end

				cage = gRegion:CreateEntity(cageType, v5:GetPosition(), v5:__wf_atom_dc309f8a())
				local __wf_atom_e919fb8e = v5:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.cage = cage
				break
			end
		end

		if not __wf_atom_7e8ad928(cage) then
			__wf_atom_3d96ddcd:__wf_atom_d494454b(cage)
		end
	end
end

local function fn4(positions, value, minValue, maxValue)
	local v4 = value or 0
	local v5 = maxValue or 3

	if (minValue or 2) >= #positions then
		return positions
	end

	local v6 = -1
	local v7 = 1
	local v8 = 2

	for i = 1, #positions do
		for j = i + 1, #positions do
			local v9 = __wf_atom_a93b9922(positions[i], positions[j])

			if not (v6 < v9) then
				continue
			end

			v8 = j
			v7 = i
			v6 = v9
		end
	end

	local result = { positions[v7], positions[v8] }
	local v9 = {}

	for i, v10 in ipairs(positions) do
		if i ~= v7 and i ~= v8 then
			table.insert(v9, v10)
		end
	end

	while #result < v5 and #v9 > 0 do
		local v10 = -1
		local v11 = nil

		for i, v12 in ipairs(v9) do
			local v13 = 1e300

			for _, v14 in ipairs(result) do
				local v15 = __wf_atom_a93b9922(v12, v14)

				if v15 < v13 then
					v13 = v15
				end
			end

			if not (v10 < v13) then
				continue
			end

			v11 = i
			v10 = v13
		end

		if v4 <= v10 then
			table.insert(result, table.remove(v9, v11))
		else
			break
		end
	end

	return result
end

local function fn5()
	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_f54283ea()
	end
end

function SpawnScout(instance)
	Sleep(1)

	if __wf_atom_7e8ad928(instance) then
		return
	end

	v2 = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(v2) or not v2:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	if math.random() > chanceToSpawn then
		instance:Destroy()
		return
	end

	v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	local __wf_atom_b7c04e13 = v2:__wf_atom_b7c04e13()

	if __wf_atom_7e8ad928(__wf_atom_b7c04e13) or #__wf_atom_b7c04e13 == 0 then
		instance:Destroy()
		return
	end

	local v4 = __wf_atom_b7c04e13[__wf_atom_5784a397(1, #__wf_atom_b7c04e13)]
	local position = v2:GetPosition()
	local __wf_atom_28ce676a = v:__wf_atom_28ce676a()
	__wf_atom_28ce676a:__wf_atom_267bfc41(position, spawnRange, 5)
	__wf_atom_28ce676a:__wf_atom_62a3e89b(5, 5, -5)
	__wf_atom_28ce676a:__wf_atom_4a7833f4()
	__wf_atom_28ce676a:__wf_atom_655394dc()
	__wf_atom_28ce676a:__wf_atom_06c7577b()
	__wf_atom_28ce676a:__wf_atom_7e9d12f8(30)
	__wf_atom_28ce676a:__wf_atom_a3426025(position, 1.5)
	__wf_atom_28ce676a:__wf_atom_9b7f7161(
		position,
		__wf_atom_e97f3142(__wf_atom_fa8d0177(position, v4:GetPosition())),
		-6,
		2,
		1,
		1,
		false
	)
	__wf_atom_28ce676a:__wf_atom_c9dbb0ae(Range(0, 10), -0.8, 3.1, 1, 0, false)
	__wf_atom_28ce676a:__wf_atom_9699b67c(false)
	__wf_atom_28ce676a:__wf_atom_09d2b44e(false)
	__wf_atom_28ce676a:__wf_atom_bacad54b()
	__wf_atom_28ce676a:__wf_atom_a49949e0(Symbol("ScoutQuery"), Color("0xFF0000"))
	local v5 = fn4(
		module4.GetPositions(10, __wf_atom_28ce676a),
		5,
		numRandomObjects.minValue,
		numRandomObjects.maxValue
	)

	if #v5 < numRandomObjects.minValue then
		instance:Destroy()
		return
	end

	for _, v6 in ipairs(v5) do
		local v7 = __wf_atom_fa8d0177(v6, v4:GetPosition())
		v7.pitch = 0
		local entity = gRegion:CreateEntity(objectType, v6, v7)
		v2:__wf_atom_d494454b(entity)
	end

	local agentType = agentTypes[__wf_atom_5784a397(1, #agentTypes)]
	local enemyLevel = module.GetEnemyLevel(v2)
	local v6 = __wf_atom_5784a397(enemyLevel.minValue, enemyLevel.maxValue)
	local v7 = __wf_atom_fa8d0177(v5[1], v4:GetPosition())
	v3 = v:__wf_atom_402b3832(agentType, v5[1], v7, Symbol("RandomTeam"), v6)

	if not __wf_atom_7e8ad928(v3) then
		v3:__wf_atom_2df0ea60(true)
		v3:__wf_atom_920a5a62()
		v2:__wf_atom_97f955c1(v3)
		v2:__wf_atom_b447e001(fn5, Symbol("OnCampAlerted"), math.floor(v2:__wf_atom_3634e6d2() / 2), true)

		while
			not __wf_atom_7e8ad928(v2)
			and v2:__wf_atom_4026dfb5() ~= 6
			and not (v2:__wf_atom_3634e6d2(true) <= 0 or v2:__wf_atom_0cc670d2() <= 0)
		do
			Sleep(0)
		end

		if __wf_atom_7e8ad928(v2) then
			return
		else
			v2:__wf_atom_4ab4e145(Symbol("OnCampAlerted"))
		end
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end

function SpawnVillagers(instance)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) or not __wf_atom_3d96ddcd:IsA(__wf_atom_f806fd7a) then
		instance:Destroy()
		return
	end

	if math.random() > chanceToSpawn then
		instance:Destroy()
		return
	end

	local all = gRegion:FindAll(__wf_atom_f806fd7a, __wf_atom_3d96ddcd:GetPosition(), 0, 30)

	for _, v4 in ipairs(all) do
		if not v4:IsA(villagerHintType) then
			continue
		end

		instance:Destroy()
		return
	end

	local position = __wf_atom_3d96ddcd:GetPosition()
	local v4 = math.max(20, __wf_atom_3d96ddcd:__wf_atom_103377cc() + 5)
	local all2 = gRegion:FindAll(__wf_atom_46b5a019, position, 0, v4)

	if #all2 == 0 then
		instance:Destroy()
		return
	end

	local v5 = {}

	for _, v6 in ipairs(all2) do
		if not v6:IsEnabled() then
			continue
		end

		local __wf_atom_1cd2b24a = v6:__wf_atom_1cd2b24a()

		for _, v7 in ipairs(__wf_atom_1cd2b24a) do
			if v7 ~= villagerPoiTag then
				continue
			end

			table.insert(v5, v6)
			break
		end
	end

	if #v5 == 0 then
		if not (#randomObjectTypes > 0) then
			instance:Destroy()
			return
		end

		local v6 = __wf_atom_5784a397(numRandomObjects.minValue, numRandomObjects.maxValue)
		local randomSpawnsOnNavInRange = module.FindRandomSpawnsOnNavInRange(position, spawnRange, v6, 3)
		local v7 = math.min(v6, #randomSpawnsOnNavInRange)

		if v7 <= 0 then
			instance:Destroy()
			return
		end

		for _ = 1, v7 do
			local v8 = __wf_atom_5784a397(1, #randomObjectTypes)
			local randomObjectType = randomObjectTypes[v8]
			local v9 = __wf_atom_5784a397(1, #randomSpawnsOnNavInRange)
			local v10 = __wf_atom_fa8d0177(position, randomSpawnsOnNavInRange[v9])
			local groundPos = module2.GetGroundPos(randomSpawnsOnNavInRange[v9])
			local entity = gRegion:CreateEntity(randomObjectType, groundPos, v10)
			table.insert(v5, entity)
			__wf_atom_3d96ddcd:__wf_atom_d494454b(entity)
		end
	end

	if #v5 == 0 then
		instance:Destroy()
		return
	end

	v = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()

	for _ = 1, math.min(#v5, math.random(villagerNumToSpawn.minValue, villagerNumToSpawn.maxValue)) do
		local v6 = __wf_atom_5784a397(1, #v5)
		local v7 = v5[v6]
		table.remove(v5, v6)
		local agentType = agentTypes[__wf_atom_5784a397(1, #agentTypes)]

		if __wf_atom_7e8ad928(v7) then
			continue
		end

		local randomPointInRangeOnNav = v:GetRandomPointInRangeOnNav(v7:GetPosition(), 0.5, 1, true, 1)
		local __wf_atom_50a7d83e = v:__wf_atom_402b3832(
			agentType,
			randomPointInRangeOnNav,
			__wf_atom_80368bb1,
			EMPTY_SYMBOL
		):__wf_atom_50a7d83e()

		if v7:__wf_atom_9141f195(__wf_atom_50a7d83e) then
			__wf_atom_3d96ddcd:__wf_atom_d494454b(__wf_atom_50a7d83e)
		else
			__wf_atom_50a7d83e:Destroy()
		end
	end

	if not __wf_atom_7e8ad928(instance) then
		instance:Destroy()
	end
end