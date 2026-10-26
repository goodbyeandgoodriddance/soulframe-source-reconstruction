local v = 0
local v2 = 3
local module = require("Lotus.Scripts.Libs.AudioLib")
local v3 = Vector(0, 0, 1)
local v4 = {
	__wf_atom_4ebf67cb,
	__wf_atom_3feeb44a,
	__wf_atom_43e0c427,
	__wf_atom_7b01f9ce,
	__wf_atom_d0a48db7,
	WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
	WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
}

local function fn(instance)
	local v5 = math.random(-180, 180)
	local v6 = __wf_atom_9341614d(v3, Rotation(v5, 0, 0))
	local minSpawnDist2 = minSpawnDist
	local maxSpawnDist2 = maxSpawnDist

	if
		instance:IsA(__wf_atom_4ebf67cb)
		and instance:__wf_atom_8efce136()
		and math.abs(instance:__wf_atom_4e50d390().heading - v5) < 130
	then
		minSpawnDist2 = math.max(minSpawnDist, 1)
		maxSpawnDist2 = minSpawnDist2 + (maxSpawnDist - minSpawnDist)
	end

	return instance:GetPosition() + v6 * math.random(minSpawnDist2, maxSpawnDist2)
end

function TowerAttack(object)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()

	while _T.PolluterTowerAlerted do
		Sleep(Random(v, v2))
		local __wf_atom_ef7900cf = gRegion:__wf_atom_ef7900cf()
		local v5 = {}
		local v6 = nil

		for _, v7 in ipairs(__wf_atom_ef7900cf) do
			if v7:IsA(__wf_atom_9d7477c0) then
				continue
			end

			local __wf_atom_d5fda8be = v7:__wf_atom_d5fda8be(__wf_atom_a2a18137)

			if __wf_atom_d5fda8be >= 15 and __wf_atom_d5fda8be <= 100 then
				table.insert(v5, v7)
			end
		end

		if #v5 > 0 then
			v6 = v5[__wf_atom_5784a397(1, #v5)]
		end

		if
			not __wf_atom_7e8ad928(v6)
			and __wf_atom_7e8ad928((gRegion:__wf_atom_f738b4af(Symbol("OdeShredder"), v6:__wf_atom_a2a18137(), 0, 25)))
		then
			local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(
				Symbol("OdeOrganBowser"),
				v6:__wf_atom_a2a18137(),
				0,
				15
			)
			local flag

			if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
				flag = false
			else
				v6 = __wf_atom_f738b4af
				flag = true
			end

			local __wf_atom_c3b255b8 = gRegion:__wf_atom_c3b255b8()

			if not __wf_atom_7e8ad928(targetFxType) and __wf_atom_7e8ad928(__wf_atom_c3b255b8) then
				local v7 = fn(v6)
				local __wf_atom_a2a18137_2 = gRegion:FindNearestTagged(Symbol("OdeTowerElectricRod"), v7):__wf_atom_a2a18137()
				local v8 = Vector()

				if gRegion:__wf_atom_c20d246a(__wf_atom_a2a18137_2, v7, v4, nil, v8) then
					v7 = v8
				end

				local __wf_atom_2f2bada0 = v6:__wf_atom_2f2bada0()
				gRegion:CreateEntity(targetFxType, v7, __wf_atom_2f2bada0, v6, nil, 1):__wf_atom_8a035cd5(
					Symbol("towerExplosion"),
					false
				)

				if flag then
					v6:__wf_atom_8a035cd5(Symbol("barrelExplosion"), false)
				end
			end
		end

		Sleep(0)
		v = 5
		v2 = 15
	end
end

function towerExplosion(object)
	local __wf_atom_a2a18137 = object:__wf_atom_a2a18137()
	local nearestTagged = gRegion:FindNearestTagged(Symbol("OdeTowerElectricRod"), __wf_atom_a2a18137)

	if not __wf_atom_7e8ad928(nearestTagged) then
		gRegion:CreateEntity(
			TeslaChargeFxType,
			nearestTagged:__wf_atom_a2a18137(),
			nearestTagged:__wf_atom_2f2bada0(),
			object,
			nil,
			1
		)
		local entity = gRegion:CreateEntity(
			TeslaChargeBeamFxType,
			nearestTagged:__wf_atom_a2a18137(),
			nearestTagged:__wf_atom_2f2bada0(),
			nil,
			nil,
			1
		)

		if not __wf_atom_7e8ad928(entity) then
			entity:__wf_atom_a64eca67(__wf_atom_a2a18137)
		end
	end

	gRegion:__wf_atom_c4f78a8f()
	local v5 = 4
	local v6 = 1

	while v5 > 0 do
		v5 -= __wf_atom_084b3e93()
		v6 -= __wf_atom_084b3e93()

		if v6 < 0 then
			local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
			module.EnableNearestTaggedSequencer(Symbol("SFXOrganChargeNotes"), true, __wf_atom_c4f78a8f:GetPosition())
			v6 = 1
		end

		Sleep(0)
	end

	local __wf_atom_c4f78a8f = gRegion:__wf_atom_c4f78a8f()
	module.EnableNearestTaggedSequencer(Symbol("SFXOrganShot"), true, __wf_atom_c4f78a8f:GetPosition())
	local __wf_atom_f738b4af = gRegion:__wf_atom_f738b4af(Symbol("OdeOrganBoss"), object:__wf_atom_a2a18137(), 0, 10)
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.checkForCover = true
	radialDamageData.hostAuthoritative = true
	radialDamageData.radius = 8
	radialDamageData.baseAmount = 80
	radialDamageData.stabilityDamage = 80
	radialDamageData:__wf_atom_7498285f(5, 0.5)
	radialDamageData:__wf_atom_7498285f(0, 0.5)
	radialDamageData:__wf_atom_d6f4d914(31, true)
	radialDamageData:__wf_atom_98d98d81(object:__wf_atom_d0069154())

	if __wf_atom_7e8ad928(__wf_atom_f738b4af) then
		radialDamageData:__wf_atom_6b472125(object)
	else
		radialDamageData:__wf_atom_6b472125(__wf_atom_f738b4af)
	end

	gRegion:__wf_atom_f6ec80de(radialDamageData)
	local __wf_atom_80368bb1_2 = __wf_atom_80368bb1

	if not (__wf_atom_7e8ad928(nearestTagged) or __wf_atom_7e8ad928(object)) then
		__wf_atom_a2a18137 = object:__wf_atom_d0069154()
		__wf_atom_80368bb1_2 = __wf_atom_fa8d0177(nearestTagged:__wf_atom_a2a18137(), __wf_atom_a2a18137)
	end

	gRegion:CreateEntity(burstFxType, __wf_atom_a2a18137, __wf_atom_80368bb1_2, nil, nil, 1)

	if not __wf_atom_7e8ad928(nearestTagged) then
		gRegion:CreateEntity(
			TeslaFireFxType,
			nearestTagged:__wf_atom_a2a18137(),
			nearestTagged:__wf_atom_2f2bada0(),
			object,
			nil,
			1
		)
	end

	object:PlaySound(burstSound, false, 1, true, nil, 1)
	object:Attach(deathFXSpawner, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, object, 1)
end

function barrelExplosion(object)
	if not __wf_atom_7e8ad928(object) then
		object:FirePort("Destroy")
	end
end