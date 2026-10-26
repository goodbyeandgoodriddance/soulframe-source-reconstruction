local module = require("Lotus.Scripts.Libs.AbilitiesLib")
require("SF.Scripts.Effects.IdolEffects")
local v = 10
local stabilityDamage = 150
local v2 = Range(0.5, 2)
Symbol("LastEnergyBladeAbility")

local function fn(p, object)
	local magikForceCalc = module.magikForceCalc(object, p, mOwner)
	module.magikEnergyCalc(object, p, mOwner)

	if p == 1 then
		stabilityDamage = 150
		v = 6
	elseif p == 2 then
		stabilityDamage = 200
		v = 8
	elseif p == 3 then
		stabilityDamage = 250
		v = 10
	else
		stabilityDamage = 300
		v = 12
	end

	stabilityDamage *= magikForceCalc
	v *= magikForceCalc
end

local function fn2(instance) -- 1 equivalent call inferred from this helper
	for _, className in ipairs(invalidAvatarTypes) do
		if instance:IsA(className) then
			return false
		end
	end

	return true
end

function ActivateAbility(object, object2, _, p)
	fn(p, object2)
	local __wf_atom_4e50d390 = object2:__wf_atom_4e50d390()

	if object2:__wf_atom_535d5cbb() then
		module.AddCastImmunity(object2)
		module.Fear(object2, 10)
		object2:MotionControl():__wf_atom_3a1d0c16(object2:__wf_atom_4e50d390())
		Sleep(0)

		if __wf_atom_7e8ad928(pactFxType) then
			pactFxType = object:__wf_atom_8e96c598(4)
		end

		local v3

		if not __wf_atom_7e8ad928(pactFxType) then
			v3 = object2:Attach(pactFxType, EMPTY_SYMBOL)
		end

		if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "Cast", false, 4, 1, true, 1) then
			return
		end

		module.RemoveCastImmunity(object2)

		if not __wf_atom_7e8ad928(v3) then
			v3:Destroy()
		end
	else
		local v3 = object2:__wf_atom_9b5dcd3b(activateAnim, false, 2, 1, true, -1) * activateAnim:__wf_atom_091354f5(Symbol("Cast"))
		object2:MotionControl():__wf_atom_3959d938(true)
		local __wf_atom_30e3d82b = object2:__wf_atom_30e3d82b()
		local ___wf_atom_28d5d4aa = __wf_atom_28d5d4aa
		local v4 = Symbol("GAME_C1_SPINE1")

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
		end

		local flag = false

		while v3 > 0 do
			if object2:__wf_atom_c138b19b(activateAnim) then
				flag = true
			elseif flag then
				return
			end

			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) and __wf_atom_30e3d82b:__wf_atom_929bb30b() then
				local __wf_atom_216d6edd = __wf_atom_30e3d82b:__wf_atom_216d6edd()

				if not __wf_atom_7e8ad928(__wf_atom_216d6edd) then
					local __wf_atom_1c374cc9 = __wf_atom_216d6edd:__wf_atom_1c374cc9(v4)
					__wf_atom_4e50d390 = __wf_atom_fa8d0177(object2:GetPosition(), __wf_atom_1c374cc9)
					object2:__wf_atom_51075230(__wf_atom_4e50d390)
					object2:__wf_atom_84d66e8e(__wf_atom_4e50d390)
				end
			end

			Sleep(0)
			v3 -= __wf_atom_084b3e93()
		end
	end

	object2:Attach(castFxType, EMPTY_SYMBOL)
	local __wf_atom_a06d543c = object2:__wf_atom_a06d543c()
	local v3 = __wf_atom_edfe0d73(__wf_atom_a06d543c, Vector(0, 1, 0))
	local v4 = object2:__wf_atom_a2a18137() - v3 * 0.35
	local v5 = v / 25
	local v6 = { __wf_atom_4ebf67cb, __wf_atom_3feeb44a, __wf_atom_43e0c427, __wf_atom_7b01f9ce }
	local v7 = {}
	local entity = gRegion:CreateEntity(orbDecoType, v4, __wf_atom_4e50d390, object)

	if not __wf_atom_7e8ad928(entity) then
		entity:__wf_atom_6cf07262(v5)
	end

	local __wf_atom_4417a5d4 = object2:__wf_atom_4417a5d4()
	local damageData = Engine.DamageData()
	damageData:__wf_atom_6b472125(object2)
	damageData:__wf_atom_7498285f(15, 1)
	damageData:__wf_atom_34a8a27a(object)
	local v8 = v5
	local v9 = 1
	local v10 = 0.1
	local v11 = true

	while v5 > 0 do
		v4 += __wf_atom_a06d543c * (v9 * 25 * __wf_atom_084b3e93())
		local v12 = Vector(v4.x, v4.y + 2, v4.z)
		local v13 = Vector(v4.x, v4.y - 8, v4.z)

		if not __wf_atom_7e8ad928(entity) then
			entity:SetPosition(v4 + Vector(0, 0.3, 0))
		end

		gRegion:__wf_atom_c20d246a(v12, v13, v6, nil, v4)
		local all = gRegion:FindAll(__wf_atom_4ebf67cb, v4, 0, 3)

		if pushAvatars then
			damageData.baseAmount = 50 / #all * (v8 - v5 + 1)

			for _, v14 in ipairs(all) do
				if v14:__wf_atom_129d1aba(object2) then
					continue
				end

				if v14:__wf_atom_4417a5d4() then
					v9 = v14:__wf_atom_464a4772() and 0.35 or v9

					if fn2(v14) then -- inferred equivalent call
						damageData:__wf_atom_12cf5317(__wf_atom_a06d543c)
						v14:MotionControl():__wf_atom_4bb21efc(__wf_atom_a06d543c * (v9 * 25))
					else
						v5 = 0
					end

					if v10 <= 0 then
						v14:__wf_atom_649bf33e(damageData)

						if v14:__wf_atom_464a4772() then
							v10 = 0.2
						else
							v10 = 0.1
						end
					end
				end

				if not v7[v14:__wf_atom_18aa6e58()] then
					v7[v14:__wf_atom_18aa6e58()] = v14
				end
			end
		end

		if v11 and not object2:__wf_atom_c138b19b(activateAnim) then
			object:__wf_atom_6a4cf64f()
			v11 = false
		end

		Sleep(0)
		v5 -= __wf_atom_084b3e93()
		v10 -= __wf_atom_084b3e93()
	end

	if not __wf_atom_7e8ad928(entity) then
		entity:Destroy()
	end

	local entity2 = gRegion:CreateEntity(explosionDecoType, v4, __wf_atom_80368bb1, object2)

	if not __wf_atom_7e8ad928(entity2) then
		entity2:SetMeshScale(4)
	end

	gRegion:CreateEntity(explosionFxType, v4, __wf_atom_80368bb1, object)
	damageData.baseAmount = 50
	damageData:__wf_atom_7498285f(0, 1)

	for _, v12 in pairs(v7) do
		if __wf_atom_7e8ad928(v12) or v12:IsKilled() or v12:__wf_atom_129d1aba(object2) then
			continue
		end

		if v12:__wf_atom_4417a5d4() then
			v12:MotionControl():__wf_atom_4bb21efc(__wf_atom_28d5d4aa)
		end

		if not __wf_atom_4417a5d4 then
			continue
		end

		local v13 = v12:GetPosition() - v4
		Normalize(v13)
		local v14 = math.deg((math.acos((Dot(__wf_atom_a06d543c, v13)))))

		if not (v12:__wf_atom_464a4772() or v14 <= 80) then
			continue
		end

		damageData:__wf_atom_8e0ba0ec(v2:__wf_atom_ff1686f2())
		v12:__wf_atom_649bf33e(damageData)
	end

	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = 50
	radialDamageData.stabilityDamage = stabilityDamage
	radialDamageData:__wf_atom_7498285f(0, 1)
	radialDamageData.radius = 8
	radialDamageData:__wf_atom_12cf5317(20)
	radialDamageData:__wf_atom_98d98d81(v4)
	radialDamageData:__wf_atom_6b472125(object2)
	radialDamageData:__wf_atom_34a8a27a(object)
	radialDamageData:__wf_atom_1e7d87e6(__wf_atom_4ebf67cb)
	radialDamageData:__wf_atom_1e7d87e6(__wf_atom_7b01f9ce)
	gRegion:__wf_atom_f6ec80de(radialDamageData)
	local radialDamageData2 = Engine.RadialDamageData()
	radialDamageData2.baseAmount = 0
	radialDamageData2.stabilityDamage = stabilityDamage
	radialDamageData2:__wf_atom_7498285f(0, 1)
	radialDamageData2.radius = 8
	radialDamageData2:__wf_atom_12cf5317(20)
	radialDamageData2:__wf_atom_98d98d81(v4)
	radialDamageData2:__wf_atom_6b472125(object2)
	radialDamageData2:__wf_atom_34a8a27a(object)
	gRegion:__wf_atom_f6ec80de(radialDamageData2)
end

function DeactivateAbility(p, object, _, _)
	repeat
		Sleep(0)
	until __wf_atom_7e8ad928(object) or not object:__wf_atom_c138b19b(activateAnim)

	local abilityStats = module.GetAbilityStats(p, mOwner, true)

	if not __wf_atom_7e8ad928(abilityStats) then
		abilityStats:Destroy()
	end

	if not __wf_atom_7e8ad928(object) and object:__wf_atom_7b82e9e1(0) then
		object:__wf_atom_9b5dcd3b(orbTossAnim, false, 2, 1, true)
	end
end