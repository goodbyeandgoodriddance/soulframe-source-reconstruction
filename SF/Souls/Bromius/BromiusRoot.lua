local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local baseAmount = 15
local v = 4

local function fn(p, object)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		v = 4
		baseAmount = 10
	elseif p == 2 then
		v = 5
		baseAmount = 12
	elseif p == 3 then
		v = 5
		baseAmount = 13
	else
		v = 6
		baseAmount = 15
	end

	v *= magikForceCalc
	baseAmount *= magikForceCalc
end

function EvaluateAbility(_, object)
	return not object:__wf_atom_59cb39a4()
end

function NpcEvaluateAbility(_, _)
	return 0
end

function ActivateAbility(object, object2, _, p)
	fn(p, object2)
	local motionControl = object2:MotionControl()
	motionControl:__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
	motionControl:__wf_atom_3959d938(true)
	module.Fear(object2, 10)
	module.AddCastImmunity(object2)
	Sleep(0)
	object2:PlaySound(CastSound, false)
	object2:Attach(castFxType, EMPTY_SYMBOL)

	if __wf_atom_7e8ad928(pactFxType) then
		pactFxType = object:__wf_atom_8e96c598(4)
	end

	local v2

	if not __wf_atom_7e8ad928(pactFxType) then
		v2 = object2:Attach(pactFxType, EMPTY_SYMBOL)
	end

	if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
		return
	end

	if not __wf_atom_7e8ad928(v2) then
		v2:Destroy()
	end

	object2:PlaySound(rootImpactSound, false, 1, false)
	object:__wf_atom_6a4cf64f()
	module.RemoveCastImmunity(object2)
	motionControl:__wf_atom_3959d938(false)
	local __wf_atom_a06d543c = object2:__wf_atom_a06d543c()
	local v3 = object2:GetPosition() + __wf_atom_a06d543c * 2
	local v4 = __wf_atom_fa8d0177(__wf_atom_28d5d4aa, __wf_atom_a06d543c)
	local v5 = Symbol("SpawnSpike")
	local v6 = Vector()
	local v7 = Vector()
	local v8 = Vector()
	local v9 = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
	local v10 = Vector(0, 1.25, 0)
	local v11 = Vector(0, 4, 0)
	local v12 = 0.25

	for i = 1, 5 do
		VectorAdd(v6, v3, v10)
		__wf_atom_c37ab6c1(v7, v6, v11)

		if gRegion:__wf_atom_c20d246a(v6, v7, v9, nil, v8) then
			local entity = gRegion:CreateEntity(
				spikeFx,
				v8,
				v4 + Rotation(0, 10, math.random(-15, 15)),
				object2,
				object2
			)

			if not __wf_atom_7e8ad928(entity) then
				entity:__wf_atom_8a035cd5(v5, false)
			end

			v3 = v8
		elseif i > 2 then
			break
		end

		v3 += __wf_atom_a06d543c * 3
		Sleep(v12)
		v12 *= 0.65
	end
end

function DeactivateAbility(_, object, _, _)
	while not __wf_atom_7e8ad928(object) and object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end

	if not __wf_atom_7e8ad928(object) then
		object:MotionControl():__wf_atom_3959d938(false)
	end
end

function SpawnSpike(object)
	local creator = object:GetCreator()
	local __wf_atom_c78fa517 = mOwner:__wf_atom_c78fa517()
	local bromiusRootHits = {}
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.radius = 2
	radialDamageData.baseAmount = 10
	radialDamageData.stabilityDamage = 10
	radialDamageData.checkForCover = false
	radialDamageData.blockableProjType = 4
	radialDamageData:__wf_atom_7498285f(0, 1)
	radialDamageData:__wf_atom_d6f4d914(31, true)
	radialDamageData:__wf_atom_d6f4d914(20, true)
	radialDamageData:__wf_atom_98d98d81(object:GetPosition())
	radialDamageData.fallOff = 0
	radialDamageData:__wf_atom_6b472125(creator)
	radialDamageData:__wf_atom_34a8a27a(__wf_atom_c78fa517)
	radialDamageData:__wf_atom_a8149853(Symbol("SpikeHit"))
	local damageData = Engine.DamageData()
	damageData.baseAmount = baseAmount
	damageData:__wf_atom_7498285f(0, 1)
	damageData:__wf_atom_6b472125(creator)
	damageData:__wf_atom_34a8a27a(__wf_atom_c78fa517)
	Sleep(0.2)
	_T.bromiusRootHits = bromiusRootHits
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	_T.bromiusRootHits = nil
	local v2 = Vector(0, 2, 0.75)
	local _ = object:GetPosition() + __wf_atom_9341614d(v2, object:__wf_atom_dc309f8a())

	for i = #bromiusRootHits, 1, -1 do
		local v3 = bromiusRootHits[i]
		local __wf_atom_f51f1faa = v3:__wf_atom_f51f1faa()

		if
			__wf_atom_7e8ad928(__wf_atom_f51f1faa)
			or __wf_atom_f51f1faa:__wf_atom_d4dc8568()
			or v3:__wf_atom_464a4772()
		then
			table.remove(bromiusRootHits, i)
		else
			local __wf_atom_fec6bb4d = __wf_atom_f51f1faa:__wf_atom_fec6bb4d(1)
			v3:AttachRagdoll(__wf_atom_fec6bb4d, object, EMPTY_SYMBOL, true)
			v3:PlaySound(impaleSound, false, 1, true)
			__wf_atom_fec6bb4d:__wf_atom_e310f01f(v2, __wf_atom_80368bb1)
			v3:__wf_atom_5047e0ed(false)
			__wf_atom_f51f1faa:__wf_atom_41296388(true)
			__wf_atom_f51f1faa:__wf_atom_0bd69c3e(false, 7, false)
			v3:__wf_atom_7470861b():DOT(damageData, v)
		end
	end

	if #bromiusRootHits == 0 then
		Sleep(0.3)
	else
		Sleep(v)
	end

	for _, v3 in ipairs(bromiusRootHits) do
		if __wf_atom_7e8ad928(v3) then
			continue
		end

		local __wf_atom_f51f1faa = v3:__wf_atom_f51f1faa()

		if __wf_atom_7e8ad928(__wf_atom_f51f1faa) or not __wf_atom_f51f1faa:__wf_atom_d4dc8568() then
			continue
		end

		v3:PlaySound(impaleDissolveSound, false, 1, true)
		v3:__wf_atom_8391ca00(__wf_atom_f51f1faa:__wf_atom_382d2379())
		v3:__wf_atom_5047e0ed(true)
		__wf_atom_f51f1faa:__wf_atom_41296388(false)
		__wf_atom_f51f1faa:__wf_atom_0bd69c3e(true, 7, false)
	end

	if not __wf_atom_7e8ad928(spikeExplodeFx) then
		gRegion:CreateEntity(spikeExplodeFx, object:GetPosition(), __wf_atom_80368bb1, creator, creator)
	end

	object:PlayTriggeredFade()
end

function SpikeHit(_, instance)
	if not __wf_atom_7e8ad928(instance) and instance:IsA(__wf_atom_4ebf67cb) and not instance:IsKilled() then
		table.insert(_T.bromiusRootHits, instance)
	end
end