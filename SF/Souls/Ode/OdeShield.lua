local module = require("Lotus.Scripts.Libs.AbilitiesLib")
local module2 = require("SF.Scripts.Effects.IdolEffects")
local v = 5
local v2 = 45
local v3 = Symbol("BlockingBehavior")

local function fn(p, instance)
	local magikForceCalc = module.magikForceCalc(instance, p, mOwner)
	module.magikEnergyCalc(instance, p, mOwner)

	if p == 1 then
		v = 2
		v2 = 25
	elseif p == 2 then
		v = 3
		v2 = 25
	else
		if p == 3 then
			v = 5
		else
			v = 7
		end

		v2 = 30
	end

	v = math.round(v * magikForceCalc)
	v2 *= magikForceCalc
end

function NpcEvaluateAbility(_, object)
	local __wf_atom_9a1e4ed3 = object:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()
	local __wf_atom_d2b2176d = object:__wf_atom_d2b2176d()

	if
		not __wf_atom_9a1e4ed3.visible
		or __wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
	then
		return 0
	end

	local __wf_atom_be152500 = __wf_atom_d2b2176d:__wf_atom_be152500(0)

	if
		__wf_atom_7e8ad928(__wf_atom_be152500)
		or __wf_atom_d2b2176d:__wf_atom_9f71ab59()
		or __wf_atom_be152500:GetState() ~= 0
	then
		return 0
	end

	return 1
end

function ActivateAbility(object, instance, _, p)
	fn(p, instance)

	if instance:__wf_atom_535d5cbb() then
		module.AddCastImmunity(instance)
		module.Fear(instance, 10)
		module.EnableWeaponFiring(instance, mOwner, false)

		if __wf_atom_7e8ad928(pactFxType) then
			pactFxType = object:__wf_atom_8e96c598(4)
		end

		local v4

		if not __wf_atom_7e8ad928(pactFxType) then
			v4 = instance:Attach(pactFxType, EMPTY_SYMBOL)
		end

		if not module.PlayAnimAndSuspendUntilEvent(object, activateAnim, "ActivateAbility", false, 4, 1, true, 1) then
			return
		end

		if not __wf_atom_7e8ad928(v4) then
			v4:Destroy()
		end

		module.RemoveCastImmunity(instance)
	else
		local __wf_atom_30e3d82b = instance:__wf_atom_30e3d82b()

		if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
			__wf_atom_30e3d82b:__wf_atom_aa4361c1(v3, instance, 1)
			__wf_atom_30e3d82b:__wf_atom_b414eabf()
		end

		if module.PlayAnimAndSuspendUntilEvent(object, activateAnim, castEvent, false, 4, 1, false) then
			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_42b767a2(v3)
			end
		else
			if not __wf_atom_7e8ad928(__wf_atom_30e3d82b) then
				__wf_atom_30e3d82b:__wf_atom_42b767a2(v3)
			end

			return
		end
	end

	local v4 = (instance:__wf_atom_535d5cbb() or not (npcRangeOverride >= 0)) and 30 or npcRangeOverride
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	local v5 = Symbol("DoShield")

	if v4 > 0 then
		local all = gRegion:FindAll(__wf_atom_7e6ed5fa, instance:GetPosition(), 0, v4)

		for _, v6 in ipairs(all) do
			if not v6:__wf_atom_129d1aba(instance) or v6:HasTag(__wf_atom_37768748) then
				continue
			end

			v6:__wf_atom_8a035cd5(v5, false)
		end
	elseif not instance:HasTag(__wf_atom_37768748) then
		instance:__wf_atom_8a035cd5(v5, false)
	end

	Sleep(0.65)
	module2.OdeIdolDestroy(instance, odeIdolOrbType, false)
end

function DeactivateAbility(_, object, _, _)
	repeat
		Sleep(0)
	until __wf_atom_7e8ad928(object) or not object:__wf_atom_c138b19b(activateAnim)

	if not __wf_atom_7e8ad928(object) then
		if object:__wf_atom_535d5cbb() then
			module.EnableWeaponFiring(object, mOwner, true)
		end

		if object:__wf_atom_7b82e9e1(0) then
			object:__wf_atom_9b5dcd3b(orbTossAnim, false, 2, 1, true)
		end
	end
end

function DoShield(instance)
	local __wf_atom_37768748 = mOwner:__wf_atom_37768748()
	local v4 = 20
	local v5 = v
	local __wf_atom_7470861b = instance:__wf_atom_7470861b()
	local __wf_atom_d2b2176d = instance:__wf_atom_d2b2176d()
	local isMaster = gRegion:IsMaster()
	local __wf_atom_18aa6e58 = instance:__wf_atom_18aa6e58()
	local __wf_atom_e55d02aa = __wf_atom_d2b2176d:__wf_atom_e55d02aa()
	mOwner:__wf_atom_a7328d06(true)
	instance:__wf_atom_78128d94(__wf_atom_37768748)
	instance:__wf_atom_2b0feace(true)

	if isMaster then
		__wf_atom_d2b2176d:AddUpgrade(20, 0, v2)
		__wf_atom_d2b2176d:AddUpgrade(316, 4, 10)

		if immuneToStabilityDamage then
			__wf_atom_d2b2176d:AddUpgrade(169, 4, 0)
		end
	end

	if _T.deoraFightSequence then
		__wf_atom_7470861b:__wf_atom_1fa97530(7, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(3, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(4, __wf_atom_37768748)
		__wf_atom_7470861b:__wf_atom_1fa97530(5, __wf_atom_37768748)
	end

	local __wf_atom_55597fe3 = __wf_atom_7470861b:__wf_atom_55597fe3()
	local __wf_atom_b518a791 = __wf_atom_55597fe3:__wf_atom_b518a791()
	local __wf_atom_679ed446 = __wf_atom_55597fe3:__wf_atom_679ed446()
	local __wf_atom_3371f607 = __wf_atom_55597fe3:__wf_atom_3371f607()
	local v6 = instance:Attach(attachFxType, EMPTY_SYMBOL)
	local baseAmount = __wf_atom_55597fe3.baseAmount
	local v7 = instance:Attach(shieldOrb, Symbol("GAME_R1_WEAPON1"), Vector(0, 0, 0))

	if not _T.odeShieldOrbs then
		_T.odeShieldOrbs = {}
	end

	if not __wf_atom_7e8ad928(v7) then
		table.insert(_T.odeShieldOrbs, v7)
	end

	local v8 = instance:Attach(shieldBeam, Symbol("GAME_L1_CLAV1"))

	if not (__wf_atom_7e8ad928(v8) or __wf_atom_7e8ad928(v7)) then
		v8:__wf_atom_b2394158(v7, EMPTY_SYMBOL)
	end

	local v9 = 1

	while not instance:IsKilled() do
		local __wf_atom_b518a791_2 = __wf_atom_55597fe3:__wf_atom_b518a791()
		local __wf_atom_679ed446_2 = __wf_atom_55597fe3:__wf_atom_679ed446()
		local __wf_atom_3371f607_2 = __wf_atom_55597fe3:__wf_atom_3371f607()
		local v10 = _T.odeShock and _T.odeShock[__wf_atom_18aa6e58]

		if
			__wf_atom_b518a791_2 ~= __wf_atom_b518a791
			or __wf_atom_679ed446_2 ~= __wf_atom_679ed446
			or __wf_atom_3371f607_2 ~= __wf_atom_3371f607
		then
			if v10 then
				__wf_atom_55597fe3:__wf_atom_6b472125(instance)
				__wf_atom_55597fe3:__wf_atom_34a8a27a(__wf_atom_e55d02aa)
				__wf_atom_55597fe3.weaponsActiveBehaviorIndex = 0
				local allObjects = gRegion:FindAllObjects(__wf_atom_4ebf67cb)
				__wf_atom_b518a791 = __wf_atom_b518a791_2
				__wf_atom_3371f607 = __wf_atom_3371f607_2
				__wf_atom_679ed446 = __wf_atom_679ed446_2

				for _, v11 in ipairs(_T.odeShock[__wf_atom_18aa6e58]) do
					if __wf_atom_7e8ad928(v11) then
						continue
					end

					local position = v11:GetPosition()
					local v12 = v11:__wf_atom_cfe217b8() ^ 2
					v11:Attach(orbReactFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance)
					v11:Attach(rangeDecoType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance):SetMeshScale(v11:__wf_atom_cfe217b8())

					for i = #allObjects, 1, -1 do
						if allObjects[i]:__wf_atom_4402f880(instance) then
							table.remove(allObjects, i)
						end
					end

					local _ = #allObjects
					baseAmount = __wf_atom_55597fe3.baseAmount
					local baseAmount2 = __wf_atom_55597fe3.baseAmount
					local baseAmount3 = __wf_atom_55597fe3.baseAmount / 20
					__wf_atom_55597fe3:__wf_atom_7498285f(0, 1)

					for i = #allObjects, 1, -1 do
						local allObject = allObjects[i]

						if not (allObject:__wf_atom_c215662d(position) <= v12) then
							continue
						end

						if allObject:__wf_atom_464a4772() then
							__wf_atom_55597fe3.baseAmount = baseAmount3
						else
							__wf_atom_55597fe3.baseAmount = baseAmount2
						end

						allObject:__wf_atom_649bf33e(__wf_atom_55597fe3)
						table.remove(allObjects, i)
					end
				end

				__wf_atom_55597fe3.baseAmount = baseAmount
				__wf_atom_55597fe3:__wf_atom_6b472125(__wf_atom_679ed446)
				__wf_atom_55597fe3:__wf_atom_34a8a27a(__wf_atom_3371f607)
			else
				__wf_atom_3371f607 = __wf_atom_3371f607_2
				__wf_atom_679ed446 = __wf_atom_679ed446_2
				__wf_atom_b518a791 = __wf_atom_b518a791_2
			end

			if __wf_atom_55597fe3.hitType == 3 then
				v9 = math.round((math.max(1, baseAmount / 50)))

				if not __wf_atom_7e8ad928(__wf_atom_679ed446_2) and __wf_atom_679ed446_2:IsA(__wf_atom_4ebf67cb) then
					if __wf_atom_679ed446_2:__wf_atom_464a4772() then
						v9 += v9
					end

					local damageData = Engine.DamageData()
					damageData:__wf_atom_6b472125(instance)
					damageData:__wf_atom_34a8a27a(__wf_atom_e55d02aa)
					damageData.baseAmount = 1
					damageData.criticalChance = 0.15
					damageData.stabilityDamage = __wf_atom_55597fe3.baseAmount * 5
					damageData:__wf_atom_7498285f(0, 1)
					__wf_atom_679ed446_2:__wf_atom_649bf33e(damageData)
				end

				if not __wf_atom_7e8ad928(v7) then
					v7:Attach(orbReactFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance)
					v7:Attach(rangeDecoType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1, instance):SetMeshScale(1.2)
				end

				if _T.deoraFightSequence then
					instance:Attach(breakFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
					break
				else
					instance:Attach(hitReactFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
				end
			end

			if v5 > 0 then
				if not __wf_atom_55597fe3:__wf_atom_6e062502() then
					v5 -= v9
				end

				if v5 <= 0 then
					break
				end
			end
		end

		Sleep(0)

		if not (v4 > 0) or v10 then
			continue
		end

		v4 -= __wf_atom_084b3e93()

		if v4 <= 0 then
			break
		end
	end

	instance:RemoveTag(__wf_atom_37768748)
	instance:__wf_atom_2b0feace(false)
	__wf_atom_7470861b:__wf_atom_63396172(__wf_atom_37768748)

	if not __wf_atom_7e8ad928(v6) then
		v6:Destroy()
	end

	if not __wf_atom_7e8ad928(v8) then
		v8:Destroy()
	end

	if not __wf_atom_7e8ad928(v7) then
		local index = table.find(_T.odeShieldOrbs, v7)
		table.remove(_T.odeShieldOrbs, index)

		if #_T.odeShieldOrbs == 0 then
			_T.odeShieldOrbs = nil
		end

		v7:Destroy()
	end

	if isMaster then
		__wf_atom_d2b2176d:RemoveUpgrade(20, 0, v2)
		__wf_atom_d2b2176d:RemoveUpgrade(316, 4, 10)

		if immuneToStabilityDamage then
			__wf_atom_d2b2176d:RemoveUpgrade(169, 4, 0)
		end
	end

	if not __wf_atom_7e8ad928(mOwner) then
		mOwner:__wf_atom_a7328d06(false)
	end

	__wf_atom_7470861b:__wf_atom_56b2394e(7, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_56b2394e(3, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_56b2394e(4, __wf_atom_37768748)
	__wf_atom_7470861b:__wf_atom_56b2394e(5, __wf_atom_37768748)
end