local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("SF.Scripts.Libs.ObjectiveHudLib")
local module3 = require("SF.Scripts.Libs.TransmissionSet")
local module4 = require("SF.Scripts.Libs.EncounterLib")
local module5 = require("SF.Scripts.Libs.RaycastLib")
local v = WeakResource("/SF/Types/Player/EnvoyAvatar")
local entities = {}
local entities2 = {}
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = {}

local function fn(object)
	for i, v6 in ipairs(entities) do
		module2.UpdateOrAddHudTask(object, "BuriedTreasure" .. tostring(i), hudItems[i], nil, not v6:IsEnabled())
	end
end

local function fn2()
	if __wf_atom_7e8ad928(v5.bangle) then
		v5.bangle = 1
	end

	if not (v5.bangle > 1) then
		v5.bangle += __wf_atom_084b3e93()
		return
	end

	v4 = gRegion:__wf_atom_ef7900cf()

	for _, v6 in ipairs(v4) do
		if not v6:IsA(v) or v6:__wf_atom_bb3e7833(compassType) then
			continue
		end

		v6:Attach(compassType, Symbol("GAME_R1_LEG1"), Vector(0, 0.1, 0.1), Rotation(0, 30, 0))
		print("Attached banglenut to " .. v6:__wf_atom_5b41f63b())
	end

	v5.bangle = 0
end

local function fn3()
	v4 = gRegion:__wf_atom_ef7900cf()

	for _, v6 in ipairs(v4) do
		local __wf_atom_bb3e7833 = v6:__wf_atom_bb3e7833(compassType)

		if __wf_atom_bb3e7833 then
			__wf_atom_bb3e7833:Destroy()
		end
	end
end

local function fn4(__wf_atom_0e0a6fee, p)
	if __wf_atom_7e8ad928(__wf_atom_0e0a6fee) then
		return
	end

	local v6 = WeakResource("/EE/Types/Engine/Terrain")
	local v7 = WeakResource("/EE/Types/Engine/CsgZone")
	local v8 = Vector()
	local v9 = Rotation()
	local __wf_atom_267afa54 = gRegion:__wf_atom_267afa54(
		__wf_atom_0e0a6fee + Vector(0, 2, 0),
		__wf_atom_0e0a6fee + Vector(0, -20, 0),
		nil,
		{ __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce },
		nil,
		v8,
		v9
	)
	local correctGroundHitAngle = module5.CorrectGroundHitAngle(v9)

	if __wf_atom_7e8ad928(__wf_atom_267afa54) or __wf_atom_7e8ad928(v8) then
		return
	end

	local v10 = false

	if p and not (__wf_atom_267afa54:IsA(v6) or __wf_atom_267afa54:IsA(v7)) then
		return
	end

	if __wf_atom_267afa54:IsA(v7) and module5.ObjectHasSizeClearance(v8, nil, 2.1) then
		v10 = true
		return v8, correctGroundHitAngle, true
	end

	if module5.ObjectHasSizeClearance(v8, { v6, v7 }, 1.5) then
		return v8, correctGroundHitAngle, v10
	end
end

local function fn5(object)
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(Symbol("UnearthTreasureSpawn"))
	local __wf_atom_2226b35c2 = gRegion:__wf_atom_2226b35c(Symbol("BuriedTreasureVolume"))
	local __wf_atom_0a6a5887 = gRegion:__wf_atom_0a6a5887(Symbol("LevelEntranceWp"))
	local v6 = Symbol("Intermediate")
	local v7 = Symbol("Objective")
	local __wf_atom_0e0a6fee = v3:__wf_atom_0e0a6fee(__wf_atom_0a6a5887:GetPosition())
	local v8 = {}

	for i = #__wf_atom_2226b35c, 1, -1 do
		local __wf_atom_e800787c = __wf_atom_2226b35c[i]:__wf_atom_e800787c()
		local __wf_atom_0e0a6fee2 = v3:__wf_atom_0e0a6fee(__wf_atom_2226b35c[i]:GetPosition())
		local __wf_atom_57856d42 = v3:__wf_atom_57856d42(__wf_atom_0e0a6fee, __wf_atom_0e0a6fee2)

		if __wf_atom_7e8ad928(__wf_atom_e800787c) then
			table.remove(__wf_atom_2226b35c, i)
		elseif __wf_atom_57856d42 == 0 then
			table.insert(v8, __wf_atom_2226b35c[i])
			table.remove(__wf_atom_2226b35c, i)
		else
			local __wf_atom_db682341 = __wf_atom_e800787c:__wf_atom_db682341()

			if __wf_atom_57856d42 < 150 and __wf_atom_db682341 ~= v6 and __wf_atom_db682341 ~= v7 then
				table.remove(__wf_atom_2226b35c, i)
			end
		end
	end

	local v9 = __wf_atom_7e8ad928(__wf_atom_2226b35c) and {} or __wf_atom_2226b35c

	for _, v10 in ipairs(__wf_atom_2226b35c2) do
		local v11 = nil

		if v10:__wf_atom_bbcb227c() or v10:__wf_atom_642b7ae0() then
			v11 = v10:__wf_atom_4e28532a() ^ 2
		elseif v10:__wf_atom_fdefab34() then
			local __wf_atom_80cf57aa = v10:__wf_atom_80cf57aa()
			v11 = __wf_atom_80cf57aa.x * __wf_atom_80cf57aa.z
		end

		local __wf_atom_0e0a6fee2 = v3:__wf_atom_0e0a6fee(v10:GetPosition())
		local __wf_atom_57856d42 = v3:__wf_atom_57856d42(__wf_atom_0e0a6fee, __wf_atom_0e0a6fee2)

		for _ = 1, math.ceil(v11 / 300) do
			if __wf_atom_57856d42 >= 150 then
				table.insert(v9, v10)
			elseif __wf_atom_57856d42 == 0 then
				table.insert(v8, v10)
				break
			end
		end
	end

	local __wf_atom_0a6a5887_2 = gRegion:__wf_atom_0a6a5887(Symbol("Exit"))
	local v10 = Symbol("ExitBranch")

	if not __wf_atom_7e8ad928(__wf_atom_0a6a5887_2) then
		local layerIndex = __wf_atom_0a6a5887_2:__wf_atom_e800787c():GetLayerIndex()
		v3:__wf_atom_eb6c68dc(v10, layerIndex, 4, -1, 1, 0)
	end

	local v11 = {}
	local v12 = {}
	local v13 = {}

	for _, v14 in ipairs(v9) do
		local __wf_atom_db682341 = v14:__wf_atom_e800787c():__wf_atom_db682341()
		local v15 = "Other"

		if __wf_atom_db682341 == v6 or __wf_atom_db682341 == v7 then
			table.insert(v11, v14)
			v15 = "Large Hub"
		elseif v3:__wf_atom_ab4fd7ad(v14, v10) > 0 then
			table.insert(v12, v14)
			v15 = "Exit Branch"
		else
			table.insert(v13, v14)
		end

		if not _T.DungeonObjDebugDraw then
			continue
		end

		gRegion:__wf_atom_5b35a0c8(v14:GetPosition() + Vector(0, 1, 0), Color(0, 192, 192), v15, 1, 999)
		gRegion:__wf_atom_628723a6(v14:GetPosition(), v14:GetPosition() + Vector(0, 1, 0), Color(0, 192, 192), 999)
	end

	local v14 = __wf_atom_5784a397(0, 2)

	while true do
		local v15 = nil
		local v16 = nil
		local v17 = false
		local v18

		if #entities == 0 and #v11 > 0 then
			local v19 = __wf_atom_5784a397(1, #v11)
			v18 = v11[v19]
			table.remove(v11, v19)
			v8 = module.MergeTables(v11, v8)
			v11 = {}
		elseif #entities <= 1 and #v12 > 0 then
			local v19 = __wf_atom_5784a397(1, #v12)
			v18 = v12[v19]
			table.remove(v12, v19)
			v8 = module.MergeTables(v12, v8)
			v12 = {}
		elseif #v13 > 0 then
			local v19 = __wf_atom_5784a397(1, #v13)
			v18 = v13[v19]
			table.remove(v13, v19)
		elseif #v8 > 0 then
			local v19 = __wf_atom_5784a397(1, #v8)
			v18 = v8[v19]
			table.remove(v8, v19)
		else
			print("No valid spawnpoints left")
			break
		end

		if v18:IsA(__wf_atom_8b8e8b22) then
			local count = 0

			while __wf_atom_7e8ad928(v15) and count < 5 do
				local randomPointInVolume = module.GetRandomPointInVolume(v18)
				local __wf_atom_0e0a6fee2 = v3:__wf_atom_0e0a6fee(randomPointInVolume)

				if
					__wf_atom_0e0a6fee2 ~= randomPointInVolume
					and __wf_atom_0e0a6fee2 ~= __wf_atom_28d5d4aa
					and __wf_atom_0e0a6fee2 ~= nil
				then
					v15, v16, v17 = fn4(__wf_atom_0e0a6fee2, true)
				end

				count += 1
			end
		else
			v15, v16, v17 = fn4((v3:__wf_atom_0e0a6fee(v18:GetPosition())))

			if not __wf_atom_7e8ad928(v15) then
				v16 = __wf_atom_d919c2d7(v16, v18:__wf_atom_dc309f8a())
			end
		end

		if not __wf_atom_7e8ad928(v15) then
			local buriedTreasureType = buriedTreasureType
			local v19

			if #entities >= numItems then
				v19 = not __wf_atom_7e8ad928(falsePositiveType) and v14 > 0
			else
				v19 = false
			end

			if v19 then
				buriedTreasureType = falsePositiveType
			end

			local entity = gRegion:CreateEntity(buriedTreasureType, v15, v16)
			object:__wf_atom_d494454b(entity)

			if v19 then
				print("Spawned false positive")
				table.insert(entities2, entity)
			else
				print("Spawned treasure")
				table.insert(entities, entity)
			end

			if v17 and not __wf_atom_7e8ad928(groundDecoType) then
				local v20 = Vector(0, __wf_atom_8d119bab(0.0375, 0.05), 0)
				object:__wf_atom_d494454b((gRegion:CreateEntity(
					groundDecoType,
					v15 + v20,
					Rotation(__wf_atom_5784a397(0, 360), 0, 0)
				)))
			end
		end

		if not (#entities >= numItems and v14 <= #entities2) then
			continue
		end

		print("Spawn count reached")
		break
	end

	print("Done spawning")
end

function Main(object)
	print("Buried treasure encounter started")
	v3 = gRegion:__wf_atom_2202ffb6():__wf_atom_7d789620()
	v2 = object:__wf_atom_26b04ea9()
	local __wf_atom_d0c8d09f = object:__wf_atom_dd85e6db():__wf_atom_d0c8d09f()
	object:__wf_atom_8e6fec76(1)

	if not module4.WaitForParentEncounterActive(object) then
		object:__wf_atom_8e6fec76(6)
		return
	end

	fn5(object)
	fn2()
	object:__wf_atom_8e6fec76(2)
	local v6 = nil

	while not module4.PrimedMissionShouldShutDown(object, v2) do
		local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
		local count = 0

		for i = #entities, 1, -1 do
			if __wf_atom_7e8ad928(entities[i]) or not entities[i]:IsEnabled() then
				count += 1
			elseif _T.DungeonObjDebugDraw then
				local __wf_atom_57856d42 = v3:__wf_atom_57856d42(
					entities[i]:GetPosition(),
					__wf_atom_c4f78a8f:GetPosition()
				)
				gRegion:__wf_atom_5b35a0c8(
					entities[i]:GetPosition() + Vector(0, 1, 0),
					Color(0, 255, 0),
					"Buried Treasure " .. i .. ": " .. math.ceil(__wf_atom_57856d42),
					1,
					0
				)
				gRegion:__wf_atom_628723a6(
					entities[i]:GetPosition(),
					entities[i]:GetPosition() + Vector(0, 1, 0),
					Color(0, 255, 0),
					0
				)
			end
		end

		for i = #entities2, 1, -1 do
			if __wf_atom_7e8ad928(entities2[i]) or not entities2[i]:IsEnabled() then
				table.remove(entities2, i)
			elseif _T.DungeonObjDebugDraw then
				local __wf_atom_57856d42 = v3:__wf_atom_57856d42(
					entities2[i]:GetPosition(),
					__wf_atom_c4f78a8f:GetPosition()
				)
				gRegion:__wf_atom_5b35a0c8(
					entities2[i]:GetPosition() + Vector(0, 1, 0),
					Color(192, 192, 0),
					"False Positive " .. i .. ": " .. math.ceil(__wf_atom_57856d42),
					1,
					0
				)
				gRegion:__wf_atom_628723a6(
					entities2[i]:GetPosition(),
					entities2[i]:GetPosition() + Vector(0, 1, 0),
					Color(192, 192, 0),
					0
				)
			end
		end

		fn2()

		if count ~= v6 then
			fn(object)
			v6 = count
		end

		if count == #entities then
			object:__wf_atom_8e6fec76(4)
			break
		else
			Sleep(0)
		end
	end

	if __wf_atom_7e8ad928(object) then
		fn3()
		return
	end

	for i = #entities2, 1, -1 do
		if not __wf_atom_7e8ad928(entities2[i]) then
			entities2[i]:Destroy()
		end
	end

	if object:__wf_atom_4026dfb5() == 4 then
		print("Buried treasure encounter completed")
		Sleep(4)

		if __wf_atom_7e8ad928(object) then
			fn3()
			return
		end

		module4.GiveDeedRewards(object, dropTable)
		module2.RemoveHudGroup(object)
		Sleep(3)
		module3.PlayGlobalTransmission(__wf_atom_d0c8d09f, deedDoneTransmissionTag)

		while not __wf_atom_7e8ad928(object) and object:__wf_atom_4026dfb5() < 6 do
			Sleep(0)
		end
	else
		object:__wf_atom_8e6fec76(6)
	end

	print("Buried treasure encounter shutdown")
	module2.RemoveHudGroup(object)
	fn3()
end

function RetrieveContextAction(instance, _)
	local __wf_atom_3d96ddcd = instance:__wf_atom_3d96ddcd()

	if __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
		instance:Destroy()
	else
		__wf_atom_3d96ddcd:Destroy()
	end
end