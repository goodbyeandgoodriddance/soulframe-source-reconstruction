local radius = 6
local baseAmount = 40
local stabilityDamage = 30
local baseAmount2 = 20
local module = require("Lotus.Scripts.Libs.AbilitiesLib")

local function fn(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 0, nil, nil, 26, Symbol("GroundStab"))
	local magikForceCalc = module.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		radius = 4
		baseAmount = 40
		stabilityDamage = 30
	elseif __wf_atom_2a745663 == 2 then
		radius = 5
		baseAmount = 45
		stabilityDamage = 45
	elseif __wf_atom_2a745663 == 3 then
		radius = 6
		baseAmount = 50
		stabilityDamage = 60
	else
		radius = 8
		baseAmount = 60
		stabilityDamage = 80
	end

	baseAmount *= magikForceCalc
	return true
end

local function fn2(object)
	local __wf_atom_2a745663 = object:__wf_atom_d2b2176d():__wf_atom_2a745663(0, 0, nil, nil, 26, Symbol("AutoTarget"))
	local magikForceCalc = module.magikForceCalc(object, __wf_atom_2a745663, mOwner)

	if __wf_atom_2a745663 == 0 then
		return false
	end

	if __wf_atom_2a745663 == 1 then
		baseAmount2 = 0
	elseif __wf_atom_2a745663 == 2 then
		baseAmount2 = 5
	elseif __wf_atom_2a745663 == 3 then
		baseAmount2 = 10
	else
		baseAmount2 = 20
	end

	baseAmount2 *= magikForceCalc
	return true
end

function AddUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	Sleep(0)
	object:__wf_atom_520644d6(14, Symbol("OnMelee"), Symbol("OnMeleePassive"))
	local v = fn2(__wf_atom_6009c8ed)
	local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()

	if gRegion:IsMaster() and v then
		__wf_atom_d2b2176d:AddUpgrade(350, 0, 15, nil, nil, 26, Symbol("CC_GAP_CLOSER"))
	end

	if __wf_atom_6009c8ed:__wf_atom_4417a5d4() and v then
		local v2 = Symbol("OnMeleeHit")
		local v3 = Symbol("GapCloserPassive")
		local v4 = nil
		local v5 = 0

		while not __wf_atom_7e8ad928(__wf_atom_6009c8ed) do
			if __wf_atom_7e8ad928(v4) then
				v4 = __wf_atom_d2b2176d:__wf_atom_9fb9a1d6()
			end

			if not __wf_atom_7e8ad928(v4) then
				local __wf_atom_1ffe3ac8 = v4:__wf_atom_1ffe3ac8()

				if not __wf_atom_7e8ad928(__wf_atom_1ffe3ac8) then
					while not __wf_atom_7e8ad928(v4) and __wf_atom_1ffe3ac8 == v4:__wf_atom_1ffe3ac8() do
						Sleep(0)
					end

					object:__wf_atom_2a5bca4a(nil, v3)
					object:__wf_atom_520644d6(5, v2, v3)
					v5 = 3
				end
			end

			if v5 > 0 then
				v5 -= __wf_atom_084b3e93()

				if v5 <= 0 then
					if not __wf_atom_7e8ad928(v4) then
						local __wf_atom_75a0566d = v4:__wf_atom_75a0566d()

						if not __wf_atom_7e8ad928(__wf_atom_75a0566d) then
							local __wf_atom_fe33ffd0 = __wf_atom_75a0566d:__wf_atom_fe33ffd0()

							if not __wf_atom_7e8ad928(__wf_atom_fe33ffd0) then
								while __wf_atom_fe33ffd0 == __wf_atom_75a0566d:__wf_atom_fe33ffd0() do
									Sleep(0)
								end
							end
						end
					end

					object:__wf_atom_2a5bca4a(nil, v3)
				end
			end

			Sleep(0)
		end
	end
end

function RemoveUpgrade(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if __wf_atom_7e8ad928(__wf_atom_6009c8ed) then
		return
	end

	object:__wf_atom_2a5bca4a(nil, Symbol("OnMeleePassive"))
	local v = fn2(__wf_atom_6009c8ed)

	if gRegion:IsMaster() then
		local __wf_atom_d2b2176d = __wf_atom_6009c8ed:__wf_atom_d2b2176d()

		if v then
			__wf_atom_d2b2176d:RemoveUpgrade(350, 0, 15, nil, nil, 26, Symbol("CC_GAP_CLOSER"))
		end
	end

	if __wf_atom_6009c8ed:__wf_atom_4417a5d4() and v then
		object:__wf_atom_2a5bca4a(nil, Symbol("GapCloserPassive"))
	end
end

function OnMelee(object)
	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()
	local __wf_atom_9fb9a1d6 = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_9fb9a1d6()

	if __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		return
	end

	local __wf_atom_75a0566d = __wf_atom_9fb9a1d6:__wf_atom_75a0566d()

	if __wf_atom_7e8ad928(__wf_atom_75a0566d) then
		return
	end

	local __wf_atom_f824cfe6 = __wf_atom_75a0566d:__wf_atom_f824cfe6()

	if __wf_atom_f824cfe6 ~= 18 and __wf_atom_f824cfe6 ~= 20 or not fn(__wf_atom_6009c8ed) then
		return
	end

	__wf_atom_6009c8ed:__wf_atom_8914dfde("StartMeleeSweep", 1)

	if __wf_atom_7e8ad928(__wf_atom_9fb9a1d6) then
		return
	end

	local __wf_atom_66088189 = __wf_atom_9fb9a1d6:__wf_atom_66088189(1, 0)
	local __wf_atom_1c374cc9 = __wf_atom_6009c8ed:__wf_atom_1c374cc9(not __wf_atom_7e8ad928(__wf_atom_66088189) and __wf_atom_66088189:__wf_atom_f5bac0e4() or Symbol("GAME_R1_WEAPON1"))
	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = baseAmount
	radialDamageData.stabilityDamage = stabilityDamage
	radialDamageData.radius = radius
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = false
	radialDamageData:__wf_atom_7498285f(5, 1)
	radialDamageData:__wf_atom_98d98d81(__wf_atom_1c374cc9)
	radialDamageData:__wf_atom_6b472125(__wf_atom_6009c8ed)
	radialDamageData:__wf_atom_34a8a27a(object)
	radialDamageData:__wf_atom_a8149853(Symbol("RadialHit"))
	_T.RadialHitEntities = {}
	gRegion:__wf_atom_f6ec80de(radialDamageData)

	if #_T.RadialHitEntities > 0 then
		table.sort(_T.RadialHitEntities, function(a, b)
			return a:__wf_atom_c215662d(__wf_atom_1c374cc9) < b:__wf_atom_c215662d(__wf_atom_1c374cc9)
		end)
		local v = table.remove(_T.RadialHitEntities, 1)

		if not (__wf_atom_7e8ad928(stabbedAttachType) or __wf_atom_7e8ad928(v)) then
			v:Attach(stabbedAttachType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)

			if __wf_atom_6009c8ed:__wf_atom_8efce136() then
				__wf_atom_6009c8ed:PlaySound(groundStrikeImpact, false)
			end
		end

		for _, radialHitEntity in ipairs(_T.RadialHitEntities) do
			if __wf_atom_7e8ad928(radialHitEntity) then
				continue
			end

			if not (__wf_atom_7e8ad928(beamType) or __wf_atom_7e8ad928(__wf_atom_66088189)) then
				__wf_atom_66088189:Attach(beamType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1):__wf_atom_341daa34(
					radialHitEntity,
					0
				)
			end

			if not __wf_atom_7e8ad928(targetAttachType) then
				radialHitEntity:Attach(targetAttachType, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
			end
		end
	end

	_T.RadialHitEntities = nil
end

function RadialHit(p, instance)
	if instance:IsA(__wf_atom_4ebf67cb) and not instance:__wf_atom_4402f880(p) then
		table.insert(_T.RadialHitEntities, instance)
	end
end

function OnMeleeHit(object, _, _, object2)
	if __wf_atom_7e8ad928(object2) then
		return
	end

	local __wf_atom_6009c8ed = object:__wf_atom_6009c8ed()

	if not fn2(__wf_atom_6009c8ed) then
		return
	end

	object:__wf_atom_2a5bca4a(nil, Symbol("GapCloserPassive"))
	local damageData = Engine.DamageData()
	damageData.baseAmount = baseAmount2
	damageData:__wf_atom_7498285f(5, 1)
	damageData:__wf_atom_6b472125(__wf_atom_6009c8ed)
	damageData:__wf_atom_34a8a27a(object)
	object2:__wf_atom_649bf33e(damageData)
	local __wf_atom_2a745663 = __wf_atom_6009c8ed:__wf_atom_d2b2176d():__wf_atom_2a745663(
		0,
		0,
		nil,
		nil,
		26,
		Symbol("AutoTarget")
	)
	local wireHitFxTypeOne = wireHitFxTypeOne

	if __wf_atom_2a745663 == 2 then
		wireHitFxTypeOne = wireHitFxTypeTwo
	elseif __wf_atom_2a745663 == 3 or __wf_atom_2a745663 == 4 then
		wireHitFxTypeOne = wireHitFxTypeThree
	end

	if not __wf_atom_7e8ad928(wireHitFxTypeOne) then
		object2:Attach(wireHitFxTypeOne, Symbol("GAME_C1_SPINE3"), __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	end
end