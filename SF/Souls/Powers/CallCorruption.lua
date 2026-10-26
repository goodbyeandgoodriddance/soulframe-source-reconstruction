local module = require("Lotus.Scripts.Libs.AbilitiesLib")

function NpcEvaluateAbility(object, object2)
	local __wf_atom_9a1e4ed3 = object2:__wf_atom_30e3d82b():__wf_atom_9a1e4ed3()

	if
		__wf_atom_7e8ad928(__wf_atom_9a1e4ed3.avatar)
		or not __wf_atom_9a1e4ed3.visible
		or __wf_atom_9a1e4ed3.avatar:__wf_atom_bedb4e3f()
		or __wf_atom_9a1e4ed3.avatar:IsKilled()
	then
		return 0
	end

	object:__wf_atom_f7170fc9(__wf_atom_9a1e4ed3.avatar)
	return 1
end

function ActivateAbility(p, object, object2)
	local v = module.PlayAnim(p, activateAnim, false, 4, 1, false)
	local v2 = v * activateAnim:__wf_atom_091354f5(Symbol(animEventCharge))
	local _ = v * activateAnim:__wf_atom_091354f5(Symbol(animEventDisconnect)) - v2
	object:__wf_atom_8914dfde(animEventCharge, 1)

	if __wf_atom_7e8ad928(object2) or not object:__wf_atom_c138b19b(activateAnim) then
		return
	end

	for _ = 1, numStrikes do
		local v3 = object2:Attach(markFx, EMPTY_SYMBOL)
		object:__wf_atom_8914dfde(animEventDisconnect, 1)

		if not __wf_atom_7e8ad928(v3) then
			v3:Destroy()
		end

		local v4

		if not __wf_atom_7e8ad928(object2) then
			local position = object2:GetPosition()
			local v5 = __wf_atom_e97f3142(object2:__wf_atom_4e50d390())
			local v6 = __wf_atom_edfe0d73(Vector(0, 1, 0), v5)

			if Dot(v6, object2:__wf_atom_a06d543c()) < 0 then
				v6 *= -1
			end

			v4 = position + (v5 * math.random(1, 1.5) + v6 * math.random(0.25, 0.5))
			local v7 = {
				__wf_atom_4ebf67cb,
				__wf_atom_3feeb44a,
				__wf_atom_43e0c427,
				__wf_atom_7b01f9ce,
				__wf_atom_d0a48db7,
				WeakResource("/EE/Types/Engine/SimpleBlockingVolume"),
				WeakResource("/SF/Objects/Natural/Trees/TreeDecoration")
			}

			if __wf_atom_7e8ad928(gRegion:__wf_atom_c20d246a(v4 + Vector(0, 4, 0), v4 - Vector(0, 2, 0), v7, nil, v4)) then
				v4 = position
			end
		end

		object:__wf_atom_8914dfde(animEventStrike, 0.2)

		if __wf_atom_7e8ad928(object2) or not object:__wf_atom_c138b19b(activateAnim) then
			break
		end

		local radialDamageData = Engine.RadialDamageData()
		radialDamageData.baseAmount = 50
		radialDamageData.stabilityDamage = 60
		radialDamageData.radius = 4
		radialDamageData.fallOff = 0
		radialDamageData.checkForCover = false
		radialDamageData.hitType = 4
		radialDamageData:__wf_atom_7498285f(13, 1)
		radialDamageData:__wf_atom_d6f4d914(31, true)
		radialDamageData:__wf_atom_98d98d81(v4)
		radialDamageData:__wf_atom_6b472125(object)
		radialDamageData:__wf_atom_34a8a27a(p)
		radialDamageData.burstEffectType = strikeFx
		radialDamageData.hostAuthoritative = false
		gRegion:__wf_atom_f6ec80de(radialDamageData)
		Sleep(0)

		if __wf_atom_7e8ad928(object2) then
			break
		end
	end

	while object:__wf_atom_c138b19b(activateAnim) do
		Sleep(0)
	end
end

function DeactivateAbility(_, _, object)
	if not __wf_atom_7e8ad928(object) then
		object:__wf_atom_0650fed7(markFx)
	end
end