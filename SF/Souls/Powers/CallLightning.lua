local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function ActivateAbility(p, object, object2)
	local v = module.PlayAnim(p, activateAnim, false, 4, 1, false)
	object:Attach(chargeFx, EMPTY_SYMBOL, __wf_atom_28d5d4aa, __wf_atom_80368bb1)
	local v2 = v * activateAnim:__wf_atom_091354f5(Symbol(animEventCharge))
	local v3 = v * activateAnim:__wf_atom_091354f5(Symbol(animEventDisconnect)) - v2
	local v4 = v * activateAnim:__wf_atom_091354f5(Symbol(animEventStrike)) - (v2 + v3)
	Sleep(v2)

	if __wf_atom_7e8ad928(object2) or not object:__wf_atom_c138b19b(activateAnim) then
		return
	end

	local v5 = object2:Attach(markFx, EMPTY_SYMBOL)
	Sleep(v3)

	if not __wf_atom_7e8ad928(v5) then
		v5:Destroy()
	end

	local v6

	if not __wf_atom_7e8ad928(object2) then
		local position = object2:GetPosition()
		local v7 = __wf_atom_e97f3142(object2:__wf_atom_4e50d390())
		local v8 = __wf_atom_edfe0d73(Vector(0, 1, 0), v7)

		if Dot(v8, object2:__wf_atom_a06d543c()) < 0 then
			v8 *= -1
		end

		v6 = position + (v7 * math.random(1, 1.5) + v8 * math.random(0.25, 0.5))
		local v9 = {
			__wf_atom_4ebf67cb,
			__wf_atom_3feeb44a,
			__wf_atom_43e0c427,
			__wf_atom_7b01f9ce,
			__wf_atom_d0a48db7,
			WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
			WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
		}

		if __wf_atom_7e8ad928(gRegion:__wf_atom_c20d246a(v6 + Vector(0, 4, 0), v6 - Vector(0, 2, 0), v9, nil, v6)) then
			v6 = position
		end
	end

	Sleep(v4)

	if __wf_atom_7e8ad928(object2) or not object:__wf_atom_c138b19b(activateAnim) then
		return
	end

	local radialDamageData = Engine.RadialDamageData()
	radialDamageData.baseAmount = 50
	radialDamageData.radius = 1.25
	radialDamageData.fallOff = 0
	radialDamageData.checkForCover = false
	radialDamageData.hitType = 4
	radialDamageData:__wf_atom_7498285f(5, 1)
	radialDamageData:__wf_atom_d6f4d914(19, true)
	radialDamageData:__wf_atom_d6f4d914(31, true)
	radialDamageData:__wf_atom_98d98d81(v6)
	radialDamageData:__wf_atom_6b472125(object)
	radialDamageData:__wf_atom_34a8a27a(p)
	radialDamageData.burstEffectType = strikeFx
	gRegion:__wf_atom_f6ec80de(radialDamageData)
end

function DeactivateAbility(_, _, object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_0650fed7(markFx)
	end
end