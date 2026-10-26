local v = WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/PuzzleHangingCageDoorDeco")
local v2 = WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/PuzzleHangingCageSproutfolkMaleDeco")
WeakResource("/Soulframe/SF/Types/Gameplay/Puzzles/PuzzleChainAnchorDeco")
local v3 = WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/PuzzleChainIntegralAnchorDeco")
local v4 = WeakResource("/SF/Types/Gameplay/Puzzles/Attachments/PuzzleChainCeilingRollDeco")
local v5 = Vector(0, -0.25, 0)
local v6 = Vector(200, 200, 200)
local module = require("SF.Scripts.Libs.CommonFunctionsLib")
local module2 = require("Lotus.Scripts.Libs.AudioLib")
local module3 = require("SF.Scripts.Libs.StatsLib")
local v7 = {
	INITIALIZING = 0,
	HANGING = 1,
	MOVING = 2,
	LOCKED = 3,
	UNLOCKED = 4
}
local v8 = { CHAINED = 0, WEAKSPOT = 1, GRAPPLING = 2 }
local v9 = { LINEAR = 0, QUADRATIC = 1, SQUARE = 2, SMOOTH = 3 }
local v10 = Symbol("SproutfolkHangingCage")
local v11 = { "", "", "/SF/Language/Objectives/HangingCageGrapplingHint" }
local v12 = nil
local v13 = nil

local function fn(object, object2, p)
	local v14

	if p then
		v14 = chainBeamType
	else
		v14 = ropeBeamType
	end

	local entity = gRegion:CreateEntity(v14, object:GetPosition() + v5, object:__wf_atom_dc309f8a())
	entity:AttachToInPlace(object, EMPTY_SYMBOL)
	local __wf_atom_c082fc3d = object:__wf_atom_c082fc3d()

	if __wf_atom_c082fc3d ~= 1 then
		entity:__wf_atom_e310f01f(entity:__wf_atom_fa6a8faf() / __wf_atom_c082fc3d, entity:__wf_atom_45c0553e())
	end

	local __wf_atom_bb3e7833 = object2:__wf_atom_bb3e7833(__wf_atom_3a0953be)

	if __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833 = object2
	end

	entity:__wf_atom_b2394158(__wf_atom_bb3e7833, EMPTY_SYMBOL)
	return entity
end

local function fn2(items, p)
	local entities = {}
	local chainRetractBeamType2

	if p then
		chainRetractBeamType2 = chainRetractBeamType
	else
		chainRetractBeamType2 = chainBeamType
	end

	for _, item in pairs(items) do
		local __wf_atom_3d96ddcd = item:__wf_atom_3d96ddcd()
		local position = item:GetPosition()
		local __wf_atom_8cc00ef8 = item:__wf_atom_8cc00ef8()

		if __wf_atom_7e8ad928(position) or __wf_atom_7e8ad928(__wf_atom_8cc00ef8) then
			continue
		end

		item:Destroy()
		local entity = gRegion:CreateEntity(chainRetractBeamType2, position, __wf_atom_80368bb1, v12)
		table.insert(entities, entity)
		entity:__wf_atom_b2394158(__wf_atom_8cc00ef8, EMPTY_SYMBOL)

		if not __wf_atom_7e8ad928(__wf_atom_3d96ddcd) then
			entity:AttachToInPlace(__wf_atom_3d96ddcd, EMPTY_SYMBOL)
		end
	end

	return entities
end

local function fn3(position, p)
	local v14 = math.min(__wf_atom_104bfe98(position.y, p.y, weakSpotRatioOverride), p.y - 1) - position.y
	local v15 = position + Vector(0, v14, 0)
	return (gRegion:CreateEntity(weakSpotType, v15, __wf_atom_80368bb1, v12))
end

local function fn4()
	local all = gRegion:FindAll(weakSpotType)

	for _, v14 in pairs(all) do
		if v14:GetCreator() == v12 then
			return v14
		end
	end

	return nil
end

local function fn5(p, list, p2, p3)
	local result = {}

	for i = 1, #list do
		local v14 = nil

		if i == 1 then
			fn(p2, list[1], p)

			if not __wf_atom_7e8ad928(p3) and #list == 1 then
				v14 = fn(list[1], p3, p)
			end
		elseif i == #list then
			v14 = fn(list[i - 1], list[i], p)

			if not __wf_atom_7e8ad928(p3) then
				v14 = fn(list[i], p3, p)
			end
		else
			v14 = fn(list[i - 1], list[i], p)
		end

		table.insert(result, v14)
	end

	return result
end

local function fn6(p, p2)
	local v14, v15

	if p2 then
		v14 = p + Vector(0, 100, 0)
		v15 = Vector(0, 0.25, 0)
	else
		v14 = p - Vector(0, 100, 0)
		v15 = Vector(0, -2.5, 0)
	end

	local v16 = Vector()
	gRegion:__wf_atom_c20d246a(p + v15, v14, {}, nil, v16)

	if __wf_atom_7e8ad928(v16) or v16 == __wf_atom_28d5d4aa then
		return
	end

	v16.x = p.x
	v16.z = p.z

	if p2 then
		return v16
	end

	local v17 = Vector(v16.x, v16.y, v16.z)

	if not v13:__wf_atom_bd5c14eb(v17, 0.5, 0, 99) then
		v13:__wf_atom_bd5c14eb(v17, 5, 0, 99)
	end

	if not __wf_atom_7e8ad928(v17) and v17 ~= v16 and Distance(v16, v17) < 1 then
		if v16.y < v17.y then
			return (Vector(v17.x, v16.y, v17.z))
		end

		return v17
	end

	return v16
end

function NoiseOnHit(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.noise then
		return
	end

	__wf_atom_e919fb8e.noise = true
	object:__wf_atom_1f5b5444(Vector(4, 1, 4), 0.1, Vector(2, 20, 20), 0.1, 0.1, 2.5)
	Sleep(2.61)
	__wf_atom_e919fb8e.noise = false
end

function NoiseOnShake(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.noise then
		return
	end

	__wf_atom_e919fb8e.noise = true
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v2)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:FirePort("PlayTriggeredAnim")
	end

	if not __wf_atom_7e8ad928(sproutfolkCageRattleSound) then
		object:PlaySound(sproutfolkCageRattleSound, false)
	end

	if not __wf_atom_7e8ad928(sproutfolkTrappedVocal) then
		object:PlaySound(sproutfolkTrappedVocal, false)
	end

	object:__wf_atom_25c58c94(true)
	object:__wf_atom_1f5b5444(Vector(2, 1, 2), 1, Vector(1, 10, 10), 1, 0.1, 1)
	Sleep(1.11)
	object:__wf_atom_25c58c94(false)
	__wf_atom_e919fb8e.noise = false
end

function NoiseOnShakeOnGround(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_e919fb8e.noise then
		return
	end

	__wf_atom_e919fb8e.noise = true
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(v2)

	if not __wf_atom_7e8ad928(__wf_atom_bb3e7833) then
		__wf_atom_bb3e7833:FirePort("PlayTriggeredAnim")
	end

	if not __wf_atom_7e8ad928(sproutfolkCageRattleSound) then
		object:PlaySound(sproutfolkCageRattleSound, false)
	end

	if not __wf_atom_7e8ad928(sproutfolkTrappedVocal) then
		object:PlaySound(sproutfolkTrappedVocal, false)
	end

	object:FirePort("EnableReplicaMoveNoise")
	object:__wf_atom_25c58c94(true)
	object:__wf_atom_1f5b5444(Vector(0.5, 20, 0.5), 2, Vector(0, 5, 5), 1, 0.1, 1)
	Sleep(1.11)
	object:FirePort("DisableReplicaMoveNoise")
	object:__wf_atom_25c58c94(false)
	__wf_atom_e919fb8e.noise = false
end

function CageDeflectUpdate(object)
	Sleep(0)
	module.Deflect(object)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if not __wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript) then
		__wf_atom_e919fb8e.runningHitUpdateScript = false
	end
end

function CageOnHit(object, _)
	local __wf_atom_e919fb8e = object:__wf_atom_e919fb8e()

	if __wf_atom_7e8ad928(__wf_atom_e919fb8e.farHitCount) then
		__wf_atom_e919fb8e.farHitCount = 1
	else
		__wf_atom_e919fb8e.farHitCount += 1
	end

	if
		__wf_atom_7e8ad928(__wf_atom_e919fb8e.runningHitUpdateScript)
		or __wf_atom_e919fb8e.runningHitUpdateScript == false
	then
		__wf_atom_e919fb8e.runningHitUpdateScript = true
		object:__wf_atom_8a035cd5(Symbol("CageDeflectUpdate"), false)
	end

	if __wf_atom_e919fb8e.farHitCount > 1 then
		_T.HideImpactMessage()
		local v14 = v11[cageKindIndex + 1]

		if v14 ~= "" then
			_T.ShowImpactMessage(v14, 5)
		end
	end

	if __wf_atom_7e8ad928(object) then
		return
	end

	object:__wf_atom_8a035cd5(Symbol("NoiseOnHit"), false)

	if gRegion:IsMaster() then
		if not __wf_atom_7e8ad928(cageHitSound) then
			object:PlaySound(cageHitSound, false)
		end

		if not __wf_atom_7e8ad928(object) then
			object:SetHealth((object:__wf_atom_95174740()))
		end
	end
end

local function fn7(object, p, p2, total, p3, p4)
	if __wf_atom_7e8ad928(object) or not (total < p3) then
		return total
	end

	local v14 = total / p3

	if p4 ~= v9.LINEAR then
		if p4 == v9.QUADRATIC then
			v14 = math.pow(v14, 2)
		elseif p4 == v9.SQUARE then
			v14 = math.sqrt(v14)
		elseif p4 == v9.SMOOTH then
			v14 = __wf_atom_24a82b69(v14)
		end
	end

	object:SetPosition((__wf_atom_f55d6358(p, p2, v14)))
	total += __wf_atom_084b3e93()
	return total
end

local function fn8(p, p2)
	v13:__wf_atom_bd5c14eb(p, 5, 0, 99)
	local __wf_atom_80368bb1_2

	if __wf_atom_7e8ad928(p2) then
		__wf_atom_80368bb1_2 = __wf_atom_80368bb1
	elseif __wf_atom_5784a397(0, 1) > 0.5 then
		__wf_atom_80368bb1_2 = __wf_atom_fa8d0177(p, p2)
	else
		__wf_atom_80368bb1_2 = __wf_atom_fa8d0177(p2, p)
	end

	return (gRegion:CreateEntity(poiTypes[__wf_atom_5784a397(1, #poiTypes)], p, __wf_atom_80368bb1_2))
end

local function fn9(instance, sproutfolkRescuedType)
	if __wf_atom_7e8ad928(instance) then
		return
	end

	instance:__wf_atom_e6ed03c8()
	local v14 = instance:GetPosition() + instance:__wf_atom_a06d543c()
	local __wf_atom_dc309f8a = instance:__wf_atom_dc309f8a()
	instance:Destroy()
	local entity = gRegion:CreateEntity(sproutfolkRescuedType, v14, __wf_atom_dc309f8a)
	local v15 = fn6(v14 + Vector(0, 5, 0), false)

	if math.abs(math.abs(v14.y) - math.abs(v15.y)) > 1 then
		v15 = v14
	end

	if __wf_atom_7e8ad928(v15) then
		v15 = v14
	end

	local smooth = v9.SMOOTH
	local v16 = 0

	while v16 < 1 do
		v16 = fn7(entity, v14, v15, v16, 1, smooth)
	end

	return entity
end

local function fn10(p)
	if cageKindIndex == v8.GRAPPLING then
		return (gRegion:CreateEntity(ceilingRollType, p - Vector(0, 0.5, 0), __wf_atom_80368bb1, v12))
	end

	return (gRegion:CreateEntity(anchorType, p, __wf_atom_80368bb1, v12))
end

local function fn11()
	local v14

	if cageKindIndex == v8.GRAPPLING then
		v14 = gRegion:FindAll(v4)
	else
		v14 = gRegion:FindAll(v3)
	end

	for _, v15 in pairs(v14) do
		if v15:GetCreator() == v12 then
			return v15
		end
	end

	return nil
end

local function fn12()
	local layerIndex = module.GetLayerIndex(v12)

	if module.IsInOverworld() or layerIndex == 1 then
		return true
	end

	local position = v12:GetPosition()
	local __wf_atom_dc309f8a = v12:__wf_atom_dc309f8a()
	gRegion:CreateEntity(statsStartedTriggerType, position, __wf_atom_dc309f8a, v12):__wf_atom_f947c7cc(v6)
	module.SortPortalsInZoneByAccessType(layerIndex)
	return true
end

function CageOnEnabled(object)
	v13 = gRegion:__wf_atom_2202ffb6()
	v12 = object
	local __wf_atom_f2317dfd = object:__wf_atom_f2317dfd()
	local v14 = __wf_atom_f2317dfd ~= v7.INITIALIZING

	if __wf_atom_7e8ad928(object) then
		return
	end

	local position = object:GetPosition()
	local v15 = fn6(position, true)
	local v16 = fn6(position, false)

	if __wf_atom_7e8ad928(v16) then
		return
	end

	local v17 = v16 + Vector(0, 2.1, 0)
	local v18 = nil
	local v19 = 0
	local v20 = {}
	local v21 = nil
	local v22 = nil

	if not __wf_atom_7e8ad928(v15) then
		local v23

		if v14 then
			v23 = fn11()
		else
			v23 = fn10(v15)
		end

		if not __wf_atom_7e8ad928(v23) then
			table.insert(v20, v23)
		end

		if cageKindIndex == v8.WEAKSPOT then
			v22 = false

			if v14 then
				v21 = fn4()
			else
				v21 = fn3(position, v15)
			end

			if not __wf_atom_7e8ad928(v21) then
				table.insert(v20, 1, v21)
			end
		elseif cageKindIndex == v8.CHAINED then
			v22 = true

			if #chainAnchors > 0 then
				v20 = module.MergeTables(v20, chainAnchors, false)
			end
		elseif cageKindIndex == v8.GRAPPLING then
			v22 = true
		end
	end

	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_0f45538d)
	local exclusiveTarget = nil
	local v23 = nil
	local v24 = {}
	local __wf_atom_bb3e7833_2 = object:__wf_atom_bb3e7833(v)
	local __wf_atom_bb3e7833_3 = object:__wf_atom_bb3e7833(v2)

	if cageKindIndex ~= v8.CHAINED then
		if cageKindIndex == v8.WEAKSPOT then
			v23 = object:__wf_atom_bb3e7833(__wf_atom_2a98954f)
		elseif cageKindIndex == v8.GRAPPLING then
			exclusiveTarget = object:__wf_atom_bb3e7833(__wf_atom_6a50bd07)

			if not __wf_atom_7e8ad928(ropeRoll) then
				local __wf_atom_e919fb8e = ropeRoll:__wf_atom_e919fb8e()
				__wf_atom_e919fb8e.exclusiveTarget = exclusiveTarget
			end
		end
	end

	local linear = v9.LINEAR
	local v25 = __wf_atom_5784a397(8, 15)
	local v26 = fn5(v22, v20, object, chainRoll)
	local v27 = true

	while not __wf_atom_7e8ad928(object) do
		local __wf_atom_f2317dfd2 = object:__wf_atom_f2317dfd()
		local v28 = not __wf_atom_7e8ad928(__wf_atom_f2317dfd) and __wf_atom_f2317dfd ~= __wf_atom_f2317dfd2

		if __wf_atom_f2317dfd2 == v7.INITIALIZING then
			object:SetVisibility(true)

			if cageKindIndex == v8.CHAINED then
				chainRoll:SetVisibility(true)
				chainRoll:FirePort("Enable")
				local position2 = chainRoll:GetPosition()
				local v29 = fn8(position2 - chainRoll:__wf_atom_a06d543c() * 2, position2)

				if not __wf_atom_7e8ad928(v29) then
					table.insert(v24, v29)
				end
			elseif cageKindIndex == v8.WEAKSPOT then
				if not __wf_atom_7e8ad928(v23) then
					v23:Enable()
				end

				local v29 = fn8(v17 - Vector(0, 2.1, 0))

				if not __wf_atom_7e8ad928(v29) then
					table.insert(v24, v29)
				end
			elseif cageKindIndex == v8.GRAPPLING then
				if not __wf_atom_7e8ad928(exclusiveTarget) then
					exclusiveTarget:Enable()
				end

				if not __wf_atom_7e8ad928(ropeRoll) then
					ropeRoll:FirePort("Show")
					ropeRoll:FirePort("Enable")
				end
			end

			object:__wf_atom_e792b90b(true)
			v27 = fn12()
			object:__wf_atom_0e990c03(v7.HANGING)
		elseif __wf_atom_f2317dfd2 == v7.HANGING then
			if cageKindIndex == v8.CHAINED then
				if __wf_atom_7e8ad928(chainRoll) then
					break
				end

				if chainRoll:__wf_atom_b81a6e66() then
					object:__wf_atom_0e990c03(v7.MOVING)
				end
			elseif cageKindIndex == v8.WEAKSPOT then
				if __wf_atom_7e8ad928(v21) then
					object:__wf_atom_0e990c03(v7.MOVING)
				elseif v21:__wf_atom_c6f1f83d() < v21:__wf_atom_95174740() then
					object:__wf_atom_0e990c03(v7.MOVING)
				end
			elseif
				cageKindIndex == v8.GRAPPLING
				and not __wf_atom_7e8ad928(exclusiveTarget)
				and not __wf_atom_7e8ad928(ropeRoll)
				and (exclusiveTarget:__wf_atom_b81a6e66() or ropeRoll:__wf_atom_b81a6e66())
			then
				_T.HideImpactMessage()
				object:__wf_atom_0e990c03(v7.MOVING)
			end

			if v25 < v19 then
				object:__wf_atom_8a035cd5(Symbol("NoiseOnShake"), false)
				v25 = __wf_atom_5784a397(8, 15)
				v19 = 0
			else
				v19 += __wf_atom_084b3e93()
			end
		elseif __wf_atom_f2317dfd2 == v7.MOVING then
			if v28 then
				v19 = 0
				v18 = Distance(position, v17) / 5

				if cageKindIndex == v8.CHAINED then
					linear = v9.SMOOTH
					v26 = fn2(v26, true)
				elseif cageKindIndex == v8.WEAKSPOT then
					linear = v9.QUADRATIC
					local __wf_atom_bb3e7833_4 = object:__wf_atom_bb3e7833(__wf_atom_7879bfc7)

					if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_4) then
						__wf_atom_bb3e7833_4:Destroy()
					end
				elseif cageKindIndex == v8.GRAPPLING then
					linear = v9.SMOOTH
					v17 = ropeRoll:GetPosition() - Vector(0, 0.5, 0)
					v18 *= 2.5
					module2.EnableSequencerAttachments(v20[1], true, Symbol("chainWinchCeilingPullSequencer"))
				end

				if not __wf_atom_7e8ad928(sproutfolkFallingVocal) then
					object:PlaySound(sproutfolkFallingVocal, false)
				end

				if not __wf_atom_7e8ad928(cageDropStartSound) then
					object:PlaySound(cageDropStartSound, false)
				end
			end

			if v19 < v18 then
				v19 = fn7(object, position, v17, v19, v18, linear)
			else
				object:__wf_atom_0e990c03(v7.LOCKED)
			end
		elseif __wf_atom_f2317dfd2 == v7.LOCKED then
			if v28 then
				v19 = 0
				__wf_atom_bb3e7833:Enable()

				if cageKindIndex == v8.CHAINED then
					chainRoll:Deactivate()
					v26 = fn2(v26, false)
				elseif cageKindIndex == v8.GRAPPLING then
					ropeRoll:Deactivate()
					ropeRoll:Disable()
					exclusiveTarget:Deactivate()
					module2.EnableSequencerAttachments(v20[1], false, Symbol("chainWinchCeilingPullSequencer"))
					object:__wf_atom_bb3e7833(__wf_atom_7879bfc7)
				elseif cageKindIndex == v8.WEAKSPOT then
					if not __wf_atom_7e8ad928(v23) then
						v23:Disable()
					end

					if not __wf_atom_7e8ad928(sproutfolkTossedVocal) then
						object:PlaySound(sproutfolkTossedVocal, false)
					end

					if not __wf_atom_7e8ad928(cageGroundHitSound) then
						object:PlaySound(cageGroundHitSound, false)
					end
				end

				object:__wf_atom_e792b90b(false)
				object:MakeInvulnerable()

				if not __wf_atom_7e8ad928(landedDustEffectType) then
					gRegion:CreateEntity(landedDustEffectType, v17 - Vector(0, 1.5, 0), __wf_atom_80368bb1)
				end

				if not __wf_atom_7e8ad928(cageDroppedSwellSound) then
					object:PlaySound(cageDroppedSwellSound, false)
				end
			end

			if v25 < v19 then
				object:__wf_atom_8a035cd5(Symbol("NoiseOnShakeOnGround"), false)
				v25 = __wf_atom_5784a397(8, 15)
				v19 = 0
			else
				v19 += __wf_atom_084b3e93()
			end

			if object:IsEnabled() and object:__wf_atom_b81a6e66() then
				object:__wf_atom_0e990c03(v7.UNLOCKED)
			end
		elseif __wf_atom_f2317dfd2 == v7.UNLOCKED then
			local v29 = Rotation(135, 0, 0)
			__wf_atom_bb3e7833_2:__wf_atom_e310f01f(
				__wf_atom_bb3e7833_2:__wf_atom_fa6a8faf(),
				__wf_atom_bb3e7833_2:__wf_atom_45c0553e() - v29
			)

			if not __wf_atom_7e8ad928(__wf_atom_bb3e7833_3) then
				fn9(__wf_atom_bb3e7833_3, sproutfolkRescuedType)
			end

			object:Deactivate()
			object:Disable()

			if not __wf_atom_7e8ad928(exclusiveTarget) then
				exclusiveTarget:Disable()
			end

			if not __wf_atom_7e8ad928(cageDoorOpenedSound) then
				object:PlaySound(cageDoorOpenedSound, false)
			end

			if not __wf_atom_7e8ad928(sproutfolkRescuedVocal) then
				object:PlaySound(sproutfolkRescuedVocal, false)
			end

			if not __wf_atom_7e8ad928(cageUnlockedSwellSound) then
				object:PlaySound(cageUnlockedSwellSound, false)
			end

			if v27 then
				module3.LogProcPuzzleSolved(object, "HangingCage")
			end

			break
		end

		Sleep(0)
		__wf_atom_f2317dfd = __wf_atom_f2317dfd2
	end
end

function ActionOnTouched(object, object2)
	local __wf_atom_3d96ddcd = object:__wf_atom_3d96ddcd()

	if not __wf_atom_7e8ad928(playerTouchAnim) then
		object2:__wf_atom_921c1a5f(playerTouchAnim, true, 3, 1, true)
		Sleep(0.01)
	end

	__wf_atom_3d96ddcd:Activate()
	object:Disable()
end

function ChainRollOnEnabled(object)
	object:__wf_atom_bb3e7833(__wf_atom_0f45538d):Enable()
	local v14 = false

	while not __wf_atom_7e8ad928(object) and object:IsEnabled() do
		local __wf_atom_b81a6e66 = object:__wf_atom_b81a6e66()

		if v14 ~= __wf_atom_b81a6e66 then
			if __wf_atom_b81a6e66 then
				module2.EnableSequencerAttachments(object, true, Symbol("chainWinchPullSequencer"))
				object:__wf_atom_ff224fc2(true)
			else
				module2.EnableSequencerAttachments(object, false, Symbol("chainWinchPullSequencer"))
				object:__wf_atom_ff224fc2(false)
				object:Disable()
			end

			v14 = __wf_atom_b81a6e66
		end

		Sleep(0)
	end
end

function ChainRollStandaloneOnEnabled(object)
	local __wf_atom_bb3e7833 = object:__wf_atom_bb3e7833(__wf_atom_0f45538d)
	__wf_atom_bb3e7833:Enable()
	local v14 = fn5(true, chainAnchors, hangingMover, object)
	local v15 = false

	while not __wf_atom_7e8ad928(object) do
		if not object:IsEnabled() then
			__wf_atom_bb3e7833:Disable()
			break
		end

		local __wf_atom_b81a6e66 = object:__wf_atom_b81a6e66()

		if v15 ~= __wf_atom_b81a6e66 then
			if __wf_atom_b81a6e66 then
				module2.EnableSequencerAttachments(object, true, Symbol("chainWinchPullSequencer"))
				object:__wf_atom_ff224fc2(true)
				hangingMover:FirePort("Start")
				v14 = fn2(v14, true)
			else
				module2.EnableSequencerAttachments(object, false, Symbol("chainWinchPullSequencer"))
				object:__wf_atom_ff224fc2(false)
				__wf_atom_bb3e7833:Enable()
				v14 = fn2(v14, false)
			end

			v15 = __wf_atom_b81a6e66
		end

		Sleep(0)
	end
end

function DebugSpawnCages()
	print("Alert! Debug puzzle trigger has been accidentally submitted. It can cause troubles if not removed from the level.")
	local __wf_atom_2226b35c = gRegion:__wf_atom_2226b35c(v10)

	for _, v14 in pairs(__wf_atom_2226b35c) do
		v14:Enable()
	end
end